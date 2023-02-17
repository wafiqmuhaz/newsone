// ignore_for_file: avoid_unnecessary_containers, inference_failure_on_instance_creation, use_key_in_widget_constructors, sort_constructors_first, prefer_const_constructors_in_immutables, avoid_multiple_declarations_per_line, always_use_package_imports, lines_longer_than_80_chars

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

import '../screens/article_screen.dart';
import '../screens/image_screen.dart';

class NewsTile extends StatelessWidget {
  final String image, title, content, date, fullArticle;
  NewsTile({
    required this.content,
    required this.date,
    required this.image,
    required this.title,
    required this.fullArticle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      margin: const EdgeInsets.only(bottom: 24),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Hero(
                  tag: 'image-$image',
                  child: CachedNetworkImage(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: image,
                    placeholder: (context, url) => Image(
                      image: const AssetImage('images/dotted-placeholder.jpg'),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(
                      imageUrl: image,
                      headline: title,
                    ),
                  ),
                );
              },
            ),
            GestureDetector(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      content,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  Transition(
                    child: ArticleScreen(articleUrl: fullArticle),
                    transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
