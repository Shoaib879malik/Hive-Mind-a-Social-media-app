import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Mood data class containing display information
class MoodData {
  final String name;
  final String emoji;
  final Color color;
  final IconData icon;
  final List<String> keywords;

  const MoodData({
    required this.name,
    required this.emoji,
    required this.color,
    required this.icon,
    required this.keywords,
  });
}

/// Theme and display information for different moods
class MoodTheme {
  static const Map<String, MoodData> moods = {
    'Happy': MoodData(
      name: 'Happy',
      emoji: '😊',
      color: AppColors.moodHappy,
      icon: Icons.sentiment_very_satisfied,
      keywords: [
        'happy',
        'joy',
        'excited',
        'amazing',
        'wonderful',
        'great',
        'love',
        'awesome',
        'fantastic',
        'blessed',
        'grateful',
        'delighted',
        'thrilled',
        'cheerful',
        'elated',
        'overjoyed',
        'ecstatic',
        'blissful',
        'content',
        'glad',
        'pleased',
        'satisfied',
        'yay',
        '❤️',
        '😊',
        '😄',
        '🎉',
      ],
    ),
    'Sad': MoodData(
      name: 'Sad',
      emoji: '😢',
      color: AppColors.moodSad,
      icon: Icons.sentiment_dissatisfied,
      keywords: [
        'sad',
        'depressed',
        'down',
        'unhappy',
        'miserable',
        'heartbroken',
        'crying',
        'tears',
        'lonely',
        'upset',
        'disappointed',
        'hurt',
        'grief',
        'sorrow',
        'melancholy',
        'gloomy',
        'blue',
        'devastated',
        'broken',
        'miss',
        'lost',
        'alone',
        '😢',
        '😭',
        '💔',
      ],
    ),
    'Excited': MoodData(
      name: 'Excited',
      emoji: '🤩',
      color: AppColors.moodExcited,
      icon: Icons.celebration,
      keywords: [
        'excited',
        'can\'t wait',
        'pumped',
        'hyped',
        'stoked',
        'thrilled',
        'eager',
        'anticipating',
        'fired up',
        'energized',
        'enthusiastic',
        'wow',
        'omg',
        'incredible',
        'insane',
        'crazy',
        'wild',
        'epic',
        'lit',
        'party',
        'celebrate',
        '🎉',
        '🤩',
        '🔥',
        '🚀',
      ],
    ),
    'Calm': MoodData(
      name: 'Calm',
      emoji: '😌',
      color: AppColors.moodCalm,
      icon: Icons.self_improvement,
      keywords: [
        'calm',
        'peaceful',
        'relaxed',
        'serene',
        'tranquil',
        'zen',
        'meditation',
        'mindful',
        'quiet',
        'still',
        'gentle',
        'soothing',
        'rest',
        'breathe',
        'nature',
        'harmony',
        'balance',
        'ease',
        'chill',
        'cozy',
        'comfortable',
        '😌',
        '🧘',
        '☮️',
        '🌿',
      ],
    ),
    'Angry': MoodData(
      name: 'Angry',
      emoji: '😤',
      color: AppColors.moodAngry,
      icon: Icons.sentiment_very_dissatisfied,
      keywords: [
        'angry',
        'mad',
        'furious',
        'annoyed',
        'frustrated',
        'irritated',
        'rage',
        'hate',
        'pissed',
        'livid',
        'outraged',
        'fuming',
        'disgusted',
        'fed up',
        'sick of',
        'enraged',
        'infuriated',
        'ugh',
        'argh',
        '😤',
        '😡',
        '🤬',
        '💢',
      ],
    ),
    'Neutral': MoodData(
      name: 'Neutral',
      emoji: '😐',
      color: AppColors.moodNeutral,
      icon: Icons.sentiment_neutral,
      keywords: [],
    ),
  };

  static MoodData getMoodData(String mood) {
    return moods[mood] ?? moods['Neutral']!;
  }

  static List<String> get allMoods => moods.keys.toList();

  static Color getMoodColor(String mood) {
    return getMoodData(mood).color;
  }

  static String getMoodEmoji(String mood) {
    return getMoodData(mood).emoji;
  }

  static IconData getMoodIcon(String mood) {
    return getMoodData(mood).icon;
  }
}
