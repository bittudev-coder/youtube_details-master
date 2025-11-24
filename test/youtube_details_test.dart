import 'package:youtube_details/youtube_details.dart';
import 'package:test/test.dart';

void main() {
  final yb = YouTubeDetails.getInstance;

  group('YouTube API Tests', () {
    test('Channel Details Working', () async {
      final data = await yb.fetchChannelDetails(channelId: 'byte_coding5339');
      expect(data, isNotNull);
      expect(data!.title!.isNotEmpty, true);
    });

    test('Videos Fetch Working', () async {
      final list = await yb.fetchVideos(channelId: 'byte_coding5339');
      expect(list, isA<List>());
    });

    test('Shorts Fetch Working', () async {
      final list = await yb.fetchShorts(channelId: 'byte_coding5339');
      expect(list, isA<List>());
    });

    test('Posts Fetch Working', () async {
      final list = await yb.fetchPosts(channelId: 'byte_coding5339');
      expect(list, isA<List>());
    });

    test('Video Details Working', () async {
      final video = await yb.fetchVideoDetails(videoId: 'yhCTP-81tZ0');
      expect(video, isNotNull);
    });
  });
}
