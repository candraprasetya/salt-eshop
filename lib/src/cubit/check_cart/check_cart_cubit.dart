import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:salt_test/src/utilities/utilities.dart';

part 'check_cart_state.dart';

class CheckCartCubit extends Cubit<CheckCartState> {
  CheckCartCubit() : super(CheckCartInitial());

  Future<void> checkCart(int id) async {
    var box = await Hive.openBox(boxName.cart);

    if (box.get(id) != null) {
      emit(CheckCartIsAvailable());
    } else {
      emit(CheckCartIsNotAvailable());
    }
  }
}
