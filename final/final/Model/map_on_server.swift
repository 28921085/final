//
//  map_on_server.swift
//  final
//
//  Created by 1+ on 2022/6/24.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
struct playerState: Hashable,Codable, Identifiable {
    @DocumentID var id: String?
    var x:Int
    var y:Int
    var HP:Int
    var energy:Int
    var energyRecovery:Int
    var role:Int //killer 0 1 2 3   human 0 1
    //var thisTurnCannotMove:Bool
    var isDead:Bool
    var distanceFromKiller:Double
    init(){
        x=0
        y=0
        HP=5
        energy=3
        energyRecovery=3
        role=0
        //thisTurnCannotMove=false
        isDead=true
        distanceFromKiller=50 //inf  l1: 0-3 l2: 4-6 l3: 7-10
    }
}
struct mapInfo: Hashable,Codable, Identifiable {
    @DocumentID var id: String?
    var type:Int //0 factory 1 puzzle
    var boxOpened:[Int]
    var mainTargetOpened:[Int]
    var turnToWho:Int //1,2,3,4
    var animateForAll:Bool //all player see last player move (if can see)
    init(){
        type=0
        boxOpened=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] //17 boxes or less
        mainTargetOpened=[0,0,0,0,0,0,0,0]//8 target
        turnToWho=1
        animateForAll=false
    }
}
