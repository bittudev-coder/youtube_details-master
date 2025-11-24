import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_details/src/Model/channel_details_model.dart';
import 'package:youtube_details/src/Model/videos_model.dart';

import 'Config/string_config.dart';
import 'Model/posts_model.dart';
import 'Model/shorts_model.dart';
import 'Model/video_model.dart';

/// A high–level API for scraping and extracting YouTube channel data
/// such as:
///
/// - Channel details
/// - Channel videos
/// - YouTube Shorts
/// - Community posts
/// - Individual video details
///
/// This class uses YouTube's public web endpoints and parses
/// the `ytInitialData` JSON present inside the HTML page.
/// All methods return parsed models for easy usage.
class YouTubeDetails {
  YouTubeDetails._();

  /// Returns a singleton instance of [YouTubeDetails].
  static final YouTubeDetails getInstance = YouTubeDetails._();

  /// Fetches channel details such as:
  /// - Channel title
  /// - Profile image
  /// - Subscriber/meta text
  Future<ChannelDetailsModel?> fetchChannelDetails({
    required String channelId,
  }) async {
    final url = '$baseUrl$channelId';

    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'Mozilla/5.0'},
    );

    if (response.statusCode != 200) {
      print(jsonEncode({'error': 'Page not loaded'}));
      return null;
    }

    final html = response.body;

    final patterns = [
      RegExp(r'ytInitialData"\s*:\s*(\{.*?\})\s*,\s*"ytInitialPlayerResponse"', dotAll: true),
      RegExp(r'ytInitialData"\s*=\s*(\{.*?\});', dotAll: true),
      RegExp(r'var ytInitialData\s*=\s*(\{.*?\});', dotAll: true),
    ];

    String? jsonString;

    for (final p in patterns) {
      final match = p.firstMatch(html);
      if (match != null) {
        jsonString = match.group(1);
        break;
      }
    }

    if (jsonString == null) {
      print(jsonEncode({'error': 'ytInitialData not found'}));
      return null;
    }

    Map<String, dynamic>? data;
    try {
      data = jsonDecode(jsonString);
    } catch (e) {
      print(jsonEncode({'error': 'JSON Decode Failed'}));
      return null;
    }

    final pageHeader = data!['header']?['pageHeaderRenderer'];

    if (pageHeader == null) {
      print(jsonEncode({'error': 'header not found'}));
      return null;
    }

    final title = pageHeader['pageTitle'];

    final imageSources = pageHeader?['content']?['pageHeaderViewModel']
    ?['image']?['decoratedAvatarViewModel']?['avatar']
    ?['avatarViewModel']?['image']?['sources'] ?? [];

    String? profileImage;
    if (imageSources is List && imageSources.isNotEmpty) {
      profileImage = imageSources.last['url'];
    }

    final meta = pageHeader?['content']?['pageHeaderViewModel']?['metadata']
    ?['contentMetadataViewModel']?['metadataRows']?[1]?['metadataParts']
    ?[0]?['text']?['content'];

    final output = {
      'title': title,
      'profile_image': profileImage,
      'meta': meta,
    };

    return ChannelDetailsModel.fromJson(output);
  }

  /// Fetches the list of uploaded long–form videos of a YouTube channel.
  Future<List<VideosModel>> fetchVideos({required String channelId}) async {
    final url = '$baseUrl$channelId/$videosPath';
    List<VideosModel> videoList = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );

      if (response.statusCode != 200) {
        print(jsonEncode({'error': 'Page not loaded'}));
        return videoList;
      }

      final html = response.body;

      final patterns = [
        RegExp(r'ytInitialData"\s*:\s*(\{.*?\})\s*,\s*"ytInitialPlayerResponse"', dotAll: true),
        RegExp(r'ytInitialData"\s*=\s*(\{.*?\});', dotAll: true),
        RegExp(r'var ytInitialData\s*=\s*(\{.*?\});', dotAll: true),
      ];

      String? jsonString;

      for (final p in patterns) {
        final match = p.firstMatch(html);
        if (match != null) {
          jsonString = match.group(1);
          break;
        }
      }

      if (jsonString == null) {
        print(jsonEncode({'error': 'ytInitialData not found'}));
        return videoList;
      }

      Map<String, dynamic>? data = jsonDecode(jsonString);

      final tabs = data!['contents']?['twoColumnBrowseResultsRenderer']?['tabs'];
      if (tabs == null) {
        return videoList;
      }

      Map? finalTab;
      for (var item in tabs) {
        if (item['tabRenderer']?['title'] == 'Videos') {
          finalTab = item['tabRenderer'];
          break;
        }
      }
      if (finalTab == null) {
        return videoList;
      }

      final contents = finalTab['content']?['richGridRenderer']?['contents'] ?? [];

      for (var item in contents) {
        var v = item?['richItemRenderer']?['content']?['videoRenderer'];
        if (v == null) {
          continue;
        }

        videoList.add(
          VideosModel(
            videoId: v['videoId'],
            title: v['title']?['runs']?[0]?['text'],
            thumbnail: (v['thumbnail']?['thumbnails'] != null)
                ? v['thumbnail']['thumbnails'].last['url']
                : null,
            duration: v['lengthText']?['simpleText'],
            views: v['viewCountText']?['simpleText'],
            published: v['publishedTimeText']?['simpleText'],
          ),
        );
      }

      return videoList;
    } catch (e) {
      print(jsonEncode({'error': 'Exception occurred: $e'}));
      return videoList;
    }
  }

  /// Fetches YouTube Shorts from the channel's "Shorts" tab.
  Future<List<ShortModel>> fetchShorts({required String channelId}) async {
    final url = '$baseUrl$channelId/$shortsPath';
    List<ShortModel> shortsList = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );

      if (response.statusCode != 200) {
        print({'error': 'Page not loaded'});
        return shortsList;
      }

      final html = response.body;

      final patterns = [
        RegExp(r'ytInitialData"\s*:\s*(\{.*?\})\s*,\s*"ytInitialPlayerResponse"', dotAll: true),
        RegExp(r'ytInitialData"\s*=\s*(\{.*?\});', dotAll: true),
        RegExp(r'var ytInitialData\s*=\s*(\{.*?\});', dotAll: true),
      ];

      String? jsonString;
      for (final p in patterns) {
        final m = p.firstMatch(html);
        if (m != null) {
          jsonString = m.group(1);
          break;
        }
      }

      if (jsonString == null) {
        print({'error': 'ytInitialData not found'});
        return shortsList;
      }

      final data = jsonDecode(jsonString);

      final tabs = data['contents']?['twoColumnBrowseResultsRenderer']?['tabs'];

      Map? shortsTab;
      for (var t in tabs) {
        if (t['tabRenderer']?['title'] == 'Shorts') {
          shortsTab = t['tabRenderer'];
          break;
        }
      }

      if (shortsTab == null) {
        return shortsList;
      }

      final contents = shortsTab['content']?['richGridRenderer']?['contents'] ?? [];

      for (var item in contents) {
        final s = item?['richItemRenderer']?['content']?['shortsLockupViewModel'];
        if (s == null) {
          continue;
        }

        final thumb = s['thumbnail']?['sources']?[0];

        shortsList.add(
          ShortModel(
            videoId: s['onTap']?['innertubeCommand']?['reelWatchEndpoint']?['videoId'],
            title: s['overlayMetadata']?['primaryText']?['content'],
            views: s['overlayMetadata']?['secondaryText']?['content'],
            thumbnail: thumb?['url'],
            width: thumb?['width'],
            height: thumb?['height'],
            entityId: s['entityId'],
            accessibilityText: s['accessibilityText'],
          ),
        );
      }

      return shortsList;
    } catch (e) {
      print({'error': 'Exception occurred: $e'});
      return shortsList;
    }
  }

  /// Fetches community posts from the channel's "Posts" tab.
  Future<List<PostsModel>> fetchPosts({required String channelId}) async {
    final url = '$baseUrl$channelId/$postsPath';
    List<PostsModel> posts = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );

      if (response.statusCode != 200) {
        return posts;
      }

      final html = response.body;

      final patterns = [
        RegExp(r'ytInitialData"\s*:\s*(\{.*?\})\s*,\s*"ytInitialPlayerResponse"', dotAll: true),
        RegExp(r'ytInitialData"\s*=\s*(\{.*?\});', dotAll: true),
        RegExp(r'var ytInitialData\s*=\s*(\{.*?\});', dotAll: true),
      ];

      String? jsonString;
      for (final p in patterns) {
        final m = p.firstMatch(html);
        if (m != null) {
          jsonString = m.group(1);
          break;
        }
      }

      if (jsonString == null) {
        return posts;
      }

      final data = jsonDecode(jsonString);

      final tabs = data['contents']['twoColumnBrowseResultsRenderer']['tabs'];
      Map? postsTab;

      for (final t in tabs) {
        if (t['tabRenderer']?['title'] == 'Posts') {
          postsTab = t['tabRenderer'];
          break;
        }
      }

      if (postsTab == null) {
        return posts;
      }

      final contents = postsTab['content']['sectionListRenderer']['contents'][0]
      ['itemSectionRenderer']['contents'];

      for (var item in contents) {
        final postData = item['backstagePostThreadRenderer']?['post']?['backstagePostRenderer'];
        if (postData == null) {
          continue;
        }

        final id = postData['postId'];
        final author = postData['authorText']?['runs']?[0]?['text'] ?? '';
        final channelId = postData['authorEndpoint']?['browseEndpoint']?['browseId'] ?? '';
        final content = postData['contentText']?['runs']?[0]?['text'] ?? '';
        final published = postData['publishedTimeText']?['runs']?[0]?['text'] ?? '';
        final likes = postData['voteCount']?['simpleText'] ?? '0';

        final comments = postData['actionButtons']?['commentActionButtonsRenderer']?['replyButton']?['buttonRenderer']?['text']?['simpleText'] ?? '0';

        String type = 'text';
        Media? mediaObj;

        final attachment = postData['backstageAttachment'];

        if (attachment?['videoRenderer'] != null) {
          final v = attachment['videoRenderer'];
          type = 'video';

          final thumbnail = (v['thumbnail']?['thumbnails']?.isNotEmpty ?? false)
              ? v['thumbnail']['thumbnails'].last['url']
              : '';

          mediaObj = Media(
            thumbnail: thumbnail,
            postUrl: '/watch?v=${v['videoId']}',
          );
        } else if (attachment?['backstageImageRenderer'] != null) {
          final img = attachment['backstageImageRenderer'];
          final thumbList = img['image']?['thumbnails'];
          String thumbUrl = thumbList != null && thumbList.isNotEmpty ? thumbList.last['url'] : '';

          type = 'image';

          mediaObj = Media(thumbnail: thumbUrl, postUrl: '/post/$id');
        }

        posts.add(
          PostsModel(
            postInfo: PostInfo(
              id: id,
              author: author,
              authorChannelId: channelId,
              content: content,
              publishedTime: published,
              likes: likes,
              comments: comments,
            ),
            type: type,
            media: mediaObj,
          ),
        );
      }

      return posts;
    } catch (e) {
      print('Error: $e');
      return posts;
    }
  }

  /// Fetches detailed information about a single YouTube video.
  Future<VideoModel?> fetchVideoDetails({required String videoId}) async {
    final url = '$videoDetailsUrl$videoId&format=json';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        print('Server Error: ${response.statusCode}');
        return null;
      }

      final body = response.body;

      if (body.startsWith('<') || body.startsWith('<!DOCTYPE')) {
        print('Invalid Response (HTML received instead of JSON)');
        print(body);
        return null;
      }

      final data = jsonDecode(body);

      if (data is Map && data['error'] != null) {
        print('API Error: ${data['error']}');
        return null;
      }

      return VideoModel.fromJson(data);
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
