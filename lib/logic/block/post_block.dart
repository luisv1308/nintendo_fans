import 'dart:async';

import 'package:nintendo_fans/logic/viewmodel/post_view_model.dart';
import 'package:nintendo_fans/model/news.dart';
import 'package:nintendo_fans/model/post.dart';
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:nintendo_fans/services/news/news_service.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:xml/xml.dart';

class PostBloc {
  final PostViewModel postViewModel = PostViewModel();
  final newsController = StreamController<List<News>>();
  final fabController = StreamController<bool>();
  final fabVisibleController = StreamController<bool>();
  Sink<bool> get fabSink => fabController.sink;
  Stream<List<News>> get newsItems => newsController.stream;
  Stream<bool> get fabVisible => fabVisibleController.stream;
  NewsService service = NewsService(RestClient());

  PostBloc() {
    var res = service.fetchStoreResponse();
    List<News> newsList = List();
    res.then((data) {
      var items = data.content.findAllElements('item');
      items.forEach((item) {
        // print(item.findElements('media:thumbnail'));
        News news = News();
        news.title = item.findElements('title').single.text;
        news.pubDate = item.findElements('pubDate').single.text;
        news.link = item.findElements('link').single.text;
        news.thumbnail = item.findElements('media:thumbnail').single.attributes[0].value;
        // print(thumb.attributes[0].value);
        // news.thumbnail = '';
        // thumb.map((node) {
        //   print(node.getAttribute('url'));
        //   news.thumbnail = node.getAttribute('url');
        // });
        // print(news.thumbnail);
        news.description = item.findElements('description').single.text;
        newsList.add(news);
      });
      newsController.add(newsList);
      // titles.map((node) => node.text).forEach(print);
    });
    fabController.stream.listen(onScroll);
  }
  onScroll(bool visible) {
    fabVisibleController.add(visible);
  }

  void dispose() {
    newsController?.close();
    fabController?.close();
    fabVisibleController?.close();
  }
}
