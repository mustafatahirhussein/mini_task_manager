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

  void _login(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      print("Email: ${formData['email']}");
      print("Password: ${formData['password']}");

      context.read<AuthBloc>().register(email: formData['email'], password: formData['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocBuilder<AuthBloc, AuthState>(
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
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  state is AuthLoading ? const CircularProgressIndicator() : AppButton.primary(
                    onTap: () => _login(context),
                    label: "Login",
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (_) => const RegisterPage()),
                  //     );
                  //   },
                  //   child: const Text("Don't have an account? Register"),
                  // )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
