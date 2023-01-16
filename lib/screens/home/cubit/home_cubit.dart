import 'package:sample_authentication/authentication/authentication_cubit.dart';
import 'package:sample_authentication/screens/home/cubit/home_state.dart';
import 'package:sample_authentication/widgets/custom_cubit.dart';

class HomeCubit extends BaseCubit<HomeScreenState> {
  AuthenticationCubit authenticationCubit;
  int tabIndex = 0;
  HomeCubit(this.authenticationCubit) : super(HomeScreenInitialState());

  Future<void> init() async {
    emit(HomeScreenRefreshState());
  }

  void onTabIndexChanged(int index) {
    tabIndex = index;
    emit(HomeScreenRefreshState());
  }
}
