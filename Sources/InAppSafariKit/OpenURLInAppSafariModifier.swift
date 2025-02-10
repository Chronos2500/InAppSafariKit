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
    let entersReaderIfAvailable: Bool?
    let barCollapsingEnabled: Bool?
    let dismissButtonStyle: SFSafariViewController.DismissButtonStyle?
    let preferredBarTintColor: UIColor?
    let preferredControlTintColor: UIColor?
    let modalPresentationStyle: UIModalPresentationStyle?

    func body(content: Content) -> some View {
        content
            .environment(\.openURL, OpenURLAction { url in
                guard let scheme = url.scheme, scheme == "http" || scheme == "https" else {
                    return .systemAction(url)
                }

                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = entersReaderIfAvailable ?? style.entersReaderIfAvailable
                config.barCollapsingEnabled = barCollapsingEnabled ?? style.barCollapsingEnabled
                let vc = SFSafariViewController(url: url, configuration: config)
                vc.dismissButtonStyle = dismissButtonStyle ?? style.dismissButtonStyle
                vc.preferredBarTintColor = preferredBarTintColor ?? style.preferredBarTintColor
                vc.preferredControlTintColor = preferredControlTintColor ?? style.preferredControlTintColor
                vc.modalPresentationStyle = modalPresentationStyle ?? style.modalPresentationStyle
                UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                return .handled
            })

    }
}

public struct CustomSafariStyle : Sendable{
    public var entersReaderIfAvailable: Bool
    public var barCollapsingEnabled: Bool
    public var dismissButtonStyle: SFSafariViewController.DismissButtonStyle
    public var preferredBarTintColor: UIColor?
    public var preferredControlTintColor: UIColor?
    public var modalPresentationStyle: UIModalPresentationStyle

    public init(
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
    /// Open the URL in the app using `SFSafariViewController`.
    /// - Parameters:
    ///   - entersReaderIfAvailable: Default value `false`
    ///   - barCollapsingEnabled: Default value `true`
    ///   - dismissButtonStyle: Default value `.done`
    ///   - preferredBarTintColor: Default value `nil`
    ///   - preferredControlTintColor: Default value `nil`
    ///   - modalPresentationStyle: `.none` cannot be used. Default value `.fullScreen`
    public func OpenURLInAppSafari(
        entersReaderIfAvailable: Bool? = nil,
        barCollapsingEnabled: Bool? = nil,
        dismissButtonStyle: SFSafariViewController.DismissButtonStyle? = nil,
        preferredBarTintColor: UIColor? = nil,
        preferredControlTintColor: UIColor? = nil,
        modalPresentationStyle: UIModalPresentationStyle? = nil
    ) -> some View {
        return modifier(OpenURLInAppSafariModifier(
            entersReaderIfAvailable: entersReaderIfAvailable,
            barCollapsingEnabled: barCollapsingEnabled,
            dismissButtonStyle: dismissButtonStyle,
            preferredBarTintColor: preferredBarTintColor,
            preferredControlTintColor: preferredControlTintColor,
            modalPresentationStyle: modalPresentationStyle
        ))
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
