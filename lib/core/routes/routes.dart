import 'package:flutter/material.dart';
import 'package:mini_task_manager/core/widgets/app_text.dart';
import 'package:mini_task_manager/features/auth/presentation/pages/auth_check_state.dart';
import 'package:mini_task_manager/features/auth/presentation/pages/login_view.dart';
import 'package:mini_task_manager/features/dashboard/pages/dashboard_view.dart';

class AppRoutes {

  static const String initialRoute = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => AuthCheckView());

        case login:
        return MaterialPageRoute(builder: (_) => LoginView());
        case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      // case bmiResult:
      //   var arg = settings.arguments as BmiResultView;
      //   return MaterialPageRoute(
      //       builder: (_) => BmiResultView(model: arg.model));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: AppText.subHeader(
              text: "No route found",
            ),
          ),
        ));
    }
  }
}