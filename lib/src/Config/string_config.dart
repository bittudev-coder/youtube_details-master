/// Base YouTube URL used to access a channel by username or handle.
///
/// The final request URL typically looks like:
/// `https://www.youtube.com/@channelName`
const String baseUrl = 'https://www.youtube.com/@';

/// Path appended to a channel URL to access the "Videos" tab.
///
/// Example:
/// `https://www.youtube.com/@channelName/videos`
const String videosPath = '/videos';

/// Path appended to a channel URL to access the "Shorts" tab.
///
/// Example:
/// `https://www.youtube.com/@channelName/shorts`
const String shortsPath = '/shorts';

/// Path appended to a channel URL to access the "Posts" (Community) tab.
///
/// Example:
/// `https://www.youtube.com/@channelName/posts`
const String postsPath = '/posts';

/// Base URL for fetching video details using YouTube's oEmbed API.
///
/// The final request looks like:
/// `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json`
///
/// The `format=json` is added automatically from the API function.
const String videoDetailsUrl =
    'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=';
