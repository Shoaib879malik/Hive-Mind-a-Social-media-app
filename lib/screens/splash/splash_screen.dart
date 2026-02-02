import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Animated splash screen with logo and gradient background
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.forward();

    // Navigate to login after splash animation
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // Animated background shapes
            ...List.generate(5, (index) {
              return Positioned(
                left: (index * 100.0) - 50,
                top: (index * 150.0) - 100,
                child:
                    Container(
                          width: 200 + (index * 50.0),
                          height: 200 + (index * 50.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primaryBlue.withOpacity(0.1),
                                AppColors.primaryBlue.withOpacity(0.0),
                              ],
                            ),
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.2, 1.2),
                          duration: Duration(seconds: 3 + index),
                          curve: Curves.easeInOut,
                        )
                        .then()
                        .scale(
                          begin: const Offset(1.2, 1.2),
                          end: const Offset(0.8, 0.8),
                          duration: Duration(seconds: 3 + index),
                          curve: Curves.easeInOut,
                        ),
              );
            }),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.5),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.hub_rounded,
                          size: 60,
                          color: AppColors.white,
                        ),
                      )
                      .animate()
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        duration: 600.ms,
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: 32),

                  // App name
                  ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.primaryBlue,
                            AppColors.accentBlue,
                            AppColors.primaryBlueLight,
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Hive Mind',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 400.ms,
                        duration: 600.ms,
                      ),

                  const SizedBox(height: 8),

                  // Tagline
                  Text(
                        'Connect. Share. Express.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white.withOpacity(0.7),
                          letterSpacing: 2,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 800.ms,
                        duration: 600.ms,
                      ),

                  const SizedBox(height: 80),

                  // Loading indicator
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.white.withOpacity(0.5),
                    ),
                  ).animate().fadeIn(delay: 1200.ms, duration: 400.ms),
                ],
              ),
            ),

            // Bottom branding
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Text(
                'Your World. Your Voice.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white.withOpacity(0.5),
                  letterSpacing: 1,
                ),
              ).animate().fadeIn(delay: 1500.ms, duration: 600.ms),
            ),
          ],
        ),
      ),
    );
  }
}
