import 'package:flutter/material.dart';
import 'package:sample_authentication/router.dart';
import 'package:sample_authentication/utils/image_resource.dart';
import 'package:sample_authentication/utils/string_resource.dart';
import 'package:sample_authentication/widgets/custom_scaffold.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                  height: double.infinity,
                  child:
                      Image.asset(ImageResource.startGIF, fit: BoxFit.cover)),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: const Text(StringResource.getStarted)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
