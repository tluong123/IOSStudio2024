import SwiftUI
import RealityKit
import RealityKitContent
import AVFoundation

struct ResponseView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @EnvironmentObject var feedback: Feedback
    
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
    
    let dialogue = Dialogue(
        round1Question1: "Hi, what can I get you?",
        
        round1Question1Response1: "Do you have any specials?",
        round1Question1Response2: "Just a sec.",
        round1Question1Response3: "What coffees do you have?",
        
        round2Question1: "Our soup of the day is minestr-oh-no.",
        round2Question1Response1: "Oh, I'm actually looking for coffee!",
        round2Question1Response2: "Oh, that's not what I want.",
        round2Question1Response3: "I'll get that!",
        
        round2Question2: "Hey! There are other customers waiting.",
        round2Question2Response4: "I know. I'm sorry. What coffees do you have?",
        round2Question2Response5: "Just give me a second.",
        round2Question2Response6: "What's your problem?",
        
        round2Question3: "We have the Brewster's Blend, the Java Jolt, the Roast Riddle, and the Morning Mist.",
        round2Question3Response7: "What's a Java Jolt?",
        round2Question3Response8: "What's a Roast Riddle?",
        round2Question3Response9: "What's a Brewster's Blend?",
        
        round3Question1: "No problem. Our coffees are $4 for a medium and $5 for large.",
        round3Question1Response1: "A medium Brewster's Blend please.",
        round3Question1Response2: "A large Java Jolt please.",
        round3Question1Response3: "A large Roast Riddle please.",
        
        round3Question2: "Did you want a coffee instead?",
        round3Question2Response4: "Yes please. The largest latte I can get for $4.50, please.",
        round3Question2Response5: "Yes! A large cappuccino please.",
        round3Question2Response6: "No, don't worry about it.",
        
        round3Question3: "Great. $8.80 please.",
        round3Question3Response7: "Oh, sorry, I want coffee instead.",
        round3Question3Response8: "Here you are.",
        round3Question3Response9: "Actually, don't worry...",
        
        round3Question4: "We have the Brewster's Blend, the Java Jolt, the Roast Riddle, and the Morning Mist.",
        round3Question4Response10: "A medium Brewster's Blend please.",
        round3Question4Response11: "A large Java Jolt please.",
        round3Question4Response12: "A large Roast Riddle please.",
        
        round3Question5: "Be quick!",
        round3Question5Response13: "A medium Brewster's Blend please.",
        round3Question5Response14: "A large Java Jolt please.",
        round3Question5Response15: "A large Roast Riddle please.",
        
        round3Question6: "Excuse me?",
        round3Question6Response16: "I'm really sorry. A medium Brewster's Blend please.",
        round3Question6Response17: "Sorry. A large Java Jolt please.",
        round3Question6Response18: "Stuff you, buddy!",
        
        round3Question7: "A cappuccino.",
        round3Question7Response19: "A large Java Jolt please!",
        round3Question7Response20: "A medium Java Jolt please!",
        round3Question7Response21: "Can I please have the latte?",
        
        round3Question8: "Our special take on a flat white.",
        round3Question8Response22: "A medium Roast Riddle please.",
        round3Question8Response23: "A large Roast Riddle please.",
        round3Question8Response24: "I'd like the latte.",
        
        round3Question9: "Our version of a latte!",
        round3Question9Response25: "I'll have that in a medium, please.",
        round3Question9Response26: "I'll grab a large Brewster's Blend.",
        round3Question9Response27: "Can I have a large Roast Riddle please?",
        
        round4Question1: "Coming right up. $4 please.",
        round4Question2: "Coming right up. $5 please.",
        round4Question3: "Coming right up. $5 please.",
        round4Question4: "Great! That's a Brewster's Blend in a medium. $4 please.",
        round4Question5: "Coming right up. $5 please.",
        round4Question6: "No problem. Have a nice day.",
        round4Question7: "No problem. What coffee can I get you?",
        round4Question8: "Thanks! It'll be out soon.",
        round4Question9: "No problem. Have a nice day.",
        round4Question10: "Coming right up. $4 please.",
        round4Question11: "Coming right up. $5 please.",
        round4Question12: "Coming right up. $5 please.",
        round4Question13: "Coming right up. $4 please.",
        round4Question14: "Coming right up. $5 please.",
        round4Question15: "Coming right up. $5 please.",
        round4Question16: "That's $4.",
        round4Question17: "That's $5.",
        round4Question18: "Get out of my cafe!",
        round4Question19: "Coming right up. $5 please.",
        round4Question20: "Coming right up. $4 please.",
        round4Question21: "Coming right up. $4 please.",
        round4Question22: "Coming right up. $4 please.",
        round4Question23: "Coming right up. $5 please.",
        round4Question24: "Coming right up. $4 please.",
        round4Question25: "Sure. $4 please.",
        round4Question26: "Coming right up. $5 please.",
        round4Question27: "Coming right up. $5 please.")
    
    var body: some View {
        
        VStack {
            VStack {
                Text(question)
                    .multilineTextAlignment(.center)
                    .onChange(of: question) { _, newQuestion in
                        SpeechSynthesizerService.shared.speak(newQuestion)
                    }
                Spacer()
                VStack {
                    //button 1
                    Button(action: {
                        round += 1
                        restartTimer()
                        switch round {
                        case 2:
                            lastAnswer = 1
                            question = dialogue.round2Question1
                            button1 = dialogue.round2Question1Response1
                            button2 = dialogue.round2Question1Response2
                            button3 = dialogue.round2Question1Response3
                        case 3:
                            switch lastAnswer {
                            case 1:
                                lastAnswer = 1
                                question = dialogue.round3Question1
                                button1 = dialogue.round3Question1Response1
                                button2 = dialogue.round3Question1Response2
                                button3 = dialogue.round3Question1Response3
                            case 2:
                                lastAnswer = 4
                                question = dialogue.round3Question4
                                button1 = dialogue.round3Question4Response10
                                button2 = dialogue.round3Question4Response11
                                button3 = dialogue.round3Question4Response12
                            case 3:
                                lastAnswer = 7
                                question = dialogue.round3Question7
                                button1 = dialogue.round3Question7Response19
                                button2 = dialogue.round3Question7Response20
                                button3 = dialogue.round3Question7Response21
                            default:
                                break
                            }
                        case 4:
                            dialogueComplete()
                            //                            feedback.feedback = "Button 1"
                            print(feedback.feedback)
                            switch lastAnswer {
                            case 1:
                                question = dialogue.round4Question1
                                feedback.passed = true
                                feedback.feedback = "You were presented with the soup option but still kept the conversation centred on coffee. You successfully ordered a Medium Brewster's Blend."
                            case 2:
                                question = dialogue.round4Question4
                                feedback.passed = true
                                feedback.feedback = "You almost ordered the soup, but you came to your senses. Though you didn't specify the coffee by name, you got there in the end."
                            case 3:
                                question = dialogue.round4Question7
                                feedback.passed = true
                                feedback.feedback = "You were about to pay for the soup, but you remembered your task at the last minute. Try getting to the point next time."
                            case 4:
                                question = dialogue.round4Question10
                                feedback.passed = true
                                feedback.feedback = "You kept the barista waiting, but you ordered the right coffee. Nice work!"
                            case 5:
                                question = dialogue.round4Question13
                                feedback.passed = true
                                feedback.feedback = "You kept the barista waiting, but you ordered the right coffee. Nice work!"
                            case 6:
                                question = dialogue.round4Question16
                                feedback.passed = true
                                feedback.feedback = "You almost antagonised the barista, but you ordered the right coffee."
                            case 7:
                                question = dialogue.round4Question19
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Java Jolt even though the barista told you it was a cappuccino."
                            case 8:
                                question = dialogue.round4Question22
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Roast Riddle even though the barista told you it was a flat white."
                            case 9:
                                question = dialogue.round4Question25
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
                            lastAnswer = 2
                            question = dialogue.round2Question2
                            button1 = dialogue.round2Question2Response4
                            button2 = dialogue.round2Question2Response5
                            button3 = dialogue.round2Question2Response6
                        case 3:
                            switch lastAnswer {
                            case 1:
                                lastAnswer = 2
                                question = dialogue.round3Question2
                                button1 = dialogue.round3Question2Response4
                                button2 = dialogue.round3Question2Response5
                                button3 = dialogue.round3Question2Response6
                            case 2:
                                lastAnswer = 5
                                question = dialogue.round3Question5
                                button1 = dialogue.round3Question5Response13
                                button2 = dialogue.round3Question5Response14
                                button3 = dialogue.round3Question5Response15
                            case 3:
                                lastAnswer = 8
                                question = dialogue.round3Question8
                                button1 = dialogue.round3Question8Response22
                                button2 = dialogue.round3Question8Response23
                                button3 = dialogue.round3Question8Response24
                            default:
                                break
                            }
                        case 4:
                            feedback.feedback = "Button 1"
                            dialogueComplete()
                            switch lastAnswer {
                            case 1:
                                question = dialogue.round4Question2
                                feedback.passed = false
                                feedback.feedback = "You were presented with the soup option but still kept the conversation centred on coffee. Unfortunately, you didn't order a latte under $4.50."
                            case 2:
                                question = dialogue.round4Question5
                                feedback.passed = false
                                feedback.feedback = "You didn't order soup - good work. However, you didn't order a latte under $4.50 either."
                            case 3:
                                question = dialogue.round4Question8
                                feedback.passed = false
                                feedback.feedback = "You ordered soup when you were supposed to order coffee."
                            case 4:
                                question = dialogue.round4Question11
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 5:
                                question = dialogue.round4Question14
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 6:
                                question = dialogue.round4Question17
                                feedback.passed = false
                                feedback.feedback = "You antagonised the barista, and you ordered the wrong coffee."
                            case 7:
                                question = dialogue.round4Question20
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Java Jolt even though the barista told you it was a cappuccino."
                            case 8:
                                question = dialogue.round4Question23
                                feedback.passed = false
                                feedback.feedback = "You didn't order a latte on a $4.50 budget. You ordered a Roast Riddle even though the barista told you it was a flat white."
                            case 9:
                                question = dialogue.round4Question26
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
                            lastAnswer = 3
                            question = dialogue.round2Question3
                            button1 = dialogue.round2Question3Response7
                            button2 = dialogue.round2Question3Response8
                            button3 = dialogue.round2Question3Response9
                        case 3:
                            switch lastAnswer {
                            case 1:
                                lastAnswer = 3
                                question = dialogue.round3Question3
                                button1 = dialogue.round3Question3Response7
                                button2 = dialogue.round3Question3Response8
                                button3 = dialogue.round3Question3Response9
                            case 2:
                                lastAnswer = 6
                                question = dialogue.round3Question6
                                button1 = dialogue.round3Question6Response16
                                button2 = dialogue.round3Question6Response17
                                button3 = dialogue.round3Question6Response18
                            case 3:
                                lastAnswer = 9
                                question = dialogue.round3Question9
                                button1 = dialogue.round3Question9Response25
                                button2 = dialogue.round3Question9Response26
                                button3 = dialogue.round3Question9Response27
                            default:
                                break
                            }
                        case 4:
                            dialogueComplete()
                            switch lastAnswer {
                            case 1:
                                question = dialogue.round4Question3
                                feedback.passed = false
                                feedback.feedback = "You were presented with the soup option but still kept the conversation centred on coffee. Unfortunately, you didn't order a latte under $4.50."
                            case 2:
                                question = dialogue.round4Question6
                                feedback.passed = false
                                feedback.feedback = "You didn't order soup, but you didn't order coffee either."
                            case 3:
                                question = dialogue.round4Question9
                                feedback.passed = false
                                feedback.feedback = "You didn't order soup, but you didn't order coffee either."
                            case 4:
                                question = dialogue.round4Question12
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 5:
                                question = dialogue.round4Question15
                                feedback.passed = false
                                feedback.feedback = "You kept the barista waiting and ordered the wrong coffee."
                            case 6:
                                question = dialogue.round4Question18
                                feedback.passed = false
                                feedback.feedback = "You got kicked out of the cafe."
                            case 7:
                                question = dialogue.round4Question21
                                feedback.passed = true
                                feedback.feedback = "Great work! You ordered a latte on a $4.50 budget."
                            case 8:
                                question = dialogue.round4Question24
                                feedback.passed = true
                                feedback.feedback = "You didn't order the latte by name, but you still ordered it on a $4.50 budget. Nice work."
                            case 9:
                                question = dialogue.round4Question27
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
                    openWindow(id: "FeedbackView")
                    dismissWindow(id: "ResponseView")
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
            }
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
                    openWindow(id: "FeedbackView")
                    dismissWindow(id: "ResponseView")
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
        SpeechSynthesizerService.shared.speak(question)
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
