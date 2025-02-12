//
//  InAppSafariKitExampleApp.swift
//  InAppSafariKitExample
//  
//  Created by Chronos2500 on 2025/02/13.
//

import SwiftUI
import InAppSafariKit

@main
struct InAppSafariKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // You can customize the default style here.
                .environment(\.customSafariStyle, CustomSafariStyle())
        }
    }
}
