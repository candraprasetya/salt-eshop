part of 'widgets.dart';

class MyProductShimmer extends StatelessWidget {
  final bool isGrid;

  const MyProductShimmer({super.key, this.isGrid = false});

  @override
  Widget build(BuildContext context) {
    return isGrid
        ? StaggeredGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: List.generate(
                16,
                (index) => VxBox()
                    .color(Colors.white)
                    .size(context.percentHeight * 60,
                        context.percentHeight * Random().nextInt(60))
                    .withRounded(value: 10)
                    .make()
                    .shimmer()),
          ).p24()
        : ListView.separated(
            separatorBuilder: (context, index) => 16.heightBox,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            itemCount: 16,
            itemBuilder: (context, index) {
              return VxBox()
                  .color(Colors.white)
                  .size(context.screenWidth, context.percentHeight * 12)
                  .withRounded(value: 10)
                  .make()
                  .shimmer();
            },
          ).whFull(context).p24();
  }
}
