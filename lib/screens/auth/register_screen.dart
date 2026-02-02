import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_button.dart';

/// Registration screen with multi-step form
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _handleRegister();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _handleRegister() {
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pushReplacementNamed('/main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _currentStep > 0
                          ? _prevStep()
                          : Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Step ${_currentStep + 1} of 3',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child:
                          Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: index <= _currentStep
                                      ? AppColors.primaryBlue
                                      : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              )
                              .animate(target: index <= _currentStep ? 1 : 0)
                              .scaleX(
                                begin: 0,
                                end: 1,
                                alignment: Alignment.centerLeft,
                                duration: 300.ms,
                              ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 32),

              // Form content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _buildStep(),
                    ),
                  ),
                ),
              ),

              // Bottom button
              Padding(
                padding: const EdgeInsets.all(24),
                child: GlassButton(
                  text: _currentStep == 2 ? 'Create Account' : 'Continue',
                  onPressed: _nextStep,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1().animate().fadeIn(duration: 300.ms);
      case 1:
        return _buildStep2().animate().fadeIn(duration: 300.ms);
      case 2:
        return _buildStep3().animate().fadeIn(duration: 300.ms);
      default:
        return const SizedBox();
    }
  }

  Widget _buildStep1() {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your name?",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "This will be displayed on your profile",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),

        DarkGlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              DarkGlassTextField(
                controller: _nameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              DarkGlassTextField(
                controller: _usernameController,
                hintText: 'Username',
                prefixIcon: Icons.alternate_email,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your email address",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "We'll send you a verification link",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),

        DarkGlassContainer(
          padding: const EdgeInsets.all(24),
          child: DarkGlassTextField(
            controller: _emailController,
            hintText: 'Email Address',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create a password",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Make it strong and memorable",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),

        DarkGlassContainer(
          padding: const EdgeInsets.all(24),
          child: DarkGlassTextField(
            controller: _passwordController,
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
          ),
        ),

        const SizedBox(height: 24),

        // Password requirements
        ...[
          _RequirementItem(
            text: 'At least 8 characters',
            isMet: _passwordController.text.length >= 8,
          ),
          _RequirementItem(
            text: 'Contains a number',
            isMet: _passwordController.text.contains(RegExp(r'[0-9]')),
          ),
          _RequirementItem(
            text: 'Contains a special character',
            isMet: _passwordController.text.contains(
              RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
            ),
          ),
        ],
      ],
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _RequirementItem({required this.text, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 18,
            color: isMet ? AppColors.success : AppColors.white.withOpacity(0.4),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isMet
                  ? AppColors.success
                  : AppColors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
