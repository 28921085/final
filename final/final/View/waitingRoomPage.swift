//
//  waitingRoomPage.swift
//  final
//
//  Created by 1+ on 2022/6/19.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
struct roomHostPage: View {
    @Binding var viewController:Int
    @Binding var roomID:Int
    @Binding var whichPlayer:Int
    @State private var ready=[0,0,0,0]
    @State private var type=[0,1,1,1]
    @State private var change = false
    @State private var refresh:Timer?
    @State private var room = roomInfo()
    @State private var player1 = userData()
    @State private var player2 = userData()
    @State private var player3 = userData()
    @State private var player4 = userData()
    var body: some View {
        ZStack{
            Image("fog")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onAppear(perform: {
                    refresh = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ t in
                        //fetch data
                        if let user = Auth.auth().currentUser {
                            let db = Firestore.firestore()
                            let documentReference = db.collection("rooms").document("\(roomID)")
                            documentReference.getDocument { document, error in
                                guard let document = document,document.exists,
                                var data = try? document.data(as: roomInfo.self)
                                else {return}
                                room = data
                                if data.player1_ID != ""{
                                        Firestore.firestore().collection("userdatas").document("\(data.player1_ID)").getDocument{
                                            doc1, err1 in
                                            guard let doc1 = doc1,doc1.exists,
                                            var data1 = try? doc1.data(as: userData.self)
                                            else {return}
                                            player1 = data1
                                        }
                                }
                                else {
                                    player1 = userData()
                                }
                                if data.player2_ID != ""{
                                        Firestore.firestore().collection("userdatas").document("\(data.player2_ID)").getDocument{
                                            doc1, err1 in
                                            guard let doc1 = doc1,doc1.exists,
                                            var data1 = try? doc1.data(as: userData.self)
                                            else {return}
                                            player2 = data1
                                        }
                                }
                                else {
                                    player2 = userData()
                                }
                                if data.player3_ID != ""{
                                        Firestore.firestore().collection("userdatas").document("\(data.player3_ID)").getDocument{
                                            doc1, err1 in
                                            guard let doc1 = doc1,doc1.exists,
                                            var data1 = try? doc1.data(as: userData.self)
                                            else {return}
                                            player3 = data1
                                        }
                                }
                                else {
                                    player3 = userData()
                                }
                                if data.player4_ID != ""{
                                        Firestore.firestore().collection("userdatas").document("\(data.player4_ID)").getDocument{
                                            doc1, err1 in
                                            guard let doc1 = doc1,doc1.exists,
                                            var data1 = try? doc1.data(as: userData.self)
                                            else {return}
                                            player4 = data1
                                        }
                                }
                                else {
                                    player4 = userData()
                                }
                            }
                        }
                        if room.game_start{
                            if whichPlayer == 1{
                                
                            }
                            else if whichPlayer == 2{
                                
                            }
                            else if whichPlayer == 3{
                                
                            }
                            else if whichPlayer == 4{
                                
                            }
                            
                        }
                    }
                   
                })
            VStack{
                HStack{
                    Button{
                        if room.playerCount == 1{
                            Firestore.firestore().collection("rooms").document("\(roomID)").delete()
                            viewController=3
                            return
                        }
                        if whichPlayer == 1{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p1ready": false],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player1_ID": ""],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": room.playerCount-1],merge: true)
                        }
                        else if whichPlayer == 2{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p2ready": false],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player2_ID": ""],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": room.playerCount-1],merge: true)
                        }
                        else if whichPlayer == 3{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p3ready": false],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player3_ID": ""],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": room.playerCount-1],merge: true)
                        }
                        else if whichPlayer == 4{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p4ready": false],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["player4_ID": ""],merge: true)
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["playerCount": room.playerCount-1],merge: true)
                        }
                        viewController=3
                    }label:{
                        HStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 70, height: 30, alignment: .center)
                                .overlay(
                                    Text("back")
                                        .foregroundColor(Color.white)
                                )
                        }
                    }
                    //Spacer()
                    Button{
                        if whichPlayer == 1{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p1ready": !room.p1ready],merge: true)
                        }
                        else if whichPlayer == 2{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p2ready": !room.p2ready],merge: true)
                        }
                        else if whichPlayer == 3{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p3ready": !room.p3ready],merge: true)
                        }
                        else if whichPlayer == 4{
                            Firestore.firestore().collection("rooms").document("\(roomID)").setData(["p4ready": !room.p4ready],merge: true)
                        }
                        
                    }label:{
                        HStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 70, height: 30, alignment: .center)
                                .overlay(
                                    Text("ready")
                                        .foregroundColor(Color.white)
                                )
                        }
                    }
                    if whichPlayer == 1{
                        Button{
                            //game start
                            if room.p1ready && room.p2ready && room.p3ready && room.p4ready{
                                Firestore.firestore().collection("rooms").document("\(roomID)").setData(["game_start": true],merge: true)
                            }
                            
                        }label:{
                            HStack(alignment: .center){
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.blue)
                                    .frame(width: 70, height: 30, alignment: .center)
                                    .overlay(
                                        Text("start")
                                            .foregroundColor(Color.white)
                                    )
                            }
                        }
                    }
                    Text("room : \(roomID)")
                        .foregroundColor(Color.green)
                }
                HStack{
                    playerInfo(type: $type[0],ready: $room.p1ready,name:$player1.name,photoURL: $player1.photoURL)
                        
                    playerInfo(type: $type[1],ready: $room.p2ready,name:$player2.name,photoURL: $player2.photoURL)
                }
                
                HStack{
                    playerInfo(type: $type[2],ready: $room.p3ready,name:$player3.name,photoURL: $player3.photoURL)
                    playerInfo(type: $type[3],ready: $room.p4ready,name:$player4.name,photoURL: $player4.photoURL)
                }
            }
        }
    }
}

struct test1: View {
    @State private var viewController = 6
    @State private var roomID = 7201775
    @State private var whichPlayer = 1
    var body: some View {
        roomHostPage(viewController:$viewController,roomID: $roomID,whichPlayer: $whichPlayer)
    }
}
struct waitingRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        test1()
    }
}
