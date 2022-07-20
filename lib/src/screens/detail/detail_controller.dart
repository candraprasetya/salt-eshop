part of '../screens.dart';

class DetailController extends GetxController {
  String title = '';
  void changeTitle(String newTitle) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      title = newTitle;
      update();
    });
  }

  @override
  void onInit() {
    BlocProvider.of<DetailCubit>(Get.context!).getDetail(Get.arguments);
    super.onInit();
  }
}
