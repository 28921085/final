//
//  Game_main.swift
//  final
//
//  Created by 1+ on 2022/6/15.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Game_killer: View {
    @Binding var viewController:Int
    @Binding var kx:Int
    @Binding var ky:Int
    @Binding var playerstate:[playerState]
    @Binding var game:mapInfo
    @Binding var roomID:Int
    @Binding var whichPlayer:Int
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    @State private var map=Array(repeating: Array(repeating: 0, count: 100), count: 100)
    //@State private var kx=12 //offset x,y  = 50,50 map=50-74 (25x25)
    //@State private var ky=12
    @State private var command:[Int]=[0,0,0]
    @State private var energy:Int=5
    @State private var energyMax:Int=5
    @State private var HP:Int=10
    @State private var HPMax:Int=10
    @State private var killerType="♛"
    @State private var killer=["♛","♜","♝","♞"]
    @State private var human=["♙","♕"]
    @State private var changeCount:Int=0
    @State private var item:Int = 0 //0=empty 1=king 2=castle
    @State private var refresh:Timer?
    //♙♕
    //♛♜♝♞
    var index_offset=50
    var kingMove:Set<[Int]> = [[1,0],[1,1],[1,-1],[0,1],[0,-1],[-1,1],[-1,0],[-1,-1]]
    var knightMove:Set<[Int]> = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]
    var all_boxes = [[7,2],[2,7],[5,9],[5,15],[2,17],[7,22],[9,5],[15,5],[12,12],[9,19],[15,19],[17,2],[22,7],[19,9],[19,15],[22,17],[17,22]]
    var all_main_target = [[4,4],[3,12],[4,20],[12,3],[12,21],[20,4],[21,12],[20,20]]
    func check(x:Int,y:Int)->Bool{
        var tx=x-4
        var ty=y-4
        if killerType == "♛"{
            return kingMove.contains([tx,ty])
        }
        else if killerType == "♜"{
            if  !(tx == 0 && ty == 0){//!=中心
                //直線
                if tx == 0{
                    if ty > 0{
                        for i in(1...ty){
                            if map[kx+index_offset][ky+i+index_offset] == 1{
                                return false
                            }
                        }
                    }
                    else{
                        ty *= -1
                        for i in(1...ty){
                            if map[kx+index_offset][ky-i+index_offset] == 1{
                                return false
                            }
                        }
                    }
                    return true
                }
                if ty == 0{
                    if tx > 0{
                        for i in(1...tx){
                            if map[kx+i+index_offset][ky+index_offset] == 1{
                                return false
                            }
                        }
                    }
                    else{
                        tx *= -1
                        for i in(1...tx){
                            if map[kx-i+index_offset][ky+index_offset] == 1{
                                return false
                            }
                        }
                    }
                    return true
                }
            }
        }
        else if killerType == "♝"{
            if  tx != 0 && ty != 0 {//!=中心
                //直線
                if abs(tx) != abs(ty){
                    return false
                }
                if tx > 0{
                    if ty > 0{
                        for i in(1...ty){
                            if map[kx+i+index_offset][ky+i+index_offset] == 1{
                                return false
                            }
                        }
                    }
                    else{
                        for i in(1...tx){
                            if map[kx+i+index_offset][ky-i+index_offset] == 1{
                                return false
                            }
                        }
                    }
                }
                else{
                    if ty > 0{
                        for i in(1...ty){
                            if map[kx-i+index_offset][ky+i+index_offset] == 1{
                                return false
                            }
                        }
                    }
                    else{
                        ty *= -1
                        for i in(1...ty){
                            if map[kx-i+index_offset][ky-i+index_offset] == 1{
                                return false
                            }
                        }
                    }
                }
                return true
            }
        }
        else if killerType == "♞"{
            return knightMove.contains([tx,ty])
        }
        return false
    }
    func turnGround(x:Int,y:Int){
        map[x+index_offset][y+index_offset]=0
        //return to database
        
    }
    func move(x:Int,y:Int){
        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["x":kx+x],merge:true)
        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["y":ky+y],merge:true)
        //kx += x
        //ky += y
    }
    func openBox(){
        var op = Int.random(in: (1...5))
        switch op{
        case 1:
            Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["HP":min(HP + Int.random(in: 1...3), HPMax)],merge:true)
            //HP = min(HP + Int.random(in: 1...3), HPMax)
        case 2:
            Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["energy":min(energy + Int.random(in: 1...3), energyMax)],merge:true)
            //energy = min(energy + Int.random(in: 1...3), energyMax)
        case 3:// 1 = king
            item = 2//castle
        case 4:
            item = 3//
        case 5:
            item = 4 //knight
        default:
            break
        }
    }
    var body: some View {
        ZStack{
            Image("fog")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onAppear(perform: {
                    map=factory().map
                    refresh = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ t in
                        Firestore.firestore().collection("games").document("\(roomID)").collection("map").document("info").getDocument { document, error in
                            guard let document = document,document.exists,
                            var data = try? document.data(as: mapInfo.self)
                            else {return}
                            game = data
                        }
                        for i in(0...3){
                            Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p\(i+1)").getDocument{
                                doc1, err1 in
                                guard let doc1 = doc1,doc1.exists,
                                var data1 = try? doc1.data(as: playerState.self)
                                else {return}
                                playerstate[i] = data1
                            }
                        }
                        
                        for i in(0..<17){
                            if game.boxOpened[i] == 1{
                                turnGround(x: all_boxes[i][0], y: all_boxes[i][1])
                            }
                        }
                        for i in(0..<8){
                            if game.mainTargetOpened[i] == 1{
                                turnGround(x: all_main_target[i][0], y: all_main_target[i][1])
                            }
                        }
                        killerType = killer[playerstate[0].role]
                        HP = playerstate[0].HP
                        energy = playerstate[0].energy
                        kx = playerstate[0].x
                        ky = playerstate[0].y
                    }
                })
            
            VStack{
                Spacer()
                VStack(spacing:0){//vision
                    ForEach(0..<9){ i in
                        HStack(spacing:0){
                            ForEach(0..<9){ j in
                                if i == 0 || j == 0 || i == 8 || j == 8{
                                    //fog()
                                    Rectangle()
                                        .fill(Color.gray)
                                        .opacity(0.3)
                                        .frame(width:screenWidth/10,height: screenWidth/10)
                                }
                                else{
                                    if map[i+kx+index_offset-4][j+ky+index_offset-4] == 0{//ground
                                        Rectangle()
                                            .fill(check(x: i, y: j) ? (command[0] == 1 ? Color.red : (command[1] == 1 ? Color.green : (command[2] == 1 ? Color.yellow : Color.gray))) :  Color.gray)
                                            .frame(width:screenWidth/10,height: screenWidth/10)
                                            .overlay(
                                                ZStack{
                                                    if i == 4 && j == 4{
                                                        Text("\(killerType)").font(.system(size:screenWidth/10))
                                                    }
                                                    if playerstate[1].x-kx == i-4 && playerstate[1].y-ky == j-4{
                                                        Text("\(human[playerstate[1].role])").font(.system(size:screenWidth/10))
                                                    }
                                                    if playerstate[2].x-kx == i-4 && playerstate[2].y-ky == j-4{
                                                        Text("\(human[playerstate[2].role])").font(.system(size:screenWidth/10))
                                                    }
                                                    if playerstate[3].x-kx == i-4 && playerstate[3].y-ky == j-4{
                                                        Text("\(human[playerstate[3].role])").font(.system(size:screenWidth/10))
                                                    }
                                                }
                                                
                                                /*(i == 4 && j == 4) ?
                                                Text("\(killerType)").font(.system(size:screenWidth/10))
                                                 : Text("")*/
                                            )
                                            .onTapGesture(perform: {
                                                if check(x: i, y: j){
                                                    if command[0] == 1{
                                                        //attack
                                                        command[0]=0
                                                    }
                                                    else if command[1] == 1{
                                                        move(x: i-4, y: j-4)
                                                        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["energy":energy-1],merge:true)
                                                        command[1]=0
                                                    }
                                                    else if command[2] == 1{
                                                        //attackmove
                                                        move(x: i-4, y: j-4)
                                                        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["energy":energy-2],merge:true)
                                                        command[2]=0
                                                    }
                                                }
                                                
                                            })
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 1{//wall
                                        wall()
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 2{//box
                                        ZStack{
                                            box()
                                                .onTapGesture(perform: {
                                                    if check(x: i, y: j){
                                                        if command[1] == 1{//move
                                                            var tmp = game.boxOpened
                                                            var pair = [i+kx-4,j+ky-4]
                                                            for p in (0..<17){
                                                                if all_boxes[p] == pair{
                                                                    tmp[p] = 1
                                                                }
                                                            }
                                                            Firestore.firestore().collection("games").document("\(roomID)").collection("map").document("info").setData(["boxOpened":tmp],merge:true)
                                                            //turnGround(x: i-4+kx, y: j-4+ky)
                                                            move(x: i-4, y: j-4)
                                                            openBox()
                                                            command[1] = 0
                                                        }
                                                        else if command[2] == 1{//attackmove
                                                            //move
                                                            var tmp = game.boxOpened
                                                            var pair = [i+kx-4,j+ky-4]
                                                            for p in (0..<17){
                                                                if all_boxes[p] == pair{
                                                                    tmp[p] = 1
                                                                }
                                                            }
                                                            Firestore.firestore().collection("games").document("\(roomID)").collection("map").document("info").setData(["boxOpened":tmp],merge:true)
                                                            //turnGround(x: i-4+kx, y: j-4+ky)
                                                            move(x: i-4, y: j-4)
                                                            openBox()
                                                            
                                                            //attack
                                                            command[2]=0
                                                        }
                                                    }
                                                    
                                                })
                                            Rectangle()
                                                .fill(check(x: i, y: j) ? (command[0] == 1 ? Color.red : (command[1] == 1 ? Color.green : (command[2] == 1 ? Color.yellow : Color.gray))) :  Color.gray)
                                                .opacity(0.5)
                                                .frame(width:screenWidth/10,height: screenWidth/10)
                                        }
                                        
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 3{//main target
                                        ZStack{
                                            main_target()
                                            Rectangle()
                                                .fill(Color.gray)
                                                .opacity(0.5)
                                                .frame(width:screenWidth/10,height: screenWidth/10)
                                        }
                                        
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 4{//boundary
                                        fog()
                                    }
                                }
                                
                            }
                        }
                    }
                }
                //Spacer()
                //Spacer()
                HStack(spacing:3){
                    Text("❤️")
                    ForEach(0..<HPMax){e in
                        Rectangle()
                            .fill(HP > e ? Color.red : Color.gray)
                            .frame(width: screenWidth/16, height: 8)
                    }
                }
                HStack{
                    Text("⚡")
                    ForEach(0..<energyMax){e in
                        Rectangle()
                            .fill(energy > e ? Color.yellow : Color.gray)
                            .frame(width: screenWidth/8, height: 8)
                    }
                }
                HStack{
                    ZStack{
                        Circle() //tool
                            .stroke(Color.black, lineWidth: 3)
                            .frame(width: screenWidth/5.8, height:screenWidth/5.8)
                        Text(//♚♜♝♞
                            item == 0 ? "" :
                                item == 1 ? "♛" :
                                item == 2 ? "♜" :
                                item == 3 ? "♝" : "♞"
                        )
                            .font(.system(size:40))
                            .onTapGesture(perform: {
                                if item != 0{
                                    
                                    var tmpType = killerType
                                    if item == 1{
                                        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["role":0],merge:true)
                                        //killerType = "♛"
                                    }
                                    else if item == 2{
                                        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["role":1],merge:true)
                                        //killerType = "♜"
                                    }
                                    else if item == 3{
                                        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["role":2],merge:true)
                                        //killerType = "♝"
                                    }
                                    else if item == 4{
                                        Firestore.firestore().collection("games").document("\(roomID)").collection("players").document("p1").setData(["role":3],merge:true)
                                        //killerType = "♞"
                                    }
                                    if tmpType == "♛"{
                                        item = 1
                                    }
                                    else if tmpType == "♜"{
                                        item = 2
                                    }
                                    else if tmpType == "♝"{
                                        item = 3
                                    }
                                    else if tmpType == "♞"{
                                        item = 4
                                    }
                                }
                            })
                    }
                    
                   /* Circle() //change
                        .stroke(Color.black, lineWidth: 3)
                        .frame(width: screenWidth/5.8, height:screenWidth/5.8)
                        .overlay(Text("change"))
                        .onTapGesture(perform: {
                            changeCount += 1
                            killerType = change[changeCount % 4]
                        })*/
                }
                HStack{
                    ZStack{
                        Circle()
                            .stroke(command[0]==0 ? Color.black : Color.blue, lineWidth: 5)
                            .frame(width: screenWidth/5.8, height:screenWidth/5.8)
                        Circle()
                            .fill(Color.orange)
                            .frame(width: screenWidth/6, height: screenWidth/6)
                            .overlay(
                                VStack{
                                    Text("ATK")
                                    Text("⚡1")
                                }
                            )
                            .onTapGesture {
                                if command[1] == 0 && command[2] == 0 && energy >= 1{
                                    command[0] ^= 1
                                    
                                }
                            }
                    }
                    ZStack{
                        Circle()
                            .stroke(command[1]==0 ? Color.black : Color.blue, lineWidth: 5)
                            .frame(width: screenWidth/5.8, height:screenWidth/5.8)
                        Circle()
                            .fill(Color.green)
                            .frame(width: screenWidth/6, height: screenWidth/6)
                            .overlay(
                                VStack{
                                    Text("Move")
                                    Text("⚡1")
                                }
                            )
                            .onTapGesture {
                                if command[0] == 0 && command[2] == 0 && energy >= 1{
                                    command[1] ^= 1
                                    
                                }
                            }
                        
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(command[2]==0 ? Color.black : Color.blue, lineWidth: 5)
                            .frame(width: screenWidth/2.9, height:screenWidth/5.8)
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.red)
                            .frame(width: screenWidth/3, height: screenWidth/6)
                            .overlay(
                                VStack{
                                    Text("ATK&Move")
                                    Text("⚡2")
                                }
                            )
                            .onTapGesture {
                                if command[1] == 0 && command[0] == 0 && energy >= 2{
                                    command[2] ^= 1
                                    
                                }
                            }
                    }
                    
                    
                    
                }
                Spacer()
            }
        }
        
        
    }
}
/*
struct Game_killer_Previews: PreviewProvider {
    static var previews: some View {
        Game_killer()
    }
}
*/
