//
//  loginView.swift
//  final
//
//  Created by 1+ on 2022/5/31.
//

import SwiftUI
import FirebaseAuth
struct loginPage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
    @State private var account = ""
    @State private var passwd = ""
    @State private var alertTitle:String = ""
    @State private var isPresented:Bool=false
    //🔑👤
    var body: some View {
        VStack{
            Button{
                viewController=0
            }label:{
                Text("上一頁")
            }
            Form {
                HStack {
                    Text("👤")
                    TextField("Enter your account", text: $account)
                        .autocapitalization(.none)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                HStack {
                    Text("🔑")
                    SecureField("Enter your password", text: $passwd)
                        .autocapitalization(.none)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    Auth.auth().signIn(withEmail: account, password: passwd) { result, error in
                         guard error == nil else {
                            print(error?.localizedDescription)
                             //print("fail")
                             alertTitle="login fail"
                             isPresented=true
                             return
                         }
                        if let user = Auth.auth().currentUser {
                            //print("\(user.email)")
                            alertTitle="hi \(user.email ?? "")"
                            userMail = user.email ?? ""
                            isPresented=true
                        }
                    }
                } label: {
                    HStack(alignment: .center){
                        Spacer()
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 60, height: 30, alignment: .center)
                            .overlay(
                                Text("送出")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
            }.alert(alertTitle, isPresented: $isPresented, actions: {
                Button("OK"){
                    if alertTitle != "login fail"{
                        viewController=3
                    }
                }
            })
        }
    }
}
