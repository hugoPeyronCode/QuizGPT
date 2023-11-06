//
//  QuizView.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 02/11/2023.
//

import SwiftUI

struct QuizView: View {
    
    @ObservedObject var vm : QuizView.ViewModel
    @Binding var selectedTab : Int
        
    var body: some View {
        NavigationStack {
            VStack{
                
                Text("\(vm.question.questionState.rawValue)")
                
                Text(vm.topic)
                
                Spacer()
                
                Question
                
                Spacer()
                
                PossibleAnswers
//                    .shake(vm.wrongBinding)
                    .disabled(vm.quizState != .neutral && vm.quizState != .selected)

                Spacer()
                
                if vm.quizState == .correct || vm.quizState == .wrong {
                    MoveToNextPageButton
                    isShowingModalButton
                        .padding(.top)
                } else {
                    ValidationButton

                }
                
                Spacer()
                
            }
            .fontDesign(.default)
            .fontWeight(.black)
        }
        .sheet(isPresented: $vm.isShowingModal){
            ResultView
                .presentationDetents([.medium])
        }
    }
    
    var ResultView : some View {
        VStack {
            
            Text(vm.quizState == .correct ? "CORRECT" : "WRONG")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(vm.quizState == .correct ? .green : .pink)
                    
            Text(vm.question.explanation)
                .font(.title3)
                .bold()
                .padding()
            
            QuestionLevelUp(result: vm.quizState == .correct)
            
            Text(vm.quizState == .correct ? "You've validated this question" : "You'll see this question again soon.")
                .padding()
            
            HStack {
                MoveToNextPageButton
            }
            
            isShowingModalButton
                .padding()

        }
    }
    
    var Question : some View {
        Text(vm.question.question)
            .bold()
            .multilineTextAlignment(.center)
            .font(.title)
            .padding(.horizontal)
    }
 
    var PossibleAnswers: some View {
        Group {
            switch vm.question.questionState {
            case .duo:
                VStack {
                    ForEach(vm.duoOptions.indices, id: \.self) { index in
                        answerButton(for: vm.duoOptions[index])
                        if index == 0 {
                            Text("or")
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    }
                }
            case .square:
                // Display all possible answers
                ForEach(vm.question.possibleAnswers, id: \.self) { answer in
                    answerButton(for: answer)
                }
            case .cash:
                // Display the cash view
                CashView(answer: vm.question.answer, result: $vm.quizState)
                    .onChange(of: vm.quizState) { _ in
                        if vm.quizState == .correct{
                            vm.checkResult(goodAnswer: "good", answer: "good")
                        } else if vm.quizState == .wrong {
                            vm.checkResult(goodAnswer: "good", answer: "bad")
                        }
                    }
            case .validated:
                // Handle the validated state if needed
                Text("This question has been validated.")
            }
        }
    }
    
    // Refactored button creation to a function for reuse
    private func answerButton(for answer: String) -> some View {
        SingleSelectButton(content: answer, fontString: "Helvetica", selectedItems: $vm.selectedItems, quizState: $vm.quizState) {
            vm.quizState = .selected
            vm.selectedItems.removeAll()
            HapticManager.shared.generateFeedback(for: .successLight)
            vm.selectedItems = [answer]
        }
    }
    
    
    var ValidationButton: some View {
        ValidateButton(quizState: $vm.quizState) {
            vm.checkResult(goodAnswer: vm.question.answer, answer: vm.selectedItems.first!)
        }
        .disabled(vm.selectedItems.isEmpty)
    }
    
    var isShowingModalButton : some View {
        Button {
            // Toggle the fact that the modal is shown or not.
            vm.isShowingModal.toggle()
        } label: {
            Image(systemName: !vm.isShowingModal ? "chevron.up" : "chevron.down")
                .foregroundStyle(.foreground)
                .fontWeight(.black)
        }
        
    }
    
    var MoveToNextPageButton : some View {
        Button {
            withAnimation {
                vm.isShowingModal = false
                moveToNextQuestion()
            }
        } label: {
            HStack {
                Text("Next question")
//                Image(systemName: "chevron.right")
//                    .font(.largeTitle)
            }
            .font(.title2)
            .fontWeight(.black)
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .fontWeight(.semibold)
            .foregroundStyle(QuizManager.shared.color(quizState: vm.quizState))
        }
    }
    
    func moveToNextQuestion() {
        withAnimation {
            if selectedTab < TopicsManager.shared.allQuestions.count - 1 {
                selectedTab += 1
            }
        }
    }
    
}

#Preview {
    QuizView(vm: QuizView.ViewModel(topic: "Text", question: Question(question: "", possibleAnswers: ["Test"], answer: "Answer", explanation: "", questionState: .duo)), selectedTab: .constant(1))
}
