import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/avatar_widget.dart';

/// Messages/Direct messages screen
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GlassTextField(
                hintText: 'Search messages...',
                prefixIcon: Icons.search,
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 16),

            // Online now
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: MockData.users.where((u) => u.isOnline).length,
                itemBuilder: (context, index) {
                  final onlineUsers = MockData.users
                      .where((u) => u.isOnline)
                      .toList();
                  final user = onlineUsers[index];

                  return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                AvatarWidget(
                                  imageUrl: user.avatarUrl,
                                  name: user.name,
                                  size: 56,
                                ),
                                Positioned(
                                  right: 2,
                                  bottom: 2,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 60,
                              child: Text(
                                user.name.split(' ').first,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms, duration: 300.ms)
                      .slideX(begin: 0.2, end: 0);
                },
              ),
            ),

            const SizedBox(height: 8),

            // Conversations
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockData.users.length,
                itemBuilder: (context, index) {
                  final user = MockData.users[index];
                  final isUnread = index < 2;

                  return GlassContainer(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        borderColor: isUnread
                            ? AppColors.primaryBlue.withOpacity(0.3)
                            : null,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                AvatarWidget(
                                  imageUrl: user.avatarUrl,
                                  name: user.name,
                                  size: 54,
                                ),
                                if (user.isOnline)
                                  Positioned(
                                    right: 2,
                                    bottom: 2,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: AppColors.success,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        user.name,
                                        style: TextStyle(
                                          fontWeight: isUnread
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      if (user.isVerified) ...[
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.verified,
                                          size: 14,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getRandomMessage(index),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isUnread
                                          ? AppColors.textPrimary
                                          : AppColors.textMuted,
                                      fontSize: 13,
                                      fontWeight: isUnread
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _getRandomTime(index),
                                  style: TextStyle(
                                    color: isUnread
                                        ? AppColors.primaryBlue
                                        : AppColors.textMuted,
                                    fontSize: 11,
                                    fontWeight: isUnread
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (isUnread) ...[
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (200 + (index * 100)).ms, duration: 300.ms)
                      .slideY(begin: 0.1, end: 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRandomMessage(int index) {
    final messages = [
      'Hey! How are you doing? 😊',
      'That sounds great! Let me know when you\'re free',
      'Just sent you the photos from yesterday',
      'Thanks for the recommendation! 🙌',
      'See you tomorrow at the event!',
      'Haha that was so funny! 😂',
    ];
    return messages[index % messages.length];
  }

  String _getRandomTime(int index) {
    final times = ['2m', '15m', '1h', '3h', '1d', '2d'];
    return times[index % times.length];
  }
}
