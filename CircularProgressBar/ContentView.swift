//
//  ContentView.swift
//  CircularProgressBar
//
//  Created by Black Billy on 21/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var value: Double = 0.0
    @State private var showValue: Bool = false
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 25)
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.gray.opacity(0.5))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
                Circle()
                    .stroke(lineWidth: 0.34)
                    .frame(width: 175, height: 175)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .overlay {
                        Circle()
                            .stroke(.black.opacity(0.1), lineWidth: 2)
                            .blur(radius: 5)
                            .mask {
                                Circle()
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                            }
                    }
                Circle()
                    .trim(from: 0, to: showValue ? value : 0.0)
                    .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.pink, .pink.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                Text("\(value.asNumberWith2Decimals())")
            }
            .onTapGesture {
                withAnimation(.spring().speed(0.2)) {
                    showValue.toggle()
                    if showValue {
                        value = 0.7
                    } else {
                        value = 0.0
                    }
                }
            }
            
            Button {
                withAnimation(.spring().speed(0.2)) {
                    showValue.toggle()
                    if showValue {
                        value = 0.7
                    } else {
                        value = 0.0
                    }
                }
            } label: {
                Text("Show Value")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(.pink)
                    )
            }
        }
    }
}

#Preview {
    ContentView()
}

extension Double {
    private var numberFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asNumberWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return numberFormatter2.string(from: number) ?? "0.00"
    }
}
