//
//  YumHuntApp.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/13/23.
//

import SwiftUI

@main
struct YumHuntApp: App {
    var body: some Scene {
        WindowGroup {
            HomePage()
                .environmentObject(ApiData())
           
        }
    }
}
