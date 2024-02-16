class RandomCat {
  RandomCat(
      {required this.id,
      required this.url,
      required this.width,
      required this.height});

  String id;
  String url;
  int width;
  int height;

  factory RandomCat.fromJson(List<dynamic> json) {
    return RandomCat(
        id: json[0]['id'],
        url: json[0]['url'],
        width: json[0]['width'],
        height: json[0]['height']);
  }
}
