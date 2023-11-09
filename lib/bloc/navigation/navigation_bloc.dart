import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<NavigationToFinal>((event, emit) => emit(NavigationState(currentPage: 'Final')));
    on<NavigationToBirthday>((event, emit)=>emit(NavigationState(
      currentPage: 'Birthday',
    )));
  }
}