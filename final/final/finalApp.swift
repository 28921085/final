//
//  finalApp.swift
//  final
//
//  Created by 1+ on 2022/5/30.
//

import SwiftUI
import Firebase
@main
struct finalApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
