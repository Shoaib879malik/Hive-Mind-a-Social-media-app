import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// User avatar widget with online status indicator
class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final bool showOnlineStatus;
  final bool isOnline;
  final bool hasBorder;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 36,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth = 2,
    this.onTap,
  });

  String get _initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name![0].toUpperCase();
  }

  Color get _backgroundColor {
    if (name == null || name!.isEmpty) return AppColors.primaryBlue;
    final colors = [
      AppColors.primaryBlue,
      AppColors.accentBlue,
      AppColors.moodHappy,
      AppColors.moodCalm,
      AppColors.moodExcited,
    ];
    return colors[name!.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: hasBorder
                  ? Border.all(
                      color: borderColor ?? AppColors.primaryBlue,
                      width: borderWidth,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.glassShadow,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          if (showOnlineStatus)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.28,
                height: size * 0.28,
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.success : AppColors.textMuted,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_backgroundColor, _backgroundColor.withOpacity(0.7)],
        ),
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: AppColors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Gradient bordered avatar for stories
class StoryAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final bool hasUnseenStory;
  final VoidCallback? onTap;

  const StoryAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 56,
    this.hasUnseenStory = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: hasUnseenStory ? AppColors.storyGradient : null,
          color: hasUnseenStory ? null : AppColors.textMuted.withOpacity(0.3),
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: AvatarWidget(imageUrl: imageUrl, name: name, size: size - 10),
        ),
      ),
    );
  }
}
