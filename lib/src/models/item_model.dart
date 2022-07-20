part of 'models.dart';

List<ItemModel> itemModelFromJson(String str) =>
    List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemModelToJson(List<ItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
  ItemModel({
    this.id,
    this.title,
    this.description,
    this.url,
    this.finalPrice,
    this.basePrice,
    this.city,
    this.sold,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? url;
  final int? finalPrice;
  final int? basePrice;
  final String? city;
  final int? sold;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        finalPrice: json["final_price"],
        basePrice: json["base_price"],
        city: json["city"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "final_price": finalPrice,
        "base_price": basePrice,
        "city": city,
        "sold": sold,
      };
}
