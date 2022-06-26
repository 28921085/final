//
//  userPage.swift
//  final
//
//  Created by 1+ on 2022/6/1.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
struct userPage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
    @Binding var roomID:Int
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
                    viewController=5
                }label:{
                    VStack{
                        HStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 120, height: 60, alignment: .center)
                                .overlay(
                                    Text("👤帳戶中心")
                                        .foregroundColor(Color.white)
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
                Link(destination: URL(string: "https://medium.com/@seer.28921085/ios-%E9%81%8A%E6%88%B2-%E6%9C%9F%E6%9C%AB%E4%BD%9C%E6%A5%ADpart-2-demo-5c6caa7813a2")!
                     , label: {
                    Text("💡")
                })
                
            }
            Button{
                //viewController=5
            }label:{
                VStack{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.green)
                            .frame(width: 120, height: 60, alignment: .center)
                            .overlay(
                                Text("隨機匹配")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
            }
            Button{
                //viewController=5
            }label:{
                VStack{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.green)
                            .frame(width: 120, height: 60, alignment: .center)
                            .overlay(
                                Text("加入房間")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
            }
            Button{
                if let user = Auth.auth().currentUser {
                    print(user.uid, user.email)
                    let db = Firestore.firestore()
                    var data = roomInfo()
                    data.id = user.uid
                    data.player1_ID = user.uid
                    do {
                        let documentReference = try db.collection("rooms").document("\(data.roomNum)").setData(from: data)
                       
                   } catch {
                       print(error)
                   }
                }
                
                
            }label:{
                VStack{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.red)
                            .frame(width: 120, height: 60, alignment: .center)
                            .overlay(
                                Text("創建房間")
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
