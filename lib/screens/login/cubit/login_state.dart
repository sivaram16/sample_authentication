import 'package:sample_authentication/utils/base_equatable.dart';

class LoginScreenState extends BaseEquatable {}

class LoginScreenInitialState extends LoginScreenState {}

class LoginScreenLoadingState extends LoginScreenState {}

class LoginScreenRefreshState extends LoginScreenState {
  @override
  bool operator ==(Object other) => false;
}

class LoginScreenErrorState extends LoginScreenState {
  final String error;
  LoginScreenErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}
