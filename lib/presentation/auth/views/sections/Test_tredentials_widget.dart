// import 'package:firefox_calender/app/theme/app_text_styles.dart';
// import 'package:firefox_calender/app/theme/app_theme.dart';
// import 'package:flutter/material.dart';

// /// Debug Test Credentials Widget
// /// Shows test credentials at the bottom of login screen for development
// class TestCredentialsWidget extends StatelessWidget {
//   const TestCredentialsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(AppTheme.radiusMd),
//         border: Border.all(color: Colors.blue.shade200, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.info_outline, size: 20, color: Colors.blue.shade700),
//               const SizedBox(width: 8),
//               Text(
//                 'Test Credentials',
//                 style: AppTextStyles.labelMedium.copyWith(
//                   color: Colors.blue.shade700,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           _buildCredentialRow(
//             icon: Icons.email,
//             label: 'Email:',
//             value: 'user@gmail.com',
//           ),
//           const SizedBox(height: 8),
//           _buildCredentialRow(
//             icon: Icons.lock,
//             label: 'Password:',
//             value: 'Password123!',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCredentialRow({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.blue.shade600),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: AppTextStyles.bodySmall.copyWith(
//             color: Colors.blue.shade700,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: SelectableText(
//             value,
//             style: AppTextStyles.bodySmall.copyWith(
//               color: Colors.blue.shade900,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'monospace',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
