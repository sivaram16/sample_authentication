import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_authentication/authentication/authentication_cubit.dart';
import 'package:sample_authentication/cubit.dart';
import 'package:sample_authentication/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider<AuthenticationCubit>(
    create: (BuildContext context) {
      return AuthenticationCubit()..init();
    },
    child: const MyApp(),
  ));
  Bloc.observer = EchoCubitDelegate();
}
