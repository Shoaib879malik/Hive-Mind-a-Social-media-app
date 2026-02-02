import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/avatar_widget.dart';

/// Explore/Search screen
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: GlassTextField(
                controller: _searchController,
                hintText: 'Search people, hashtags...',
                prefixIcon: Icons.search,
                onChanged: (value) {
                  setState(() => _isSearching = value.isNotEmpty);
                },
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2, end: 0),

            // Content
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildDiscoverContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoverContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.trending_up, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                const Text(
                  'Trending Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

          const SizedBox(height: 12),

          // Trending hashtags
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: MockData.trendingHashtags.length,
              itemBuilder: (context, index) {
                final tag = MockData.trendingHashtags[index];
                return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: index == 0
                              ? AppColors.primaryGradient
                              : null,
                          color: index == 0 ? null : AppColors.glassWhite,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: index == 0
                                ? Colors.transparent
                                : AppColors.glassBorder,
                          ),
                        ),
                        child: Text(
                          tag['tag'],
                          style: TextStyle(
                            color: index == 0
                                ? AppColors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: (150 + (index * 50)).ms, duration: 300.ms)
                    .slideX(begin: 0.2, end: 0);
              },
            ),
          ),

          const SizedBox(height: 24),

          // Suggested users
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Suggested for You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

          const SizedBox(height: 12),

          ...MockData.users.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;

            return GlassContainer(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      AvatarWidget(
                        imageUrl: user.avatarUrl,
                        name: user.name,
                        size: 50,
                        showOnlineStatus: true,
                        isOnline: user.isOnline,
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
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
                            Text(
                              user.username,
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '${user.followersCount} followers',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: (300 + (index * 100)).ms, duration: 300.ms)
                .slideY(begin: 0.1, end: 0);
          }),

          const SizedBox(height: 24),

          // Discover grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Discover',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return GlassContainer(
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: Icon(
                          Icons.image_rounded,
                          size: 48,
                          color: AppColors.textMuted.withOpacity(0.5),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: (600 + (index * 100)).ms, duration: 300.ms)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                    );
              },
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text(
            'Search for "${_searchController.text}"',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
