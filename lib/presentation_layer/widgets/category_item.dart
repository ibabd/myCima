import 'package:flutter/material.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/global_config.dart' as globals;
import 'package:mycima_app_last/presentation_layer/screens/filmDetails.dart';
import 'package:mycima_app_last/presentation_layer/screens/seariesDetails.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryItem({Key? key,required this.categoryModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var detailsModels1=DataApi().getDetailsCategory(id: "${categoryModel.id}");
    return  Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  InkWell(
        onTap: (){
          globals.isSearies? Navigator.pushNamed(
              context, SeariesInfo.route,arguments:categoryModel):
          Navigator.pushNamed(
              context, Details.route,arguments:categoryModel);
        },
        child: GridTile(
          child: Container(
            color:const Color.fromRGBO(14, 19, 49, 1),
            child: categoryModel.thumbnailUrl!.isNotEmpty ?
            FadeInImage.assetNetwork(
              width: double.infinity,
              height: double.infinity,
              placeholder: 'assets/images/loading.gif',
              image: globals.isSearies?categoryModel.thumbnailUrl.toString().replaceAll(
                  categoryModel.thumbnailUrl.toString().substring(
                      categoryModel.thumbnailUrl!.indexOf(
                          ':', categoryModel.thumbnailUrl!.indexOf(':') + 1),
                      categoryModel.thumbnailUrl!.indexOf(r'/wp')),
                  "")
                  :categoryModel.thumbnailUrl!,
              //categoryModel.thumbnailUrl.toString(),
              fit: BoxFit.cover,
            )
                :Image.asset('assets/images/zoma.jpg'),
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

