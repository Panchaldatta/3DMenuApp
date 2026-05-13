// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/qr_scan/presentation/pages/qr_scan_page.dart';
import 'features/menu/presentation/pages/menu_page.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MenuVerseApp()));
}

class MenuVerseApp extends ConsumerWidget {
  const MenuVerseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (c, s) => const SplashPage()),
        GoRoute(path: '/scan', builder: (c, s) => const QRScanPage()),
        GoRoute(path: '/menu', builder: (c, s) => const MenuPage()),
      ],
    );
    return MaterialApp.router(
      title: 'MenuVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
