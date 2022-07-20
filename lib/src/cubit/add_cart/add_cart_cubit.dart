import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:salt_test/src/cubit/cubits.dart';
import 'package:salt_test/src/models/models.dart';
import 'package:salt_test/src/utilities/utilities.dart';

part 'add_cart_state.dart';

class AddCartCubit extends Cubit<AddCartState> {
  final getCartBloc = BlocProvider.of<GetCartCubit>(Get.context!);
  final checkCartBloc = BlocProvider.of<CheckCartCubit>(Get.context!);
  AddCartCubit() : super(AddCartInitial());

  Future<void> addToCart(ItemModel item) async {
    var box = await Hive.openBox(boxName.cart);
    emit(AddCartIsLoading());
    if (item.id == null) {
      emit(AddCartIsFailed());
    } else {
      box.put(item.id, jsonEncode(item));
      getCartBloc.getCart();
      checkCartBloc.checkCart(item.id!);
      emit(AddCartIsSuccess());
    }
  }

  Future<void> removeFromCart(int id) async {
    var box = await Hive.openBox(boxName.cart);
    if (box.get(id) == null) {
      emit(AddCartIsFailed());
    } else {
      box.delete(id);
      getCartBloc.getCart();
      checkCartBloc.checkCart(id);
      emit(AddCartIsSuccess());
    }
  }
}
