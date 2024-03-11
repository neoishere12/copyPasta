//
//  ContentView.swift
//  ToDo
//
//  Created by Nitin Singh Manhas on 07/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PasswordViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.passwordModel.textFields.count > 2 {
                    ScrollView {
                        content
                    }
                } else {
                    content
                }
            }
            .navigationTitle("copyPasta")
            .onAppear {
                viewModel.loadTextFieldsFromUserDefaults()
            }
        }
    }

    private var content: some View {
        VStack {
            ForEach(viewModel.passwordModel.textFields.indices, id: \.self) { index in
                HStack {
                    TextField("Password", text: $viewModel.passwordModel.textFields[index])
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding()

                    Button(action: {
                        viewModel.copyToClipboard(index: index)
                    }, label: {
                        Label(viewModel.buttonText1, systemImage: "doc.on.doc.fill")
                    })

                    Button(action: {
                        viewModel.paste(index: index)
                    }, label: {
                        Label("Paste", systemImage: "doc.on.doc.fill")
                            .tint(.orange)
                    })
                    .padding()

                    Button(action: {
                        viewModel.deleteTextField(index: index)
                    }, label: {
                        Label("Delete", systemImage: "trash")
                            .tint(.red)
                    })
                    .padding()
                }
            }

            Button(action: {
                viewModel.addNewTextField()
            }, label: {
                Label("Add Textfield", systemImage: "plus")
            })

            Spacer()
        }
    }

}


#Preview {
    ContentView()
}
