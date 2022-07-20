part of '../screens.dart';

class CartScreen extends StatelessWidget {
  final c = Get.put(CartController());
  final d = Get.find<HomeController>();
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          myAppBar(constName.appName, subTitle: 'Keranjang', showBack: true),
      bottomNavigationBar: _buildBottomNav(context),
      body: RefreshIndicator(
        color: colorName.pink,
        onRefresh: () async => context.read<GetCartCubit>().getCart(),
        child: BlocBuilder<GetCartCubit, GetCartState>(
          builder: (context, state) {
            if (state is GetCartIsSuccess) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return 16.heightBox;
                },
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return MyCartCard(
                    item: state.items[index],
                    onTap: () => d.openDetail(state.items[index]),
                  );
                },
              ).pSymmetric(h: 24).whFull(context);
            }
            if (state is GetCartIsLoading) {
              return const MyProductShimmer();
            }
            if (state is GetCartIsFailed) {
              return VStack(
                [
                  Lottie.asset(animationFiles.empty,
                      height: context.percentWidth * 40,
                      width: context.percentWidth * 40),
                  'Keranjang Kamu Kosong, yuk masukkan product pilihan kamu!'
                      .text
                      .bold
                      .size(14)
                      .center
                      .make()
                      .pSymmetric(h: 24, v: 16),
                  MyButton(
                      title: 'Pilih Produk',
                      color: colorName.pink,
                      onPressed: () {
                        Get.back();
                      })
                ],
                crossAlignment: CrossAxisAlignment.center,
              );
            }
            return 0.heightBox;
          },
        ),
      ),
    );
  }

  Widget _buildPrice(int basePrice, int finalPrice) {
    return (basePrice == finalPrice)
        ? NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
            .format(finalPrice)
            .text
            .size(18)
            .bold
            .color(colorName.black)
            .make()
        : VStack(
            [
              HStack(
                [
                  VxBox(
                          child:
                              "${(100 - ((finalPrice / basePrice) * 100)).toDoubleStringAsFixed(digit: 0)}%"
                                  .text
                                  .size(6)
                                  .color(colorName.darkRed)
                                  .make()
                                  .pSymmetric(v: 2, h: 6))
                      .color(colorName.darkRed.withOpacity(.2))
                      .withRounded(value: 6)
                      .make(),
                  6.widthBox,
                  NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
                      .format(basePrice)
                      .text
                      .size(6)
                      .lineThrough
                      .color(colorName.grey)
                      .make(),
                ],
              ),
              4.heightBox,
              NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
                  .format(finalPrice)
                  .text
                  .size(18)
                  .bold
                  .color(colorName.black)
                  .make(),
            ],
            crossAlignment: CrossAxisAlignment.start,
          );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is GetCartIsSuccess) {
          int resultBase = state.items
              .map((item) => item.basePrice!)
              .reduce((value, current) => value + current);
          int resultFinal = state.items
              .map((item) => item.finalPrice!)
              .reduce((value, current) => value + current);
          return HStack([
            _buildPrice(resultBase, resultFinal).expand(),
            MyButton(
              title: 'Bayar',
              onPressed: () {
                BlocProvider.of<GetCartCubit>(context).removeAllCart();
              },
              color: colorName.pink,
            ),
          ])
              .p24()
              .box
              .withShadow([
                const BoxShadow(
                    blurRadius: 20,
                    color: colorName.lightGrey,
                    offset: Offset(0, -10))
              ])
              .white
              .make();
        }
        return 0.widthBox;
      },
    );
  }
}
