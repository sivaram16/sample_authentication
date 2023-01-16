import 'package:sample_authentication/utils/base_equatable.dart';

class HomeScreenState extends BaseEquatable {}

class HomeScreenInitialState extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenRefreshState extends HomeScreenState {
  @override
  bool operator ==(Object other) => false;
}

class HomeScreenErrorState extends HomeScreenState {
  final String error;
  HomeScreenErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}
