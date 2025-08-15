import 'package:mini_task_manager/exports.dart';

class AppButton extends ElevatedButton {
  AppButton.primary(
      {super.key, Color? color, String? label, VoidCallback? onTap})
      : super(
          onPressed: onTap,
          child: AppText.subHeader(
            text: label ?? "",
            color: AppColors.white,
            fontSize: 16.sp,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.primary,
            minimumSize: Size(double.infinity, .075.sh),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
}
