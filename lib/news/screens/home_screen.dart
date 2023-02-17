// ignore_for_file: unnecessary_lambdas, avoid_dynamic_calls, avoid_unnecessary_containers, prefer_const_constructors, avoid_redundant_argument_values, always_use_package_imports, depend_on_referenced_packages, use_key_in_widget_constructors, sort_constructors_first, prefer_const_constructors_in_immutables, prefer_final_locals, omit_local_variable_types, strict_raw_type, type_annotate_public_apis, inference_failure_on_function_return_type, always_declare_return_types, use_colored_box, lines_longer_than_80_chars, library_private_types_in_public_api, unused_field, unused_local_variable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transition/transition.dart';

import '../../CustomAppbar/CustomAppbar.dart';
import '../../l10n/l10n.dart';
import '../components/news_tile.dart';
import '../components/shimmer_news_tile.dart';
import '../helper/news.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  final String category;
  HomeScreen({required this.category});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List articles = [];
  bool _loading = true;
  bool _showConnected = false;
  bool _articleExists = true;
  bool _retryBtnDisabled = false;

  Icon themeIcon = Icon(Icons.dark_mode);
  bool isLightTheme = false;

  Color baseColor = Colors.grey[300]!;
  Color highlightColor = Colors.grey[100]!;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    _loading = true;
    getNews();
    // getTheme();
  }

  // getTheme() async {
  //   final settings = await Hive.openBox('settings');
  //   setState(() {
  //     // isLightTheme = settings.get('isLightTheme') ?? false;
  //     baseColor = isLightTheme ? Colors.grey[300]! : Color(0xff2c2c2c);
  //     highlightColor = isLightTheme ? Colors.grey[100]! : Color(0xff373737);
  //     themeIcon = isLightTheme ? Icon(Icons.dark_mode) : Icon(Icons.light_mode);
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
          l10n.youAreOffline, //'You are Offline',
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
          l10n.backOnline,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getNews();
    }
  }

  Future getNews() async {
    _loading = true;
    checkConnectivity();
    News newsClass = News();
    await newsClass.getNews(category: widget.category);
    articles = newsClass.news;
    setState(() {
      if (articles.isEmpty) {
        _articleExists = false;
      } else {
        _articleExists = true;
      }
      _loading = false;
      _retryBtnDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = context.l10n;
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
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
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              Transition(
                child: CategoryScreen(),
                transitionEffect: TransitionEffect.LEFT_TO_RIGHT,
              ),
            );
          },
          icon: Icon(
            Icons.menu_outlined,
            size: 30,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'News',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 0, 68, 255),
              ),
            ),
            Text(
              'One',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   onPressed: () async {
          //     // await themeProvider.toggleThemeData();
          //     // setState(() {
          //     //   themeIcon = themeProvider.themeIcon();
          //     // });
          //   },
          //   icon: themeIcon,
          // ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            elevation: 1,
            itemBuilder: (context) {
              return AppLocalizations.supportedLocales.map(
                (locale) {
                  return PopupMenuItem<String>(
                    value: locale.languageCode,
                    child: Text(
                      Utils.localeToCountryName(locale),
                    ),
                  );
                },
              ).toList();
            },
            onSelected: (value) {
              context.read<AppbarConfigCubit>().changeLanguage(
                    Locale(value),
                  );
            },
          ),
        ],
      ),
      body: _loading
          ? Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ShimmerNewsTile();
                },
              ),
            )
          : _articleExists
              ? RefreshIndicator(
                  child: ListView(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NewsTile(
                            image: articles[index].image.toString(),
                            title: articles[index].title.toString(),
                            content: articles[index].content.toString(),
                            date: articles[index].publishedDate.toString(),
                            fullArticle: articles[index].fullArticle.toString(),
                          );
                        },
                      ),
                    ],
                  ),
                  onRefresh: () => getNews(),
                )
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No data available'),
                        TextButton(
                          child: const Text('Retry Now!'),
                          onPressed: () {
                            if (!_articleExists) {
                              setState(() {
                                _retryBtnDisabled = true;
                              });
                              getNews();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
