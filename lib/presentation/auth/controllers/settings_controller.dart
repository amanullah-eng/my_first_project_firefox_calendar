import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firefox_calender/core/service/biometric_service.dart';


/// Settings Controller
/// Converted from React UserSettings.tsx
/// Manages user settings, profile, notifications, and theme preferences
class SettingsController extends GetxController {
  // Storage
  final storage = GetStorage();
  final BiometricService _biometricService = BiometricService();
  final ImagePicker _imagePicker = ImagePicker();

  // User data
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userPhone = ''.obs;
  final RxString userProfilePicture = ''.obs;
  final RxBool isAdmin = false.obs;

  // Active tab
  final RxString activeTab = 'profile'.obs;

  // Notification settings
  final RxMap<String, bool> notifications = <String, bool>{
    'meetingReminder': true,
    'scheduleUpdate': true,
    'lineManagerAction': false,
    'paymentUpdate': true,
  }.obs;

  // Theme settings
  final RxBool isDarkMode = false.obs;
  final RxBool biometricEnabled = false.obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isUploadingImage = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _loadSettings();
  }

  /// Load user data from storage
  void _loadUserData() {
    userName.value = storage.read('userName') ?? 'User';
    userEmail.value = storage.read('userEmail') ?? '';
    userPhone.value = storage.read('userPhone') ?? '';
    userProfilePicture.value = storage.read('userProfilePicture') ?? '';
    
    // Mock admin check - replace with actual logic
    isAdmin.value = userEmail.value == 'admin@gmail.com';
  }

  /// Load settings from storage
  void _loadSettings() {
    // Load notification settings
    final savedNotifications = storage.read('notificationSettings');
    if (savedNotifications != null) {
      notifications.value = Map<String, bool>.from(savedNotifications);
    }

    // Load theme setting
    isDarkMode.value = Get.isDarkMode;
    
    // Load biometric setting
    biometricEnabled.value = storage.read('biometricEnabled') ?? false;
  }

  /// Set active tab
  void setActiveTab(String tab) {
    activeTab.value = tab;
  }

  /// Toggle notification setting
  Future<void> toggleNotification(String key) async {
    notifications[key] = !(notifications[key] ?? false);
    await storage.write('notificationSettings', notifications);
    
    Get.snackbar(
      'Settings',
      'Notification preference updated',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      duration: const Duration(seconds: 2),
    );
  }

  /// Toggle theme
  void toggleTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    isDarkMode.value = Get.isDarkMode;
    
    Get.snackbar(
      'Theme',
      'Theme changed to ${Get.isDarkMode ? 'dark' : 'light'} mode',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
      colorText: Get.isDarkMode ? Colors.white : Colors.black,
      duration: const Duration(seconds: 2),
    );
  }

  /// Handle profile picture selection
  Future<void> selectProfilePicture() async {
    try {
      isUploadingImage.value = true;

      // Show source selection dialog
      final source = await _showImageSourceDialog();
      if (source == null) {
        isUploadingImage.value = false;
        return;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        // For now, just store the local path
        // In production, you would upload to server and get URL
        userProfilePicture.value = image.path;
        await storage.write('userProfilePicture', image.path);

        Get.snackbar(
          'Success',
          'Profile picture updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error selecting profile picture: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile picture',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isUploadingImage.value = false;
    }
  }

  /// Show image source selection dialog
  Future<ImageSource?> _showImageSourceDialog() async {
    return await Get.dialog<ImageSource>(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Handle biometric enrollment
  Future<void> enrollBiometric() async {
    try {
      isLoading.value = true;

      if (kIsWeb) {
        Get.snackbar(
          'Not Supported',
          'Biometric authentication is not supported on Web',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade100,
          colorText: Colors.orange.shade900,
          duration: const Duration(seconds: 2),
        );
        return;
      }

      // Check if biometric is available
      final isAvailable = await _biometricService.isBiometricAvailable();
      if (!isAvailable) {
        Get.snackbar(
          'Not Available',
          'Biometric authentication not available on this device',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade100,
          colorText: Colors.orange.shade900,
          duration: const Duration(seconds: 2),
        );
        return;
      }

      // Authenticate to enable biometric
      final authenticated = await _biometricService.authenticateToEnable();

      if (authenticated) {
        biometricEnabled.value = true;
        await storage.write('biometricEnabled', true);
        await storage.write('biometricSetupDate', DateTime.now().toIso8601String());

        Get.snackbar(
          'Success',
          'Biometric login enrolled successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Failed',
          'Biometric enrollment failed or was cancelled',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error enrolling biometric: $e');
      Get.snackbar(
        'Error',
        'Failed to enroll biometric authentication',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle logout
  Future<void> handleLogout() async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Clear user session
      await storage.remove('isLoggedIn');
      await storage.remove('userEmail');
      await storage.remove('userName');
      await storage.remove('sessionExpiry');
      // Keep notification and biometric preferences

      Get.snackbar(
        'Logout',
        'You have been logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade100,
        colorText: Colors.blue.shade900,
        duration: const Duration(seconds: 2),
      );

      // Navigate to login
      Get.offAllNamed('/login');
    }
  }

  /// Get user initials for avatar
  String getUserInitials() {
    if (userName.value.isEmpty) return 'U';

    final parts = userName.value.trim().split(' ');
    if (parts.isEmpty) return 'U';

    return parts
        .where((part) => part.isNotEmpty)
        .map((part) => part[0])
        .join('')
        .toUpperCase();
  }

  /// Get notification setting display text
  String getNotificationDisplayText(String key) {
    switch (key) {
      case 'meetingReminder':
        return 'Meeting Reminder';
      case 'scheduleUpdate':
        return 'Schedule Update';
      case 'lineManagerAction':
        return 'Line Manager Action';
      case 'paymentUpdate':
        return 'Payment Update';
      default:
        return key;
    }
  }

  /// Get notification setting description
  String getNotificationDescription(String key) {
    switch (key) {
      case 'meetingReminder':
        return 'Get notified before meetings start';
      case 'scheduleUpdate':
        return 'Receive updates when schedules change';
      case 'lineManagerAction':
        return 'Notifications from your line manager';
      case 'paymentUpdate':
        return 'Updates about payment status';
      default:
        return '';
    }
  }
}