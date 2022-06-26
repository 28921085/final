//
//  Game_map.swift
//  final
//
//  Created by 1+ on 2022/6/15.
//


struct factory: Codable{
    var map:[[Int]]
    init(){
        map=Array(repeating: Array(repeating: 0, count: 100), count: 100)
        var index_offset=50
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
    }
}
