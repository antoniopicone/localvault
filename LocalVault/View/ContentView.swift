//
//  ContentView.swift
//  LocalVault
//
//  Created by Antonio Picone on 28/10/23.
//

import SwiftUI
import SwiftData
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    @State private var showCreateContactView = false
    @Environment(\.modelContext) private var modelContext
    // @Query private var items: [Item]
    @State private var items = SampleItems.items

    var body: some View {
        
        if isUnlocked {
                        
            NavigationSplitView {
                List {
                    ForEach(items) { item in
                        NavigationLink(value: item) {
                            ItemRowView(item: item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.automatic)
                .navigationDestination(for: Item.self, destination: { item in
                    EditItemView(item: item)
                })
    #if os(macOS)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
    #endif
                .sheet(isPresented: $showCreateContactView, content: {
                    CreateItemView(items: $items)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showCreateContactView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }
                .navigationBarTitle("Passwords")
                
            } detail: {
                Text("Select an item")
            }
            
        } else {
            Button("Unlock App") {
            authenticateWithBiometrics()
                }
        }
        
        
    }
    
    func authenticateWithBiometrics() {
           let context = LAContext()
           var error: NSError?
           
           // Verifica se il dispositivo supporta l'autenticazione biometrica
           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               let reason = "Unlock the app with Face ID"
               
               // Esegue l'autenticazione con Face ID
               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                   DispatchQueue.main.async {
                       if success {
                           // L'autenticazione con Face ID è riuscita
                           isUnlocked = true
                       } else {
                           // L'autenticazione con Face ID non è riuscita
                           print("Authentication failed: \(authenticationError?.localizedDescription ?? "")")
                       }
                   }
               }
           } else {
               // Il dispositivo non supporta l'autenticazione biometrica o non è configurato
               print("Biometric authentication unavailable")
           }
   }
    


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
