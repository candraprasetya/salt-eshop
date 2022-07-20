part of 'services.dart';

class ItemService {
  static Future<List<ItemModel>> fetchItems() async {
    String data =
        await DefaultAssetBundle.of(Get.context!).loadString(jsonFiles.cartUrl);
    final response = BaseResponse.fromJson(jsonDecode(data));
    List<ItemModel> items =
        List<ItemModel>.from(response.data.map((x) => ItemModel.fromJson(x)));
    return items;
  }
}
