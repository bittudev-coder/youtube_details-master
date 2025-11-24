import 'dart:convert';

/// Represents a standard YouTube video item fetched from a channel's
/// "Videos" tab.
///
/// This model includes essential metadata such as:
/// - [videoId] → Video identifier
/// - [title] → Video title
/// - [thumbnail] → URL of the video thumbnail
/// - [duration] → Duration text (e.g., "10:23")
/// - [views] → View count text
/// - [published] → Publish time text
///
/// It is used when parsing the result of the "Videos" tab via HTML scraping.
class VideosModel {
  /// The unique YouTube video ID (used to build URLs like `/watch?v=ID`).
  final String? videoId;

  /// The video title.
  final String? title;

  /// URL of the video's thumbnail image.
  final String? thumbnail;

  /// The duration text displayed by YouTube (e.g., `"5:41"`).
  final String? duration;

  /// Readable view count such as `"1.2M views"`.
  final String? views;

  /// Published time text such as `"3 days ago"`.
  final String? published;

  /// Creates a [VideosModel] instance with standard YouTube video metadata.
  VideosModel({
    this.videoId,
    this.title,
    this.thumbnail,
    this.duration,
    this.views,
    this.published,
  });

  /// Creates a [VideosModel] from a JSON map.
  ///
  /// Example JSON:
  /// ```json
  /// {
  ///   "videoId": "abc123",
  ///   "title": "My new video",
  ///   "thumbnail": "https://i.ytimg.com/..",
  ///   "duration": "10:25",
  ///   "views": "150K views",
  ///   "published": "2 weeks ago"
  /// }
  /// ```
  factory VideosModel.fromJson(Map<String, dynamic> json) {
    return VideosModel(
      videoId: json['videoId'] as String?,
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] as String?,
      duration: json['duration'] as String?,
      views: json['views'] as String?,
      published: json['published'] as String?,
    );
  }

  /// Converts this model into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'title': title,
      'thumbnail': thumbnail,
      'duration': duration,
      'views': views,
      'published': published,
    };
  }

  /// Returns a new [VideosModel] with updated fields while keeping
  /// the existing values for unspecified fields.
  VideosModel copyWith({
    String? videoId,
    String? title,
    String? thumbnail,
    String? duration,
    String? views,
    String? published,
  }) {
    return VideosModel(
      videoId: videoId ?? this.videoId,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      views: views ?? this.views,
      published: published ?? this.published,
    );
  }

  @override
  String toString() {
    return 'VideoModel(videoId: $videoId, title: $title)';
  }

  /// Parses a JSON string containing an array of video objects
  /// into a list of [VideosModel].
  ///
  /// Returns an empty list if the JSON is not an array.
  static List<VideosModel> listFromJsonString(String jsonString) {
    final decoded = json.decode(jsonString);
    if (decoded is! List) {
      return [];
    }
    return decoded
        .map<VideosModel>(
          (e) => VideosModel.fromJson(e as Map<String, dynamic>),
    )
        .toList();
  }

  /// Converts a list of [VideosModel] into a JSON string.
  static String listToJsonString(List<VideosModel> list) {
    final maps = list.map((e) => e.toJson()).toList();
    return json.encode(maps);
  }
}
