/// Story model (including voice stories)
class StoryModel {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final StoryType type;
  final String? imageUrl;
  final String? audioUrl;
  final String? transcription;
  final Duration? duration;
  final DateTime createdAt;
  final DateTime expiresAt;
  final int viewsCount;
  final bool isViewed;

  const StoryModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.type,
    this.imageUrl,
    this.audioUrl,
    this.transcription,
    this.duration,
    required this.createdAt,
    required this.expiresAt,
    this.viewsCount = 0,
    this.isViewed = false,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  bool get isVoiceStory => type == StoryType.voice;

  String get timeRemaining {
    final remaining = expiresAt.difference(DateTime.now());
    if (remaining.inHours > 0) {
      return '${remaining.inHours}h left';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes}m left';
    } else {
      return 'Expiring soon';
    }
  }

  StoryModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    StoryType? type,
    String? imageUrl,
    String? audioUrl,
    String? transcription,
    Duration? duration,
    DateTime? createdAt,
    DateTime? expiresAt,
    int? viewsCount,
    bool? isViewed,
  }) {
    return StoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      transcription: transcription ?? this.transcription,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      viewsCount: viewsCount ?? this.viewsCount,
      isViewed: isViewed ?? this.isViewed,
    );
  }
}

enum StoryType { image, voice, text }
