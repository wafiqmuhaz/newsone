// ignore_for_file: prefer_const_declarations, type_annotate_public_apis, inference_failure_on_function_return_type, always_declare_return_types, prefer_final_locals, always_use_package_imports, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_redundant_argument_values, lines_longer_than_80_chars

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsone/l10n/l10n.dart';
import 'package:transition/transition.dart';

import '../components/category_card.dart';
import '../helper/categoryData.dart';
import '../models/category_model.dart';
import 'home_screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen();

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];
  bool _showConnected = false;
  bool isLightTheme = false;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    // getTheme();
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
          l10n.youAreOffline, //'You are Offline',
          style: const TextStyle(color: Colors.white),
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
          l10n.backOnline, //'You are back Online',
          style: const TextStyle(color: Colors.white),
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
            ? const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(
                  255,
                  158,
                  193,
                  255,
                ),
              )
            : const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(
                  255,
                  158,
                  193,
                  255,
                ),
              ),
        backgroundColor: const Color.fromARGB(
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
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(l10n.categories),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CategoryCard(
                image: categories[index].imageAssetUrl,
                text: categories[index].categoryName,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  Transition(
                    child: HomeScreen(category: categories[index].category),
                    transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
