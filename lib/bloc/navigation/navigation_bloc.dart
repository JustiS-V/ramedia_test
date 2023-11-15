import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<NavigationToWhite>((event, emit) => emit(NavigationState(currentPage: 'WhitePage')));
    on<NavigationToGrey>((event, emit) => emit(NavigationState(currentPage: 'GreyPage')));
  }
}