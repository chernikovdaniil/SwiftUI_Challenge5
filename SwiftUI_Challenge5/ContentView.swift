//
//  ContentView.swift
//  SwiftUI_Challenge5
//
//  Created by Danil Chernikov on 12.12.2023.
//

import SwiftUI

#Preview {
    ContentView()
}

/*
 ...
 На экране 4 цветных прямоугольника. Сверху перетаскиваем квадрат.

 - Цвета фона [Color.white, .pink, .yellow, .black].
 - На темных цветах квадрат белый, на светлых - черный.
 - Нельзя использовать mask. Жест не прерывается между цветами.

 Сними короткое видео-скринкаст. Не снимай на фоне своего кода - видео отправляю в чат. В описании к видео добавь ссылку на публичный репозиторий на GitHub с исходным кодом проекта. Используй для этого задания ⚠️ отдельный новый репозиторий, его можно удалить после проверки задания. Видео со ссылкой отправь в бот.
 */

struct ContentView: View {
    @State private var squarePossition = CGPoint()
    
    private let colors = [Color.white, .pink, .yellow, .black]
    private let backColors = [Color.black, .white, .black, .white]
    
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 0) {
                ForEach(backColors, id: \.self) {
                    $0
                }
            }
            .overlay {
                VStack(spacing: 0) {
                    ForEach(colors, id: \.self) {
                        $0
                    }
                }
                .overlay {
                    Color
                        .white
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(width: 100, height: 100)
                        .position(squarePossition)
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    squarePossition = $0.location
                                }
                        )
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
            }
            .onAppear {
                let rect = reader.frame(in: .local)
                squarePossition = CGPoint(x: rect.midX, y: rect.midY)
            }
        }.ignoresSafeArea()
    }
}
