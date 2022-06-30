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
    @State private var game=mapInfo()
    @State private var playerstate=[playerState(),playerState(),playerState(),playerState()]
    @State private var roomID = 7201775
    @State private var whichPlayer = 1
    @State private var posX = 0
    @State private var posY = 0
    @State private var language = "English"
    var body: some View {
        ZStack{
            /*Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()*/
            switch viewController{
            case 0:
                ZStack{
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    startPage(viewController: $viewController,userMail: $userMail,userData: $userdata)
                }
                
            case 1:
                ZStack{
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    loginPage(viewController: $viewController,userMail: $userMail)
                }
                
            case 2:
                ZStack{
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    registerPage(viewController: $viewController)
                }
                
            case 3:
                ZStack{
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    userPage(viewController: $viewController,userMail: $userMail,roomID: $roomID,whichPlayer:$whichPlayer,language: $language)
                }
                
            case 4:
                
                userProfileSettingPage(viewController: $viewController,userMail: $userMail)
            case 5:
                ZStack{
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    userProfilePage(viewController: $viewController)
                }
                
            case 6:
                roomHostPage(viewController: $viewController,roomID: $roomID,whichPlayer: $whichPlayer,kx:$posX,ky:$posY,language: $language)
            case 7:
                Game_killer(viewController: $viewController,kx:$posX,ky:$posY,playerstate:$playerstate,game:$game,roomID: $roomID,whichPlayer: $whichPlayer,language: $language)
            case 8:
                Game_human(viewController: $viewController,kx:$posX,ky:$posY,playerstate:$playerstate,game:$game,roomID: $roomID,whichPlayer: $whichPlayer,language: $language)
            case 9:
                ZStack{
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    SettingPage(language: $language, viewController: $viewController)
                }
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
