import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/avatar_widget.dart';

/// Notifications screen
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Mark all read',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Notifications list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount:
                    MockData.notifications.length + 3, // + some older ones
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ).animate().fadeIn(duration: 300.ms);
                  }

                  if (index == 4) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 12),
                      child: Text(
                        'Earlier',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 300.ms);
                  }

                  final notificationIndex = index > 4 ? index - 2 : index - 1;
                  if (notificationIndex >= MockData.notifications.length) {
                    return _buildOlderNotification(index);
                  }

                  final notification =
                      MockData.notifications[notificationIndex];

                  return _NotificationItem(
                        notification: notification,
                        isNew: index < 4,
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms, duration: 300.ms)
                      .slideX(begin: 0.1, end: 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOlderNotification(int index) {
    final user = MockData.users[index % MockData.users.length];
    return _NotificationItem(
          notification: {
            'type': 'like',
            'user': user,
            'postId': 'post_old',
            'time': DateTime.now().subtract(Duration(days: index)),
          },
          isNew: false,
        )
        .animate()
        .fadeIn(delay: (100 * index).ms, duration: 300.ms)
        .slideX(begin: 0.1, end: 0);
  }
}

class _NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;
  final bool isNew;

  const _NotificationItem({required this.notification, required this.isNew});

  @override
  Widget build(BuildContext context) {
    final user = notification['user'] as dynamic;
    final type = notification['type'] as String;

    IconData icon;
    Color iconColor;
    String text;

    switch (type) {
      case 'like':
        icon = Icons.favorite;
        iconColor = AppColors.error;
        text = 'liked your post';
        break;
      case 'comment':
        icon = Icons.chat_bubble;
        iconColor = AppColors.primaryBlue;
        text = 'commented: "${notification['comment']}"';
        break;
      case 'follow':
        icon = Icons.person_add;
        iconColor = AppColors.success;
        text = 'started following you';
        break;
      case 'mention':
        icon = Icons.alternate_email;
        iconColor = AppColors.warning;
        text = 'mentioned you in a post';
        break;
      default:
        icon = Icons.notifications;
        iconColor = AppColors.primaryBlue;
        text = 'notified you';
    }

    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      borderColor: isNew ? AppColors.primaryBlue.withOpacity(0.3) : null,
      child: Row(
        children: [
          Stack(
            children: [
              AvatarWidget(imageUrl: user.avatarUrl, name: user.name, size: 48),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: Icon(icon, size: 10, color: AppColors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: user.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ' $text'),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(notification['time'] as DateTime),
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          if (type == 'follow')
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Follow', style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}
