// ignore_for_file: type_annotate_public_apis, inference_failure_on_function_return_type, always_declare_return_types, prefer_final_locals, avoid_redundant_argument_values, unused_import, deprecated_member_use, lines_longer_than_80_chars, always_use_package_imports, use_key_in_widget_constructors, sort_constructors_first, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_field, prefer_single_quotes, prefer_const_constructors, cascade_invocations, omit_local_variable_types, sort_child_properties_last, avoid_dynamic_calls

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:newsone/l10n/l10n.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../helper/menu_items.dart';

class ArticleScreen extends StatefulWidget {
  final String articleUrl;
  ArticleScreen({required this.articleUrl});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
//  final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
  late final WebViewController _controller;

  int position = 1;
  bool _showConnected = false;
  bool isLightTheme = true;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    // getTheme();
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    ////
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (value) {
            setState(() {
              position = 1;
            });
          },
          onPageFinished: (value) {
            setState(() {
              position = 0;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
                  Page resource error:
                  code: ${error.errorCode}
                  description: ${error.description}
                  errorType: ${error.errorType}
                  isForMainFrame: ${error.isForMainFrame}
                  ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.articleUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;

    ////
  }

  // getTheme() async {
  //   final settings = await Hive.openBox('settings');
  //   setState(() {
  //     isLightTheme = settings.get('isLightTheme') ?? false;
  //   });
  // }

  checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    var isConnected = result != ConnectivityResult.none;
    if (!isConnected) {
      var l10n = context.l10n;
      _showConnected = true;
      final snackBar = SnackBar(
        content: Text(
          l10n.backOnline, //"You are Offline",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (isConnected && _showConnected) {
      var l10n = context.l10n;
      _showConnected = false;
      final snackBar = SnackBar(
        content: Text(
          l10n.youAreOffline, //"You are back Online",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    var l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: isLightTheme
            ? SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(
                  255,
                  158,
                  193,
                  255,
                ),
              )
            : SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(
                  255,
                  158,
                  193,
                  255,
                ),
              ),
        backgroundColor: Color.fromARGB(
          255,
          158,
          193,
          255,
        ),
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              l10n.news,
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff50A3A4),
              ),
            ),
            Text(
              l10n.one,
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 56, 180, 252),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              final menuItems = MenuItems(context);
              return menuItems.choices.map((String choice) {
                return PopupMenuItem(
                  child: Text(choice),
                  value: choice,
                );
              }).toList();
            },
            onSelected: choiceAction,
          ),
          // PopupMenuButton(
          //   itemBuilder: (BuildContext context) {
          //     return MenuItems.choices.map((String choice) {
          //       return PopupMenuItem(
          //         child: Text(choice),
          //         value: choice,
          //       );
          //     }).toList();
          //   },
          //   onSelected: choiceAction,
          // ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 0.98,
        child: Center(
          child: IndexedStack(
            index: position,
            children: [
              WebViewWidget(
                controller: _controller,
              )
              // WebView(
              //   initialUrl: widget.articleUrl,
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onPageStarted: (value) {
              //     setState(() {
              //       position = 1;
              //     });
              //   },
              //   onPageFinished: (value) {
              //     setState(() {
              //       position = 0;
              //     });
              //   },
              //   onWebViewCreated: ((WebViewController webViewController) {
              //     _controller.complete(webViewController);
              //   }),
              // ),
              ,
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    var l10n = context.l10n;
    if (choice == l10n.copyLink) {
      Clipboard.setData(ClipboardData(text: widget.articleUrl));
      Fluttertoast.showToast(
        msg: l10n.linkCopied,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16,
      );
    } else if (choice == l10n.openInBrowser) {
      launch(widget.articleUrl);
    } else if (choice == l10n.shareVia) {
      Share.share(widget.articleUrl);
    }
  }
}
