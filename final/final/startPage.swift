//
//  startPage.swift
//  final
//
//  Created by 1+ on 2022/5/31.
//

import SwiftUI
import FirebaseAuth
struct startPage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
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
