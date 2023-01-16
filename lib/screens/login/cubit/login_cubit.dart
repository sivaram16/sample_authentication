import 'package:flutter/cupertino.dart';
import 'package:sample_authentication/authentication/authentication_cubit.dart';
import 'package:sample_authentication/screens/login/cubit/login_state.dart';
import 'package:sample_authentication/service/otp_service.dart';
import 'package:sample_authentication/utils/preference_helper.dart';
import 'package:sample_authentication/widgets/custom_cubit.dart';

class LoginCubit extends BaseCubit<LoginScreenState> {
  AuthenticationCubit authenticationCubit;
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool showVerificationCodeWidget = false;

  LoginCubit(this.authenticationCubit) : super(LoginScreenInitialState());

  Future<void> init() async {
    emit(LoginScreenRefreshState());
  }

  Future<void> generateOTP() async {
    if (mobileController.text.trim().isEmpty) {
      emit(LoginScreenErrorState("Number is required"));
      return;
    }
    emit(LoginScreenLoadingState());
    showVerificationCodeWidget = true;
    await OTPService.submitPhoneNumber(mobileController.text);
    emit(LoginScreenRefreshState());
  }

  void openVerficationCodeWidget() {
    showVerificationCodeWidget = true;
    emit(LoginScreenRefreshState());
  }

  Future<void> verifyOTP() async {
    if (otpController.text.trim().isEmpty) {
      emit(LoginScreenErrorState("OTP is required"));
      return;
    }
    emit(LoginScreenLoadingState());
    final bool isVerified = await OTPService.submitOTP(otpController.text);
    if (isVerified) {
      PreferenceHelper.saveIsLoggedIn(value: true);
      PreferenceHelper.saveNumber(value: mobileController.text);
      authenticationCubit.loggedIn();
    }
    emit(LoginScreenRefreshState());
  }
}
