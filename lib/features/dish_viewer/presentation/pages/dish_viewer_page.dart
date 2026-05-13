import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  double _rotation = 0.0;

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
                
                // 3D Visualizer Placeholder
                Expanded(
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _rotation += details.delta.dx * 0.01;
                      });
                    },
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Shadow/Reflection
                          Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(1.2)
                              ..translate(0.0, 100.0, 0.0),
                            alignment: FractionalOffset.center,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonBlue.withOpacity(0.2),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // Rotating Image Placeholder (3D Mimic)
                          Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_rotation),
                            alignment: FractionalOffset.center,
                            child: Hero(
                              tag: 'dish_${widget.dish.id}',
                              child: Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(widget.dish.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.neonCyan.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            style: Theme.of(context).textTheme.displaySmall,
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
