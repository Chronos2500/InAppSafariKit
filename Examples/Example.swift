//
//  Example.swift
//  InAppSafariKitExample
//
//  Created by Chronos2500 on 2025/02/11.
//

import SwiftUI
//import InAppSafariKit

struct ContentView: View {
    private let url = URL(string: "https://www.apple.com")!
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Link("Open Default Browser", destination: url)
                    Link("Open by InAppSafariKit (Default)", destination: url)
                        .OpenURLInAppSafari()
                }
                Section {
                    Link("Bar Collapsing Disabled", destination: url)
                        .OpenURLInAppSafari(barCollapsingEnabled: false)

                    Link("Dismiss Button: Close", destination: url)
                        .OpenURLInAppSafari(dismissButtonStyle: .close)

                    Link("Custom Bar Colors", destination: url)
                        .OpenURLInAppSafari(
                            preferredBarTintColor: .purple,
                            preferredControlTintColor: .white
                        )

                    Link("Presentation Style: Like .Sheet", destination: url)
                        .OpenURLInAppSafari(modalPresentationStyle: .pageSheet)
                    Link("Presentation Style: Like .fullScreenCover", destination: url)
                        .OpenURLInAppSafari(modalPresentationStyle: .overFullScreen)
                } header: {
                    Text("Customization Examples")
                } footer: {
                    Text("This is Markdown. The official Apple website is [here](https://www.apple.com).")
                        .OpenURLInAppSafari(modalPresentationStyle: .pageSheet)
                }
            }
            .navigationTitle("InAppSafariKit")
        }

    }
}

#Preview {
    ContentView()
}

