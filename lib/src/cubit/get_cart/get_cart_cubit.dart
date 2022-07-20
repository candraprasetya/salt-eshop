import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:salt_test/src/models/models.dart';
import 'package:salt_test/src/utilities/utilities.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(GetCartInitial());

  Future<void> getCart() async {
    emit(GetCartIsLoading());
    var box = await Hive.openBox(boxName.cart);
    Timer(const Duration(milliseconds: 1500), () {
      if (box.isNotEmpty) {
        List<ItemModel> items = List<ItemModel>.from(
            box.values.map((x) => ItemModel.fromJson(jsonDecode(x))));
        emit(GetCartIsSuccess(Set.of(items).toList()));
      } else {
        emit(GetCartIsFailed());
      }
    });
  }

  Future<void> removeAllCart() async {
    emit(GetCartIsLoading());
    var box = await Hive.openBox(boxName.cart);
    Timer(const Duration(milliseconds: 1500), () {
      if (box.isNotEmpty) {
        box.clear();
        Get.snackbar('Pembayaran Berhasil',
            'Yuk belanja terus untuk naikin level profil kamu');
        emit(GetCartIsFailed());
      }
    });
  }
}
