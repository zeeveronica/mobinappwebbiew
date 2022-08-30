// import 'dart:async';
// import 'dart:io';
//
// import 'package:android_intent/android_intent.dart';
// import 'package:android_intent/flag.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// //import 'package:webview_flutter/webview_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// // void main() {
// //   runApp(const MyApp());
// // }
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Permission.camera.request();
//   await Permission.microphone.request();
//
//   runApp(MyApp());
// }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MyHomePage(),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   void initState() {
// //     if (Platform.isAndroid) WebView.platform = AndroidWebView();
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.portraitUp,
// //       DeviceOrientation.portraitDown,
// //     ]);
// //     if (Platform.isAndroid) {
// //       WebView.platform = SurfaceAndroidWebView();
// //     }
// //     super.initState();
// //     // Enable virtual display.
// //     // if (Platform.isAndroid) WebView.platform = AndroidWebView();
// //   }
// //
// //   Future<bool> _exitApp(BuildContext context) async {
// //     if (await controller.canGoBack()) {
// //       print("onwill goback");
// //       //controller.goBack();
// //       return Future.value(false);
// //     } else {
// //       Scaffold.of(context).showSnackBar(
// //         const SnackBar(content: Text("No back history item")),
// //       );
// //       return Future.value(false);
// //     }
// //   }
// //
// //   void _startActivityInNewTask() {
// //     final AndroidIntent intent = AndroidIntent(
// //       action: 'action_view',
// //       data: Uri.encodeFull('https://mobility.beta-space.com/test2.php'),
// //       flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
// //     );
// //     intent.launch();
// //   }
// //
// //   late WebViewController controller;
// //   @override
// //   final Completer<WebViewController> _controller = Completer<WebViewController>();
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //         onWillPop: () => _exitApp(context),
// //         // Navigator.of(context).pop(true);
// //         // if (await controller.canGoBack()) {
// //         //   controller.goBack();
// //         //   return false;
// //         // } else {
// //         //   return true;
// //         // }
// //
// //         child: SafeArea(
// //             child: Scaffold(
// //           body: ElevatedButton(
// //             child: const Text('Tap here to start activity in new task.'),
// //             onPressed: _startActivityInNewTask,
// //           ),
// //         )));
// //
// //     // WebView(
// //     //   initialUrl: 'https://mobility.beta-space.com/',
// //     //   javascriptMode: JavascriptMode.unrestricted,
// //     //   onWebViewCreated: (controller) {
// //     //     _controller.complete(controller);
// //     //     this.controller = controller;
// //     //   },
// //     // ),
// //   }
// // }
// // // body: Builder(builder: (BuildContext context) {
// // //             return WebView(
// // //               initialUrl: 'https://mobility.beta-space.com/test2.php',
// // //               javascriptMode: JavascriptMode.unrestricted,
// // //               onWebViewCreated: (WebViewController webViewController) {
// // //                 _controller.complete(webViewController);
// // //               },
// // //               // onProgress: (int progress) {
// // //               //   print("WebView is loading (progress : $progress%)");
// // //               // },
// // //               //
// // //               // navigationDelegate: (NavigationRequest request) {
// // //               //   if (request.url.startsWith('https://www.youtube.com/')) {
// // //               //     print('blocking navigation to $request}');
// // //               //     return NavigationDecision.prevent;
// // //               //   }
// // //               //   print('allowing navigation to $request');
// // //               //   return NavigationDecision.navigate;
// // //               // },
// // //               // onPageStarted: (String url) {
// // //               //   print('Page started loading: $url');
// // //               // },
// // //               // onPageFinished: (String url) {
// // //               //   print('Page finished loading: $url');
// // //               // },
// // //               gestureNavigationEnabled: true,
// // //               //support geolocation or not
// // //             );
// // //           }),
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();

  await Permission.storage.request();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  Future<bool> _exitApp(BuildContext context) async {
    if (await _webViewController.canGoBack()) {
      print("onwill goback");
      //controller.goBack();
      return Future.value(false);
    } else {
      Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text("No back history item")),
      );
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () => _exitApp(context),
        child: SafeArea(
          child: Scaffold(
            body: Container(
              child: Column(children: <Widget>[
                //progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse("http://bigmobilitywebapp.sba.com/")),
                    // initialUrlRequest: URLRequest(url: Uri.parse("https://mobility.beta-space.com")),
                    initialOptions: InAppWebViewGroupOptions(crossPlatform: InAppWebViewOptions()),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
