//
//  EditContactView.swift
//  SwiftDataContacts
//
//  Created by Stephan Dowless on 6/9/23.
//

import SwiftUI

struct EditItemView: View {
    @ObservedObject var item: Item
    @Environment(\.dismiss) private var dismiss
    @State private var isEditingEnabled = false
    @State private var isShowingConfirmation = false
    @State private var originalItem: Item?
        
        
    
    var body: some View {
        Form {
           
            Section {
                TextField("Url", text: $item.serviceUrl).disabled(!isEditingEnabled)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }
            
            Section {
                TextField("Username", text: $item.serviceUsername).disabled(!isEditingEnabled)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
          
                SecureField("Password", text: $item.servicePassword).disabled(!isEditingEnabled)
                    .keyboardType(.default)
                    
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if isEditingEnabled {
                        
                        isShowingConfirmation = true
                    } else {
                        originalItem = Item(serviceUsername: item.serviceUsername, servicePassword: item.servicePassword,
                                            serviceUrl: item.serviceUrl, lastUpdated: item.lastUpdated)
                        
                        isEditingEnabled.toggle()
                    }
                }) {
                    Text(isEditingEnabled ? "Done" : "Edit")
                }
            }
        }
        .confirmationDialog("Confirm", isPresented: $isShowingConfirmation, titleVisibility: .visible) {
                    Button("Save") {
                        isEditingEnabled.toggle()
                        isShowingConfirmation = false
                    }
                    Button("Discard", role: .cancel) {
                        isShowingConfirmation = false
                        
                        guard let originalItem = originalItem else { return }
                            item.serviceUrl = originalItem.serviceUrl
                            item.serviceUsername = originalItem.serviceUsername
                            item.servicePassword = originalItem.servicePassword
                            item.lastUpdated = originalItem.lastUpdated
                            self.originalItem = nil
                        isEditingEnabled.toggle()
                        
                    }
                }
        .navigationBarTitle("Edit Item", displayMode: .inline)
    }
}
