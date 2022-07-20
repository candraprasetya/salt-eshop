import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_test/src/cubit/cubits.dart';
import 'package:salt_test/src/utilities/utilities.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ListItemCubit()),
        BlocProvider(create: (context) => AddCartCubit()),
        BlocProvider(create: (context) => GetCartCubit()),
        BlocProvider(create: (context) => DetailCubit()),
        BlocProvider(create: (context) => CheckCartCubit()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(),
          primaryColor: colorName.pink,
        ),
        getPages: pages,
        title: 'SALT Test',
        initialRoute: routeName.home,
      ),
    );
  }
}
