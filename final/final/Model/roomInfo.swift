//
//  roomInfo.swift
//  final
//
//  Created by 1+ on 2022/6/25.
//
import FirebaseFirestoreSwift
import FirebaseFirestore
struct roomInfo: Hashable,Codable, Identifiable {
    @DocumentID var id: String?
    var roomNum:Int
    var player1_ID:String
    var player2_ID:String
    var player3_ID:String
    var player4_ID:String
    var p1ready:Bool
    var p2ready:Bool
    var p3ready:Bool
    var p4ready:Bool
    var playerCount:Int
    var game_start:Bool
    init(){
        roomNum = Int.random(in: 1000000...9999999)
        player1_ID = ""
        player2_ID = ""
        player3_ID = ""
        player4_ID = ""
        p1ready = false
        p2ready = false
        p3ready = false
        p4ready = false
        playerCount = 0
        game_start = false
    }
}
