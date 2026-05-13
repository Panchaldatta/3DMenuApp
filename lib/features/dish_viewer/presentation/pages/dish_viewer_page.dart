import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:menuverse/core/theme/colors.dart';
import 'package:menuverse/features/menu/domain/models/dish.dart';
import 'package:menuverse/features/cart/providers/cart_provider.dart';

class DishViewerPage extends ConsumerStatefulWidget {
  final Dish dish;

  const DishViewerPage({Key? key, required this.dish}) : super(key: key);

  @override
  ConsumerState<DishViewerPage> createState() => _DishViewerPageState();
}

class _DishViewerPageState extends ConsumerState<DishViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Dynamic Lighting / Background Glow
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.neonBlue.withOpacity(0.1),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 5.seconds),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
                
                // Real 3D Visualizer
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'dish_${widget.dish.id}',
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: ModelViewer(
                          src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // Should be widget.dish.modelUrl in real app
                          alt: widget.dish.name,
                          ar: true,
                          autoRotate: true,
                          cameraControls: true,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Details Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.dish.name,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 28),
                          ),
                          Text(
                            '\$${widget.dish.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.neonCyan,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.dish.rating} (120+ reviews)',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const Spacer(),
                          const Icon(Icons.timer_outlined, color: AppColors.neonBlue, size: 20),
                          const SizedBox(width: 4),
                          const Text('15-20 min', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.dish.description,
                        style: const TextStyle(color: Colors.white60, fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 32),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(cartProvider.notifier).addToCart(widget.dish);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${widget.dish.name} added to cart!'),
                                      backgroundColor: AppColors.neonBlue,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.neonBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: const Text('Add to Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
