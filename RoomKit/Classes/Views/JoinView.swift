import SwiftUI

public struct JoinView: View {
    
    @Environment(\.presentationMode)
    var presentation

    @EnvironmentObject
    var room: Room
    
    @State
    private var name: String = ""

    public var body: some View {
        
        VStack {
            // The text field
            VStack(spacing: 20) {
                TextField("Enter your name", text: $name)
                .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .padding()
            
            // Join Button
            Button(action: {
                Rooms.join(name: self.name) { (room, error) in
                    self.presentation.wrappedValue.dismiss()
                }
            }) {
                Text("Join")
            }
            .buttonStyle(ThemedButtonStyle(theme: .success))
            .padding()
            
            // Our cancel button
            cancelButton
        }
        .onAppear {
            debugPrint("On appear")
        }
        .background(Color.clear)
        .keyboardResponsive()
        .padding()
    }

    
    private var cancelButton: some View {
        Button("Cancel") {
            self.presentation.wrappedValue.dismiss()
        }
        .buttonStyle(ThemedButtonStyle(theme: .primary))
        .padding()
    }
}
