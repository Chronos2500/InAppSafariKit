# InAppSafariKit

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

SwiftUI で `SFSafariViewController` を利用して、アプリ内で URL を開くためのシンプルなパッケージです。`Link`等で開かれるURLも`SFSafariViewController`を使ったアプリ内ブラウザとして開けます。

## 特徴

-   `Link` で開くURLを、`SFSafariViewController` を使ってアプリ内で開きます。
-   `SFSafariViewController` の各種設定や掲示アニメーションスタイルをカスタマイズできます。
-   デフォルト設定は`@Environment(\.customSafariStyle)`で変えられます

## 動作環境

-   iOS 15.0+

## インストール


## 使用方法
### 基本的な使い方

```swift
import SwiftUI
import InAppSafariKit

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
            }
        }
    }
}
```
`Link`に`.OpenURLInAppSafari()`修飾子を追加するだけで、`SFSafariViewController`を使用して、リンクをアプリ内で開けるようになります。
アプリ内すべてに適用する場合は、親Viewに`.OpenURLInAppSafari()`修飾子を追加してください。
デフォルトでは、`SFSafariViewController`は以下のように設定されています。

-   `entersReaderIfAvailable`: `false`
-   `barCollapsingEnabled`: `true`
-   `dismissButtonStyle`: `.done`
-   `preferredBarTintColor`: `nil`
-   `preferredControlTintColor`: `nil`
-   `modalPresentationStyle`: `.fullScreen`
### カスタマイズ

`.OpenURLInAppSafari()` モディファイアに引数を渡すことで、`SFSafariViewController` の設定をカスタマイズできます。

```swift
Link("Custom Bar Colors", destination: url)
    .OpenURLInAppSafari(
        preferredBarTintColor: .purple,
        preferredControlTintColor: .white
    )
```
#### 使用例

| ![Demo01](Assets/Demo01.gif) | ![Demo02](Assets/Demo01.gif) |
|:--:|:--:|
| デフォルト設定 | `preferredBarTintColor = .purple` |

| ![Demo03](Assets/Demo03.gif) | ![Demo04](Assets/Demo04.gif) |
|:--:|:--:|
| `modalPresentationStyle = .pageSheet` | `modalPresentationStyle = .overFullScreen` |

### デフォルト設定

`customSafariStyle`環境変数を使うと、デフォルト値を変更できます。

```swift
@main
struct InAppSafariKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.customSafariStyle,CustomSafariStyle(dismissButtonStyle: .cancel,preferredBarTintColor: .gray))
        }
    }
}

```
## ライセンス

MIT License
