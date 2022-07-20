import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salt_test/src/models/models.dart';
import 'package:salt_test/src/services/services.dart';

part 'list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  ListItemCubit() : super(ListItemInitial());

  void fetchListItems() {
    emit(ListItemIsLoading());
    Timer(const Duration(milliseconds: 1500), () async {
      final data = await ItemService.fetchItems();
      if (data.isNotEmpty) {
        emit(ListItemIsSuccess(data));
      } else {
        emit(ListItemIsFailed('Tidak ada Data'));
      }
    });
  }
}
