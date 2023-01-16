import 'package:sample_authentication/utils/base_equatable.dart';

class AuthenticationState extends BaseEquatable {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationAuthenticatedState extends AuthenticationState {}

class AuthenticationUnAuthenticatedState extends AuthenticationState {}
