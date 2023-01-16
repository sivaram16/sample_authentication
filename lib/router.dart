import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_authentication/authentication/authentication_cubit.dart';
import 'package:sample_authentication/authentication/authentication_state.dart';
import 'package:sample_authentication/screens/home/cubit/home_cubit.dart';
import 'package:sample_authentication/screens/login/cubit/login_cubit.dart';
import 'package:sample_authentication/screens/start/start_screen.dart';

import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'widgets/custom_provider.dart';

class AppRoutes {
  static const String login = "login";
  static const String home = "home";
  static const String start = "start";
}

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return _buildLoginScreen();

    case AppRoutes.home:
      return _buildHomeScreen();
    case AppRoutes.start:
      return _buildStartScreen();

    default:
      return _buildLoginScreen();
  }
}

MaterialPageRoute _buildLoginScreen() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.login),
    builder: (context) => addAuth(context, PageBuilder.buildLoginScreen()),
  );
}

MaterialPageRoute _buildHomeScreen() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.home),
    builder: (context) => addAuth(context, PageBuilder.buildHomeScreen()),
  );
}

MaterialPageRoute _buildStartScreen() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.start),
    builder: (context) => addAuth(context, PageBuilder.buildStartScreen()),
  );
}

Widget addAuth(BuildContext context, Widget widget) {
  final AuthenticationCubit authenticationCubit =
      BlocProvider.of<AuthenticationCubit>(context);

  return BlocListener(
    bloc: authenticationCubit,
    listener: (BuildContext context, AuthenticationState state) {
      if (state is AuthenticationUnAuthenticatedState) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacementNamed(context, AppRoutes.start);
      }

      if (state is AuthenticationAuthenticatedState) {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    },
    child: BlocBuilder(
      bloc: authenticationCubit,
      builder: (BuildContext context, AuthenticationState state) {
        return widget;
      },
    ),
  );
}

class PageBuilder {
  static Widget buildLoginScreen() {
    return CProvider(
      create: (context) {
        final AuthenticationCubit authenticationCubit =
            BlocProvider.of<AuthenticationCubit>(context);
        return LoginCubit(authenticationCubit)..init();
      },
      builder: (context) => const LoginScreen(),
    );
  }

  static Widget buildHomeScreen() {
    return CProvider(
      create: (context) {
        final AuthenticationCubit authenticationCubit =
            BlocProvider.of<AuthenticationCubit>(context);
        return HomeCubit(authenticationCubit)..init();
      },
      builder: (context) => const HomeScreen(),
    );
  }

  static Widget buildStartScreen() {
    return const StartScreen();
  }
}
