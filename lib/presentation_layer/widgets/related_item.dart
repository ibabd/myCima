// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/global_config.dart' as globals;
import 'package:mycima_app_last/presentation_layer/screens/filmDetails.dart';


class RelatedItem extends StatelessWidget {
  final CategoryModel categoryModel;
  const RelatedItem({Key? key,required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        // Navigator.pushNamed(context, DetailsScreen.route,arguments: CategoryModel(
        //   title: categoryModel.title
        // ));
        globals.isSearies? Navigator.pushNamed(context, Details.route): Navigator.pushNamed(context, Details.route);
        // Get.to( DetailsScreen());
      },
      child: Container(
        width: 200,
        height: 200,
        margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(8),
        ),
        child:  GridTile(
          child: Container(
            color:const Color.fromRGBO(14, 19, 49, 1),
            child: categoryModel.thumbnailUrl!.isNotEmpty ?
            //عقبال مالصورة تيجى يعرض الlooding
            FadeInImage.assetNetwork(
              width: double.infinity,
              height: 200,
              placeholder: 'assets/images/yellow_progress.gif',
              image:categoryModel.thumbnailUrl!,
              fit: BoxFit.cover,

            ):Image.asset('assets/images/svg.png'),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(categoryModel.title!,style: const TextStyle(
              height: 1.3,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

