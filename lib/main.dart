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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

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

  String typeString = '';
  String ipString = '';
  String portString = '';
  void getinputs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    typeString = prefs.getString('type')!;
    ipString = prefs.getString('url').toString();
    portString = prefs.getString('port').toString();
  }

  @override
  void initState() {
    super.initState();
    getinputs(); // read in initState
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Welcome()
        //ipString.isEmpty ? Welcome() : Homescreen()
        // WillPopScope(
        //   onWillPop: () => _exitApp(context),
        //   child: SafeArea(
        //     child: Scaffold(
        //       body: Container(
        //         child: Column(children: <Widget>[
        //           //progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
        //           Expanded(
        //             child: InAppWebView(
        //               // initialUrlRequest: URLRequest(url: Uri.parse("http://172.16.0.20/")),
        //               //
        //               // initialUrlRequest: URLRequest(url: Uri.parse("http://bigmobilitywebapp.sba.com/")),
        //               initialUrlRequest: URLRequest(
        //                   url: Uri.parse("https://mobility.beta-space.com")),
        //               initialOptions: InAppWebViewGroupOptions(
        //                   crossPlatform: InAppWebViewOptions()),
        //               onWebViewCreated: (InAppWebViewController controller) {
        //                 _webViewController = controller;
        //               },
        //               onProgressChanged:
        //                   (InAppWebViewController controller, int progress) {
        //                 setState(() {
        //                   this.progress = progress / 100;
        //                 });
        //               },
        //             ),
        //           ),
        //         ]),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextEditingController type = TextEditingController();
  final TextEditingController url = TextEditingController();
  final TextEditingController port = TextEditingController();
  String typeString = '';
  String ipString = '';
  String portString = '';
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'http';
  late SharedPreferences prefs;
  final _key = 'cur_r';

  void _saveInputs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //SharedPreferences.getInstance().then((prefs) {
    prefs.setString('type', type.text.toString());
    prefs.setString('type', dropdownValue.toString());
    prefs.setString('url', url.text.toString());
    prefs.setString('port', port.text.toString());
    typeString = prefs.getString('type')!;
    ipString = prefs.getString('url').toString();
    portString = prefs.getString('port').toString();
    print(typeString);
    print(ipString);
    print(portString);
    print("testign0");
  }

  _read() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      dropdownValue = prefs.getString(_key) ?? "http"; // get the value
    });
  }

  @override
  void initState() {
    super.initState();
    _read(); // read in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/mobility-logo-inner-dark1.png',
                  width: 200,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter some text';
                      //     }
                      //     return null;
                      //   },
                      //   controller: type,
                      //   decoration: InputDecoration(
                      //       fillColor: Colors.grey.shade100,
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             const BorderSide(color: Colors.grey, width: 0.0),
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide:
                      //             const BorderSide(color: Colors.grey, width: 0.0),
                      //       ),
                      //       labelText: 'Enter Type ',
                      //       hintText: 'Enter Your Type http/https'),
                      // ),

                      DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        labelText: 'Enter Port ',
                        hintText: 'Enter Your Port'),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      prefs.setString(_key,
                          dropdownValue); // save value to SharedPreference
                    },
                    items: ['http', 'https']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: url,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        labelText: 'Enter URL/IP',
                        hintText: 'Enter Your URL/IP'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: port,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        labelText: 'Enter Port ',
                        hintText: 'Enter Your Port'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid!) {
                      _saveInputs();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homescreen()));
                      return;
                    } else {
                      print("sucess");
                    }
                    _formKey.currentState?.save();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 50), primary: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
