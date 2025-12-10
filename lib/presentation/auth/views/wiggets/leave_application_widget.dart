// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firefox_calender/app/theme/app_colors.dart';
// import 'package:firefox_calender/app/theme/app_text_styles.dart';
// import 'package:firefox_calender/app/theme/app_theme.dart';

// /// Leave Application Widget
// /// Converted from React LeaveApplication component
// /// Placeholder implementation for leave application functionality
// class LeaveApplicationWidget extends StatelessWidget {
//   const LeaveApplicationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Text(
//             'Leave Application',
//             style: AppTextStyles.h3.copyWith(
//               color: isDark
//                   ? AppColors.foregroundDark
//                   : AppColors.foregroundLight,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Info Card
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.blue.shade900.withOpacity(0.2)
//                   : Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(AppTheme.radiusMd),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.blue.shade800
//                     : Colors.blue.shade200,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.info_outline,
//                   size: 20,
//                   color: isDark
//                       ? Colors.blue.shade400
//                       : Colors.blue.shade600,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     'Leave application functionality will be available soon. You can submit leave requests through your line manager.',
//                     style: AppTextStyles.bodyMedium.copyWith(
//                       color: isDark
//                           ? Colors.blue.shade200
//                           : Colors.blue.shade800,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // Leave Types Card
//           _buildLeaveTypesCard(isDark),

//           const SizedBox(height: 16),

//           // Leave Balance Card
//           _buildLeaveBalanceCard(isDark),

//           const SizedBox(height: 16),

//           // Recent Applications Card
//           _buildRecentApplicationsCard(isDark),
//         ],
//       ),
//     );
//   }

//   /// Build leave types card
//   Widget _buildLeaveTypesCard(bool isDark) {
//     final leaveTypes = [
//       {'name': 'Annual Leave', 'icon': Icons.calendar_today, 'color': Colors.green.shade600},
//       {'name': 'Personal Leave', 'icon': Icons.person, 'color': Colors.blue.shade600},
//       {'name': 'Sick Leave', 'icon': Icons.local_hospital, 'color': Colors.red.shade600},
//       {'name': 'Days in Lieu', 'icon': Icons.event_available, 'color': Colors.purple.shade600},
//     ];

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.cardDark : AppColors.cardLight,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMd),
//         border: Border.all(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Leave Types',
//             style: AppTextStyles.h4.copyWith(
//               color: isDark
//                   ? AppColors.foregroundDark
//                   : AppColors.foregroundLight,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 16),

//           ...leaveTypes.map((type) => Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: (type['color'] as Color).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     type['icon'] as IconData,
//                     size: 20,
//                     color: type['color'] as Color,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   type['name'] as String,
//                   style: AppTextStyles.labelMedium.copyWith(
//                     color: isDark
//                         ? AppColors.foregroundDark
//                         : AppColors.foregroundLight,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           )),
//         ],
//       ),
//     );
//   }

//   /// Build leave balance card
//   Widget _buildLeaveBalanceCard(bool isDark) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.cardDark : AppColors.cardLight,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMd),
//         border: Border.all(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Current Leave Balance',
//             style: AppTextStyles.h4.copyWith(
//               color: isDark
//                   ? AppColors.foregroundDark
//                   : AppColors.foregroundLight,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 16),

//           Row(
//             children: [
//               Expanded(
//                 child: _buildBalanceItem(
//                   'Annual Leave',
//                   '18 days',
//                   Colors.green.shade600,
//                   isDark,
//                 ),
//               ),
//               Expanded(
//                 child: _buildBalanceItem(
//                   'Personal Leave',
//                   '12 days',
//                   Colors.blue.shade600,
//                   isDark,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           Row(
//             children: [
//               Expanded(
//                 child: _buildBalanceItem(
//                   'Sick Leave',
//                   '10 days',
//                   Colors.red.shade600,
//                   isDark,
//                 ),
//               ),
//               Expanded(
//                 child: _buildBalanceItem(
//                   'Days in Lieu',
//                   '5 days',
//                   Colors.purple.shade600,
//                   isDark,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// Build balance item
//   Widget _buildBalanceItem(String label, String value, Color color, bool isDark) {
//     return Container(
//       margin: const EdgeInsets.all(4),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(AppTheme.radiusSm),
//         border: Border.all(
//           color: color.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: AppTextStyles.h4.copyWith(
//               color: color,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: AppTextStyles.labelSmall.copyWith(
//               color: isDark
//                   ? AppColors.foregroundDark
//                   : AppColors.foregroundLight,
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }

