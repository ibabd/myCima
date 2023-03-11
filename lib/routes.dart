import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycima_app_last/business_layer/my_cima_cubit.dart';
import 'package:mycima_app_last/constant.dart';
import 'package:mycima_app_last/dataLayer/data_repository/repository.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/dataLayer/services/services_data.dart';
import 'package:mycima_app_last/presentation_layer/screens/filmDetails.dart';
import 'package:mycima_app_last/presentation_layer/screens/homePage.dart';
import 'package:mycima_app_last/presentation_layer/screens/seariesDetails.dart';

class AppRouter{
  late DataRepository dataRepository;
  late MyCimaCubit cimaCubit;
  AppRouter(){
    dataRepository=DataRepository(CimaApi());
    cimaCubit=MyCimaCubit(dataRepository);
  }

  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeScreen:
        return MaterialPageRoute(builder: (_)=>BlocProvider(
          create: (BuildContext context)=>
          cimaCubit,
          child: const HomePage(),
        ),
        );
      case details:
      //انا عاوز اباصى الداتا او الاوبجكت بتاع الcharacter الى بيعرض كل item فى شاشه التفاصيل
      // دة الاوبجكت بتاع الى المفروض اباصيه لما اجى اروح ل details screen
        final categoryModel=settings.arguments as CategoryModel;
        return MaterialPageRoute(builder: (_)=>
            BlocProvider(
                create: (BuildContext context)=>
                //هنا بنشئ كيوبت جديد مختلف عن الكيوبت ال فوق بداتا مختلفه
                MyCimaCubit(dataRepository),
                child: Details(categoryModel: categoryModel,)));
      case details1:
      //انا عاوز اباصى الداتا او الاوبجكت بتاع الcharacter الى بيعرض كل item فى شاشه التفاصيل
      // دة الاوبجكت بتاع الى المفروض اباصيه لما اجى اروح ل details screen
        final categoryModel=settings.arguments as CategoryModel;
        // final seariesModel=settings.arguments as SeariesModel;
        return MaterialPageRoute(builder: (_)=>
            BlocProvider(
                create: (BuildContext context)=>
                //هنا بنشئ كيوبت جديد مختلف عن الكيوبت ال فوق بداتا مختلفه
                MyCimaCubit(dataRepository),
                child: SeariesInfo(categoryModel: categoryModel, )));
    }
    return null;
  }
}