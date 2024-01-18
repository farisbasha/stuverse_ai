import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stuverse_ai/app/utils/constants.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(
          const NavigationState(
            bottomNavItems: Routes.homeScreenName,
            index: 0,
          ),
        );

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(
          const NavigationState(
            bottomNavItems: Routes.homeScreenName,
            index: 0,
          ),
        );

      case 1:
        emit(
          const NavigationState(
            bottomNavItems: Routes.profileScreenName,
            index: 1,
          ),
        );
    }
  }
}
