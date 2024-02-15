class RandomDog {
  RandomDog({required this.fileSizeBytes, required this.url});

  int fileSizeBytes;
  String url;

  factory RandomDog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'fileSizeBytes': int fileSizeBytes, 'url': String url} =>
        RandomDog(fileSizeBytes: fileSizeBytes, url: url),
      _ => throw const FormatException('Failed to load RandomDog')
    };
  }
}
