import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/qr_scan/presentation/pages/qr_scan_page.dart';
import 'features/menu/presentation/pages/menu_page.dart';
import 'features/admin/presentation/pages/admin_dashboard_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/order_tracking/presentation/pages/order_tracking_page.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MenuVerseApp()));
}

class MenuVerseApp extends ConsumerWidget {
  const MenuVerseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashPage()),
        GoRoute(path: '/scan', builder: (context, state) => const QRScanPage()),
        GoRoute(path: '/menu', builder: (context, state) => const MenuPage()),
        GoRoute(path: '/admin', builder: (context, state) => const AdminDashboardPage()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
        GoRoute(path: '/tracking', builder: (context, state) => const OrderTrackingPage()),
      ],
    );

    return MaterialApp.router(
      title: 'MenuVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
