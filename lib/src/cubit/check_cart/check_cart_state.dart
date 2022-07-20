part of 'check_cart_cubit.dart';

@immutable
abstract class CheckCartState {}

class CheckCartInitial extends CheckCartState {}

class CheckCartIsAvailable extends CheckCartState {}

class CheckCartIsNotAvailable extends CheckCartState {}
