class News {
  String pubDate;
  String title;
  String description;
  String link;
  String guid;
  String thumbnail;

  News({this.pubDate, this.title});

  Map<String, dynamic> toJson() => {
        'pubDate': pubDate,
        'title': title,
        'description': description,
        'link': link,
        'guid': guid,
        'thumbnail': thumbnail,
      };
}
