//
//  ContentView.swift
//  ToDo
//
//  Created by Nitin Singh Manhas on 07/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var textFields: [String] = [""]
    @State private var text: String = ""
    @State private var buttonText1: String = "Copy"

    var body: some View {
        NavigationView {
            Group {
                if textFields.count > 2 {
                    ScrollView {
                        content
                    }
                } else {
                    content
                }
            }
            .navigationTitle("Passwords")
        }
    }

    private var content: some View {
        VStack {
            Text("helo")
            ForEach(textFields.indices, id: \.self) { index in
                HStack {
                    TextField("Password", text: $textFields[index])
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding()
                    
                    Button(action: {
                        copyToClipboard(index: index)
                    }, label: {
                        Label(buttonText1, systemImage: "doc.on.doc.fill")
                    })
                    
                    Button(action: {
                        paste(index: index)
                    }, label: {
                        Label("Paste", systemImage: "doc.on.doc.fill")
                            .tint(.orange)
                    })

                    .padding()
                }
            }

            Button(action: {
                addNewTextField()
            }, label: {
                Label("Add Textfield", systemImage: "plus")
            })

            Spacer()
        }
    }

    func paste(index: Int) {
           if let string = UIPasteboard.general.string {
               textFields[index] = string
               print("Text pasted from clipboard: \(textFields[index])")
           }
       }
    
    func copyToClipboard(index: Int) {
        UIPasteboard.general.string = textFields[index]
        self.buttonText1 = "copied!"
        print("Text copied to clipboard: \(textFields[index])")
    }

    func addNewTextField() {
        textFields.append("")
    }
}

#Preview {
    ContentView()
}
