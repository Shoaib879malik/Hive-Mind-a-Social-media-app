import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:social_media_fyp/screens/messages/messages_screen.dart';
import 'package:social_media_fyp/screens/notifications/notifications_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/post_card.dart';
import '../../widgets/glass_button.dart';

/// Home screen with stories and feed
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  Future<void> _onRefresh() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isRefreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),

          // Main content
          RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.primaryBlue,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // App bar
                SliverToBoxAdapter(
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Logo
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [AppColors.white, AppColors.accentBlue],
                            ).createShader(bounds),
                            child: const Text(
                              'Hive Mind',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Actions
                          GlassIconButton(
                            icon: Icons.notifications_outlined,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationsScreen(),
                                ),
                              );
                            },
                            iconColor: AppColors.white,
                            size: 34,
                          ),
                          const SizedBox(width: 8),
                          GlassIconButton(
                            icon: Icons.chat_bubble_outline,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MessagesScreen(),
                                ),
                              );
                            },
                            iconColor: AppColors.white,
                            size: 34,
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                ),

                // Stories
                SliverToBoxAdapter(
                  child: Container(
                    height: 90,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: MockData.stories.length,
                      itemBuilder: (context, index) {
                        final story = MockData.stories[index];
                        final isFirst = index == 0;

                        return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      StoryAvatar(
                                        imageUrl: story.userAvatar,
                                        name: story.userName,
                                        size: 60,
                                        hasUnseenStory: !story.isViewed,
                                        onTap: () {
                                          // Open story viewer
                                        },
                                      ),
                                      if (isFirst)
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              gradient:
                                                  AppColors.primaryGradient,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AppColors.white,
                                                width: 2,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 10,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 60,
                                    child: Text(
                                      isFirst ? 'Your Story' : story.userName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(delay: (100 * index).ms, duration: 300.ms)
                            .slideX(
                              begin: 0.2,
                              end: 0,
                              delay: (100 * index).ms,
                            );
                      },
                    ),
                  ),
                ),

                // Feed
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),

                        // Create post prompt
                        GlassContainer(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  AvatarWidget(
                                    imageUrl: MockData.currentUser.avatarUrl,
                                    name: MockData.currentUser.name,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(
                                          context,
                                        ).pushNamed('/create-post');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.glassOverlay,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          "What's on your mind?",
                                          style: TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    height: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: const Icon(
                                        Icons.image_rounded,
                                        color: AppColors.primaryBlue,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 300.ms, duration: 400.ms)
                            .slideY(begin: 0.2, end: 0),

                        const SizedBox(height: 8),

                        // Posts
                        ...MockData.posts.asMap().entries.map((entry) {
                          final index = entry.key;
                          final post = entry.value;

                          return PostCard(
                                post: post,
                                onLike: () {},
                                onComment: () {},
                                onShare: () {},
                                onProfileTap: () {},
                                onMoodTap: () {},
                              )
                              .animate()
                              .fadeIn(
                                delay: (400 + (index * 100)).ms,
                                duration: 400.ms,
                              )
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                delay: (400 + (index * 100)).ms,
                              );
                        }),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
