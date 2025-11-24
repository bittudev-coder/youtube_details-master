/// Represents a YouTube Community Post in structured form.
///
/// A community post can be of type:
/// - 'text'
/// - 'image'
/// - 'video'
///
/// Each post always contains [postInfo] and may optionally contain
/// a [media] object (for image or video posts).
class PostsModel {
  /// Core metadata about the post such as text, author, likes, published time.
  final PostInfo postInfo;

  /// The type of community post:
  /// - 'text'
  /// - 'image'
  /// - 'video'
  final String type;

  /// Optional media data for image or video posts.
  final Media? media;

  /// Creates a new [PostsModel] instance.
  PostsModel({
    required this.postInfo,
    required this.type,
    this.media,
  });

  /// Creates a [PostsModel] from a JSON map.
  ///
  /// Example expected structure:
  /// ```json
  /// {
  ///   'post_info': {...},
  ///   'type': 'image',
  ///   'media': {...}
  /// }
  /// ```
  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      postInfo: PostInfo.fromJson(json['post_info']),
      type: json['type'],
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
    );
  }

  /// Converts this post into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'post_info': postInfo.toJson(),
      'type': type,
      'media': media?.toJson(),
    };
  }
}

/// Holds general information about a YouTube community post.
///
/// Includes text content, author details, published time,
/// and engagement metrics such as likes and comment count.
class PostInfo {
  /// Unique ID of the community post.
  final String id;

  /// Name of the user/channel who created the post.
  final String author;

  /// Channel ID of the post creator.
  final String authorChannelId;

  /// The main text content of the post.
  final String content;

  /// Published time (relative), e.g., '2 days ago'.
  final String publishedTime;

  /// Like count text, e.g., '5K' or '120'.
  final String likes;

  /// Comment count text, e.g., '30' or '1.2K'.
  final String comments;

  /// Creates a new [PostInfo] instance.
  PostInfo({
    required this.id,
    required this.author,
    required this.authorChannelId,
    required this.content,
    required this.publishedTime,
    required this.likes,
    required this.comments,
  });

  /// Creates a [PostInfo] object from JSON.
  ///
  /// Expected JSON structure:
  /// ```json
  /// {
  ///   'id': 'ABC123',
  ///   'author': 'Channel Name',
  ///   'author_channel_id': 'UCxxxx',
  ///   'content': 'This is a post',
  ///   'published_time': '3 hours ago',
  ///   'likes': '1.2K',
  ///   'comments': '230'
  /// }
  /// ```
  factory PostInfo.fromJson(Map<String, dynamic> json) {
    return PostInfo(
      id: json['id'],
      author: json['author'],
      authorChannelId: json['author_channel_id'],
      content: json['content'],
      publishedTime: json['published_time'],
      likes: json['likes'],
      comments: json['comments'],
    );
  }

  /// Converts the post information into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'author_channel_id': authorChannelId,
      'content': content,
      'published_time': publishedTime,
      'likes': likes,
      'comments': comments,
    };
  }
}

/// Represents media attached to a community post.
///
/// This can be either:
/// - an image thumbnail
/// - or a video preview thumbnail
///
/// It also includes a [postUrl] that points to the full post or video.
class Media {
  /// Thumbnail image URL of the attached media.
  final String thumbnail;

  /// URL path of the media (post or video).
  final String postUrl;

  /// Creates a [Media] object.
  Media({
    required this.thumbnail,
    required this.postUrl,
  });

  /// Creates a [Media] instance from a JSON map.
  ///
  /// Example:
  /// ```json
  /// {
  ///   'thumbnail': 'https://image.png',
  ///   'post_url': '/post/xyz'
  /// }
  /// ```
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      thumbnail: json['thumbnail'],
      postUrl: json['post_url'],
    );
  }

  /// Converts this media object into JSON.
  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail,
      'post_url': postUrl,
    };
  }
}
