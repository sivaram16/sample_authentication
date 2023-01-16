import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPService {
  static AuthCredential? phoneAuthCredential;
  static String? verification;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Create OTP
  static Future<void> submitPhoneNumber(String number) async {
    String phoneNumber = "+91 ${number.trim()}";

    void verificationCompleted(AuthCredential phoneAuthCredential) {}

    void verificationFailed(FirebaseAuthException error) {
      Fluttertoast.showToast(
        msg: "OTP verification failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        webPosition: "center",
        timeInSecForIosWeb: 3,
        fontSize: 14.0,
      );
    }

    void codeSent(String verificationId, [int? code]) {
      verification = verificationId;
      Fluttertoast.showToast(
        msg: "OTP sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        webPosition: "center",
        timeInSecForIosWeb: 3,
        fontSize: 14.0,
      );
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      verification = verificationId;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      handleError(e);
    }
  }

  /// Validate OTP
  static Future<bool> submitOTP(String otp) async {
    String smsCode = otp.trim();
    bool isVerified = false;
    try {
      phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verification!, smsCode: smsCode);
      await firebaseAuth.signInWithCredential(phoneAuthCredential!).then(
          (authResult) {
        isVerified = true;
      }, onError: (error) {
        handleError(error);
        isVerified = false;
      });
    } catch (e) {
      handleError(e);
      isVerified = false;
    }
    return isVerified;
  }

  static void handleError(var e) {
    if (e is PlatformException) {
      if (e.code == 'ERROR_INVALID_VERIFICATION_CODE') {
        Fluttertoast.showToast(
          msg: "Invalid OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          webPosition: "center",
          timeInSecForIosWeb: 3,
          fontSize: 14.0,
        );
      }
    } else {}
  }
}
