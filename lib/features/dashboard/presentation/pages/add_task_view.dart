import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mini_task_manager/features/dashboard/data/model/task_model.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/task/task_cubit.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/task/task_state.dart';
import '../../../../exports.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, this.task});

  final TaskModel? task;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.task != null) {
        _formKey.currentState?.patchValue({
          'title': widget.task?.title ?? "",
          'desc': widget.task?.desc ?? "",
        });
      }
    });
    super.initState();
  }

  void _saveTask(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      TaskModel task = TaskModel.fromJson(formData);
      task.createdAt = Timestamp.now();
      context.read<TaskCubit>().addTask(task);
    }
  }

  void _saveChanges(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      TaskModel? task = widget.task?.copyWith(
        title: formData['title'],
        desc: formData['desc'],
      );
      context.read<TaskCubit>().updateTask(task!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? "Add Task" : "Edit Task")),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskSuccess) {
            AppSnackBar.showSuccessMessage(context, message: state.message);
            Navigator.pop(context);
          }
          if(state is TaskError) {
            AppSnackBar.showErrorMessage(context, message: state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      decoration: const InputDecoration(
                        labelText: 'Enter Task',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                    ),
                    const SizedBox(height: 16),

                    FormBuilderTextField(
                      name: 'desc',
                      maxLines: 3,
                      maxLength: 200,
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.maxLength(200),
                      ]),
                    ),

                    const SizedBox(height: 24),
                    state is TaskLoading
                        ? AppLoader()
                        : AppButton.primary(
                      onTap: () => widget.task == null ? _saveTask(context) : _saveChanges(context),
                      label: widget.task == null ? "Add Task" : "Save Changes",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
