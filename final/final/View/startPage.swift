//
//  startPage.swift
//  final
//
//  Created by 1+ on 2022/5/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
struct startPage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
    @Binding var userData:userData
    var body: some View {
        VStack{
            if let user = Auth.auth().currentUser {
                Button{
                    userMail = user.email ?? ""
                    viewController=3
                }label:{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.green)
                            .frame(width: 200, height: 60, alignment: .center)
                            .overlay(
                                VStack{
                                    Text("quick login")
                                        .foregroundColor(Color.white)
                                    Text("\(user.email ?? "")")
                                        .foregroundColor(Color.white)
                                }
                            )
                            .onAppear(perform: {
                                let db = Firestore.firestore()
                                db.collection("userdatas").document("\(user.uid)").getDocument(completion: { document, error in
                                    guard let document = document,
                                           document.exists,
                                          let userInfo = try? document.data(as: final.userData.self) else {return}
                                    userData=userInfo
                                })
                            })
                    }
                   
                }
            }
            Button{
                viewController=1
            }label:{
                HStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blue)
                        .frame(width: 60, height: 30, alignment: .center)
                        .overlay(
                            Text("登入")
                                .foregroundColor(Color.white)
                        )
                }
            }
            Button{
                viewController=2
            }label:{
                HStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blue)
                        .frame(width: 120, height: 30, alignment: .center)
                        .overlay(
                            Text("建立新帳號")
                                .foregroundColor(Color.white)
                        )
                }
            }
        }
    }
}

/*struct startPage_Previews: PreviewProvider {
    static var previews: some View {
        startPage()
    }
}*/
