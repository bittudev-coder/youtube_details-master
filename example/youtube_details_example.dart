import 'dart:convert';
import 'package:youtube_details/youtube_details.dart';

/// Example demonstrating how to use the `YouTubeDetails` package.
///
/// This example fetches:
/// - Channel details
/// - All videos
/// - Shorts
/// - Community posts
/// - Single video details
///
/// Replace 'byte_coding5339' and video ID with your own channel or video IDs.
Future<void> main() async {
  // Get singleton instance
  final yt = YouTubeDetails.getInstance;

  const channelId = 'byte_coding5339';
  const videoId = 'yhCTP-81tZ0';

  try {
    // ---------------------------
    // Fetch Channel Details
    // ---------------------------
    print('\n🔹 Fetching Channel Details...');
    final channel = await yt.fetchChannelDetails(channelId: channelId);
    if (channel != null) {
      print(jsonEncode(channel.toJson()));
    } else {
      print('❌ Channel not found or page failed to load');
    }

    // ---------------------------
    // Fetch All Videos
    // ---------------------------
    print('\n🔹 Fetching All Videos...');
    final videos = await yt.fetchVideos(channelId: channelId);
    print(jsonEncode(videos.map((v) => v.toJson()).toList()));

    // ---------------------------
    // Fetch Shorts
    // ---------------------------
    print('\n🔹 Fetching YouTube Shorts...');
    final shorts = await yt.fetchShorts(channelId: channelId);
    print(jsonEncode(shorts.map((s) => s.toJson()).toList()));

    // ---------------------------
    // Fetch Community Posts
    // ---------------------------
    print('\n🔹 Fetching YouTube Posts...');
    final posts = await yt.fetchPosts(channelId: channelId);
    print(jsonEncode(posts.map((p) => p.toJson()).toList()));

    // ---------------------------
    // Fetch Single Video Details
    // ---------------------------
    print('\n🔹 Fetching Single Video Details...');
    final video = await yt.fetchVideoDetails(videoId: videoId);
    if (video != null) {
      print(jsonEncode(video.toJson()));
    } else {
      print('❌ Video not found');
    }
  } catch (e) {
    print('\n❌ Error Occurred: $e');
  }
}
