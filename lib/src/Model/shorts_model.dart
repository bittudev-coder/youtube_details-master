/// Represents a YouTube Shorts video extracted from channel data.
///
/// This model contains essential metadata such as title, view count,
/// thumbnail, and video dimensions.
///
/// It is used when parsing the 'Shorts' tab of a YouTube channel.
class ShortModel {
  /// The ID of the YouTube Shorts video.
  ///
  /// Can be used to build a watch URL (e.g., '/shorts/{videoId}').
  final String? videoId;

  /// Title or caption of the Shorts video.
  final String? title;

  /// Display-friendly view count, e.g. '1.2M views'.
  final String? views;

  /// Thumbnail URL of the Shorts video.
  final String? thumbnail;

  /// Thumbnail width in pixels.
  final int? width;

  /// Thumbnail height in pixels.
  final int? height;

  /// Internal YouTube entity ID for the Shorts video.
  ///
  /// This is mostly used by YouTube internally and may not always appear.
  final String? entityId;

  /// Accessibility description associated with the Shorts video.
  final String? accessibilityText;

  /// Creates a new [ShortModel] containing Shorts metadata.
  ShortModel({
    this.videoId,
    this.title,
    this.views,
    this.thumbnail,
    this.width,
    this.height,
    this.entityId,
    this.accessibilityText,
  });

  /// Creates a [ShortModel] instance from a JSON map.
  ///
  /// Expected JSON structure:
  /// ```json
  /// {
  ///   'videoId': 'abc123',
  ///   'title': 'Funny Clip',
  ///   'views': '2.3M',
  ///   'thumbnail': 'https://link.jpg',
  ///   'width': 720,
  ///   'height': 1280,
  ///   'entityId': 'xyz',
  ///   'accessibilityText': 'Shorts clip description'
  /// }
  /// ```
  factory ShortModel.fromJson(Map<String, dynamic> json) => ShortModel(
    videoId: json['videoId'],
    title: json['title'],
    views: json['views'],
    thumbnail: json['thumbnail'],
    width: json['width'],
    height: json['height'],
    entityId: json['entityId'],
    accessibilityText: json['accessibilityText'],
  );

  /// Converts this Shorts model into a JSON map.
  Map<String, dynamic> toJson() => {
    'videoId': videoId,
    'title': title,
    'views': views,
    'thumbnail': thumbnail,
    'width': width,
    'height': height,
    'entityId': entityId,
    'accessibilityText': accessibilityText,
  };
}
