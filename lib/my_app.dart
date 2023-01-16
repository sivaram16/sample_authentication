import 'package:flutter/material.dart';
import 'package:sample_authentication/router.dart';
import 'package:sample_authentication/utils/color_resource.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorResource.Color_FFF,
        appBarTheme: const AppBarTheme(color: ColorResource.Color_FFF),
      ),
      home: addAuth(context, Container()),
    );
  }
}
