import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_authentication/screens/login/cubit/login_cubit.dart';
import 'package:sample_authentication/screens/login/cubit/login_state.dart';
import 'package:sample_authentication/utils/image_resource.dart';
import 'package:sample_authentication/utils/string_resource.dart';
import 'package:sample_authentication/widgets/custom_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
    final cubit = context.read<LoginCubit>();
    final showCodeWidget =
        context.select((LoginCubit cubit) => cubit.showVerificationCodeWidget);

    return BlocConsumer(
        bloc: cubit,
        listener: (context, state) {
          if (state is LoginScreenErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              webPosition: "center",
              timeInSecForIosWeb: 3,
              fontSize: 14.0,
            );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              Image.asset(
                ImageResource.background,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              if (showCodeWidget) ...[
                const _VerficationCodeWidget()
              ] else ...[
                const Center(
                  child: Text(
                    StringResource.signIN,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: getInputField(
                      cubit.mobileController, StringResource.mobileNumber),
                ),
                const SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: getButton(
                        StringResource.signIN, () => cubit.generateOTP())),
              ]
            ],
          );
        });
  }
}

class _VerficationCodeWidget extends StatelessWidget {
  const _VerficationCodeWidget();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: getInputField(cubit.otpController, StringResource.enterOTP),
        ),
        const SizedBox(height: 20),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: getButton(StringResource.submit, () => cubit.verifyOTP())),
      ],
    );
  }
}

Widget getInputField(TextEditingController controller, String hintText) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey)),
  );
}

Widget getButton(String text, Function() onPressed) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      onPressed: onPressed,
      child: Text(text));
}
