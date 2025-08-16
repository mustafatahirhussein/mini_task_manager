

import 'package:mini_task_manager/config/extensions/dateformat_ext.dart';
import 'package:mini_task_manager/config/extensions/padding_ext.dart';
import 'package:mini_task_manager/features/dashboard/data/model/task_model.dart';
import 'package:mini_task_manager/features/dashboard/presentation/pages/add_task_view.dart';

import '../../../../exports.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, this.task, this.onDone});

  final TaskModel? task;
  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addTask, arguments: AddTaskView(task: task));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: .01.sh),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(.04.sw),
          color: AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subHeader(
                  text: task?.title ?? "",
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                AppText.subHeader(text: task?.desc ?? "", color: AppColors.white),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(
                  value: task?.isDone ?? false,
                  activeColor: AppColors.white,
                  checkColor: AppColors.primary,
                  onChanged: (val) => onDone?.call(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                AppText.subHeader(text: task?.createdAt?.formattedDate ?? "", color: AppColors.white, fontSize: 11.sp,),
              ],
            ),
          ],
        ).applyDefaultPadding(),
      ),
    );
  }
}
