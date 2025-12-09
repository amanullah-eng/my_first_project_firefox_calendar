import 'package:firefox_calender/presentation/auth/controllers/createacciunt_controller.dart';
import 'package:firefox_calender/presentation/auth/views/otp_pop_up.dart';
import 'package:firefox_calender/presentation/auth/views/sections/password_rules_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';

class CreateAccountScreen extends GetView<CreateAccountController> {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            /// MAIN UI OR SUCCESS SCREEN
            Obx(
              () => controller.showSuccessScreen.value
                  ? _buildSuccessContent(context)
                  : _buildCreateAccountContent(context),
            ),

            /// OTP POPUP (OVERLAY)
            Obx(
              () => controller.showOTPPopup.value
                  ? Center(
                      child: OTPPopup(
                        email: controller.emailController.text,
                        onVerify: controller.handleOTPVerify,
                        onClose: controller.closeOTPPopup,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // MAIN CREATE ACCOUNT CONTENT (NO SCAFFOLD)
  // ================================================================
  Widget _buildCreateAccountContent(BuildContext context) {
    return Column(
      children: [
        _buildTopBar(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    _buildHeader(context),
                    const SizedBox(height: 32),
                    _buildForm(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // SUCCESS CONTENT (NO SCAFFOLD)
  // ================================================================
  Widget _buildSuccessContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Icon(
                Icons.check_circle,
                size: 64,
                color: Colors.green.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Success Title
            Text(
              'Account Created Successfully',
              style: AppTextStyles.h2.copyWith(
                color: isDark
                    ? AppColors.foregroundDark
                    : AppColors.foregroundLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Redirecting Message
            Text(
              'Redirecting to login...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.mutedForegroundDark
                    : AppColors.mutedForegroundLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // TOP BAR
  // ================================================================
  Widget _buildTopBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: controller.navigateToLogin,
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 12),
          Text(
            'Create Account',
            style: AppTextStyles.h4.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // HEADER
  // ================================================================
  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: isDark ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            boxShadow: isDark
                ? [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          padding: EdgeInsets.all(isDark ? 8 : 0),
          child: const Center(
            child: Icon(
              Icons.local_fire_department,
              size: 48,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // FORM
  // ================================================================
  Widget _buildForm(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email Label
        Text(
          'Email',
          style: AppTextStyles.labelMedium.copyWith(
            color: isDark
                ? AppColors.foregroundDark
                : AppColors.foregroundLight,
          ),
        ),
        const SizedBox(height: 8),

        Obx(
          () => TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: controller.onEmailChanged,
            decoration: InputDecoration(
              hintText: 'Enter your email',

              // KEEP YOUR ERROR TEXT
              errorText: controller.emailError.value.isEmpty
                  ? null
                  : controller.emailError.value,

              // 👇 CUSTOM CLEAN BORDER ALWAYS
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.borderLight, // normal border
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.primary, // blue when typing
                  width: 1.5,
                ),
              ),

              // 👇 OVERRIDE UGLY DEFAULT ERROR BORDER
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.red.shade400,
                  width: 1, // <-- = keep thin border
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Password Label
        Text(
          'Password',
          style: AppTextStyles.labelMedium.copyWith(
            color: isDark
                ? AppColors.foregroundDark
                : AppColors.foregroundLight,
          ),
        ),
        const SizedBox(height: 8),

        // Password Field
        Obx(
          () => TextField(
            controller: controller.passwordController,
            obscureText: !controller.isPasswordVisible.value,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              suffixIcon: IconButton(
                onPressed: controller.togglePasswordVisibility,
                icon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 20,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Confirm Password Label
        Text(
          'Confirm Password',
          style: AppTextStyles.labelMedium.copyWith(
            color: isDark
                ? AppColors.foregroundDark
                : AppColors.foregroundLight,
          ),
        ),
        const SizedBox(height: 8),

        // Confirm Password Field
        Obx(
          () => TextField(
            controller: controller.confirmPasswordController,
            obscureText: !controller.isConfirmPasswordVisible.value,
            onChanged: (value) => controller.update(),
            decoration: InputDecoration(
              hintText: 'Confirm your password',
              suffixIcon: IconButton(
                onPressed: controller.toggleConfirmPasswordVisibility,
                icon: Icon(
                  controller.isConfirmPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 20,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Password Mismatch Error - FIXED: Using GetBuilder instead of Obx
        GetBuilder<CreateAccountController>(
          builder: (ctrl) =>
              ctrl.confirmPasswordController.text.isNotEmpty &&
                  !ctrl.passwordsMatch
              ? Text(
                  'Passwords do not match',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.destructiveLight,
                  ),
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(height: 16),

        // Password Requirements Box
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password Requirements:',
                style: AppTextStyles.labelMedium.copyWith(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => PasswordRulesWidget(
                  hasMinLength: controller.hasMinLength.value,
                  hasUppercase: controller.hasUppercase.value,
                  hasLowercase: controller.hasLowercase.value,
                  hasNumber: controller.hasNumber.value,
                  hasSpecialChar: controller.hasSpecialChar.value,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Create Account Button - FIXED: Using GetBuilder for getter validation
        GetBuilder<CreateAccountController>(
          builder: (ctrl) => ElevatedButton(
            onPressed: ctrl.canCreateAccount && !ctrl.isLoading.value
                ? ctrl.handleCreateAccount
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: ctrl.isLoading.value
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryForegroundLight,
                      ),
                    ),
                  )
                : Text(
                    'Create Account',
                    style: AppTextStyles.buttonMedium.copyWith(
                      color: AppColors.primaryForegroundLight,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
