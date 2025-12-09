// import 'package:firefox_calender/core/service/biometric_service.dart';
// import 'package:firefox_calender/presentation/auth/views/sections/biometric_prompt.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // <-- IMPORTANT
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class LoginController extends GetxController {
//   final emailController = TextEditingController(text: "user@gmail.com");
//   final passwordController = TextEditingController(text: "Password123!");

//   final RxBool isPasswordVisible = false.obs;
//   final RxString emailError = ''.obs;
//   final RxString loginError = ''.obs;
//   final RxBool isLoading = false.obs;

//   final storage = GetStorage();
//   final BiometricService _biometricService = BiometricService();

//   @override
//   void onInit() {
//     super.onInit();
//     emailError.value = '';
//     loginError.value = '';
//     print('✅ LoginController initialized');
//   }

//   // =========================================================
//   // EMAIL / PASSWORD VALIDATION
//   // =========================================================

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   bool validateEmail(String email) {
//     if (email.isEmpty) {
//       emailError.value = '';
//       return false;
//     }

//     if (!email.endsWith('@gmail.com')) {
//       emailError.value = 'Email must be @gmail.com';
//       return false;
//     }

//     emailError.value = '';
//     return true;
//   }

//   void onEmailChanged(String value) {
//     if (value.isNotEmpty) {
//       validateEmail(value);
//     } else {
//       emailError.value = '';
//     }
//     loginError.value = '';
//   }

//   // =========================================================
//   // MAIN LOGIN HANDLER  (FIXED)
//   // =========================================================

//   Future<void> handleLogin() async {
//     print('🔵 handleLogin called');
//     loginError.value = '';
//     emailError.value = '';

//     final email = emailController.text.trim();
//     final password = passwordController.text;

//     if (email.isEmpty) {
//       emailError.value = 'Email is required';
//       return;
//     }

//     if (!validateEmail(email)) return;

//     if (password.isEmpty) {
//       loginError.value = 'Password is required';
//       return;
//     }

//     isLoading.value = true;

//     try {
//       await Future.delayed(const Duration(milliseconds: 500));

//       final loginSuccess = _mockLogin(email, password);
//       if (!loginSuccess) {
//         isLoading.value = false;
//         loginError.value = 'Invalid email or password';
//         return;
//       }

//       print('✅ Login successful');

//       // Save session
//       await storage.write('isLoggedIn', true);
//       await storage.write('userEmail', email);
//       await storage.write('userName', 'Test User');

//       isLoading.value = false;

//       // Check biometric enabled
//       final biometricEnabled = storage.read('biometricEnabled') ?? false;

//       if (!biometricEnabled) {
//         bool isAvailable = false;

//         // 🚨 FIX: Prevent biometric calls on WEB
//         if (!kIsWeb) {
//           isAvailable = await _biometricService.isBiometricAvailable();
//         } else {
//           print("❌ Biometrics not supported on Web");
//         }

//         if (isAvailable) {
//           _showBiometricPromptDialog();
//         } else {
//           _navigateToDashboard();
//         }
//       } else {
//         _navigateToDashboard();
//       }
//     } catch (e) {
//       print('💥 Login error: $e');
//       isLoading.value = false;
//       loginError.value = 'An error occurred. Please try again.';
//     }
//   }

//   // =========================================================
//   // DASHBOARD NAVIGATION
//   // =========================================================

//   void _navigateToDashboard() {
//     print('🚀 Navigating to dashboard');
//     Get.offAllNamed('/dashboard');
//   }

//   // =========================================================
//   // BIOMETRIC ENABLE FLOW  (FIXED FOR WEB)
//   // =========================================================

//   void _showBiometricPromptDialog() {
//     Get.dialog(
//       BiometricPrompt(
//         isOpen: true,
//         onEnable: _enableBiometric,
//         onDismiss: _dismissBiometricPrompt,
//       ),
//       barrierDismissible: false,
//     );
//   }

//   Future<void> _enableBiometric() async {
//     try {
//       Get.back(); // close prompt

//       if (kIsWeb) {
//         print("❌ Cannot enable biometric on Web");
//         _navigateToDashboard();
//         return;
//       }

//       final authenticated = await _biometricService.authenticateToEnable();

//       if (authenticated) {
//         await storage.write('biometricEnabled', true);

//         Get.snackbar(
//           'Success',
//           'Biometric login enabled successfully',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//           colorText: Colors.green.shade900,
//         );
//       }

//       _navigateToDashboard();
//     } catch (e) {
//       print("💥 Error enabling biometric: $e");
//       _navigateToDashboard();
//     }
//   }

//   void _dismissBiometricPrompt() {
//     Get.back();
//     _navigateToDashboard();
//   }

//   // =========================================================
//   // BIOMETRIC LOGIN (FIXED)
//   // =========================================================

//   Future<void> handleBiometricLogin() async {
//     loginError.value = '';
//     isLoading.value = true;

//     final biometricEnabled = storage.read('biometricEnabled') ?? false;

//     if (!biometricEnabled) {
//       isLoading.value = false;
//       loginError.value = 'Biometric login not enabled';
//       return;
//     }

//     if (kIsWeb) {
//       isLoading.value = false;
//       loginError.value = 'Biometric authentication is not supported on Web';
//       return;
//     }

//     final isAvailable = await _biometricService.isBiometricAvailable();
//     if (!isAvailable) {
//       isLoading.value = false;
//       loginError.value = 'Biometric authentication not available';
//       return;
//     }

//     final authenticated = await _biometricService.authenticateForLogin();
//     if (!authenticated) {
//       isLoading.value = false;
//       loginError.value = 'Biometric authentication failed';
//       return;
//     }

//     emailController.text = storage.read('userEmail') ?? '';
//     await storage.write('isLoggedIn', true);

//     isLoading.value = false;
//     _navigateToDashboard();
//   }

//   // =========================================================
//   // MOCK LOGIN
//   // =========================================================

//   bool _mockLogin(String email, String password) {
//     return email == 'user@gmail.com' && password == 'Password123!';
//   }

//   // =========================================================
//   // NAVIGATION
//   // =========================================================

//   void navigateToCreateAccount() => Get.toNamed('/register');
//   void navigateToForgotPassword() => Get.toNamed('/forgot-password');
//   void navigateToContact() => Get.snackbar('Contact', 'Coming soon');
//   void openSocial() => Get.snackbar('Social', 'Opening social media...');
//   void openWebsite() => Get.snackbar('Website', 'Opening website...');
// }


import 'package:firefox_calender/core/service/biometric_service.dart';
import 'package:firefox_calender/presentation/auth/views/sections/biometric_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; 
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Enhanced Login Controller
/// Improved session management, biometric integration, and login persistence
class LoginController extends GetxController {
  // Form controllers
  final emailController = TextEditingController(text: "user@gmail.com");
  final passwordController = TextEditingController(text: "Password123!");

  // Observable variables
  final RxBool isPasswordVisible = false.obs;
  final RxString emailError = ''.obs;
  final RxString loginError = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isBiometricLoading = false.obs;

  // Storage and services
  final storage = GetStorage();
  final BiometricService _biometricService = BiometricService();

  @override
  void onInit() {
    super.onInit();
    emailError.value = '';
    loginError.value = '';
    _initializeController();
    print('✅ Enhanced LoginController initialized');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Initialize controller with session checking
  void _initializeController() {
    // Check if user has valid session
    _checkExistingSession();
    
    // Load saved email if available
    final savedEmail = storage.read('lastLoginEmail') ?? '';
    if (savedEmail.isNotEmpty && emailController.text.isEmpty) {
      emailController.text = savedEmail;
    }
  }

  /// Check for existing valid session
  void _checkExistingSession() {
    final isLoggedIn = storage.read('isLoggedIn') ?? false;
    final userEmail = storage.read('userEmail') ?? '';
    final sessionExpiry = storage.read('sessionExpiry');
    
    if (isLoggedIn && userEmail.isNotEmpty) {
      // Check session expiry
      if (sessionExpiry != null) {
        final expiryDate = DateTime.parse(sessionExpiry);
        if (DateTime.now().isAfter(expiryDate)) {
          print('🕐 Session expired, clearing storage');
          _clearSession();
          return;
        }
      }
      
      print('✅ Valid session found, redirecting to dashboard');
      // Auto-redirect to dashboard if valid session exists
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/dashboard');
      });
    }
  }

  // =========================================================
  // EMAIL / PASSWORD VALIDATION
  // =========================================================

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError.value = '';
      return false;
    }

    if (!email.endsWith('@gmail.com')) {
      emailError.value = 'Email must be @gmail.com';
      return false;
    }

    emailError.value = '';
    return true;
  }

  void onEmailChanged(String value) {
    if (value.isNotEmpty) {
      validateEmail(value);
    } else {
      emailError.value = '';
    }
    loginError.value = '';
  }

  // =========================================================
  // ENHANCED LOGIN HANDLER
  // =========================================================

  Future<void> handleLogin() async {
    print('🔵 handleLogin called');
    loginError.value = '';
    emailError.value = '';

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return;
    }

    if (!validateEmail(email)) return;

    if (password.isEmpty) {
      loginError.value = 'Password is required';
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final loginSuccess = await _performLogin(email, password);
      if (!loginSuccess) {
        isLoading.value = false;
        loginError.value = 'Invalid email or password';
        return;
      }

      print('✅ Login successful for $email');

      // Save session with enhanced data
      await _saveSession(email);

      // Save last login email for convenience
      await storage.write('lastLoginEmail', email);

      isLoading.value = false;

      // Check and handle biometric setup
      await _handleBiometricSetup();

    } catch (e) {
      print('💥 Login error: $e');
      isLoading.value = false;
      loginError.value = 'An error occurred. Please try again.';
    }
  }

  /// Enhanced login logic with better validation
  Future<bool> _performLogin(String email, String password) async {
    // TODO: Replace with actual API call
    // For now, use mock validation
    return _mockLogin(email, password);
  }

  /// Save session with enhanced data
  Future<void> _saveSession(String email) async {
    final sessionExpiry = DateTime.now().add(const Duration(days: 30));
    
    await storage.write('isLoggedIn', true);
    await storage.write('userEmail', email);
    await storage.write('userName', 'Test User'); // TODO: Get from API
    await storage.write('sessionExpiry', sessionExpiry.toIso8601String());
    await storage.write('loginTimestamp', DateTime.now().toIso8601String());
    
    print('💾 Session saved until: $sessionExpiry');
  }

  /// Clear session data
  Future<void> _clearSession() async {
    await storage.remove('isLoggedIn');
    await storage.remove('userEmail');
    await storage.remove('userName');
    await storage.remove('sessionExpiry');
    await storage.remove('loginTimestamp');
    // Keep biometric and lastLoginEmail preferences
    
    print('🗑️ Session cleared');
  }

  /// Navigate to dashboard
  void _navigateToDashboard() {
    print('🚀 Navigating to dashboard');
    Get.offAllNamed('/dashboard');
  }

  // =========================================================
  // ENHANCED BIOMETRIC SETUP AND LOGIN
  // =========================================================

  /// Handle biometric setup flow
  Future<void> _handleBiometricSetup() async {
    final biometricEnabled = storage.read('biometricEnabled') ?? false;

    if (!biometricEnabled) {
      bool isAvailable = false;

      // Check biometric availability (not on web)
      if (!kIsWeb) {
        try {
          isAvailable = await _biometricService.isBiometricAvailable();
          print('🔍 Biometric available: $isAvailable');
        } catch (e) {
          print('⚠️ Error checking biometric availability: $e');
          isAvailable = false;
        }
      } else {
        print("⌨️ Biometrics not supported on Web");
      }

      if (isAvailable) {
        _showBiometricPromptDialog();
      } else {
        _navigateToDashboard();
      }
    } else {
      _navigateToDashboard();
    }
  }

  /// Show biometric setup prompt
  void _showBiometricPromptDialog() {
    Get.dialog(
      BiometricPrompt(
        isOpen: true,
        onEnable: _enableBiometric,
        onDismiss: _dismissBiometricPrompt,
      ),
      barrierDismissible: false,
    );
  }

  /// Enable biometric authentication
  Future<void> _enableBiometric() async {
    try {
      Get.back(); // Close prompt

      if (kIsWeb) {
        print("⌨️ Cannot enable biometric on Web");
        _navigateToDashboard();
        return;
      }

      final authenticated = await _biometricService.authenticateToEnable();

      if (authenticated) {
        await storage.write('biometricEnabled', true);
        await storage.write('biometricSetupDate', DateTime.now().toIso8601String());

        Get.snackbar(
          'Success',
          'Biometric login enabled successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Setup Failed',
          'Biometric authentication setup was cancelled or failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade100,
          colorText: Colors.orange.shade900,
          duration: const Duration(seconds: 2),
        );
      }

      _navigateToDashboard();
    } catch (e) {
      print("💥 Error enabling biometric: $e");
      Get.snackbar(
        'Error',
        'Failed to enable biometric authentication',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 2),
      );
      _navigateToDashboard();
    }
  }

  /// Dismiss biometric prompt
  void _dismissBiometricPrompt() {
    Get.back();
    _navigateToDashboard();
  }

  // =========================================================
  // ENHANCED BIOMETRIC LOGIN
  // =========================================================

  // Future<void> handleBiometricLogin() async {
  //   print('🔵 handleBiometricLogin called');
  //   loginError.value = '';
  //   isBiometricLoading.value = true;

  //   try {
  //     final biometricEnabled = storage.read('biometricEnabled') ?? false;

  //     if (!biometricEnabled) {
  //       isBiometricLoading.value = false;
  //       loginError.value = 'Biometric login not enabled. Please enable it first.';
  //       return;
  //     }

  //     if (kIsWeb) {
  //       isBiometricLoading.value = false;
  //       loginError.value = 'Biometric authentication is not supported on Web';
  //       return;
  //     }

  //     final isAvailable = await _biometricService.isBiometricAvailable();
  //     if (!isAvailable) {
  //       isBiometricLoading.value = false;
  //       loginError.value = 'Biometric authentication not available on this device';
  //       return;
  //     }

  //     final authenticated = await _biometricService.authenticateForLogin();
  //     if (!authenticated) {
  //       isBiometricLoading.value = false;
  //       loginError.value = 'Biometric authentication failed or was cancelled';
  //       return;
  //     }

  //     // Successful biometric authentication
  //     final savedEmail = storage.read('userEmail') ?? '';
  //     if (savedEmail.isNotEmpty) {
  //       emailController.text = savedEmail;
        
  //       // Save session
  //       await _saveSession(savedEmail);
        
  //       // Update last activity
  //       await storage.write('lastBiometricLogin', DateTime.now().toIso8601String());
        
  //       isBiometricLoading.value = false;
        
  //       Get.snackbar(
  //         'Success',
  //         'Biometric login successful',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green.shade100,
  //         colorText: Colors.green.shade900,
  //         duration: const Duration(seconds: 1),
  //       );
        
  //       _navigateToDashboard();
  //     } else {
  //       isBiometricLoading.value = false;
  //       loginError.value = 'No saved user data found. Please login with email/password first.';
  //     }
  //   } catch (e) {
  //     print('💥 Biometric login error: $e');
  //     isBiometricLoading.value = false;
  //     loginError.value = 'Biometric authentication error. Please try again.';
  //   }
  // }

