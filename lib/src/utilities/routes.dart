part of 'utilities.dart';

mixin routeName {
  static const String home = '/home';
  static const String cart = '/cart';
  static const String detail = '/detail';
}

List<GetPage> pages = [
  GetPage(name: routeName.home, page: () => HomeScreen()),
  GetPage(name: routeName.cart, page: () => CartScreen()),
  GetPage(name: routeName.detail, page: () => DetailScreen()),
];
