import 'package:firefox_calender/presentation/auth/views/calendar_screen.dart';
import 'package:firefox_calender/presentation/auth/views/create_account_screens.dart';
import 'package:firefox_calender/presentation/auth/views/create_event_screen.dart';
import 'package:firefox_calender/presentation/auth/views/forget_password_screen.dart';
import 'package:firefox_calender/presentation/auth/views/login_screen.dart';
import 'package:firefox_calender/presentation/home/dashbord_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

/// App page configurations with bindings and transitions
class AppPages {
  AppPages._();

  /// Initial route
  static const String initial = AppRoutes.login;

  /// All app pages with their bindings and transitions
  static final routes = <GetPage>[
    // // ========== AUTH PAGES ==========
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const CreateAccountScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ========== MAIN PAGES ==========
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Calendar Page - Now fully implemented
    GetPage(
      name: AppRoutes.calendar,
      page: () => const CalendarScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // Create Event Page
    GetPage(
      name: AppRoutes.createEvent,
      page: () => const CreateEventScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // Placeholder pages for navigation items
    GetPage(
      name: AppRoutes.hours,
      page: () => const PlaceholderScreen(title: 'Hours'),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.payroll,
      page: () => const PlaceholderScreen(title: 'Payroll'),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const PlaceholderScreen(title: 'Settings'),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];

  /// Default page transition
  static const Transition defaultTransition = Transition.rightToLeft;

  /// Default transition duration
  static const Duration defaultTransitionDuration = Duration(milliseconds: 300);
}

/// Placeholder screen for routes not yet implemented
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              '$title Screen',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon...',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
