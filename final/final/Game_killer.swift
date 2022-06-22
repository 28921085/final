//
//  Game_main.swift
//  final
//
//  Created by 1+ on 2022/6/15.
//

import SwiftUI

struct Game_killer: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    @State private var map=Array(repeating: Array(repeating: 0, count: 100), count: 100)
    @State private var kx=12 //offset x,y  = 50,50 map=50-74 (25x25)
    @State private var ky=12
    @State private var command:[Int]=[0,0,0]
    @State private var energy:Int=5
    @State private var energyMax:Int=5
    @State private var HP:Int=10
    @State private var HPMax:Int=10
    @State private var killerType="♚"
    @State private var change=["♚","♜","♝","♞"]
    @State private var changeCount:Int=0
    @State private var item:Int = 0 //0=empty
    //♙♕
    //♚♜♝♞
    var index_offset=50
    var kingMove:Set<[Int]> = [[1,0],[1,1],[1,-1],[0,1],[0,-1],[-1,1],[-1,0],[-1,-1]]
    var knightMove:Set<[Int]> = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]
    
    var killerSpawnPoint:Set<[Int]> = [[22,12],[22,2],[22,22]]
    func check(x:Int,y:Int)->Bool{
        var tx=x-4
        var ty=y-4
        if killerType == "♚"{
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
    var body: some View {
        ZStack{
            Image("fog")
                .resizable()
                .scaledToFill()
                .onAppear(perform: {
                    //map[63][63]=1
                    var spawn = killerSpawnPoint.randomElement()
                    if let tmpx = spawn?[0]{
                        kx = tmpx
                    }
                    if let tmpy = spawn?[1]{
                        ky = tmpy
                    }
                    for i in(0..<100){
                        for j in(0..<50){
                            map[j][i]=4
                            map[i][j]=4
                        }
                    }
                    for i in(0..<100){
                        for j in(0..<25){
                            map[99-j][i]=4
                            map[i][99-j]=4
                        }
                    }
                    for i in(0...24){//wall
                        map[0+index_offset][i+index_offset]=1
                        map[i+index_offset][0+index_offset]=1
                        map[24+index_offset][i+index_offset]=1
                        map[i+index_offset][24+index_offset]=1
                    }
                    for i in(1...6){
                        map[0+i+index_offset][8+index_offset]=1
                        map[0+i+index_offset][16+index_offset]=1
                        map[25-i+index_offset][8+index_offset]=1
                        map[25-i+index_offset][16+index_offset]=1
                        map[8+index_offset][0+i+index_offset]=1
                        map[16+index_offset][0+i+index_offset]=1
                        map[8+index_offset][25-i+index_offset]=1
                        map[16+index_offset][25-i+index_offset]=1
                    }
                    for i in(0...2){
                        map[10+index_offset][12+i+index_offset]=1
                        map[16+index_offset][12-i+index_offset]=1
                        map[13-i+index_offset][9+index_offset]=1
                        map[13+i+index_offset][15+index_offset]=1
                    }
                    
                    map[2+index_offset][7+index_offset]=2
                    map[7+index_offset][2+index_offset]=2
                    map[5+index_offset][9+index_offset]=2
                    map[5+index_offset][15+index_offset]=2
                    map[2+index_offset][17+index_offset]=2
                    map[7+index_offset][22+index_offset]=2
                    map[9+index_offset][5+index_offset]=2
                    map[15+index_offset][5+index_offset]=2
                    map[12+index_offset][12+index_offset]=2
                    map[9+index_offset][19+index_offset]=2
                    map[15+index_offset][19+index_offset]=2
                    map[17+index_offset][2+index_offset]=2
                    map[22+index_offset][7+index_offset]=2
                    map[19+index_offset][9+index_offset]=2
                    map[19+index_offset][15+index_offset]=2
                    map[22+index_offset][17+index_offset]=2
                    map[17+index_offset][22+index_offset]=2
                    
                    map[4+index_offset][4+index_offset]=3
                    map[3+index_offset][12+index_offset]=3
                    map[4+index_offset][20+index_offset]=3
                    map[12+index_offset][3+index_offset]=3
                    map[12+index_offset][21+index_offset]=3
                    map[20+index_offset][4+index_offset]=3
                    map[21+index_offset][12+index_offset]=3
                    map[20+index_offset][20+index_offset]=3
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
                                                (i == 4 && j == 4) ?
                                                Text("\(killerType)").font(.system(size:screenWidth/10))
                                                 : Text("")
                                            )
                                            .onTapGesture(perform: {
                                                if check(x: i, y: j){
                                                    if command[0] == 1{
                                                        //attack
                                                    }
                                                    else if command[1] == 1{
                                                        //print("\(i):\(j)")
                                                        kx += i-4
                                                        ky += j-4
                                                        energy -= 1
                                                    }
                                                    else if command[2] == 1{
                                                        //attackmove
                                                        kx += i-4
                                                        ky += j-4
                                                        energy -= 2
                                                    }
                                                }
                                                
                                            })
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 1{//wall
                                        wall()
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 2{//box
                                        box()
                                            .onTapGesture(perform: {
                                                
                                            })
                                    }
                                    else if map[i+kx+index_offset-4][j+ky+index_offset-4] == 3{//main target
                                        main_target()
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
                    Circle() //tool
                        .stroke(Color.black, lineWidth: 3)
                        .frame(width: screenWidth/5.8, height:screenWidth/5.8)
                    Circle() //change
                        .stroke(Color.black, lineWidth: 3)
                        .frame(width: screenWidth/5.8, height:screenWidth/5.8)
                        .overlay(Text("change"))
                        .onTapGesture(perform: {
                            changeCount += 1
                            killerType = change[changeCount % 4]
                        })
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
                                if command[1] == 0 && command[2] == 0{
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
                                if command[0] == 0 && command[2] == 0{
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
                                if command[1] == 0 && command[0] == 0{
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

struct Game_killer_Previews: PreviewProvider {
    static var previews: some View {
        Game_killer()
    }
}
