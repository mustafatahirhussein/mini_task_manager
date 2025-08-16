import 'package:mini_task_manager/exports.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showErrorMessage(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        content: AppText.subHeader(
          text: message,
          color: AppColors.white,
        ),
      ),
    );
  }

  static void showSuccessMessage(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.black,
        content: AppText.subHeader(
          text: message,
          color: AppColors.white,
        ),
      ),
    );
  }
}
