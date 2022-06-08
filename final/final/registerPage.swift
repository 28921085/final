//
//  registerPage.swift
//  final
//
//  Created by 1+ on 2022/5/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
struct registerPage: View {
    @Binding var viewController:Int
    @State private var account = ""
    @State private var passwd1 = ""
    @State private var passwd2 = ""
    @State private var alertTitle:String = "Q"
    @State private var isPresented:Bool=false
    var body: some View {
        VStack{
            Button{
                viewController=0
            }label:{
                Text("上一頁")
            }
            Form {
                VStack {
                    Text("Enter your e-mail")
                    TextField("", text: $account)
                        .autocapitalization(.none)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                VStack {
                    Text("Enter your password")
                    SecureField("", text: $passwd1)
                        .autocapitalization(.none)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                VStack {
                    Text("Enter your password again")
                    SecureField("", text: $passwd2)
                        .autocapitalization(.none)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    if passwd1 != passwd2{
                        alertTitle="兩次輸入的密碼不一樣"
                        isPresented=true
                    }
                    else{
                        Auth.auth().createUser(withEmail: account, password: passwd1) { result, error in
                             guard let user = result?.user,
                                   error == nil else {
                                 print(error?.localizedDescription)
                                 alertTitle="註冊失敗"
                                 isPresented=true
                                 return
                             }
                            alertTitle="註冊成功，請前往設置個人資料"
                            isPresented=true
                             print(user.email, user.uid)
                           
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
                    if alertTitle == "註冊成功，請前往設置個人資料"/*"註冊成功，請回登入畫面登入"*/{
                        viewController=4
                    }
                }
            })
        }
    }
}
/*
struct registerPage_Previews: PreviewProvider {
    static var previews: some View {
        registerPage()
    }
}*/
