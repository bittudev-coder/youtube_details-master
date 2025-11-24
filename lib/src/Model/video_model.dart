/// Represents metadata for a YouTube video retrieved via the oEmbed API.
///
/// This model contains detailed information such as the video's author,
/// provider, dimensions, thumbnail metadata, and embeddable HTML.
///
/// Example usage:
/// ```dart
/// final video = VideoModel.fromJson(responseJson);
/// print(video.title);
/// ```
class VideoModel {
  /// The title of the video.
  final String title;

  /// The name of the channel or author who uploaded the video.
  final String authorName;

  /// The URL to the YouTube channel or author's page.
  final String authorUrl;

  /// The type of oEmbed resource, usually 'video'.
  final String type;

  /// The height of the video embed (in pixels).
  final int height;

  /// The width of the video embed (in pixels).
  final int width;

  /// Name of the content provider, usually 'YouTube'.
  final String providerName;

  /// URL of the content provider.
  final String providerUrl;

  /// Height of the video thumbnail.
  final int thumbnailHeight;

  /// Width of the video thumbnail.
  final int thumbnailWidth;

  /// URL of the video's thumbnail image.
  final String thumbnailUrl;

  /// The embeddable HTML iframe snippet.
  final String html;

  /// Creates a new [VideoModel] containing YouTube video metadata.
  VideoModel({
    required this.title,
    required this.authorName,
    required this.authorUrl,
    required this.type,
    required this.height,
    required this.width,
    required this.providerName,
    required this.providerUrl,
    required this.thumbnailHeight,
    required this.thumbnailWidth,
    required this.thumbnailUrl,
    required this.html,
  });

  /// Creates a [VideoModel] from a JSON map returned by the oEmbed API.
  ///
  /// Example JSON:
  /// ```json
  /// {
  ///   'title': 'Sample Video',
  ///   'author_name': 'Channel Name',
  ///   'author_url': 'https://youtube.com/c/channel',
  ///   'type': 'video',
  ///   'height': 113,
  ///   'width': 200,
  ///   'provider_name': 'YouTube',
  ///   'provider_url': 'https://youtube.com',
  ///   'thumbnail_height': 360,
  ///   'thumbnail_width': 480,
  ///   'thumbnail_url': 'https://i.ytimg.com/vi/xyz/default.jpg',
  ///   'html': '<iframe ...></iframe>'
  /// }
  /// ```
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      authorName: json['author_name'],
      authorUrl: json['author_url'],
      type: json['type'],
      height: json['height'],
      width: json['width'],
      providerName: json['provider_name'],
      providerUrl: json['provider_url'],
      thumbnailHeight: json['thumbnail_height'],
      thumbnailWidth: json['thumbnail_width'],
      thumbnailUrl: json['thumbnail_url'],
      html: json['html'],
    );
  }

  /// Converts this model into a JSON map compatible with the oEmbed format.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author_name': authorName,
      'author_url': authorUrl,
      'type': type,
      'height': height,
      'width': width,
      'provider_name': providerName,
      'provider_url': providerUrl,
      'thumbnail_height': thumbnailHeight,
      'thumbnail_width': thumbnailWidth,
      'thumbnail_url': thumbnailUrl,
      'html': html,
    };
  }

  @override
  String toString() => 'VideoModel(title: $title, author: $authorName)';
}
