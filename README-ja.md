# InAppSafariKit

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

[English is here.](README.md)

SwiftUIで `SFSafariViewController` を利用して、アプリ内でURLを開くためのシンプルなパッケージです。`Link`等で開かれるURLも`SFSafariViewController`を使ったアプリ内ブラウザとして開けます。

<img src="Assets/Demo01.gif" width="200">

## 特徴

-   `Link` で開くURLを、`SFSafariViewController` を使ってアプリ内で開きます。
-   `SFSafariViewController` の各種設定や掲示アニメーションスタイルをカスタマイズできます。
-   デフォルト設定は`@Environment(\.customSafariStyle)`で変えられます

## 動作環境

-   iOS 15.0+
-   Xcode 16.0+

## インストール
Swift Package Manager (SPM) を使用してインストールできます。

1. Xcode でプロジェクトを開きます。
2.  **File > Add Package Dependency...** を選択します。
3. `https://github.com/Chronos2500/InAppSafariKit.git` を入力します。
4. バージョン指定ルール等を設定し、 **Add Package** をクリックします。

## 使い方
### 基本的な使い方

```swift
import SwiftUI
import InAppSafariKit

struct ContentView: View {
    private let url = URL(string: "https://www.apple.com")!
    var body: some View {
        NavigationStack{
            Form{
                Link("Open Default Browser", destination: url)
                Link("Open by InAppSafariKit (Default)", destination: url)
                    .OpenURLInAppSafari()
                
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

`.OpenURLInAppSafari()` 修飾子で、`SFSafariViewController` の設定や掲示アニメーションをカスタマイズできます。

```swift
Link("Custom Bar Colors", destination: url)
    .OpenURLInAppSafari(
        preferredBarTintColor: .purple,
        preferredControlTintColor: .white
    )
```
#### カスタマイズ例

<!-- 
| ![Demo01](Assets/Demo01.gif) | ![Demo02](Assets/Demo02.gif) |
|:--:|:--:|
| Open by InAppSafariKit (Default) | preferredBarTintColor = .purple |

| ![Demo03](Assets/Demo03.gif) | ![Demo04](Assets/Demo04.gif) |
|:--:|:--:|
| modalPresentationStyle = .pageSheet | modalPresentationStyle = .overFullScreen |
 -->

<table>
  <tr>
    <td align="center"><img src="Assets/Demo01.gif" width="150"></td>
    <td align="center"><img src="Assets/Demo02.gif" width="150"></td>
  </tr>
  <tr>
    <td align="center">Open by InAppSafariKit (Default)</td>
    <td align="center"><code>preferredBarTintColor = .purple</code></td>
  </tr>
</table>

<table>
  <tr>
    <td align="center"><img src="Assets/Demo03.gif" width="150"></td>
    <td align="center"><img src="Assets/Demo04.gif" width="150"></td>
  </tr>
  <tr>
    <td align="center"><code>modalPresentationStyle = .pageSheet</code></td>
    <td align="center"><code>modalPresentationStyle = .overFullScreen</code></td>
  </tr>
</table>

### デフォルト設定

親Viewで`customSafariStyle`環境変数を使うと、子View以降のデフォルトスタイルを変更できます。

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
MIT ライセンスのもとで提供されます。

Chronos2500 © 2025
