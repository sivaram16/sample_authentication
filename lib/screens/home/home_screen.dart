import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_authentication/screens/home/cubit/home_cubit.dart';
import 'package:sample_authentication/utils/string_resource.dart';
import 'package:sample_authentication/widgets/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    context.select((HomeCubit cubit) => cubit.tabIndex);
    return CustomScaffold(
      body: const _Layout(),
      color: Colors.black,
      bottomWidget: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.transparent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.home,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.home,
              ),
            ),
            label: StringResource.home,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.store,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.store,
              ),
            ),
            label: StringResource.store,
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.card_giftcard_rounded,
              ),
            ),
            icon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.card_giftcard_rounded,
              ),
            ),
            label: StringResource.gift,
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.settings,
              ),
            ),
            icon: Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.settings,
              ),
            ),
            label: StringResource.setting,
          ),
        ],
        currentIndex: cubit.tabIndex,
        selectedItemColor: Colors.orange,
        iconSize: 20,
        onTap: (int i) {
          cubit.onTabIndexChanged(i);
        },
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    context.select((HomeCubit cubit) => cubit.tabIndex);
    return BlocConsumer(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          switch (cubit.tabIndex) {
            case 0:
              return const Center(
                child: Text(
                  StringResource.home,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            case 1:
              return const Center(
                child: Text(
                  StringResource.store,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            case 2:
              return const Center(
                child: Text(
                  StringResource.gift,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            case 3:
              return Center(
                child: InkWell(
                  onTap: () {
                    cubit.authenticationCubit.loggedOut();
                  },
                  child: const Text(
                    StringResource.clickMeToLoggout,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            default:
              return Container();
          }
        });
  }
}
