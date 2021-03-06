//
//  EnterNameView.swift
//  Scatagories
//
//  Created by David San Antonio on 1/25/21.
//

import SwiftUI

struct EnterNameView: View {
    @StateObject var onlineGameManager: OnlineGameManager
    @ObservedObject var codeTextBindingManager = CodeTextBindingManager(limit: 4)
    @State var showEnterCodeView: Bool
    
    @State private var name: String = ""
    
    @ViewBuilder
    var body: some View {
        VStack {
            if !onlineGameManager.errorMessage.isEmpty {
                VStack {
                    Text(onlineGameManager.errorMessage)
                    Text("Try again")
                }
            }
            HStack {
                Text("Name: ")
                TextField("Enter name", text: $name)
                    .overlay(
                        VStack {
                            Divider()
                                .offset(x: 0, y: 15)
                            }
                    )
            }
            .padding()
            if showEnterCodeView {
                HStack {
                    Text("Code: ")
                    TextField("Enter code", text: $codeTextBindingManager.code)
                        .overlay(
                            VStack {
                                Divider()
                                    .offset(x: 0, y: 15)
                                }
                        )
                        .autocapitalization(UITextAutocapitalizationType.allCharacters)
                }
                .padding()
            }
            Button(action: {
                if showEnterCodeView {
                    onlineGameManager.joinGame(code: codeTextBindingManager.code, name: name)
                } else {
                    onlineGameManager.startNewGame(with: name)
                }
            }) {
                Text(showEnterCodeView ? "Join" : "Start")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
                }
            .disabled(name.isEmpty)
        }
        .padding()
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
            EnterNameView(onlineGameManager: OnlineGameManager(), showEnterCodeView: true)
//            EnterNameView(onlineGameManager: OnlineGameManager(), showEnterCodeView: false)
//        }
    }
}
