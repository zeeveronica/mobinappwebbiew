import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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

  String type = "";
  String ip = "";
  String port = "";
  void getvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // SharedPreferences.getInstance().then((prefs) {
    type = prefs.getString('type').toString();
    ip = prefs.getString('url').toString();
    port = prefs.getString('port').toString();
    // setState(() {
    //
    // });
    // });
    print("************************");
    print(type);
    print(ip);
    print(port);
    url = type + "://" + ip + ':' + port;
  }

  @override
  void initState() {
    super.initState();
    getvalue();
    print("url");
    print(url);
    print(type + '://' + ip + ':' + port);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(children: <Widget>[
              //progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
              Expanded(
                child: InAppWebView(
                  // initialUrlRequest: URLRequest(url: Uri.parse("http://172.16.0.20/")),
                  //
                  // initialUrlRequest: URLRequest(url: Uri.parse("http://bigmobilitywebapp.sba.com/")),
                  initialUrlRequest: ip.isEmpty
                      ? URLRequest(url: Uri.parse(url))
                      : URLRequest(
                          url: Uri.parse("https://mobility.beta-space.com")),
                  initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                      ),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      ),
                      crossPlatform: InAppWebViewOptions()),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
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
    );
  }
}
