import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_duplicate/data/models/wellness_model.dart';
import 'package:payuung_pribadi_duplicate/observer.dart';
import 'package:payuung_pribadi_duplicate/presentation/cubit/profile_cubit.dart';
import 'package:payuung_pribadi_duplicate/presentation/cubit/wellness_cubit.dart';
import 'package:payuung_pribadi_duplicate/presentation/pages/home_page.dart';
import 'package:payuung_pribadi_duplicate/presentation/pages/profile_page.dart';
import 'package:payuung_pribadi_duplicate/services/styles.dart';

void main() {
  Bloc.observer = const Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payuung pribadi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) =>
            BlocProvider<WellnessCubit>(
              create: (BuildContext context) =>
                  WellnessCubit()..addWellness(dummyWellness),
              child: const HomePage(),
            ),
        ProfilePage.routeName: (BuildContext context) =>
            BlocProvider<ProfileCubit>(
              create: (BuildContext context) => ProfileCubit()..init(),
              child: const ProfilePage(),
            ),
      },
    );
  }
}
