import 'package:flutter/material.dart';
import 'package:mycima_app_last/dataLayer/models/searchModel.dart';


class SearchItem extends StatelessWidget {
  final Posts posts;
  const SearchItem({Key? key,required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(categoryModel: ,)));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(8),
        ),
        child:  GridTile(
          child: Container(
            color:const Color.fromRGBO(14, 19, 49, 1),
            child: posts.thumbnailUrl!.isNotEmpty ?
            //عقبال مالصورة تيجى يعرض الlooding
            FadeInImage.assetNetwork(
              width: double.infinity,
              height: double.infinity,
              placeholder: 'assets/images/yellow_progress.gif',
              image:posts.thumbnailUrl!,
              fit: BoxFit.cover,

            ):Image.asset('assets/images/svg.png'),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(posts.title!,style: const TextStyle(
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

