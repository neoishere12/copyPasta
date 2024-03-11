//
//  PasswordViewModel.swift
//  ToDo
//
//  Created by Nitin Singh Manhas on 11/03/24.
//

import Foundation
import SwiftUI


class PasswordViewModel: ObservableObject {
    @Published var passwordModel: PasswordModel
    @Published var textFields: [String] = [""]
    @Published var buttonText1: String = "Copy"
    
    init() {
        self.passwordModel = PasswordModel(textFields: [])
        loadTextFieldsFromUserDefaults()
    }
    
    // Implement functions like paste, copyToClipboard, addNewTextField, deleteTextField, saveTextFieldsToUserDefaults
    func paste(index: Int) {
        if let string = UIPasteboard.general.string {
            textFields[index] = string
            print("Text pasted from clipboard: \(textFields[index])")
            saveTextFieldsToUserDefaults()
        }
    }
    
    func copyToClipboard(index: Int) {
        UIPasteboard.general.string = textFields[index]
        self.buttonText1 = "copied!"
        print("Text copied to clipboard: \(textFields[index])")
    }
    
    func addNewTextField() {
        textFields.append("")
        saveTextFieldsToUserDefaults()
    }
    
    func deleteTextField(index: Int) {
        guard textFields.indices.contains(index) else { return }
        textFields.remove(at: index)
        saveTextFieldsToUserDefaults()
    }
    
    func saveTextFieldsToUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(textFields, forKey: "myKey")
    }
    
    func loadTextFieldsFromUserDefaults() {
        if let loadedTextFields = UserDefaults.standard.array(forKey: "myKey") as? [String] {
            textFields = loadedTextFields
        }
    }
}
