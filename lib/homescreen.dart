import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mobinappwebbiew/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen(
      {Key? key, required this.type, required this.url, required this.port})
      : super(key: key);
  final String type;
  final String url;
  final String port;
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late InAppWebViewController _webViewController;
  String type = '';
  String ip = '';
  String port = '';
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

  getvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString('type').toString();
      ip = prefs.getString('url').toString();
      port = prefs.getString('port').toString();
    });
    // SharedPreferences.getInstance().then((prefs) {

    // setState(() {
    //
    // });
    // });
    print("************************");

    print(type);
    print(ip);
    print(port);
    print("url:");
    url = widget.type + "://" + widget.url + ':' + widget.port;
  }

  @override
  void initState() {
    super.initState();
    //getvalue();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: SafeArea(
        child: Scaffold(
          /// drawer start
          drawer: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "images/http.png",
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Type :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0, top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.subdirectory_arrow_right_outlined),
                          Text(
                            widget.type,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 50,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "images/domain.png",
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "URL/IP :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   width: 150,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0, top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.subdirectory_arrow_right_outlined),
                          Expanded(
                            child: Text(
                              // "savemalysia.deltaserver.site",
                              widget.url,
                              maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      height: 50,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "images/dns.png",
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Port :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0, top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.subdirectory_arrow_right_outlined),
                          Text(
                            widget.port,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 50,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Your Link :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 10),
                      child: Text(
                        widget.type + "://" + widget.url + ':' + widget.port,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                    ),

                    ///   your link end

                    ///    Editbutton start

                    Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (cotext) => Welcome()));
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 50), primary: Colors.blue),
                      ),
                    )
                    // Edit button end
                  ])),

          ///AppBar Start

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              //size: 40, //change size on your need
              color: Colors.black, //change color on your need
            ),
          ),

          ///webview start

          body: Container(
            child: Column(children: <Widget>[
              //progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
              Expanded(
                child: InAppWebView(
                  // initialUrlRequest: URLRequest(url: Uri.parse("http://172.16.0.20/")),
                  //
                  // initialUrlRequest: URLRequest(url: Uri.parse("http://bigmobilitywebapp.sba.com/")),
                  initialUrlRequest: widget.url.isNotEmpty
                      ? URLRequest(
                          url: Uri.parse(widget.type +
                              "://" +
                              widget.url +
                              ':' +
                              widget.port))
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
