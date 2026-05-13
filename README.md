# MenuVerse – Futuristic AI-Powered Dining

MenuVerse is a world-class Flutter application designed to revolutionize the restaurant dining experience. It features an immersive UI, 3D dish interactions, and real-time order tracking.

## 🚀 Features

- **Cinematic Splash Screen**: Animated logo reveal with premium glow effects.
- **QR Scan Flow**: Instant table identification with futuristic scanning visuals.
- **Immersive Menu**: Category-based filtering, glassmorphism cards, and "Chef's Choice" badges.
- **3D Dish Viewer**: Interactive rotation and lighting effects for a cinematic food experience.
- **Animated Cart**: Slide-up modal with quantity controls and live subtotals.
- **Quick Table Actions**: One-tap requests for Waiter, Water, or Bill.
- **Real-time Tracking**: Vertical stepper UI showing live order status.
- **Digital Payment**: Multi-method checkout flow with success animations.
- **Admin Dashboard**: SaaS-level dashboard with revenue charts and popular dish analytics.
- **Loyalty System**: Tier-based points visualization and progress tracking.

## 🛠️ Tech Stack

- **Flutter & Dart**: Cross-platform development.
- **Riverpod**: Robust state management.
- **GoRouter**: Modern declarative routing.
- **Flutter Animate**: High-performance cinematic animations.
- **Fl Chart**: Premium data visualizations.
- **Supabase**: Real-time backend and data synchronization.

## 📂 Architecture

The project follows **Clean Architecture** with a feature-first structure:
- `lib/core`: Global theme, widgets, and utilities.
- `lib/features`: Individual feature modules (menu, cart, admin, etc.) with their own domain/presentation layers.
- `lib/infrastructure`: Backend service implementations (Supabase).

## 🏃 How to Run

1. **Clone the repository**.
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

*Note: For 3D models and real backend data, configure your Supabase instance and update the constants in `lib/infrastructure/supabase/supabase_service.dart`.*
