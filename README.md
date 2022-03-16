# SwiftUIWebView(with messaging)
This project shows how to implement WebView in SwiftUI using WKWebView and UIViewRepresentable. It also shows how to deal with WebView in different purposes.

**Make a WebView using WKWebView and UIViewRepresentable:**

Just for ease of use first create a ViewModel, a enum class named  _WebViewNavigation_  and another enum named  _WebUrlType_.  _WebViewNavigation_ is used to navigate WebView forward and backward.  _WebUrlType_ defines what type of url should load e.g.  `.localUrl`  or  `.publicUrl`.

We can use any  [UIKit](https://developer.apple.com/documentation/uikit)  View into SwiftUI using UIViewRepresentable which is a view wrapper. Since we are going to make a WebView for SwiftUI, first we will create a structure named  `WebView`  that inherits  `UIViewRepresentable`  and implements necessary protocols. Then we will create a  `Coordinator`  inside  `WebView`  to implement necessary protocols of WKWebView.

**Load a local** `**.html**` **file or a public website or web app in WebView:**

In the above  `WebView`, inside  `Coordinator`  class, function  `updateUIView`  loads the url of local or private website into WebView depending on  `WebUrlType`.

    if let url = Bundle.main.url(forResource: “LocalWebsite”, withExtension: “html”, subdirectory: “www”) {  
    webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())  
    }

Above lines load a website named  `LocalWebsite.html`  located inside our iOS project’s “www” directory. I mean it local webpage because it is inside the project file.

These lines load a public website or web app

    if let url = URL(string: "https://www.example.com") {  
        webView.load(URLRequest(url: url))  
    }

Get the title of the loaded website

In  `ContentView`  use  `WebView`  as follows

    WebView(url: .localUrl, viewModel: viewModel)

**Interact between iOS native app and web app through JavaScript’s function**

**Receive value from web app:**

Inside  `WebView`’s  `makeUIView`  function we passed a  `iOSNative`  as the name to the loaded web app so that web app can find our native iOS app through that name to pass value to our native iOS app. See below line:

    configuration.userContentController.add(self.makeCoordinator(), name: “iOSNative”)

Make an extension to Coordinator to catch value sent from web app like:

Here  [WKScriptMessageHandler](https://developer.apple.com/documentation/webkit/wkscriptmessagehandler)  receives all values sent from web app. Here is our web app that is sending those values. This  `LocalWebsite.html`  is located inside our project’s  `www`  directory. I created this  `.html`  file for test purpose, obviously you will work with server hosted web app.

**Pass value to web app:**

Since this is a static .html file it can not receive any value from iOS app but your real web app can receive. Just call a JavaScript function from your iOS as follows:

In my case web app’s JavaScript function’s name is  `valueGotFromIOS`.

**Intercepting web app navigation:**

To intercept every navigation of web app, just implement following function inside  `Coordinator class`.

**Navigating web app backward, forward and reloading:**

For backward navigation use

    if webView.canGoBack {  
       webView.goBack()  
    }

For forward navigation use

    if webView.canGoForward {  
       webView.goForward()  
    }

To reload WebView use

    webView.reload()

Finally build the app in [Xcode](https://developer.apple.com/xcode/)!

Reference [Md Yamin](https://medium.com/@mdyamin/swiftui-mastering-webview-5790e686833e)
