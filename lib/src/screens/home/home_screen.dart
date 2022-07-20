part of '../screens.dart';

class HomeScreen extends StatelessWidget {
  final c = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(constName.appName,
          showLogo: true, subTitle: 'E-Shop', showCart: true),
      body: RefreshIndicator(
        color: colorName.pink,
        onRefresh: () async => context.read<ListItemCubit>().fetchListItems(),
        child: BlocBuilder<ListItemCubit, ListItemState>(
          builder: (context, state) {
            if (state is ListItemIsSuccess) {
              return StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: state.items
                    .map((e) => MyItemCard(
                          item: e,
                          onTap: () => c.openDetail(e),
                        ))
                    .toList(),
              ).p24().scrollVertical(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()));
            }
            if (state is ListItemIsLoading) {
              return const MyProductShimmer(isGrid: true);
            }
            return 0.heightBox;
          },
        ),
      ),
    );
  }
}
