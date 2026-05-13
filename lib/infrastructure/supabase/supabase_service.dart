import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupabaseService {
  // Replace these with your actual Supabase URL and Anon Key
  static const String _url = 'https://your-project-id.supabase.co';
  static const String _anonKey = 'your-anon-key';

  static Future<void> initialize() async {
    // In a real app, you would uncomment this:
    /*
    await Supabase.initialize(
      url: _url,
      anonKey: _anonKey,
    );
    */
  }

  SupabaseClient get client => Supabase.instance.client;

  // Real-time Order Updates Example
  Stream<List<Map<String, dynamic>>> subscribeToOrders(String restaurantId) {
    return client
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('restaurant_id', restaurantId);
  }
}

final supabaseServiceProvider = Provider((ref) => SupabaseService());
final supabaseClientProvider = Provider((ref) => ref.watch(supabaseServiceProvider).client);
