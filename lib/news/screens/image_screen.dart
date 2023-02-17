// ignore_for_file: sort_child_properties_last, cascade_invocations, prefer_final_locals, no_leading_underscores_for_local_identifiers, use_setters_to_change_properties, sized_box_for_whitespace, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, type_annotate_public_apis, inference_failure_on_function_return_type, always_declare_return_types, inference_failure_on_function_invocation, library_private_types_in_public_api, use_key_in_widget_constructors, sort_constructors_first, prefer_const_constructors_in_immutables, lines_longer_than_80_chars

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:newsone/l10n/l10n.dart';

class ImageScreen extends StatefulWidget {
  final String imageUrl;
  final String headline;
  ImageScreen({required this.imageUrl, required this.headline});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen>
    with TickerProviderStateMixin {
  final controller = TransformationController();
  bool _showConnected = false;
  bool isLightTheme = true;
  late TapDownDetails _doubleTapDetails;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
    // getTheme();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    controller.dispose();
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
            l10n.youAreOffline, //"You are Offline",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (isConnected && _showConnected) {
      var l10n = context.l10n;
      _showConnected = false;
      final snackBar = SnackBar(
          content: Text(
            l10n.backOnline, //"You are back Online",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onDoubleTapDown: _handleDoubleTapDown,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  child: Hero(
                    tag: 'image-${widget.imageUrl}',
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                    ),
                  ),
                  transformationController: controller,
                  maxScale: 3,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.headline,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (controller.value != Matrix4.identity()) {
      final animationReset = Matrix4Tween(
        begin: controller.value,
        end: Matrix4.identity(),
      ).animate(_animationController);

      _animationController.addListener(() {
        controller.value = animationReset.value;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 2x zoom
      var _endMatrix = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);

      final animationReset = Matrix4Tween(
        begin: controller.value,
        end: _endMatrix,
      ).animate(_animationController);

      _animationController.addListener(() {
        controller.value = animationReset.value;
      });

      _animationController.reset();
      _animationController.forward();
    }
  }
}
