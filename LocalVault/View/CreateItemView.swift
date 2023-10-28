//
//  CreateContactView.swift
//  SwiftDataContacts
//
//  Created by Stephan Dowless on 6/9/23.
//

import SwiftUI

struct CreateItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var items: [Item]
    @State private var serviceUsername = ""
    @State private var serviceUrl = ""
    @State private var servicePassword = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Url", text: $serviceUrl)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
                
                Section {
                    TextField("Username", text: $serviceUsername)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
              
                    SecureField("Password", text: $servicePassword)
                        .keyboardType(.default)
                        
                }
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        withAnimation {
                            let newItem = Item(
                                serviceUsername: serviceUsername,
                                servicePassword: servicePassword,
                                serviceUrl: serviceUrl,
                                lastUpdated: Date()
                            )
                            items.append(newItem)
                            dismiss()
                        }
                    }
                    .bold()
                }
            }
        }
    }
}
