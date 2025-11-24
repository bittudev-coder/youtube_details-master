📌 YouTube Details — Fetch YouTube Data Without API Key (🔥 No API Limit)

youtube_details एक Dart/Flutter package है जिससे आप YouTube Channel Details, Videos, Shorts, Posts और Single Video Information fetch कर सकते हैं —
⚡ बिना API Key, ⚡ बिना OAuth, ⚡ बिना Token, ⚡ बिना Quota Limit

⭐ Highlights

✔ Unlimited Access
✔ Zero API Restrictions
✔ Works on Mobile, Web, Backend (Dart)
✔ 100% Free — No billing / token / API key

🔥 What you can fetch
Data	Status
Channel Details	✔
All Videos	✔
Shorts	✔
Posts	✔
Single Video Details	✔
Without YouTube API	✔
📦 Install
dependencies:
youtube_details: ^1.0.0

🚀 Quick Usage
import 'package:youtube_details/youtube_details.dart';

final yb = YouTubeDetails.getInstance;

// Channel
final channel = await yb.fetchChannelDetails(channelId: "byte_coding5339");
print(channel?.toJson());

// Videos
final videos = await yb.fetchVideos(channelId: "byte_coding5339");
print(videos.map((v) => v.toJson()).toList());

// Shorts
final shorts = await yb.fetchShorts(channelId: "byte_coding5339");
print(shorts.map((s) => s.toJson()).toList());

// Posts
final posts = await yb.fetchPosts(channelId: "byte_coding5339");
print(posts.map((p) => p.toJson()).toList());

// Single Video
final video = await yb.fetchVideoDetails(videoId: "yhCTP-81tZ0");
print(video?.toJson());

🧪 Full Example (Demo)
void main() async {
final yb = YouTubeDetails.getInstance;

print("🔹 Channel Details");
print((await yb.fetchChannelDetails(channelId: 'byte_coding5339'))?.toJson());

print("🔹 All Videos");
print((await yb.fetchVideos(channelId: 'byte_coding5339'))
.map((v) => v.toJson()).toList());

print("🔹 Shorts");
print((await yb.fetchShorts(channelId: 'byte_coding5339'))
.map((s) => s.toJson()).toList());

print("🔹 Posts");
print((await yb.fetchPosts(channelId: 'byte_coding5339'))
.map((p) => p.toJson()).toList());

print("🔹 Single Video");
print((await yb.fetchVideoDetails(videoId: 'yhCTP-81tZ0'))?.toJson());
}

⚙ Notes & Limitations

🔹 Works only for public channels & public videos
🔹 If channel/videos are private, YouTube does not provide data
🔹 This package does NOT use YouTube official API → No quota / No limit

🤝 Contribute

Pull Requests welcome.
Bug report / Feature request → GitHub Issues.

📄 License

MIT License © 2025 Bittu Kumar

⭐ Request

अगर package मददगार लगे तो Pub.dev पर ⭐ Like / Rate ज़रूर करना
ये छोटे-छोटे stars future updates के लिए motivation देते हैं 🙌

🔥 YouTube Data Fetching Made Easy
🚀 No API Key • No Quota Limit • No Restrictions • Unlimited Requests