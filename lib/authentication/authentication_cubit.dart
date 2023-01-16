import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_authentication/authentication/authentication_state.dart';
import 'package:sample_authentication/utils/preference_helper.dart';
import 'package:sample_authentication/widgets/custom_cubit.dart';

class AuthenticationCubit extends BaseCubit<AuthenticationState> {
  bool? isLoggedIn;
  String? number;
  AuthenticationCubit() : super(AuthenticationInitialState());

  Future<void> init() async {
    emit(AuthenticationLoadingState());
    isLoggedIn = await PreferenceHelper.getIsLoggedIn();
    number = await PreferenceHelper.getNumber();

    if (isLoggedIn != null) {
      emit(AuthenticationAuthenticatedState());
    } else {
      emit(AuthenticationUnAuthenticatedState());
    }
  }

  Future<void> loggedIn() async {
    emit(AuthenticationLoadingState());
    isLoggedIn = await PreferenceHelper.getIsLoggedIn();
    number = await PreferenceHelper.getNumber();

    emit(AuthenticationAuthenticatedState());
  }

  Future<void> loggedOut() async {
    isLoggedIn = null;
    number = null;
    await FirebaseAuth.instance.signOut();
    emit(AuthenticationUnAuthenticatedState());
  }
}
