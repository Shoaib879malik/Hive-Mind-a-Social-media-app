import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';

/// Mock data for demonstration
class MockData {
  // Current user
  static const UserModel currentUser = UserModel(
    id: 'user_1',
    name: 'Alex Johnson',
    username: '@alexjohnson',
    avatarUrl: 'https://i.pravatar.cc/150?img=1',
    bio:
        'Digital creator | Photographer 📸 | Living life one moment at a time ✨',
    followersCount: 2847,
    followingCount: 523,
    postsCount: 156,
    isVerified: true,
    isOnline: true,
  );

  // Sample users
  static const List<UserModel> users = [
    UserModel(
      id: 'user_2',
      name: 'Sarah Williams',
      username: '@sarahw',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      bio: 'Coffee lover ☕ | Travel enthusiast 🌍',
      followersCount: 1523,
      followingCount: 342,
      postsCount: 89,
      isVerified: true,
      isOnline: true,
    ),
    UserModel(
      id: 'user_3',
      name: 'Mike Chen',
      username: '@mikechen',
      avatarUrl: 'https://i.pravatar.cc/150?img=8',
      bio: 'Tech geek 💻 | Foodie 🍕',
      followersCount: 4521,
      followingCount: 198,
      postsCount: 234,
      isVerified: false,
      isOnline: false,
    ),
    UserModel(
      id: 'user_4',
      name: 'Emma Davis',
      username: '@emmad',
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
      bio: 'Artist 🎨 | Dreamer ✨',
      followersCount: 892,
      followingCount: 456,
      postsCount: 67,
      isVerified: false,
      isOnline: true,
    ),
    UserModel(
      id: 'user_5',
      name: 'James Wilson',
      username: '@jameswilson',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      bio: 'Fitness | Motivation | Growth 💪',
      followersCount: 12453,
      followingCount: 245,
      postsCount: 312,
      isVerified: true,
      isOnline: false,
    ),
    UserModel(
      id: 'user_6',
      name: 'Olivia Brown',
      username: '@oliviab',
      avatarUrl: 'https://i.pravatar.cc/150?img=16',
      bio: 'Fashion blogger 👗 | NYC 🗽',
      followersCount: 8721,
      followingCount: 523,
      postsCount: 421,
      isVerified: true,
      isOnline: true,
    ),
  ];

