//
//  ContentView.swift
//  final
//
//  Created by 1+ on 2022/5/30.
//

import SwiftUI
import FirebaseAuth
//import SwiftProtobuf
struct ContentView: View {
    @State private var viewController:Int=0
    @State private var userMail:String=""
    @State private var userdata=userData()
    @State private var roomID = 7201775
    @State private var whichPlayer = 1
    var body: some View {
        ZStack{
            /*Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()*/
            switch viewController{
            case 0:
                startPage(viewController: $viewController,userMail: $userMail,userData: $userdata)
            case 1:
                loginPage(viewController: $viewController,userMail: $userMail)
            case 2:
                registerPage(viewController: $viewController)
            case 3:
                userPage(viewController: $viewController,userMail: $userMail,roomID: $roomID,whichPlayer:$whichPlayer)
            case 4:
                userProfileSettingPage(viewController: $viewController,userMail: $userMail)
            case 5:
                userProfilePage(viewController: $viewController)
            case 6:
                roomHostPage(viewController: $viewController,roomID: $roomID,whichPlayer: $whichPlayer)
            /*case 7:
                roomGuestPage(viewController: $viewController,roomID: $roomID)*/
            default:
                startPage(viewController: $viewController,userMail: $userMail,userData: $userdata)
            }
        }
        
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
