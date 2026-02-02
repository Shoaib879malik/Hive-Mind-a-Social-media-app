import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../models/post_model.dart';
import '../features/mood/mood_theme.dart';
import 'avatar_widget.dart';

/// Social media post card with glass effect
class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onProfileTap;
  final VoidCallback? onMoodTap;
  final bool showMoodBadge;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onProfileTap,
    this.onMoodTap,
    this.showMoodBadge = true,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _likeController;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked;
    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    if (_isLiked) {
      _likeController.forward().then((_) => _likeController.reverse());
    }
    widget.onLike?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.glassBorder, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onProfileTap,
                        child: AvatarWidget(
                          imageUrl: widget.post.userAvatar,
                          name: widget.post.userName,
                          size: 36,
                          showOnlineStatus: true,
                          isOnline: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.post.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (widget.post.isVerified) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    size: 14,
                                    color: AppColors.primaryBlue,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              widget.post.timeAgo,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Mood badge
                      if (widget.showMoodBadge && widget.post.mood != null)
                        GestureDetector(
                          onTap: widget.onMoodTap,
                          child: _MoodBadge(mood: widget.post.mood!),
                        ),
                      const SizedBox(width: 8),
                      Icon(Icons.more_horiz, color: AppColors.textMuted),
                    ],
                  ),
                ),

                // Content
                if (widget.post.content.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.post.content,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),

                // Image
                if (widget.post.imageUrl != null) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      constraints: const BoxConstraints(maxHeight: 240),
                      child: Image.network(
                        widget.post.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          height: 160,
                          color: AppColors.glassOverlay,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 36,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                // Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        '${widget.post.likesCount} likes',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${widget.post.commentsCount} comments',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // Actions
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.glassBorder.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ActionButton(
                        icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                        label: 'Like',
                        isActive: _isLiked,
                        activeColor: AppColors.error,
                        onTap: _handleLike,
                      ),
                      _ActionButton(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: 'Comment',
                        onTap: widget.onComment,
                      ),
                      _ActionButton(
                        icon: Icons.share_outlined,
                        label: 'Share',
                        onTap: widget.onShare,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color? activeColor;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.activeColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Icon(
                  icon,
                  size: 14,
                  color: isActive
                      ? (activeColor ?? AppColors.primaryBlue)
                      : AppColors.textSecondary,
                )
                .animate(target: isActive ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 200.ms,
                )
                .then()
                .scale(
                  begin: const Offset(1.2, 1.2),
                  end: const Offset(1, 1),
                  duration: 200.ms,
                ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? (activeColor ?? AppColors.primaryBlue)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodBadge extends StatelessWidget {
  final String mood;

  const _MoodBadge({required this.mood});

  @override
  Widget build(BuildContext context) {
    final moodData = MoodTheme.getMoodData(mood);

    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: moodData.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: moodData.color.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(moodData.emoji, style: const TextStyle(fontSize: 10)),
              const SizedBox(width: 4),
              Text(
                mood,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: moodData.color,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}
