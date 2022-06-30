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
    @Binding var whichPlayer:Int
    @Binding var language:String
    @State private var roomNum:String=""
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
                                Text(language == "English" ? "back" : "上一頁")
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
                                    Text(language == "English" ? "👤Account" : "👤帳戶中心")
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
                                Text(language == "English" ? "Logout" : "登出")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
                Button{
                    viewController = 9
                }label:{
                    Text("⚙️")
                }
                Link(destination: URL(string: "https://medium.com/@seer.28921085/ios-%E9%81%8A%E6%88%B2-%E6%9C%9F%E6%9C%AB%E4%BD%9C%E6%A5%ADpart-2-demo-5c6caa7813a2")!
                     , label: {
                    Text("💡")
                })
                
            }
            /*Button{
                
                //viewController=6
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
            }*/
            HStack{
                Spacer()
                TextField(language == "English" ? "Enter room number" : "輸入房間號碼", text: $roomNum)
                    .autocapitalization(.none)
                    .frame(width: 120, height:30 )
                Button{
                    if let user = Auth.auth().currentUser {
                        roomID = Int(roomNum ?? "1000000")!
                        Firestore.firestore().collection("rooms").document("\(roomID)").getDocument{
                            doc1, err1 in
                            guard let doc1 = doc1,doc1.exists,
                            var data1 = try? doc1.data(as: roomInfo.self)
                            else {return}
                            if data1.player1_ID == ""{
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player1_ID": user.uid],merge: true)
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": data1.playerCount+1],merge: true)
                                whichPlayer = 1
                                viewController=6
                            }
                            else if data1.player2_ID == ""{
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player2_ID": user.uid],merge: true)
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": data1.playerCount+1],merge: true)
                                whichPlayer = 2
                                viewController=6
                            }
                            else if data1.player3_ID == ""{
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player3_ID": user.uid],merge: true)
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": data1.playerCount+1],merge: true)
                                whichPlayer = 3
                                viewController=6
                            }
                            else if data1.player4_ID == ""{
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player4_ID": user.uid],merge: true)
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": data1.playerCount+1],merge: true)
                                whichPlayer = 4
                                viewController=6
                            }
                        
                        }
                        
                    }
                }label:{
                    VStack{
                        HStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.green)
                                .frame(width: 120, height: 60, alignment: .center)
                                .overlay(
                                    Text(language == "English" ? "Join Room" : "加入房間")
                                        .foregroundColor(Color.white)
                                )
                        }
                    }
                }
                Spacer()
            }
            
            Button{
                if let user = Auth.auth().currentUser {
                    print(user.uid, user.email)
                    let db = Firestore.firestore()
                    var data = roomInfo()
                    data.id = user.uid
                    data.player1_ID = user.uid
                    data.playerCount = 1
                    roomID = data.roomNum
                    whichPlayer = 1
                    do {
                        let documentReference = try db.collection("rooms").document("\(data.roomNum)").setData(from: data)
                       
                   } catch {
                       print(error)
                   }
                }
                viewController = 6
                
            }label:{
                VStack{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.red)
                            .frame(width: 120, height: 60, alignment: .center)
                            .overlay(
                                Text(language == "English" ? "Create Room" : "創建房間")
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
