import Foundation

class Feedback: ObservableObject {
    @Published var feedback = "You passed."
    @Published var passed = false
}
