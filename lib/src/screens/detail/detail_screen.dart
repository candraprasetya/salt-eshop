part of '../screens.dart';

class DetailScreen extends StatelessWidget {
  final c = Get.put(DetailController());
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        builder: (controller) => Scaffold(
              appBar: myAppBar(controller.title, showBack: true),
              bottomNavigationBar: _buildBottomNav(context),
              body: BlocBuilder<DetailCubit, DetailState>(
                builder: (context, state) {
                  if (state is DetailIsSuccess) {
                    ItemModel item = state.item;
                    controller.changeTitle(item.title!);
                    BlocProvider.of<CheckCartCubit>(Get.context!)
                        .checkCart(item.id!);

                    return VStack([
                      Hero(tag: item.id!, child: Image.network(item.url!)),
                      16.heightBox,
                      _buildPrice(item),
                      _buildTitle(item).py8(),
                      _buildCity(item),
                      _sold(item).py8(),
                      Divider(
                        color: Colors.grey[200]!,
                      ).pSymmetric(h: 24),
                      _description(item).py16(),
                    ]).scrollVertical(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()));
                  }

                  return 0.heightBox;
                },
              ),
            ));
  }

  //INLINE WIDGET

  Widget _buildBottomNav(BuildContext context) {
    return BlocConsumer<AddCartCubit, AddCartState>(
      listener: (context, state) {
        if (state is AddCartIsSuccess) {
          bool isAvail =
              context.read<CheckCartCubit>().state is CheckCartIsNotAvailable;
          Get.snackbar('', '',
              titleText: 0.heightBox,
              messageText: HStack([
                Lottie.asset(
                    isAvail ? animationFiles.delete : animationFiles.saved,
                    height: isAvail
                        ? context.percentWidth * 10
                        : context.percentWidth * 10,
                    width: isAvail
                        ? context.percentWidth * 10
                        : context.percentWidth * 10),
                16.widthBox,
                (isAvail
                        ? 'Berhasil Menghapus Dari Keranjang'
                        : 'Berhasil Memasukkan Ke Keranjang')
                    .text
                    .make()
              ]));
        }
      },
      builder: (context, state) {
        return BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state is DetailIsSuccess) {
              return BlocBuilder<CheckCartCubit, CheckCartState>(
                builder: (context, checkState) {
                  if (checkState is CheckCartIsNotAvailable) {
                    return MyButton(
                      onPressed: () {
                        BlocProvider.of<AddCartCubit>(context)
                            .addToCart(state.item);
                      },
                      title: 'Add To Cart',
                      color: colorName.pink,
                    );
                  } else {
                    return MyButton(
                      onPressed: () {
                        BlocProvider.of<AddCartCubit>(context)
                            .removeFromCart(state.item.id!);
                      },
                      title: 'Remove From Cart',
                      color: colorName.darkRed,
                    );
                  }
                },
              )
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
            return MyButton(
              onPressed: () {},
              title: 'Loading....',
              color: colorName.grey,
            ).p16();
          },
        );
      },
    );
  }

  Widget _buildTitle(ItemModel item) {
    return item.title!.text
        .size(14)
        .color(colorName.black)
        .make()
        .pSymmetric(h: 24);
  }

  Widget _sold(ItemModel item) {
    return "Terjual ${item.sold}"
        .text
        .size(12)
        .bold
        .color(colorName.black)
        .make()
        .pSymmetric(h: 24);
  }

  Widget _description(ItemModel item) {
    return item.description!.text
        .size(12)
        .color(colorName.grey)
        .make()
        .pSymmetric(h: 24);
  }

  Widget _buildPrice(ItemModel item) {
    return (item.basePrice == item.finalPrice)
        ? NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
            .format(item.finalPrice)
            .text
            .size(20)
            .bold
            .color(colorName.black)
            .make()
            .pSymmetric(h: 24)
        : VStack([
            NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
                .format(item.finalPrice)
                .text
                .size(20)
                .bold
                .color(colorName.black)
                .make(),
            4.heightBox,
            HStack([
              VxBox(
                      child:
                          "${(100 - ((item.finalPrice! / item.basePrice!) * 100)).toDoubleStringAsFixed(digit: 0)}%"
                              .text
                              .size(12)
                              .color(colorName.darkRed)
                              .make()
                              .pSymmetric(v: 2, h: 6))
                  .color(colorName.darkRed.withOpacity(.2))
                  .withRounded(value: 6)
                  .make(),
              6.widthBox,
              NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
                  .format(item.basePrice)
                  .text
                  .size(12)
                  .lineThrough
                  .color(colorName.grey)
                  .make(),
            ])
          ]).pSymmetric(h: 24);
  }

  Widget _buildCity(ItemModel item) {
    return HStack(
      [
        const Icon(
          Icons.verified_user_rounded,
          color: colorName.pink,
          size: 14,
        ),
        4.widthBox,
        item.city!.text.size(8).color(colorName.black).make(),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).pSymmetric(h: 24);
  }
}