//   /// Build recent applications card
//   Widget _buildRecentApplicationsCard(bool isDark) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.cardDark : AppColors.cardLight,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMd),
//         border: Border.all(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Recent Applications',
//             style: AppTextStyles.h4.copyWith(
//               color: isDark
//                   ? AppColors.foregroundDark
//                   : AppColors.foregroundLight,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Placeholder message
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? AppColors.mutedDark.withOpacity(0.3)
//                   : AppColors.mutedLight.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(AppTheme.radiusSm),
//               border: Border.all(
//                 color: isDark
//                     ? AppColors.borderDark
//                     : AppColors.borderLight,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.inbox,
//                   size: 48,
//                   color: isDark
//                       ? AppColors.mutedForegroundDark
//                       : AppColors.mutedForegroundLight,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'No recent applications',
//                   style: AppTextStyles.labelMedium.copyWith(
//                     color: isDark
//                         ? AppColors.foregroundDark
//                         : AppColors.foregroundLight,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Your leave applications will appear here',
//                   style: AppTextStyles.bodySmall.copyWith(
//                     color: isDark
//                         ? AppColors.mutedForegroundDark
//                         : AppColors.mutedForegroundLight,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Apply Leave Button (placeholder)
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 Get.snackbar(
//                   'Coming Soon',
//                   'Leave application form will be available soon',
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.blue.shade100,
//                   colorText: Colors.blue.shade900,
//                   duration: const Duration(seconds: 2),
//                 );
//               },
//               icon: const Icon(Icons.add_circle_outline, size: 18),
//               label: const Text('Apply for Leave'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firefox_calender/app/theme/app_colors.dart';
import 'package:firefox_calender/app/theme/app_text_styles.dart';
import 'package:firefox_calender/app/theme/app_theme.dart';

/// Leave Application Widget
/// Converted from React LeaveApplication component
/// Complete implementation matching the provided screenshots
class LeaveApplicationWidget extends StatefulWidget {
  const LeaveApplicationWidget({super.key});

  @override
  State<LeaveApplicationWidget> createState() => _LeaveApplicationWidgetState();
}

class _LeaveApplicationWidgetState extends State<LeaveApplicationWidget> {
  // Form controllers
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set placeholder text for date fields
    _startDateController.text = 'dd----yyyy';
    _endDateController.text = 'dd----yyyy';
    _reasonController.text = 'Please provide a reason for your leave request...';
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leave Balance Card
          _buildLeaveBalanceCard(isDark),

          const SizedBox(height: 16),

          // Apply for Leave Form
          _buildApplyLeaveForm(isDark),

          const SizedBox(height: 16),

          // Leave History
          _buildLeaveHistory(isDark),
        ],
      ),
    );
  }

  /// Build leave balance card matching the screenshot
  Widget _buildLeaveBalanceCard(bool isDark) {
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
            'Leave Balance',
            style: AppTextStyles.h4.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Balance metrics in 2x2 grid
          Row(
            children: [
              Expanded(
                child: _buildBalanceItem(
                  'Total Allocated',
                  '20 days',
                  isDark
                      ? AppColors.mutedForegroundDark
                      : AppColors.mutedForegroundLight,
                  isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildBalanceItem(
                  'Remaining',
                  '15 days',
                  Colors.green.shade600,
                  isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildBalanceItem(
                  'Used',
                  '5 days',
                  Colors.blue.shade600,
                  isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildBalanceItem(
                  'Pending',
                  '0 requests',
                  Colors.orange.shade600,
                  isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build balance item
  Widget _buildBalanceItem(String label, String value, Color valueColor, bool isDark) {
    return Column(
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
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.h4.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  /// Build apply for leave form matching the screenshot
  Widget _buildApplyLeaveForm(bool isDark) {
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
            'Apply for Leave',
            style: AppTextStyles.h4.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Date fields row
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  'Start Date *',
                  _startDateController,
                  isDark,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateField(
                  'End Date *',
                  _endDateController,
                  isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Reason field
          _buildReasonField(isDark),

          const SizedBox(height: 20),

          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSubmitLeaveRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight, // Orange/red color from screenshot
                foregroundColor: AppColors.primaryForegroundLight,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit Leave Request',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primaryForegroundLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build date input field
  Widget _buildDateField(String label, TextEditingController controller, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isDark
                ? AppColors.foregroundDark
                : AppColors.foregroundLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.inputBackgroundDark
                : AppColors.inputBackgroundLight,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: TextField(
            controller: controller,
            onTap: () => _handleDateFieldTap(controller),
            readOnly: true,
            style: AppTextStyles.bodyMedium.copyWith(
              color: controller.text == 'dd----yyyy'
                  ? (isDark ? AppColors.mutedForegroundDark : AppColors.mutedForegroundLight)
                  : (isDark ? AppColors.foregroundDark : AppColors.foregroundLight),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: isDark 
                    ? AppColors.mutedForegroundDark
                    : AppColors.mutedForegroundLight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build reason text area field
  Widget _buildReasonField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason *',
          style: AppTextStyles.labelMedium.copyWith(
            color: isDark
                ? AppColors.foregroundDark
                : AppColors.foregroundLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.inputBackgroundDark
                : AppColors.inputBackgroundLight,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: TextField(
            controller: _reasonController,
            onTap: () => _handleReasonFieldTap(),
            maxLines: 4,
            style: AppTextStyles.bodyMedium.copyWith(
              color: _reasonController.text == 'Please provide a reason for your leave request...'
                  ? (isDark ? AppColors.mutedForegroundDark : AppColors.mutedForegroundLight)
                  : (isDark ? AppColors.foregroundDark : AppColors.foregroundLight),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12),
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: isDark 
                    ? AppColors.mutedForegroundDark
                    : AppColors.mutedForegroundLight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build leave history section matching the screenshot
  Widget _buildLeaveHistory(bool isDark) {
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
            'Leave History',
            style: AppTextStyles.h4.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 24),

          // Empty state matching the screenshot
          Center(
            child: Text(
              'No leave requests found',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.mutedForegroundDark
                    : AppColors.mutedForegroundLight,
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Handle date field tap
  void _handleDateFieldTap(TextEditingController controller) {
    // Clear placeholder if it's still there
    if (controller.text == 'dd----yyyy') {
      controller.clear();
    }
    
    // Show date picker
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((date) {
      if (date != null) {
        // Format date to match dd----yyyy pattern but with actual date
        final formattedDate = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
        controller.text = formattedDate;
      } else if (controller.text.isEmpty) {
        // Restore placeholder if no date selected
        controller.text = 'dd----yyyy';
      }
    });
  }

  /// Handle reason field tap
  void _handleReasonFieldTap() {
    if (_reasonController.text == 'Please provide a reason for your leave request...') {
      _reasonController.clear();
    }
  }

  /// Handle submit leave request
  void _handleSubmitLeaveRequest() {
    // Validate form
    if (_startDateController.text == 'dd----yyyy' || _startDateController.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select a start date',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (_endDateController.text == 'dd----yyyy' || _endDateController.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select an end date',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (_reasonController.text == 'Please provide a reason for your leave request...' || 
        _reasonController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please provide a reason for your leave request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // Show success message (placeholder for actual submission)
    Get.snackbar(
      'Success',
      'Leave request submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      duration: const Duration(seconds: 3),
    );

    // Reset form
    _startDateController.text = 'dd----yyyy';
    _endDateController.text = 'dd----yyyy';
    _reasonController.text = 'Please provide a reason for your leave request...';
  }
}