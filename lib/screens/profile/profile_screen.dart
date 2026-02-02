import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/avatar_widget.dart';

/// User profile screen
class ProfileScreen extends StatefulWidget {
  final bool isCurrentUser;

  const ProfileScreen({super.key, this.isCurrentUser = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 200 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            height: 550,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),

          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Profile header
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // Top bar
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            if (!widget.isCurrentUser)
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.white,
                                ),
                              ),
                            const Spacer(),
                            Text(
                              user.username,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.more_horiz,
                                color: AppColors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),

                      // Profile info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            // Avatar
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryBlue.withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: AvatarWidget(
                                  imageUrl: user.avatarUrl,
                                  name: user.name,
                                  size: 100,
                                ),
                              ),
                            ).animate().scale(
                              duration: 400.ms,
                              curve: Curves.elasticOut,
                            ),

                            const SizedBox(height: 16),

                            // Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                if (user.isVerified) ...[
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.verified,
                                    color: AppColors.accentBlue,
                                    size: 22,
                                  ),
                                ],
                              ],
                            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

                            const SizedBox(height: 4),

                            // Bio
                            if (user.bio != null)
                              Text(
                                user.bio!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.white.withOpacity(0.8),
                                ),
                              ).animate().fadeIn(
                                delay: 300.ms,
                                duration: 300.ms,
                              ),

                            const SizedBox(height: 24),

                            // Stats
                            DarkGlassContainer(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _StatItem(
                                        count: user.postsCount.toString(),
                                        label: 'Posts',
                                      ),
                                      Container(
                                        height: 40,
                                        width: 1,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      _StatItem(
                                        count: _formatCount(
                                          user.followersCount,
                                        ),
                                        label: 'Followers',
                                      ),
                                      Container(
                                        height: 40,
                                        width: 1,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      _StatItem(
                                        count: user.followingCount.toString(),
                                        label: 'Following',
                                      ),
                                    ],
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 400.ms, duration: 300.ms)
                                .slideY(begin: 0.2, end: 0),

                            const SizedBox(height: 20),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: widget.isCurrentUser
                                      ? GlassButton(
                                          text: 'Edit Profile',
                                          isPrimary: false,
                                          height: 46,
                                          onPressed: () {},
                                        )
                                      : GlassButton(
                                          text: 'Follow',
                                          height: 46,
                                          onPressed: () {},
                                        ),
                                ),
                                const SizedBox(width: 12),
                                GlassIconButton(
                                  icon: Icons.share_outlined,
                                  size: 46,
                                  iconColor: AppColors.white,
                                  onPressed: () {},
                                ),
                              ],
                            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content section
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 24),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Tabs
                      TabBar(
                        controller: _tabController,
                        indicatorColor: AppColors.primaryBlue,
                        indicatorWeight: 3,
                        labelColor: AppColors.primaryBlue,
                        unselectedLabelColor: AppColors.textMuted,
                        tabs: const [
                          Tab(icon: Icon(Icons.grid_view_rounded)),
                          Tab(icon: Icon(Icons.bookmark_outline)),
                          Tab(icon: Icon(Icons.mood_rounded)),
                        ],
                      ),

                      // Tab content
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          controller: _tabController,
                          children: [_PostsGrid(), _SavedGrid(), _MoodStats()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class _PostsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          color: AppColors.glassOverlay,
          child: Center(child: Icon(Icons.image, color: AppColors.textMuted)),
        );
      },
    );
  }
}

class _SavedGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 64, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text(
            'No saved posts yet',
            style: TextStyle(color: AppColors.textMuted, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _MoodStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Mood Journey',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // Mood stats
          Row(
            children: [
              _MoodStatCard(emoji: '😊', label: 'Happy', count: 45),
              const SizedBox(width: 12),
              _MoodStatCard(emoji: '🤩', label: 'Excited', count: 28),
              const SizedBox(width: 12),
              _MoodStatCard(emoji: '😌', label: 'Calm', count: 18),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            'Most of your posts express happiness! Keep spreading the positivity! ✨',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _MoodStatCard extends StatelessWidget {
  final String emoji;
  final String label;
  final int count;

  const _MoodStatCard({
    required this.emoji,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Text(
              '$count posts',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
