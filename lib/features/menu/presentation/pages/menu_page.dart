import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:menuverse/core/theme/colors.dart';
import 'package:menuverse/features/menu/domain/models/dish.dart';
import 'package:menuverse/features/menu/presentation/widgets/dish_card.dart';
import 'package:menuverse/features/menu/presentation/widgets/category_switcher.dart';
import 'package:menuverse/features/menu/presentation/widgets/quick_actions.dart';
import 'package:menuverse/features/cart/providers/cart_provider.dart';
import 'package:menuverse/features/cart/presentation/widgets/cart_sheet.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');

final menuProvider = FutureProvider<List<Dish>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);
  
  await Future.delayed(const Duration(milliseconds: 800));
  
  final allDishes = [
    const Dish(
      id: '1',
      name: 'Cyber Ramen',
      description: 'Futuristic ramen with bioluminescent noodles and neon broth.',
      price: 18.50,
      imageUrl: 'https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&q=80&w=500',
      modelUrl: '',
      calories: 450,
      spiceLevel: 3,
      isVeg: false,
      rating: 4.8,
      isChefRecommendation: true,
    ),
    const Dish(
      id: '2',
      name: 'Quantum Burger',
      description: 'A burger that exists in multiple states of deliciousness simultaneously.',
      price: 22.00,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&q=80&w=500',
      modelUrl: '',
      calories: 850,
      spiceLevel: 1,
      isVeg: false,
      rating: 4.5,
    ),
    const Dish(
      id: '3',
      name: 'Neon Sushi Roll',
      description: 'Glow-in-the-dark sushi made with ethically sourced electric eels.',
      price: 16.00,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&q=80&w=500',
      modelUrl: '',
      calories: 320,
      spiceLevel: 2,
      isVeg: true,
      rating: 4.9,
      isChefRecommendation: true,
    ),
    const Dish(
      id: '4',
      name: 'Plasma Pasta',
      description: 'Tagliatelle tossed in a high-energy plasma sauce.',
      price: 20.00,
      imageUrl: 'https://images.unsplash.com/photo-1473093226795-af9932fe5856?auto=format&fit=crop&q=80&w=500',
      modelUrl: '',
      calories: 520,
      spiceLevel: 0,
      isVeg: true,
      rating: 4.2,
    ),
    const Dish(
      id: '5',
      name: 'Nebula Salad',
      description: 'A stellar mix of cosmic greens and star-dust dressing.',
      price: 14.00,
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&q=80&w=500',
      modelUrl: '',
      calories: 210,
      spiceLevel: 0,
      isVeg: true,
      rating: 4.7,
    ),
  ];

  if (category == 'all') return allDishes;
  if (category == 'veg') return allDishes.where((d) => d.isVeg).toList();
  if (category == 'non-veg') return allDishes.where((d) => !d.isVeg).toList();
  
  return allDishes;
});

class MenuPage extends ConsumerWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDishes = ref.watch(menuProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final cartItems = ref.watch(cartProvider);

    final categories = [
      Category(id: 'all', name: 'All Dishes', icon: Icons.restaurant_menu),
      Category(id: 'veg', name: 'Vegetarian', icon: Icons.eco),
      Category(id: 'non-veg', name: 'Non-Veg', icon: Icons.kebab_dining),
      Category(id: 'drinks', name: 'Drinks', icon: Icons.local_bar),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MenuVerse',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Table 07 • Futuristic Dining',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.neonBlue,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            onPressed: () => showCart(context),
                            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 28),
                          ),
                          if (cartItems.isNotEmpty)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.neonPurple,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${cartItems.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ).animate().scale().shake(),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Category Switcher
                CategorySwitcher(
                  categories: categories,
                  selectedCategoryId: selectedCategory,
                  onCategorySelected: (id) {
                    ref.read(selectedCategoryProvider.notifier).state = id;
                  },
                ).animate().fadeIn(delay: 200.ms).slideX(),

                const SizedBox(height: 16),

                // Menu Grid
                Expanded(
                  child: asyncDishes.when(
                    data: (dishes) => GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: dishes.length,
                      itemBuilder: (context, index) {
                        return DishCard(dish: dishes[index])
                          .animate(delay: (index * 100).ms)
                          .fadeIn()
                          .scale();
                      },
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.neonBlue),
                    ),
                    error: (err, stack) => Center(
                      child: Text('Error: $err', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Quick Actions
          const Positioned(
            bottom: 30,
            right: 20,
            child: QuickActions(),
          ).animate().fadeIn(delay: 1.seconds).slideY(begin: 0.2),
        ],
      ),
    );
  }
}
