import SwiftUI
import RealityKit
import RealityKitContent
import AVFoundation

struct ResponseView: View {
    @Environment (ViewModel.self) var viewModel
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @EnvironmentObject var feedback: Feedback
    @EnvironmentObject var scenarioOptions: ScenarioOptions
    
    @State private var button1 = "1"
    @State private var button2 = "2"
    @State private var button3 = "3"
    @State public var question = "Hi, what can I get you?"
    @State private var round = 1
    @State private var lastAnswer = 0
    
    @State private var questionTimeRemaining = 9
    let questionTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var shouldHideResponseButtons = true
    @State var shouldHideProceedButton = true
    @State var roundInProgress = true
    @State var backgroundMusicVolume: Float = 0.5  // Default volume
    
    
    let dialogue = CafeDialogue()
    
    var body: some View {
        
        VStack {
            VStack {
                Text(question)
                    .opacity(scenarioOptions.captions ? 1 : 0)
                    .multilineTextAlignment(.center)
                    .onChange(of: question) { _, newQuestion in
                    }
                
                Spacer()
                VStack {
                    //button 1
                    Button(action: {
                        round += 1
                        restartTimer()
                        
                        switch round {
                        case 2:
                            playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                            lastAnswer = 1
                            question = dialogue.round2Question1
                            button1 = dialogue.round2Question1Response1
                            button2 = dialogue.round2Question1Response2
                            button3 = dialogue.round2Question1Response3
                            AudioManager.shared.playSound(named: "Question2")
                        case 3:
                            switch lastAnswer {
                            case 1:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.pointAnimationResource)
                                lastAnswer = 1
                                question = dialogue.round3Question1
                                button1 = dialogue.round3Question1Response1
                                button2 = dialogue.round3Question1Response2
                                button3 = dialogue.round3Question1Response3
                                AudioManager.shared.playSound(named: "Question5")
                                
                            case 2:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                lastAnswer = 4
                                question = dialogue.round3Question4
                                button1 = dialogue.round3Question4Response10
                                button2 = dialogue.round3Question4Response11
                                button3 = dialogue.round3Question4Response12
                                AudioManager.shared.playSound(named: "Question4")
                            case 3:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                lastAnswer = 7
                                question = dialogue.round3Question7
                                button1 = dialogue.round3Question7Response19
                                button2 = dialogue.round3Question7Response20
                                button3 = dialogue.round3Question7Response21
                                AudioManager.shared.playSound(named: "Question7")
                            default:
                                break
                            }
                        case 4:
                            dialogueComplete()
                            print(feedback.feedback)
                            switch lastAnswer {
                            case 1:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question1
                                AudioManager.shared.playSound(named: "Question14")
                                feedback.passed = true
                                feedback.feedback = "You were presented with the soup option but still kept the conversation centred on coffee. You successfully ordered a Medium Brewster's Blend."
                            case 2:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question4
                                AudioManager.shared.playSound(named: "Question16")
                                feedback.passed = true
                                feedback.feedback = "You almost ordered the soup, but you came to your senses. Though you didn't specify the coffee by name, you got there in the end."
                            case 3:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.pointAnimationResource)
                                question = dialogue.round4Question7
                                AudioManager.shared.playSound(named: "Question18")
                                feedback.passed = true
                                feedback.feedback = "You were about to pay for the soup, but you remembered your task at the last minute. Try getting to the point next time."
                            case 4:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                question = dialogue.round4Question10
                                AudioManager.shared.playSound(named: "Question14")
                                feedback.passed = true
                                feedback.feedback = "You kept the barista waiting, but you ordered the right coffee. Nice work!"
                            case 5:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                question = dialogue.round4Question13
                                AudioManager.shared.playSound(named: "Question14")
                                feedback.passed = true
                                feedback.feedback = "You kept the barista waiting, but you ordered the right coffee. Nice work!"
                            case 6:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                question = dialogue.round4Question16
                                AudioManager.shared.playSound(named: "Question20")
                                feedback.passed = true
                                feedback.feedback = "You almost antagonised the barista, but you ordered the right coffee."
                            case 7:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question19
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Java Jolt even though the barista told you it was a cappuccino."
                            case 8:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question22
                                AudioManager.shared.playSound(named: "Question14")
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Roast Riddle even though the barista told you it was a flat white."
                            case 9:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question25
                                AudioManager.shared.playSound(named: "Question23")
                                feedback.passed = true
                                feedback.feedback = "Great work! You ordered a latte on a $4.50 budget."
                            default:
                                break
                            }
                        default:
                            break
                        }
                    }, label: {
                        Text(button1)
                    })
                    
                    //button 2
                    Button(action: {
                        round += 1
                        restartTimer()
                        switch round {
                        case 2:
                            playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource)
                            lastAnswer = 2
                            question = dialogue.round2Question2
                            button1 = dialogue.round2Question2Response4
                            button2 = dialogue.round2Question2Response5
                            button3 = dialogue.round2Question2Response6
                            AudioManager.shared.playSound(named: "Question3")
                        case 3:
                            switch lastAnswer {
                            case 1:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.pointAnimationResource)
                                lastAnswer = 2
                                question = dialogue.round3Question2
                                button1 = dialogue.round3Question2Response4
                                button2 = dialogue.round3Question2Response5
                                button3 = dialogue.round3Question2Response6
                                AudioManager.shared.playSound(named: "Question10")
                            case 2:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource)
                                lastAnswer = 5
                                question = dialogue.round3Question5
                                button1 = dialogue.round3Question5Response13
                                button2 = dialogue.round3Question5Response14
                                button3 = dialogue.round3Question5Response15
                                AudioManager.shared.playSound(named: "Question12")
                            case 3:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                lastAnswer = 8
                                question = dialogue.round3Question8
                                button1 = dialogue.round3Question8Response22
                                button2 = dialogue.round3Question8Response23
                                button3 = dialogue.round3Question8Response24
                                AudioManager.shared.playSound(named: "Question8")
                            default:
                                break
                            }
                        case 4:
                            feedback.feedback = "Button 1"
                            dialogueComplete()
                            switch lastAnswer {
                            case 1:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question2
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You were presented with the soup option but still kept the conversation centred on coffee. Unfortunately, you didn't order a latte under $4.50."
                            case 2:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question5
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You didn't order soup - good work. However, you didn't order a latte under $4.50 either."
                            case 3:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question8
                                AudioManager.shared.playSound(named: "Question19")
                                feedback.passed = false
                                feedback.feedback = "You ordered soup when you were supposed to order coffee."
                            case 4:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource)
                                question = dialogue.round4Question11
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 5:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource)
                                question = dialogue.round4Question14
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 6:
                                question = dialogue.round4Question17
                                AudioManager.shared.playSound(named: "Question21")
                                feedback.passed = false
                                feedback.feedback = "You antagonised the barista, and you ordered the wrong coffee."
                            case 7:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question20
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Java Jolt even though the barista told you it was a cappuccino."
                            case 8:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question23
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Roast Riddle even though the barista told you it was a flat white."
                            case 9:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question26
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Roast Riddle even though the barista told you what a latte was."
                            default:
                                break
                            }
                        default:
                            break
                        }
                    }, label: {
                        Text(button2)
                    })
                    
                    //button 3
                    Button(action: {
                        round += 1
                        restartTimer()
                        switch round {
                        case 2:
                            playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                            lastAnswer = 3
                            question = dialogue.round2Question3
                            button1 = dialogue.round2Question3Response7
                            button2 = dialogue.round2Question3Response8
                            button3 = dialogue.round2Question3Response9
                            AudioManager.shared.playSound(named: "Question4")
                        case 3:
                            switch lastAnswer {
                            case 1:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                lastAnswer = 3
                                question = dialogue.round3Question3
                                button1 = dialogue.round3Question3Response7
                                button2 = dialogue.round3Question3Response8
                                button3 = dialogue.round3Question3Response9
                                AudioManager.shared.playSound(named: "Question11")
                            case 2:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                lastAnswer = 6
                                question = dialogue.round3Question6
                                button1 = dialogue.round3Question6Response16
                                button2 = dialogue.round3Question6Response17
                                button3 = dialogue.round3Question6Response18
                                AudioManager.shared.playSound(named: "Question13")
                            case 3:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                                lastAnswer = 9
                                question = dialogue.round3Question9
                                button1 = dialogue.round3Question9Response25
                                button2 = dialogue.round3Question9Response26
                                button3 = dialogue.round3Question9Response27
                                AudioManager.shared.playSound(named: "Question9")
                            default:
                                break
                            }
                        case 4:
                            dialogueComplete()
                            switch lastAnswer {
                            case 1:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question3
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You were presented with the soup option but still kept the conversation centred on coffee. Unfortunately, you didn't order a latte under $4.50."
                            case 2:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.waveAnimationResource)
                                question = dialogue.round4Question6
                                AudioManager.shared.playSound(named: "Question17")
                                feedback.passed = false
                                feedback.feedback = "You didn't order soup, but you didn't order coffee either."
                            case 3:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.waveAnimationResource)
                                question = dialogue.round4Question9
                                AudioManager.shared.playSound(named: "Question17")
                                feedback.passed = false
                                feedback.feedback = "You didn't order soup, but you didn't order coffee either."
                            case 4:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource)
                                question = dialogue.round4Question12
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 5:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource)
                                question = dialogue.round4Question15
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 6:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.angryAnimationResource)
                                question = dialogue.round4Question18
                                AudioManager.shared.playSound(named: "Question22")
                                feedback.passed = false
                                feedback.feedback = "You got kicked out of the cafe."
                            case 7:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question21
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = true
                                feedback.feedback = "Great work! You ordered a latte on a $4.50 budget."
                            case 8:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question24
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = true
                                feedback.feedback = "You didn't order the latte by name, but you still ordered it on a $4.50 budget. Nice work."
                            case 9:
                                playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.happyAnimationResource)
                                question = dialogue.round4Question27
                                AudioManager.shared.playSound(named: "Question15")
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Roast Riddle even though the barista told you what a latte was."
                            default:
                                break
                            }
                        default:
                            break
                        }
                    }, label: {
                        Text(button3)
                    })
                }
                .opacity(shouldHideResponseButtons ? 0 : 1)
                .buttonStyle(.borderedProminent)
                
                // setting up the slider
                VStack {
                    Text("Background Sound")
                    Slider(value: $backgroundMusicVolume, in: 0...1, step: 0.1)
                        .frame(width: 200)  // Adjust the width
                        .onChange(of: backgroundMusicVolume) { newVolume in
                            AudioManager.shared.setBackgroundMusicVolume(to: newVolume)
                        }
                }
                .padding(.top,50)
            }
            .font(.title2)
            .padding()
            .tint(.indigo)
            .onAppear() {
                setInitialState()
                AudioManager.shared.playBackgroundMusic(named: "BackgroundSound")
                AudioManager.shared.setBackgroundMusicVolume(to: backgroundMusicVolume)
            }
            
            .onDisappear {
                AudioManager.shared.stopBackgroundMusic()
            }
        }
        .font(.title2)
        .padding()
        .tint(.indigo)
        .onAppear() {
            setInitialState()
        }
        
        //            Spacer()
        
        HStack {
            Spacer()
            Button(action: {
                Task
                {
                    await dismissImmersiveSpace()
                    openWindow(id: "HomeView")
                    dismissWindow(id: "ResponseView")
                }
            }, label: {
                Image(systemName: "xmark.circle")
                    .frame(width: 30, height: 30)
            })
            .opacity(shouldHideProceedButton ? 1 : 0)
            
            Spacer()
            
            Text("\(questionTimeRemaining)")
                .padding()
                .background(.indigo)
                .foregroundStyle(.white)
                .font(.title2)
                .cornerRadius(1000)
                .opacity(shouldHideResponseButtons ? 0 : 1)
            Spacer()
            Button(action: {
                Task
                {
                    await dismissImmersiveSpace()
                    openWindow(id: "FeedbackView")
                    dismissWindow(id: "ResponseView")
                }
            }, label: {
                Image(systemName: "arrowshape.right.circle")
                    .frame(width: 30, height: 30)
            })
            .opacity(shouldHideProceedButton ? 0 : 1)
            Spacer()
        }
        .font(.title)
        .tint(.indigo)
        .buttonStyle(.borderedProminent)
        .padding()
        .onLoad {
            dismissWindow(id: "FeedbackView")
            playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
        }
        .onReceive(questionTimer) { time in
            if roundInProgress {
                if questionTimeRemaining >= 1 {
                    questionTimeRemaining -= 1
                }
                if questionTimeRemaining < 7 {
                    shouldHideResponseButtons = false
                }
                if questionTimeRemaining == 0 {
                    feedback.passed = false
                    feedback.feedback = "You didn't answer quickly enough."
                    Task {
                        await dismissImmersiveSpace()
                        openWindow(id: "FeedbackView")
                        dismissWindow(id: "ResponseView")
                    }
                }
            }
        }
        
    }
    
    private func setInitialState() {
        // Set the initial question and speak it
        //        question = dialogue.round1Question1
        button1 = dialogue.round1Question1Response1
        button2 = dialogue.round1Question1Response2
        button3 = dialogue.round1Question1Response3
        AudioManager.shared.playSound(named: "Question1")
    }
    
    
    private func updateState(from button: String) {
        // Logic to determine the next question based on button press
        // Dummy logic here: increment the round and update the question randomly
        round += 1
        // You would update 'question' and 'button1', 'button2', 'button3' here based on your game logic
        SpeechSynthesizerService.shared.speak(question)
    }
    
    private func restartTimer() {
        shouldHideResponseButtons = true
        questionTimeRemaining = 9
        _ = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    private func dialogueComplete() {
        roundInProgress = false
        shouldHideResponseButtons = true
        shouldHideProceedButton = false
    }
}

// Preview for your SwiftUI view
struct ResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseView()
    }
}
