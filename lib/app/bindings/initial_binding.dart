import 'package:firefox_calender/presentation/auth/controllers/calendar_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/create_event_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/createacciunt_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/dashboard_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/hours_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/login_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/payroll_controller.dart';
import 'package:firefox_calender/presentation/auth/controllers/settings_controller.dart';
import 'package:get/get.dart';

/// Initial binding for global dependencies
/// Controllers initialized here are available throughout the app lifecycle
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(),
      fenix: true,
    );

    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<CalendarController>(() => CalendarController(), fenix: true);
    Get.lazyPut<CreateEventController>(
      () => CreateEventController(),
      fenix: true,
    );

    Get.lazyPut<HoursController>(
      () => HoursController(),
      fenix: true,
    );

    Get.lazyPut<PayrollController>(
      () => PayrollController(),
      fenix: true,
    );
  
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
      fenix: true,
    );
  }
}