Future<void> handleBiometricLogin() async {
  print('🔵 handleBiometricLogin called');
  loginError.value = '';
  isBiometricLoading.value = true;

  try {
    // ❌ Web is not supported
    if (kIsWeb) {
      isBiometricLoading.value = false;
      loginError.value = 'Biometric authentication is not supported on Web';
      return;
    }

    // ✅ Check if device supports biometrics
    final isAvailable = await _biometricService.isBiometricAvailable();
    if (!isAvailable) {
      isBiometricLoading.value = false;
      loginError.value =
          'Biometric authentication not available on this device';
      return;
    }

    // ✅ Show biometric popup (Fingerprint / Face ID)
    final authenticated =
        await _biometricService.authenticateForLogin();

    if (!authenticated) {
      isBiometricLoading.value = false;
      loginError.value =
          'Biometric authentication failed or was cancelled';
      return;
    }

    // ✅ FORCE enable biometric after first success
    await storage.write('biometricEnabled', true);
    await storage.write(
        'lastBiometricLogin', DateTime.now().toIso8601String());

    // ✅ Auto-create / restore session
    final savedEmail = storage.read('userEmail') ?? 'user@gmail.com';
    await _saveSession(savedEmail);

    isBiometricLoading.value = false;

    Get.snackbar(
      'Success',
      'Biometric login successful',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      duration: const Duration(seconds: 1),
    );

    // ✅ ✅ ✅ FINAL DASHBOARD NAVIGATION
    _navigateToDashboard();

  } catch (e) {
    print('💥 Biometric login error: $e');
    isBiometricLoading.value = false;
    loginError.value =
        'Biometric authentication error. Please try again.';
  }
}






  // =========================================================
  // UTILITY METHODS
  // =========================================================

  /// Mock login logic (replace with actual API)
  bool _mockLogin(String email, String password) {
    return email == 'user@gmail.com' && password == 'Password123!';
  }

  /// Get session info for debugging
  Map<String, dynamic> getSessionInfo() {
    return {
      'isLoggedIn': storage.read('isLoggedIn') ?? false,
      'userEmail': storage.read('userEmail') ?? '',
      'userName': storage.read('userName') ?? '',
      'biometricEnabled': storage.read('biometricEnabled') ?? false,
      'sessionExpiry': storage.read('sessionExpiry'),
      'lastLoginEmail': storage.read('lastLoginEmail') ?? '',
    };
  }

  /// Logout with session cleanup
  Future<void> logout() async {
    await _clearSession();
    Get.offAllNamed('/login');
  }

  // =========================================================
  // NAVIGATION METHODS
  // =========================================================

  void navigateToCreateAccount() => Get.toNamed('/register');
  void navigateToForgotPassword() => Get.toNamed('/forgot-password');
  void navigateToContact() => Get.snackbar('Contact', 'Coming soon');
  void openSocial() => Get.snackbar('Social', 'Opening social media...');
  void openWebsite() => Get.snackbar('Website', 'Opening website...');
}