  // Sample posts
  static List<PostModel> get posts => [
    PostModel(
      id: 'post_1',
      userId: 'user_2',
      userName: 'Sarah Williams',
      userAvatar: 'https://i.pravatar.cc/150?img=5',
      isVerified: true,
      content:
          'Just had the most amazing coffee at this new place! ☕✨ The vibes here are absolutely incredible. Feeling so happy and grateful for these little moments in life! 😊❤️',
      imageUrl:
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800',
      mood: 'Happy',
      likesCount: 234,
      commentsCount: 45,
      isLiked: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    PostModel(
      id: 'post_2',
      userId: 'user_3',
      userName: 'Mike Chen',
      userAvatar: 'https://i.pravatar.cc/150?img=8',
      isVerified: false,
      content:
          'Can\'t wait for the weekend! Got some exciting plans ahead 🎉🚀 Who else is pumped?!',
      mood: 'Excited',
      likesCount: 156,
      commentsCount: 23,
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    PostModel(
      id: 'post_3',
      userId: 'user_5',
      userName: 'James Wilson',
      userAvatar: 'https://i.pravatar.cc/150?img=12',
      isVerified: true,
      content:
          'Morning meditation session complete 🧘 Starting the day with a calm mind and peaceful heart. Remember: breathe, focus, and let go of what you cannot control. 😌🌿',
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800',
      mood: 'Calm',
      likesCount: 892,
      commentsCount: 67,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    PostModel(
      id: 'post_4',
      userId: 'user_4',
      userName: 'Emma Davis',
      userAvatar: 'https://i.pravatar.cc/150?img=9',
      isVerified: false,
      content:
          'New artwork finally complete! 🎨 This piece took me 3 weeks but it was worth every moment. Art is my soul\'s expression. ✨',
      imageUrl:
          'https://images.unsplash.com/photo-1549887552-cb1071d3e5ca?w=800',
      mood: 'Happy',
      likesCount: 445,
      commentsCount: 89,
      isLiked: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    PostModel(
      id: 'post_5',
      userId: 'user_6',
      userName: 'Olivia Brown',
      userAvatar: 'https://i.pravatar.cc/150?img=16',
      isVerified: true,
      content:
          'Today\'s look 👗✨ Sometimes the simplest outfits make the biggest statement. What do you think?',
      imageUrl:
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=800',
      mood: 'Happy',
      likesCount: 1234,
      commentsCount: 156,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    PostModel(
      id: 'post_6',
      userId: 'user_2',
      userName: 'Sarah Williams',
      userAvatar: 'https://i.pravatar.cc/150?img=5',
      isVerified: true,
      content:
          'Missing traveling so much right now 😢 Can\'t wait until I can explore new places again. These memories keep me going... 💙',
      imageUrl:
          'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800',
      mood: 'Sad',
      likesCount: 178,
      commentsCount: 34,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Sample stories
  static List<StoryModel> get stories => [
    StoryModel(
      id: 'story_1',
      userId: 'user_1',
      userName: 'Your Story',
      userAvatar: 'https://i.pravatar.cc/150?img=1',
      type: StoryType.image,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
      isViewed: true,
    ),
    StoryModel(
      id: 'story_2',
      userId: 'user_2',
      userName: 'Sarah',
      userAvatar: 'https://i.pravatar.cc/150?img=5',
      type: StoryType.voice,
      audioUrl: 'audio_url_here',
      transcription:
          'Hey everyone! Just wanted to share my thoughts on this beautiful morning...',
      duration: const Duration(seconds: 45),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      expiresAt: DateTime.now().add(const Duration(hours: 22)),
      viewsCount: 156,
    ),
    StoryModel(
      id: 'story_3',
      userId: 'user_5',
      userName: 'James',
      userAvatar: 'https://i.pravatar.cc/150?img=12',
      type: StoryType.image,
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      expiresAt: DateTime.now().add(const Duration(hours: 20)),
      viewsCount: 423,
    ),
    StoryModel(
      id: 'story_4',
      userId: 'user_6',
      userName: 'Olivia',
      userAvatar: 'https://i.pravatar.cc/150?img=16',
      type: StoryType.voice,
      audioUrl: 'audio_url_here',
      transcription:
          'Quick fashion tip for today: Always accessorize! It makes all the difference.',
      duration: const Duration(seconds: 30),
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      expiresAt: DateTime.now().add(const Duration(hours: 18)),
      viewsCount: 892,
    ),
    StoryModel(
      id: 'story_5',
      userId: 'user_3',
      userName: 'Mike',
      userAvatar: 'https://i.pravatar.cc/150?img=8',
      type: StoryType.image,
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      expiresAt: DateTime.now().add(const Duration(hours: 16)),
      viewsCount: 234,
    ),
    StoryModel(
      id: 'story_6',
      userId: 'user_4',
      userName: 'Emma',
      userAvatar: 'https://i.pravatar.cc/150?img=9',
      type: StoryType.voice,
      audioUrl: 'audio_url_here',
      transcription:
          'Working on a new art piece today! Can\'t wait to share it with you all soon.',
      duration: const Duration(seconds: 20),
      createdAt: DateTime.now().subtract(const Duration(hours: 10)),
      expiresAt: DateTime.now().add(const Duration(hours: 14)),
      viewsCount: 145,
    ),
  ];

  // Notifications data
  static List<Map<String, dynamic>> get notifications => [
    {
      'type': 'like',
      'user': users[0],
      'postId': 'post_4',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'type': 'comment',
      'user': users[1],
      'postId': 'post_4',
      'comment': 'This is amazing! Love your work! 😍',
      'time': DateTime.now().subtract(const Duration(minutes: 15)),
    },
    {
      'type': 'follow',
      'user': users[2],
      'time': DateTime.now().subtract(const Duration(hours: 1)),
    },
    {
      'type': 'like',
      'user': users[3],
      'postId': 'post_1',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'type': 'mention',
      'user': users[4],
      'postId': 'post_new',
      'time': DateTime.now().subtract(const Duration(hours: 3)),
    },
  ];

  // Trending hashtags
  static List<Map<String, dynamic>> get trendingHashtags => [
    {'tag': '#Photography', 'posts': '125K'},
    {'tag': '#MorningVibes', 'posts': '89K'},
    {'tag': '#ArtLife', 'posts': '67K'},
    {'tag': '#TechTalk', 'posts': '54K'},
    {'tag': '#FitnessGoals', 'posts': '43K'},
    {'tag': '#FoodieLife', 'posts': '38K'},
    {'tag': '#TravelDiaries', 'posts': '32K'},
    {'tag': '#OOTD', 'posts': '28K'},
  ];
}
