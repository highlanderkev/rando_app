class RandomNumber {
  RandomNumber(
      {required this.status,
      required this.min,
      required this.max,
      required this.random});

  String status;
  int min;
  int max;
  int random;

  factory RandomNumber.fromJson(List<dynamic> json) {
    return RandomNumber(
        status: json[0]['status'],
        min: json[0]['min'],
        max: json[0]['max'],
        random: json[0]['random']);
  }
}
