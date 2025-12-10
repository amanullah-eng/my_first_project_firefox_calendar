import 'dart:io';
import 'package:firefox_calender/presentation/auth/views/wiggets/leave_application_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firefox_calender/app/theme/app_colors.dart';
import 'package:firefox_calender/app/theme/app_text_styles.dart';
import 'package:firefox_calender/app/theme/app_theme.dart';
import 'package:firefox_calender/presentation/auth/controllers/settings_controller.dart';
import 'package:firefox_calender/presentation/auth/views/sections/top_bar.dart';
import 'package:firefox_calender/presentation/auth/views/sections/bottom_nav.dart';


/// Settings Screen
/// Converted from React UserSettings.tsx
/// Shows user profile settings, notifications, theme, security options
class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            const TopBar(title: 'TireEx Settings'),

            // Tab Navigation
            _buildTabNavigation(isDark),

            // Content
            Expanded(
              child: Obx(() {
                return controller.activeTab.value == 'profile'
                    ? _buildProfileContent(context, isDark)
                    : _buildLeaveContent(context, isDark);
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  /// Build tab navigation
  Widget _buildTabNavigation(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => _buildTabButton(
              'Profile & Settings',
              'profile',
              SvgPicture.asset('assets/images/Icon (7).svg'),
              isDark,
            )),
          ),
          const SizedBox(width: 8),
          // Expanded(
          //   child: Obx(() => _buildTabButton(
          //     'Leave Application',
          //     'leave',
          //     Icons.umbrella,
          //     isDark,
          //   )),
          // ),
          Expanded(
          child: Obx(() => _buildTabButton(
            'Leave Application',
            'leave',
            SvgPicture.asset('assets/images/Icon (6).svg'),
            isDark,
          )),
        ),
        ],
      ),
    );
  }

  /// Build individual tab button
  Widget _buildTabButton(String label, String value, Widget icon, bool isDark) {
  final isActive = controller.activeTab.value == value;

  return InkWell(
    onTap: () => controller.setActiveTab(value),
    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            : (isDark ? AppColors.cardDark : AppColors.cardLight),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isActive
              ? AppColors.primary
              : (isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: icon, // ✅ SVG works perfectly now
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isActive
                    ? AppColors.primaryForegroundLight
                    : (isDark
                          ? AppColors.foregroundDark
                          : AppColors.foregroundLight),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}


  /// Build profile content
  Widget _buildProfileContent(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Picture Card
          _buildProfilePictureCard(isDark),

          const SizedBox(height: 16),

          // User Info Card
          _buildUserInfoCard(isDark),

          const SizedBox(height: 16),

          // Notification Settings Card
          _buildNotificationSettingsCard(isDark),

          const SizedBox(height: 16),

          // Appearance Card
          _buildAppearanceCard(isDark),

          const SizedBox(height: 16),

          // Security Card
          _buildSecurityCard(isDark),

          const SizedBox(height: 16),

          // Logout Button
          _buildLogoutButton(isDark),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Build profile picture card
  Widget _buildProfilePictureCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Profile Picture',
            style: AppTextStyles.h4.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 24),

          // Avatar
          Obx(() => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  backgroundImage: controller.userProfilePicture.value.isNotEmpty
                      ? (kIsWeb || !File(controller.userProfilePicture.value).existsSync()
                          ? NetworkImage(controller.userProfilePicture.value) as ImageProvider
                          : FileImage(File(controller.userProfilePicture.value)))
                      : null,
                  child: controller.userProfilePicture.value.isEmpty
                      ? Text(
                          controller.getUserInitials(),
                          style: AppTextStyles.h2.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : null,
                ),
              ),
              if (controller.isUploadingImage.value)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                ),
            ],
          )),

          const SizedBox(height: 16),

          // Change Picture Button
          Obx(() => ElevatedButton.icon(
            onPressed: controller.isUploadingImage.value
                ? null
                : controller.selectProfilePicture,
            icon: const Icon(Icons.camera_alt, size: 18),
            label: const Text('Change Profile Picture'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
              foregroundColor: isDark ? AppColors.foregroundDark : AppColors.foregroundLight,
              side: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          )),
        ],
      ),
    );
  }

  /// Build user info card
  Widget _buildUserInfoCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: AppTextStyles.h4.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Email
          Obx(() => _buildInfoItem(
            'Email',
            controller.userEmail.value,
            Icons.email,
            isDark,
          )),

          const SizedBox(height: 12),

          // Name
          Obx(() => _buildInfoItem(
            'Name',
            controller.userName.value,
            Icons.person,
            isDark,
          )),

          const SizedBox(height: 12),

          // Role (if admin)
          Obx(() => controller.isAdmin.value
              ? _buildInfoItem(
                  'Role',
                  'Administrator',
                  Icons.admin_panel_settings,
                  isDark,
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  /// Build info item
  Widget _buildInfoItem(String label, String value, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark
              ? AppColors.mutedForegroundDark
              : AppColors.mutedForegroundLight,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark
                      ? AppColors.mutedForegroundDark
                      : AppColors.mutedForegroundLight,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'Not set',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build notification settings card
  Widget _buildNotificationSettingsCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Notifications',
                style: AppTextStyles.h4.copyWith(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Notification switches
          Obx(() => Column(
            children: controller.notifications.keys.map((key) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildNotificationSwitch(
                  key,
                  controller.getNotificationDisplayText(key),
                  controller.getNotificationDescription(key),
                  controller.notifications[key] ?? false,
                  isDark,
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  /// Build notification switch
  Widget _buildNotificationSwitch(
    String key,
    String title,
    String description,
    bool value,
    bool isDark,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (description.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.mutedForegroundDark
                        : AppColors.mutedForegroundLight,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 16),
        Switch(
          value: value,
          onChanged: (newValue) => controller.toggleNotification(key),
          activeThumbColor: AppColors.primary,
        ),
      ],
    );
  }

  /// Build appearance card
  Widget _buildAppearanceCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Appearance',
                style: AppTextStyles.h4.copyWith(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Dark Mode Switch
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dark Mode',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isDark
                            ? AppColors.foregroundDark
                            : AppColors.foregroundLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Switch between light and dark themes',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark
                            ? AppColors.mutedForegroundDark
                            : AppColors.mutedForegroundLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Obx(() => Switch(
                value: controller.isDarkMode.value,
                onChanged: (value) => controller.toggleTheme(),
                activeThumbColor: AppColors.primary,
              )),
            ],
          ),
        ],
      ),
    );
  }

  /// Build security card
  Widget _buildSecurityCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.fingerprint,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Security',
                style: AppTextStyles.h4.copyWith(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Biometric Enrollment Button
          Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.enrollBiometric,
              icon: controller.isLoading.value
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryForegroundLight,
                        ),
                      ),
                    )
                  : const Icon(Icons.fingerprint, size: 18),
              label: Text(
                controller.biometricEnabled.value
                    ? 'Re-enroll Biometric Login'
                    : 'Enroll Biometric Login',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                foregroundColor: isDark ? AppColors.foregroundDark : AppColors.foregroundLight,
                side: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          )),

          // Biometric Status
          Obx(() => controller.biometricEnabled.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Biometric login is enabled',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.green.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  /// Build logout button
  Widget _buildLogoutButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.handleLogout,
        icon: const Icon(Icons.logout, size: 18),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }



  /// Build leave application content
  Widget _buildLeaveContent(BuildContext context, bool isDark) {
    return const LeaveApplicationWidget();
  }
}