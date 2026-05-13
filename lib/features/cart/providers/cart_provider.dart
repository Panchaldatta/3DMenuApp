import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menuverse/features/menu/domain/models/dish.dart';

class CartItem {
  final Dish dish;
  final int quantity;

  CartItem({required this.dish, required this.quantity});

  CartItem copyWith({Dish? dish, int? quantity}) {
    return CartItem(
      dish: dish ?? this.dish,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Dish dish) {
    final existingIndex = state.indexWhere((item) => item.dish.id == dish.id);
    if (existingIndex != -1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(dish: dish, quantity: 1)];
    }
  }

  void removeFromCart(String dishId) {
    final existingIndex = state.indexWhere((item) => item.dish.id == dishId);
    if (existingIndex != -1) {
      if (state[existingIndex].quantity > 1) {
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == existingIndex)
              state[i].copyWith(quantity: state[i].quantity - 1)
            else
              state[i]
        ];
      } else {
        state = state.where((item) => item.dish.id != dishId).toList();
      }
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalAmount {
    return state.fold(0, (total, item) => total + (item.dish.price * item.quantity));
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
