class RandomDog {
  RandomDog(
      {required this.fileSizeBytes, required this.url, this.isVideo = false});

  int fileSizeBytes;
  String url;
  bool isVideo;

  factory RandomDog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'fileSizeBytes': int fileSizeBytes, 'url': String url} => RandomDog(
          fileSizeBytes: fileSizeBytes, url: url, isVideo: isVideoUrl(url)),
      _ => throw const FormatException('Failed to load RandomDog')
    };
  }

  static bool isVideoUrl(String url) {
    return url.contains('.mp4');
  }
}
