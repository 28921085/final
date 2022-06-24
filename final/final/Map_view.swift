//
//  Map_view.swift
//  final
//
//  Created by 1+ on 2022/6/15.
//

import SwiftUI

struct fog: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
        Image("fog")
            .resizable()
            .frame(width:screenWidth/10,height: screenWidth/10)
    }
}
struct wall: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
        Image("wall")
            .resizable()
            .frame(width:screenWidth/10,height: screenWidth/10)
    }
}

struct box: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
            Image("box")
                .resizable()
                .frame(width:screenWidth/10,height: screenWidth/10)
    }
}
struct main_target: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
            Image("main target")
                .resizable()
                .frame(width:screenWidth/10,height: screenWidth/10)
    }
}


struct large_fog: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
        Image("fog")
            .resizable()
            .frame(width:screenWidth/7.2,height: screenWidth/7.2)
    }
}
struct large_wall: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
        Image("wall")
            .resizable()
            .frame(width:screenWidth/7.2,height: screenWidth/7.2)
    }
}
struct large_box: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
            Image("box")
                .resizable()
                .frame(width:screenWidth/7.2,height: screenWidth/7.2)
    }
}
struct large_main_target: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
            Image("main target")
                .resizable()
                .frame(width:screenWidth/7.2,height: screenWidth/7.2)
    }
}
struct Map_view_Previews: PreviewProvider {
    static var previews: some View {
       
        large_main_target()
            
    }
}


