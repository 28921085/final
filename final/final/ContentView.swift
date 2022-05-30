//
//  ContentView.swift
//  final
//
//  Created by 1+ on 2022/5/30.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button{
            Auth.auth().signIn(withEmail: "seer.28921085@gmail.com", password: "0000000") { result, error in
                 guard error == nil else {
                    print(error?.localizedDescription)
                    return
                 }
            }
        }label:{
            if let user = Auth.auth().currentUser {
                Text("\(user.uid)")
            } else {
                Text("login")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
