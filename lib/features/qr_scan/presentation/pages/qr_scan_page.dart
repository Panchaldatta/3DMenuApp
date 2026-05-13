import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:menuverse/core/theme/colors.dart';

class QRScanPage extends ConsumerStatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  ConsumerState<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends ConsumerState<QRScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Mock Camera View / Scanner UI
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Scanner Frame
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.neonBlue, width: 2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Stack(
                        children: [
                          // Scanner Line
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: AppColors.neonBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonBlue.withOpacity(0.8),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ).animate(onPlay: (c) => c.repeat())
                           .moveY(begin: 0, end: 250, duration: 2.seconds, curve: Curves.easeInOut),
                          
                          // Corner Accents
                          _buildCorner(top: 0, left: 0),
                          _buildCorner(top: 0, right: 0, rotate: 90),
                          _buildCorner(bottom: 0, left: 0, rotate: 270),
                          _buildCorner(bottom: 0, right: 0, rotate: 180),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Text(
                      'Position QR Code in the frame',
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
                    ).animate().fadeIn(),
                    
                    const SizedBox(height: 60),
                    
                    // Mock Success Button (for testing without real QR)
                    ElevatedButton(
                      onPressed: () => context.go('/menu'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.neonBlue.withOpacity(0.1),
                        foregroundColor: AppColors.neonBlue,
                        side: const BorderSide(color: AppColors.neonBlue),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('MOCK SCAN SUCCESS', style: TextStyle(fontWeight: FontWeight.bold)),
                    ).animate().fadeIn(delay: 1.seconds),
                  ],
                ),
              ),
            ),
          ),
          
          // Header
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'SCAN TABLE QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.neonPurple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'INSTANT DETECTION',
                    style: TextStyle(color: AppColors.neonPurple, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({double? top, double? bottom, double? left, double? right, double rotate = 0}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: rotate * 3.14159 / 180,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.neonBlue, width: 4),
              left: BorderSide(color: AppColors.neonBlue, width: 4),
            ),
          ),
        ),
      ),
    );
  }
}
