part of 'widgets.dart';

PreferredSize myAppBar(String title,
    {bool showLogo = false,
    bool showCart = false,
    bool showBack = false,
    String subTitle = ''}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child: MyAppBar(
        title: title,
        subTitle: subTitle,
        showLogo: showLogo,
        showCart: showCart,
        showBack: showBack,
      ));
}

class MyAppBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showLogo;
  final bool showCart;
  final bool showBack;

  const MyAppBar({
    super.key,
    required this.title,
    required this.subTitle,
    required this.showLogo,
    required this.showCart,
    required this.showBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: HStack([
      showBack
          ? Bounceable(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: colorName.black,
              )).pOnly(top: 24, left: 24, bottom: 24)
          : 0.heightBox,
      VStack(
        [
          showLogo
              ? Image.asset(imageFiles.logo, height: 14)
              : title.text
                  .subtitle1(context)
                  .size(14)
                  .color(colorName.grey)
                  .make(),
          (subTitle.isEmpty)
              ? 0.heightBox
              : subTitle.text
                  .headline4(context)
                  .bold
                  .size(20)
                  .color(colorName.black)
                  .make(),
        ],
        axisSize: MainAxisSize.min,
        crossAlignment: CrossAxisAlignment.start,
      ).p24().expand(),
      showCart
          ? Bounceable(onTap: () {
              Get.toNamed(routeName.cart);
            }, child: BlocBuilder<GetCartCubit, GetCartState>(
              builder: (context, state) {
                if (state is GetCartIsSuccess) {
                  return VxBadge(
                      count: state.items.length,
                      color: colorName.darkRed,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 8),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: colorName.pink,
                      ));
                }
                return const Icon(
                  Icons.shopping_cart_outlined,
                  color: colorName.pink,
                );
              },
            )).p24()
          : 0.heightBox
    ]));
  }
}
