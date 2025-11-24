/// A data model representing basic information about a YouTube channel.
///
/// This model is populated from scraped `ytInitialData` fields and contains:
/// - [title] → The channel’s display name
/// - [profileImage] → URL to the channel’s avatar/profile picture
/// - [meta] → Metadata text (usually subscribers or descriptive info)
///
/// Example:
/// ```dart
/// final channel = ChannelDetailsModel(
///   title: 'Google Developers',
///   profileImage: 'https://yt3.ggpht.com/xxxx',
///   meta: '3.5M subscribers',
/// );
/// ```
class ChannelDetailsModel {
  /// The channel title or display name.
  final String? title;

  /// URL of the channel profile/brand avatar image.
  final String? profileImage;

  /// Metadata text (e.g., subscriber count or additional info).
  final String? meta;

  /// Creates a new [ChannelDetailsModel] instance.
  ChannelDetailsModel({
    this.title,
    this.profileImage,
    this.meta,
  });

  /// Creates a [ChannelDetailsModel] from a JSON map.
  ///
  /// Expected JSON format:
  /// ```json
  /// {
  ///   'title': 'Channel Name',
  ///   'profile_image': 'https://image-url',
  ///   'meta': '3.2M subscribers'
  /// }
  /// ```
  factory ChannelDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChannelDetailsModel(
      title: json['title'],
      profileImage: json['profile_image'],
      meta: json['meta'],
    );
  }

  /// Converts the model into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'profile_image': profileImage,
      'meta': meta,
    };
  }
}
