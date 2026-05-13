import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:menuverse/core/theme/colors.dart';
import 'package:menuverse/features/cart/providers/cart_provider.dart';
import 'package:menuverse/features/cart/presentation/widgets/cart_item_row.dart';
import 'package:menuverse/features/payment/presentation/pages/checkout_page.dart';

class CartSheet extends ConsumerWidget {
  const CartSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).totalAmount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Order',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white60),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Cart Items List
          if (cartItems.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 60, color: AppColors.onSurface.withOpacity(0.2)),
                    const SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(color: AppColors.onSurface.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemRow(item: cartItems[index])
                    .animate(delay: (index * 50).ms)
                    .fadeIn()
                    .slideY(begin: 0.1);
                },
              ),
            ),
          
          const Divider(color: AppColors.divider, height: 40),
          
          // Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.neonCyan,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: cartItems.isEmpty ? null : () {
                Navigator.pop(context); // Close sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                shadowColor: AppColors.neonBlue.withOpacity(0.5),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .shimmer(duration: 3.seconds, color: Colors.white24),
          
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

void showCart(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const CartSheet(),
  );
}
