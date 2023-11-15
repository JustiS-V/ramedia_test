part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigationToWhite extends NavigationEvent {NavigationToWhite();}
class NavigationToGrey extends NavigationEvent {NavigationToGrey();}