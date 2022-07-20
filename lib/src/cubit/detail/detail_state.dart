part of 'detail_cubit.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailIsLoading extends DetailState {}

class DetailIsSuccess extends DetailState {
  final ItemModel item;

  DetailIsSuccess(this.item);
}

class DetailIsFailed extends DetailState {}
