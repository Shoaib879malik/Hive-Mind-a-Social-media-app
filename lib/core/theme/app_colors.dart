import 'package:flutter/material.dart';

/// App color palette - Blue/White Glassmorphism theme
class AppColors {
  // Primary Blues
  static const Color primaryBlue = Color(0xFF1E88E5);
  static const Color primaryBlueDark = Color(0xFF1565C0);
  static const Color primaryBlueLight = Color(0xFF42A5F5);
  static const Color accentBlue = Color(0xFF00B4D8);

  // Whites & Backgrounds
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8FAFC);
  static const Color backgroundLight = Color(0xFFF0F4F8);
  static const Color backgroundDark = Color(0xFF0A1929);

  // Glass Effect Colors
  static const Color glassWhite = Color(0x40FFFFFF);
  static const Color glassBorder = Color(0x60FFFFFF);
  static const Color glassShadow = Color(0x20000000);
  static const Color glassOverlay = Color(0x15FFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF94A3B8);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Mood Colors
  static const Color moodHappy = Color(0xFFFFD93D);
  static const Color moodSad = Color(0xFF6B7FD7);
  static const Color moodExcited = Color(0xFFFF6B6B);
  static const Color moodCalm = Color(0xFF6BCB77);
  static const Color moodAngry = Color(0xFFEE5A24);
  static const Color moodNeutral = Color(0xFF95A5A6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, accentBlue],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A1929), Color(0xFF1A365D), Color(0xFF1E3A5F)],
  );

  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x30FFFFFF), Color(0x10FFFFFF)],
  );

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E88E5), Color(0xFF00B4D8), Color(0xFF48CAE4)],
  );

  static const LinearGradient voiceStoryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9B59B6), Color(0xFF3498DB)],
  );
}
