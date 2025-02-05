//
//  OpenURLInAppSafariModifier.swift
//  InAppSafariKit
//  
//  Created by Chronos2500 on 2025/02/06.
//

import SwiftUI
import SafariServices

struct OpenURLInAppSafariModifier: ViewModifier {
    @Environment(\.customSafariStyle) private var style

    func body(content: Content) -> some View {
        content
            .environment(\.openURL, OpenURLAction { url in
                guard let scheme = url.scheme, scheme == "http" || scheme == "https" else {
                    return .systemAction(url)
                }

                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = style.entersReaderIfAvailable
                config.barCollapsingEnabled = style.barCollapsingEnabled
                let vc = SFSafariViewController(url: url, configuration: config)
                vc.dismissButtonStyle = .done
                vc.preferredBarTintColor = style.preferredBarTintColor
                vc.preferredControlTintColor = style.preferredControlTintColor
                vc.modalPresentationStyle = style.modalPresentationStyle
                UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                return .handled

            })

    }
}

public struct CustomSafariStyle {
    public var entersReaderIfAvailable: Bool
    public var barCollapsingEnabled: Bool
    public var dismissButtonStyle: SFSafariViewController.DismissButtonStyle
    public var preferredBarTintColor: UIColor?
    public var preferredControlTintColor: UIColor?
    public var modalPresentationStyle: UIModalPresentationStyle

    init(
        entersReaderIfAvailable: Bool = false,
        barCollapsingEnabled: Bool = true,
        dismissButtonStyle: SFSafariViewController.DismissButtonStyle = .done,
        preferredBarTintColor: UIColor? = nil,
        preferredControlTintColor: UIColor? = nil,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen
    ) {
        self.entersReaderIfAvailable = entersReaderIfAvailable
        self.barCollapsingEnabled = barCollapsingEnabled
        self.dismissButtonStyle = dismissButtonStyle
        self.preferredBarTintColor = preferredBarTintColor
        self.preferredControlTintColor = preferredControlTintColor
        self.modalPresentationStyle = modalPresentationStyle
    }
}

extension EnvironmentValues {
    @Entry public var customSafariStyle = CustomSafariStyle()
}

extension View {
    public func OpenURLInAppSafari() -> some View {
        return modifier(OpenURLInAppSafariModifier())
    }
}

extension UIApplication {
    internal var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}
