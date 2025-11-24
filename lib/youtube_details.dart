/// A Dart package for fetching YouTube channel data without using the
/// official YouTube Data API.
///
/// This library provides utilities to scrape public YouTube pages and extract
/// structured information such as:
///
/// * Channel Details
/// * Videos
/// * Shorts
/// * Community Posts
/// * Video Metadata (via oEmbed)
///
/// ### Example
/// ```dart
/// import 'package:youtube_details/youtube_details.dart';
///
/// void main() async {
///   final yt = YouTubeDetails.getInstance;
///
///   final channel = await yt.fetchChannelDetails(channelId: "GoogleDevelopers");
///   print(channel?.title);
///
///   final videos = await yt.fetchVideos(channelId: "GoogleDevelopers");
///   print("Videos: ${videos.length}");
/// }
/// ```
///
/// This library exports all public-facing models and the main API class.
library;

export 'src/youtube_details_base.dart';

/// Data models
export 'src/Model/channel_details_model.dart';
export 'src/Model/posts_model.dart';
export 'src/Model/shorts_model.dart';
export 'src/Model/video_model.dart';
export 'src/Model/videos_model.dart';

/// TODO: Export additional files intended for clients of this package.
