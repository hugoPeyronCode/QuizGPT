//
//  CashView.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 05/11/2023.
//


// I've got two issues on this view.
// 1. it needs to return a bool according to the result so that I can update the main view state.
// 2. the keyboard does not focus automatically. I believe this is because this view is nested in a Tab View in my Home then in the QuizView. That's too many view nested so that the keyboard is triggered properlly.

import SwiftUI
struct CashView: View {
    
    @Binding var result: QuizState
    
    @StateObject private var vm: CashView.ViewModel
    @FocusState var isInputFocused: Bool
    
    init(answer: String, result: Binding<QuizState>) {
        _vm = StateObject(wrappedValue: CashView.ViewModel(answer: answer))
        self._result = result
    }
    
    var body: some View {
        VStack {
            
            Text(vm.result?.description ?? "")
            
            ZStack {
                FillTheGaps
                HiddenTextField
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isInputFocused = true
            }
        }
        .onChange(of: vm.result) { _ in
            switch vm.result {
            case true:
                result = .correct
            case false:
                result = .wrong
            default:
                result = .neutral
            }
        }
    }
    
    var FillTheGaps: some View {
        HStack {
            ForEach(0..<vm.answer.count, id: \.self) { index in
                ZStack{
                    Text(" ")
                        .frame(width: 25, height: 40)
                        .background(Color.white.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.color(result: vm.result), lineWidth: 1)
                        )
                    Text(vm.characterAtIndex(index))
                        .frame(width: 25, height: 40)
                }
            }
        }
    }
    
    var HiddenTextField : some View {
        TextField("", text: $vm.userInput)
            .focused($isInputFocused)
            .opacity(1)
            .frame(maxWidth: .infinity, maxHeight: 500)
            .onChange(of: vm.userInput) { newValue in
                if newValue.count > vm.answer.count {
                    vm.userInput = String(newValue.prefix(vm.answer.count))
                } else if newValue.count == vm.answer.count {
                    vm.checkAnswer()
                }
        }
    }
}

#Preview {
    CashView(answer: "Bobby", result: .constant(.correct))
}

