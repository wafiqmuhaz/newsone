// ignore_for_file: avoid_print, prefer_final_locals, omit_local_variable_types, avoid_dynamic_calls, inference_failure_on_untyped_parameter, unused_local_variable, strict_raw_type, always_use_package_imports, lines_longer_than_80_chars

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future getNews({String? category}) async {
    String kDailyhuntEndpoint =
        'https://berita-indo-api.vercel.app/v1/antara-news/$category';
    String kinshortsEndpoint =
        'https://berita-indo-api.vercel.app/v1/antara-news/$category';

    http.Client client = http.Client();

    print('INI ADALAH CLIENT => $client');

    http.Response response = await client.get(Uri.parse(kinshortsEndpoint));

    print('INI ADALAH RESPONSE => $response');

    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('INI ADALAH JSONDATA $jsonData');

        if (response.statusCode == 200
            // jsonData['success'] == true
            ) {
          jsonData['data'].forEach((element) {
            var isoDate = element['isoDate'];
            var date = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(isoDate.toString()));
            if (element['image'] != '' &&
                element['description'] != '' &&
                element['link'] != null) {
              ArticleModel articleModel = ArticleModel(
                publishedDate: date,
                image: element['image'].toString(),
                content: element['description'].toString(),
                fullArticle: element['link'].toString(),
                title: element['title'].toString(),
              );
              news.add(articleModel);
            }
          });
        } else {
          print('ERROR');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
