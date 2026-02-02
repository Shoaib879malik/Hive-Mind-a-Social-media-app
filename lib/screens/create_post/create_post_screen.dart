import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/avatar_widget.dart';
import '../../data/mock_data.dart';
import '../../features/mood/mood_analyzer.dart';
import '../../features/mood/mood_theme.dart';

/// Create post screen with mood detection
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _contentController = TextEditingController();
  MoodResult? _detectedMood;
  String? _selectedImage;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _contentController.addListener(_analyzeMood);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _analyzeMood() {
    final result = MoodAnalyzer.analyze(_contentController.text);
    if (result.mood != _detectedMood?.mood) {
      setState(() {
        _detectedMood = result;
      });
    }
  }

  void _handlePost() {
    if (_contentController.text.trim().isEmpty) return;

    setState(() => _isPosting = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // Background
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 28,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Create Post',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const Spacer(),
                      GlassButton(
                        text: 'Post',
                        width: 80,
                        height: 40,
                        onPressed: _handlePost,
                        isLoading: _isPosting,
                      ),
                    ],
                  ),
                ),

                // Content area
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User info
                          Row(
                            children: [
                              AvatarWidget(
                                imageUrl: MockData.currentUser.avatarUrl,
                                name: MockData.currentUser.name,
                                size: 48,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MockData.currentUser.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.public,
                                        size: 14,
                                        color: AppColors.textMuted,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Public',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Text input
                          TextField(
                            controller: _contentController,
                            maxLines: 6,
                            style: const TextStyle(fontSize: 18, height: 1.5),
                            decoration: InputDecoration(
                              hintText: "What's on your mind?",
                              hintStyle: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 18,
                              ),
                              border: InputBorder.none,
                            ),
                          ),

                          // Mood detection card
                          if (_detectedMood != null &&
                              _detectedMood!.mood != 'Neutral' &&
                              _contentController.text.length > 5)
                            _MoodDetectionCard(mood: _detectedMood!)
                                .animate()
                                .fadeIn(duration: 300.ms)
                                .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 24),

                          // Action buttons
                          GlassContainer(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _ActionItem(
                                  icon: Icons.image_rounded,
                                  color: AppColors.success,
                                  label: 'Photo/Video',
                                  onTap: () {},
                                ),
                                const Divider(height: 24),
                                _ActionItem(
                                  icon: Icons.tag_rounded,
                                  color: AppColors.warning,
                                  label: 'Tag People',
                                  onTap: () {},
                                ),
                                const Divider(height: 24),
                                _ActionItem(
                                  icon: Icons.location_on_rounded,
                                  color: AppColors.error,
                                  label: 'Add Location',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

class _MoodDetectionCard extends StatelessWidget {
  final MoodResult mood;

  const _MoodDetectionCard({required this.mood});

  @override
  Widget build(BuildContext context) {
    final moodData = MoodTheme.getMoodData(mood.mood);
    final suggestions = MoodAnalyzer.getSuggestions(mood.mood);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            moodData.color.withOpacity(0.15),
            moodData.color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: moodData.color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(moodData.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Detected Mood: ',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        mood.mood,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: moodData.color,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    mood.confidenceLabel,
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.auto_awesome, color: moodData.color, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            suggestions.first,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
