part of '../screens.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    BlocProvider.of<GetCartCubit>(Get.context!).getCart();
    super.onInit();
  }
}
