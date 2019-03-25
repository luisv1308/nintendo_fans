class Game {
  int id;
  String title;
  String image;
  dynamic eshopPrice;
  dynamic salePrice;
  String description;
  String publisher;
  String developer;
  bool favourite;
  String rating;
  double yourRating;
  String slug;

  Game();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'eshopPrice': eshopPrice,
        'salePrice': salePrice,
        'publisher': publisher,
        'developer': developer,
        'favourite': favourite,
        'rating': rating,
        'yourRating': yourRating,
        'slug': slug,
      };

  Game.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        image = json['image'],
        eshopPrice = json['eshop_price'],
        publisher = json['publisher'],
        developer = json['developer'],
        salePrice = json['sale_price'],
        favourite = json['favourite'],
        rating = json['rating'],
        yourRating = double.parse(json['your_rating']),
        slug = json['slug'];
}
