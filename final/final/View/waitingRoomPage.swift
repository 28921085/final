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
struct waitingRoomPage: View {
    @Binding var viewController:Int
    @Binding var roomID:Int
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    @State private var ready=[0,0,0,0]
    @State private var type=[0,1,1,1]
    @State private var change = false
    @StateObject var roomData = MyRoom()
    var body: some View {
        ZStack{
            Image("fog")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onAppear(perform: {
                    if let user = Auth.auth().currentUser {
                        let db = Firestore.firestore()
                        let documentReference = db.collection("rooms").document("\(roomID)")
                        documentReference.getDocument { document, error in
                            guard let document = document,document.exists,
                            var data = try? document.data(as: roomInfo.self)
                            else {return}
                            roomData.roomData = data
                            
                        }
                    }
                })
            VStack{
                HStack{
                    Button{
                        if let user = Auth.auth().currentUser {
                            let db = Firestore.firestore()
                            let documentReference = db.collection("rooms").document("\(roomID)")
                            documentReference.getDocument { document, error in
                                guard let document = document,document.exists,
                                var data = try? document.data(as: userData.self)
                                else {return}
                                
                            }
                              
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
                }
                HStack{
                    playerInfo(type: $type[0])
                        
                    playerInfo(type: $type[1])
                }
                
                HStack{
                    playerInfo(type: $type[2])
                    playerInfo(type: $type[3])
                }
            }
        }
        .fullScreenCover(isPresented: $change)
                    { Game_killer() }
                    .onAppear{
                    
                    }
                    .onReceive(self.roomData.roomData.p1ready){	not in
                        
                    }
    }
}
struct test1: View {
    @State private var viewController = 6
    @State private var roomID = 7201775
    var body: some View {
        waitingRoomPage(viewController:$viewController,roomID: $roomID)
    }
}
struct waitingRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        test1()
    }
}
