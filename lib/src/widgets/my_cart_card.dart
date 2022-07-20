part of 'widgets.dart';

class MyCartCard extends StatelessWidget {
  final ItemModel item;
  final Function()? onTap;

  const MyCartCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                BlocProvider.of<AddCartCubit>(context).removeFromCart(item.id!);
              },
              backgroundColor: colorName.darkRed,
              foregroundColor: Colors.white,
              icon: Icons.delete_outlined,
              label: 'Delete',
            ),
          ],
        ),
        child: Bounceable(
          onTap: onTap,
          child: VStack([
            HStack([
              Hero(
                  tag: item.id!,
                  child: Image.network(item.url!,
                      height: context.percentWidth * 10,
                      width: context.percentWidth * 10,
                      loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return VxShimmer(child: child);
                  })),
              16.widthBox,
              item.title!.text.make().expand(),
            ]),
            8.heightBox,
            _buildPrice().objectCenterRight()
          ])
              .p16()
              .box
              .white
              .withRounded(value: 10)
              .border(color: colorName.lightGrey)
              .make(),
        ));
  }

  Widget _buildPrice() {
    return (item.basePrice == item.finalPrice)
        ? NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
            .format(item.finalPrice)
            .text
            .size(14)
            .bold
            .color(colorName.black)
            .make()
        : VStack(
            [
              HStack(
                [
                  VxBox(
                          child:
                              "${(100 - ((item.finalPrice! / item.basePrice!) * 100)).toDoubleStringAsFixed(digit: 0)}%"
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
                      .format(item.basePrice)
                      .text
                      .size(6)
                      .lineThrough
                      .color(colorName.grey)
                      .make(),
                ],
              ),
              4.heightBox,
              NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
                  .format(item.finalPrice)
                  .text
                  .size(14)
                  .bold
                  .color(colorName.black)
                  .make(),
            ],
            crossAlignment: CrossAxisAlignment.end,
          );
  }
}
