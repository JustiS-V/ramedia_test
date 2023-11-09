part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigationToOption extends NavigationEvent {NavigationToOption();}
class NavigationToFinal extends NavigationEvent {NavigationToFinal();}
class NavigationToBirthday extends NavigationEvent {NavigationToBirthday();}