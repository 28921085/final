//
//  Map_view.swift
//  final
//
//  Created by 1+ on 2022/6/15.
//

import SwiftUI

struct fog: View {
    //@Binding var type:Int
   // @State private var fog:Image
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
        Image("fog")
            .resizable()
            .frame(width:screenWidth/10,height: screenWidth/10)
    }
}
struct wall: View {
    //@Binding var type:Int
   // @State private var fog:Image
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var body: some View {
        
        Image("wall")
            .resizable()
            .frame(width:screenWidth/10,height: screenWidth/10)
    }
}
struct Map_view_Previews: PreviewProvider {
    @State private var t:Int=0
    static var previews: some View {
       
        wall()
            
    }
}


