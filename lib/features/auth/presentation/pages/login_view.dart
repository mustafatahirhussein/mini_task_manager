import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_state.dart';
import '../../../../exports.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormBuilderState>();

  StreamController<bool> password$ = StreamController<bool>.broadcast();

  void _login(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      context.read<AuthBloc>().login(
        email: formData['email'],
        password: formData['password'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            AppConstants.userId = state.user.uid;
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (_) => false);
          }
          if(state is AuthError) {
            AppSnackBar.showErrorMessage(context, message: state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 16),

                  StreamBuilder<bool>(
                    stream: password$.stream,
                    initialData: true,
                    builder: (context, snapshot) {
                      return FormBuilderTextField(
                        name: 'password',
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () => password$.sink.add(!snapshot.data!),
                            child: Icon(
                              snapshot.data ?? true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: snapshot.data ?? true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6),
                        ]),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                  state is AuthLoading
                      ? AppLoader()
                      : AppButton.primary(
                    onTap: () => _login(context),
                    label: "Login",
                  ),

                  const SizedBox(height: 24),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(color: AppColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, AppRoutes.signup),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
