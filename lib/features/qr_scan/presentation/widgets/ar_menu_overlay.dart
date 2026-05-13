import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:menuverse/core/theme/colors.dart';

class ARMenuOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  const ARMenuOverlay({Key? key, required this.onDismiss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Stack(
        children: [
          // 3D Model Floating in "AR" Space
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: const ModelViewer(
                src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // Placeholder GLB
                alt: "A 3D model of an astronaut",
                ar: true,
                autoRotate: true,
                cameraControls: true,
              ),
            ),
          ).animate().fadeIn(duration: 1.seconds).scale(begin: const Offset(0.5, 0.5)),
          
          // Spatial UI Elements
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  'OBJECT DETECTED',
                  style: TextStyle(
                    color: AppColors.neonBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 20)],
                  ),
                ).animate().shimmer(duration: 2.seconds),
                const SizedBox(height: 10),
                const Text(
                  'Initializing Spatial Menu...',
                  style: TextStyle(color: Colors.white70, letterSpacing: 2),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDismiss,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('OPEN FULL MENU', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ).animate().slideY(begin: 1, duration: 800.ms, curve: Curves.easeOutQuad),
        ],
      ),
    );
  }
}
