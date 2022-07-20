part of 'get_cart_cubit.dart';

@immutable
abstract class GetCartState {}

class GetCartInitial extends GetCartState {}

class GetCartIsLoading extends GetCartState {}

class GetCartIsSuccess extends GetCartState {
  final List<ItemModel> items;

  GetCartIsSuccess(this.items);
}

class GetCartIsFailed extends GetCartState {}
