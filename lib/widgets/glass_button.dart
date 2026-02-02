import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';

/// Primary gradient button with glass effect
class GlassButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isLoading;
  final IconData? icon;
  final bool isPrimary;

  const GlassButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 44,
    this.isLoading = false,
    this.icon,
    this.isPrimary = true,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            if (!widget.isLoading && widget.onPressed != null) {
              widget.onPressed!();
            }
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.width ?? double.infinity,
            height: widget.height,
            transform: Matrix4.identity()..scale(_isPressed ? 0.97 : 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: widget.isPrimary
                        ? AppColors.primaryGradient
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.isPrimary
                          ? Colors.white.withOpacity(0.3)
                          : AppColors.glassBorder,
                      width: 1.5,
                    ),
                    boxShadow: widget.isPrimary
                        ? [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: widget.isLoading
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: widget.isPrimary
                                  ? AppColors.white
                                  : AppColors.primaryBlue,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.icon != null) ...[
                                Icon(
                                  widget.icon,
                                  color: widget.isPrimary
                                      ? AppColors.white
                                      : AppColors.primaryBlue,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                widget.text,
                                style: TextStyle(
                                  color: widget.isPrimary
                                      ? AppColors.white
                                      : AppColors.primaryBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        )
        .animate(target: _isPressed ? 1 : 0)
        .shimmer(duration: 600.ms, color: Colors.white.withOpacity(0.3));
  }
}

/// Icon button with glass effect
class GlassIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? iconColor;
  final String? tooltip;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 36,
    this.iconColor,
    this.tooltip,
  });

  @override
  State<GlassIconButton> createState() => _GlassIconButtonState();
}

class _GlassIconButtonState extends State<GlassIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onPressed?.call();
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: Tooltip(
            message: widget.tooltip ?? '',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: widget.size,
              height: widget.size,
              transform: Matrix4.identity()..scale(_isPressed ? 0.9 : 1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.size / 2),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor ?? AppColors.textPrimary,
                        size: widget.size * 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .animate(target: _isPressed ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(0.9, 0.9));
  }
}

/// Floating action button with glass and gradient effect
class GlassFloatingButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final String? heroTag;

  const GlassFloatingButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.heroTag,
  });

  @override
  State<GlassFloatingButton> createState() => _GlassFloatingButtonState();
}

class _GlassFloatingButtonState extends State<GlassFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onPressed?.call();
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.primaryBlue,
                      AppColors.accentBlue,
                      AppColors.primaryBlueLight,
                      AppColors.primaryBlue,
                    ],
                    transform: GradientRotation(_controller.value * 6.28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: AppColors.white,
                    size: widget.size * 0.5,
                  ),
                ),
              );
            },
          ),
        )
        .animate(target: _isPressed ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(0.9, 0.9));
  }
}
