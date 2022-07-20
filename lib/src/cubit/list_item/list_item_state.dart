part of 'list_item_cubit.dart';

@immutable
abstract class ListItemState {}

class ListItemInitial extends ListItemState {}

class ListItemIsLoading extends ListItemState {}

class ListItemIsSuccess extends ListItemState {
  final List<ItemModel> items;
  ListItemIsSuccess(this.items);
}

class ListItemIsFailed extends ListItemState {
  final String message;

  ListItemIsFailed(this.message);
}
