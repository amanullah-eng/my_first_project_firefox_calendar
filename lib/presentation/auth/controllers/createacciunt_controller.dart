import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateAccountController extends GetxController {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxString emailError = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool showOTPPopup = false.obs;
  final RxBool showSuccessScreen = false.obs;

  // Password validation states
  final RxBool hasMinLength = false.obs;
  final RxBool hasUppercase = false.obs;
  final RxBool hasLowercase = false.obs;
  final RxBool hasNumber = false.obs;
  final RxBool hasSpecialChar = false.obs;

  // Storage
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Clear any previous errors
    emailError.value = '';

    // Listen to password changes for validation
    passwordController.addListener(_validatePassword);

    // Listen to confirm password changes to update UI
    // confirmPasswordController.addListener(() {
    //   update(); // Trigger GetBuilder rebuild
    // });
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.onClose();
  // }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Validate password requirements
  void _validatePassword() {
    final password = passwordController.text;

    // Check minimum length (8 characters)
    hasMinLength.value = password.length >= 8;

    // Check for uppercase letter
    hasUppercase.value = password.contains(RegExp(r'[A-Z]'));

    // Check for lowercase letter
    hasLowercase.value = password.contains(RegExp(r'[a-z]'));

    // Check for number
    hasNumber.value = password.contains(RegExp(r'[0-9]'));

    // Check for special character
    hasSpecialChar.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Trigger update for button state
    update();
  }

  /// Check if password is valid
  bool get isPasswordValid =>
      hasMinLength.value &&
      hasUppercase.value &&
      hasLowercase.value &&
      hasNumber.value &&
      hasSpecialChar.value;

  /// Validate email format and domain
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

  /// Handle email change
  void onEmailChanged(String value) {
    if (value.isNotEmpty) {
      validateEmail(value);
    } else {
      emailError.value = '';
    }
    update(); // Trigger GetBuilder rebuild for button
  }

  /// Check if passwords match
  bool get passwordsMatch =>
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty &&
      passwordController.text == confirmPasswordController.text;

  /// Check if form is valid
  bool get canCreateAccount =>
      emailController.text.isNotEmpty &&
      emailError.value.isEmpty &&
      isPasswordValid &&
      passwordsMatch;

  /// Handle create account
  Future<void> handleCreateAccount() async {
    // Validate email
    if (!validateEmail(emailController.text)) {
      return;
    }

    // Validate password
    if (!isPasswordValid) {
      Get.snackbar(
        'Error',
        'Password does not meet all requirements',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    // Check if passwords match
    if (!passwordsMatch) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    isLoading.value = true;
    update(); // Update button state

    // Simulate API call for account creation
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock account creation
    // TODO: Replace with actual API call
    if (_mockCreateAccount(emailController.text, passwordController.text)) {
      isLoading.value = false;
      update();

      // Show OTP popup
      showOTPPopup.value = true;
    } else {
      isLoading.value = false;
      update();

      Get.snackbar(
        'Error',
        'Failed to create account',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }

  /// Handle OTP verification
  Future<void> handleOTPVerify(String otp) async {
    // Mock OTP verification
    if (otp.length == 6) {
      // Close OTP popup
      showOTPPopup.value = false;

      // Show success screen
      showSuccessScreen.value = true;

      // Auto-navigate to login after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        Get.offAllNamed('/login');
      });
    } else {
      Get.snackbar(
        'Error',
        'Invalid OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }

  /// Close OTP popup
  void closeOTPPopup() {
    showOTPPopup.value = false;
  }

  /// Mock account creation
  /// TODO: Replace with actual API call
  bool _mockCreateAccount(String email, String password) {
    // Simple mock validation
    // In production, this should call an API endpoint
    return email.endsWith('@gmail.com') && password.length >= 8;
  }

  /// Navigate back to login
  void navigateToLogin() {
    Get.back();
  }
}
