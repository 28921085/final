//
//  userPage.swift
//  final
//
//  Created by 1+ on 2022/6/1.
//

import SwiftUI
import FirebaseAuth
struct userPage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
    var body: some View {
        VStack{
            HStack{
                Button{
                    viewController=0
                }label:{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 70, height: 30, alignment: .center)
                            .overlay(
                                Text("上一頁")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
                Button{
                    viewController=4
                }label:{
                    VStack{
                        HStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 120, height: 60, alignment: .center)
                                .overlay(
                                    VStack{
                                        Text("👤")
                                            .foregroundColor(Color.white)
                                        Text("\(userMail)")
                                            .foregroundColor(Color.white)
                                    }
                                )
                        }
                    }
                }
                Button{
                    do {
                        if let user = Auth.auth().currentUser {
                           print(user.uid, user.email)
                            
                        }
                       try Auth.auth().signOut()
                        if let user = Auth.auth().currentUser {
                           print(user.uid, user.email)
                            
                        }
                        viewController=0
                    } catch {
                       print(error)
                    }
                    //viewController=1
                }label:{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 60, height: 30, alignment: .center)
                            .overlay(
                                Text("登出")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
            }
            
            
        }
        
    }
}
/*
struct userPage_Previews: PreviewProvider {
    static var previews: some View {
        userPage()
    }
}
*/
