import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToScanner();
  }

  void _navigateToScanner() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/scan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glow
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonBlue.withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2.seconds),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.neonBlue, width: 2),
                  ),
                  child: const Icon(Icons.auto_awesome, color: AppColors.neonBlue, size: 64),
                ).animate()
                 .scale(duration: 800.ms, curve: Curves.elasticOut)
                 .shimmer(delay: 1.seconds, duration: 2.seconds),
                
                const SizedBox(height: 24),
                
                Text(
                  'MenuVerse',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                
                const SizedBox(height: 8),
                
                Text(
                  'THE FUTURE OF DINING',
                  style: TextStyle(
                    color: AppColors.neonBlue.withOpacity(0.7),
                    letterSpacing: 2,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 600.ms),
              ],
            ),
          ),
          
          // Loading Bar at Bottom
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.neonBlue),
                  ),
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 12),
                const Text(
                  'INITIALIZING AI ENGINE...',
                  style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 1),
                ).animate().fadeIn(delay: 1.seconds),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
