part of '../screens.dart';

class HomeController extends GetxController {
  void openDetail(ItemModel itemModel) {
    Get.toNamed(routeName.detail,
        preventDuplicates: false, arguments: itemModel);
  }

  @override
  void onInit() {
    BlocProvider.of<ListItemCubit>(Get.context!).fetchListItems();
    BlocProvider.of<GetCartCubit>(Get.context!).getCart();
    super.onInit();
  }
}
