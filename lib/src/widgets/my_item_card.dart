part of 'widgets.dart';

class MyItemCard extends StatelessWidget {
  final ItemModel item;
  final Function()? onTap;

  const MyItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: VxBox(
                child: VStack([
          Hero(
              tag: item.id!,
              child: Image.network(item.url!,
                  loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return VxShimmer(child: child);
              })),
          VStack([
            8.heightBox,
            _buildTitle(),
            4.heightBox,
            _buildPrice(),
            4.heightBox,
            _buildCity(),
          ]).p8()
        ]))
            .white
            .withRounded(value: 10)
            .border(
              color: colorName.lightGrey,
            )
            .make(),
      ),
    );
  }

  Widget _buildTitle() {
    return item.title!.text
        .size(12)
        .maxLines(2)
        .ellipsis
        .color(colorName.black)
        .make();
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
        : VStack([
            NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
                .format(item.finalPrice)
                .text
                .size(14)
                .bold
                .color(colorName.black)
                .make(),
            4.heightBox,
            HStack([
              VxBox(
                      child:
                          "${(100 - ((item.finalPrice! / item.basePrice!) * 100)).toDoubleStringAsFixed(digit: 0)}%"
                              .text
                              .size(8)
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
                  .size(8)
                  .lineThrough
                  .color(colorName.grey)
                  .make(),
            ])
          ]);
  }

  Widget _buildCity() {
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
    );
  }
}
