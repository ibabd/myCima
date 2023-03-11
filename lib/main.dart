import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mycima_app_last/business_layer/my_cima_cubit.dart';
import 'package:mycima_app_last/dataLayer/data_repository/repository.dart';
import 'package:mycima_app_last/dataLayer/services/services_data.dart';
import 'package:mycima_app_last/routes.dart';


void main() {
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key,required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // final CategoryModel categoryModel;
    return BlocProvider(
      create: (_)=>MyCimaCubit(DataRepository(CimaApi())),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('ar', 'en'),
        //home:const HomeScreen(),
        // initialRoute: '/homePage',
        // routes: {
        //   '/homePage':(context)=>const HomePage(),
        //  //  '/detailsScreen':(context)=> DetailsScreen(),
        //  // '/detailsScreen1':(context)=> DetailsScreenOne(categoryModel: categoryModel),
        // },
      ),
      //const HomeScreen(),
    );
  }
}