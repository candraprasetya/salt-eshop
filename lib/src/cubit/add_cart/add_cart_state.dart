part of 'add_cart_cubit.dart';

@immutable
abstract class AddCartState {}

class AddCartInitial extends AddCartState {}

class AddCartIsSuccess extends AddCartState {}

class AddCartIsLoading extends AddCartState {}

class AddCartIsFailed extends AddCartState {}
