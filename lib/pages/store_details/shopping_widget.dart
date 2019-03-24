import 'package:flutter/material.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/store_details/shopping_action.dart';
import 'package:nintendo_fans/widgets/label_icon.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:nintendo_fans/services/store/store_service.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class ShoppingWidgets extends StatefulWidget {
  final Game product;
  final StoreService service = StoreService(RestClient());

  ShoppingWidgets({Key key, this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ShoppingState(this.product);
  }
}

class _ShoppingState extends State<ShoppingWidgets> {
  Size deviceSize;
  Game product;
  double yourRating = 0.0;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    Navigator.pop(context);
    return true;
  }

  _ShoppingState(Game product) {
    this.product = product;
    this.yourRating = product.yourRating;
  }

  Widget mainCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.green),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(product.publisher),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LabelIcon(
                      icon: Icons.star,
                      iconColor: Colors.green,
                      label: product.rating,
                    ),
                    Text(
                      '\$ ' + product.eshopPrice.toString(),
                      style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.w700, fontSize: 25.0),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget imagesCard() => SizedBox(
        height: deviceSize.height / 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Card(
            elevation: 2.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(product.image),
                  ),
            ),
          ),
        ),
      );

  Widget descCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.green),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  Widget stars() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {
                  widget.service.userRating(product.id.toString(), v).then((res) {
                    print(res.content['rating']);
                    yourRating = v;
                    product.rating = res.content['rating'];
                    product.yourRating = yourRating;
                    setState(() {});
                  });
                },
                starCount: 5,
                rating: yourRating,
                size: 40.0,
                color: Colors.green,
                borderColor: Colors.orange,
              ),
            ],
          ),
        ),
      ));

  // Widget actionCard() => Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //       child: Card(
  //         child: Padding(padding: const EdgeInsets.all(8.0), child: ShoppingAction(product: product)),
  //       ),
  //     );
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: deviceSize.height / 4,
          ),
          mainCard(),
          imagesCard(),
          stars(),
          descCard(),
          // actionCard(),
        ],
      ),
    );
  }
}
