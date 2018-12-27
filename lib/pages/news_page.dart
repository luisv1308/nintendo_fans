import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nintendo_fans/logic/block/post_block.dart';
import 'package:nintendo_fans/model/news.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_divider.dart';
import 'package:nintendo_fans/widgets/common_drawer.dart';
import 'package:nintendo_fans/widgets/label_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class NewsPage extends StatelessWidget {
  //column1
  Widget profileColumn(BuildContext context, News news) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(news.thumbnail),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '',
                  style: Theme.of(context).textTheme.body1.apply(fontWeightDelta: 700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '',
                  style: Theme.of(context).textTheme.caption.apply(fontFamily: UIData.ralewayFont, color: Colors.pink),
                )
              ],
            ),
          ))
        ],
      );

  //column last
  Widget actionColumn(News news) => FittedBox(
        fit: BoxFit.contain,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            LabelIcon(
              label: "20 Likes",
              icon: FontAwesomeIcons.solidThumbsUp,
              iconColor: Colors.green,
            ),
            LabelIcon(
              label: "2 Comments",
              icon: FontAwesomeIcons.comment,
              iconColor: Colors.blue,
            ),
            Text(
              news.pubDate,
              style: TextStyle(fontFamily: UIData.ralewayFont),
            )
          ],
        ),
      );

  //post cards
  Widget postCard(BuildContext context, News news) {
    return Card(
      color: Colors.orange[200],
      elevation: 2.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: profileColumn(context, news),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(news.title, style: TextStyle(fontWeight: FontWeight.normal, fontFamily: UIData.ralewayFont, fontSize: 20.0, color: Colors.black)),
          ),
          CommonDivider(),
          InkWell(
            // onTap: () async {
            //   var url = news.link;
            //   if (await canLaunch(url)) {
            //     await launch(url);
            //   } else {
            //     throw 'Could not launch $url';
            //   }
            // },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new HtmlView(data: news.description),
              // child: Text(
              //   news.description,
              //   style: TextStyle(fontWeight: FontWeight.normal, fontFamily: UIData.ralewayFont),
              // ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          news.thumbnail != null
              ? Image.network(
                  news.thumbnail,
                  fit: BoxFit.cover,
                )
              : Container(),
          // news.thumbnail != null ? Container() : CommonDivider(),
          // actionColumn(news),
          news.thumbnail != null ? Container() : CommonDivider(),
          Container(),
        ],
      ),
    );
  }

  //allposts dropdown
  Widget bottomBar() => PreferredSize(
      preferredSize: Size(double.infinity, 50.0),
      child: Container(
          color: Colors.black,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "All Posts",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )));

  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.red[400],
        // textTheme: TextTheme(title: TextStyle(fontSize: 24.00, color: Colors.white)),
        elevation: 2.0,
        title: Text("Feed"),
        forceElevated: true,
        pinned: true,
        floating: false,
        // bottom: bottomBar(),
      );

  Widget bodyList(List<News> news) => SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: postCard(context, news[index]),
          );
        }, childCount: news.length),
      );

  Widget bodySliverList() {
    PostBloc postBloc = PostBloc();
    return StreamBuilder<List<News>>(
        stream: postBloc.newsItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: <Widget>[
                    appBar(),
                    bodyList(snapshot.data),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CommonDrawer(),
      body: bodySliverList(),
    );
  }
}
