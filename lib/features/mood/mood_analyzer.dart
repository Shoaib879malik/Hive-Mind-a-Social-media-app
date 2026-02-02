import 'mood_theme.dart';

/// AI Mood Analyzer - Analyzes text to detect emotional tone
class MoodAnalyzer {
  /// Analyzes text and returns the detected mood with confidence score
  static MoodResult analyze(String text) {
    if (text.trim().isEmpty) {
      return const MoodResult(mood: 'Neutral', confidence: 0.0);
    }

    final lowerText = text.toLowerCase();
    Map<String, int> moodScores = {};

    // Check each mood's keywords
    for (final entry in MoodTheme.moods.entries) {
      final moodName = entry.key;
      final moodData = entry.value;
      int score = 0;

      for (final keyword in moodData.keywords) {
        if (lowerText.contains(keyword.toLowerCase())) {
          // Give more weight to exact word matches
          if (RegExp(
            r'\b' + RegExp.escape(keyword.toLowerCase()) + r'\b',
          ).hasMatch(lowerText)) {
            score += 3;
          } else {
            score += 1;
          }
        }
      }

      // Check for emoji matches
      for (final keyword in moodData.keywords) {
        if (keyword.length <= 2 && text.contains(keyword)) {
          score += 2; // Emojis get extra weight
        }
      }

      moodScores[moodName] = score;
    }

    // Find the mood with highest score
    String detectedMood = 'Neutral';
    int maxScore = 0;
    int totalScore = 0;

    moodScores.forEach((mood, score) {
      totalScore += score;
      if (score > maxScore) {
        maxScore = score;
        detectedMood = mood;
      }
    });

    // Calculate confidence (0.0 to 1.0)
    double confidence = 0.0;
    if (totalScore > 0) {
      confidence = (maxScore / totalScore).clamp(0.0, 1.0);
      // Boost confidence if we found clear matches
      if (maxScore >= 3) {
        confidence = (confidence + 0.2).clamp(0.0, 1.0);
      }
    }

    // Apply additional heuristics
    detectedMood = _applyHeuristics(text, detectedMood, confidence);

    return MoodResult(
      mood: maxScore > 0 ? detectedMood : 'Neutral',
      confidence: maxScore > 0 ? confidence : 0.5,
    );
  }

  /// Apply additional heuristics for edge cases
  static String _applyHeuristics(
    String text,
    String currentMood,
    double confidence,
  ) {
    // Check for exclamation marks (indicates excitement or strong emotion)
    final exclamationCount = '!'.allMatches(text).length;
    if (exclamationCount >= 3 && currentMood == 'Neutral') {
      return 'Excited';
    }

    // Check for question marks (might indicate uncertainty)
    // Keep the current mood but note the pattern

    // Check for ALL CAPS (indicates strong emotion)
    final capsRatio =
        text.replaceAll(RegExp(r'[^A-Z]'), '').length /
        text.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    if (capsRatio > 0.5 && text.length > 10) {
      // Strong emotion, could be excited or angry
      if (currentMood == 'Neutral') {
        return 'Excited';
      }
    }

    return currentMood;
  }

  /// Get mood-based content suggestions
  static List<String> getSuggestions(String mood) {
    switch (mood) {
      case 'Happy':
        return [
          'Share your happiness with a photo! 📸',
          'Your positive energy is contagious! ✨',
          'Spread the joy - tag a friend who makes you smile!',
        ];
      case 'Sad':
        return [
          'Remember, it\'s okay to feel this way 💙',
          'Reach out to someone you trust',
          'Here are some uplifting posts from your friends...',
        ];
      case 'Excited':
        return [
          'Create a story to share this moment! 🎉',
          'Your enthusiasm is inspiring!',
          'Go live and share your excitement!',
        ];
      case 'Calm':
        return [
          'Perfect time for a mindful moment 🧘',
          'Share your peaceful vibes with others',
          'Check out these relaxing stories...',
        ];
      case 'Angry':
        return [
          'Take a deep breath before posting 🌬️',
          'Would you like to save this as a draft?',
          'Here are some calming content suggestions...',
        ];
      default:
        return [
          'What\'s on your mind today? 💭',
          'Add a photo to make your post stand out!',
          'Share your thoughts with the world',
        ];
    }
  }
}

/// Result of mood analysis
class MoodResult {
  final String mood;
  final double confidence;

  const MoodResult({required this.mood, required this.confidence});

  String get confidenceLabel {
    if (confidence >= 0.8) return 'Very confident';
    if (confidence >= 0.6) return 'Confident';
    if (confidence >= 0.4) return 'Somewhat confident';
    return 'Low confidence';
  }

  bool get isReliable => confidence >= 0.4;
}
