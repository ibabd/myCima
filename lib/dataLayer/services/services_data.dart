
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:mycima_app_last/dataLayer/models/detailsModel.dart';
import 'package:mycima_app_last/dataLayer/models/drawerModel.dart';
import 'package:mycima_app_last/dataLayer/models/filterModel.dart';
import 'package:mycima_app_last/global_config.dart' as globals;

class CimaApi{

  static const fetchLimit=15;

  Future<List<CategoryModel>>getDataRelated({ required String id})async{
    String url="https://mycima.buzz:2096/appweb/related-posts/$id/";
    var response = (await http.get(Uri.parse(url))) ;
    if (kDebugMode) {
      print(response.body.toString());
    }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((data) => CategoryModel.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
  Future<List<FilterModel>>getFilterData()async{
    String url="https://mycima.buzz:2096/appweb/filters/";
    var response = (await http.get(Uri.parse(url))) ;
    if (kDebugMode) {
      print(response.body.toString());
    }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((data) => FilterModel.fromJson(data)).toList();

    }else{
      throw Exception('error');
    }
  }

  Future<List<MenuModel>>getDataMenu()async{
    String url="https://mycima.buzz:2096/appweb/menus";
    var response = (await http.get(Uri.parse(url))) ;
    // if (kDebugMode) {
    //   print(response.body.toString());
    // }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      // return data;
      return data.map((data) => MenuModel.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
  Future<List<dynamic>>getCategoryItem({required String id})async{
    globals.categoryId=id;
    String url="https://mycima.buzz:2096/appweb/posts/category|$id/";
    // String url="https://mycima.fun/appweb/posts/archived_category[$id]/";
    if (kDebugMode) {
      print (url);
    }
    var response = (await http.get(Uri.parse(url))) ;
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      return data;
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
  Future<DetailsModel>getDetailsCategory({String id="413323"})async{
    String url="https://mycima.is/appweb/post/$id/";
    if (kDebugMode) {
      print (url);
    }
    var response = (await http.get(Uri.parse(url))) ;
    if (kDebugMode) {
      print(response.statusCode);
    }
    if(response.statusCode==200){
      if (kDebugMode) {

        print(response.body);
      }
      return  DetailsModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('error');
    }
  }
  // Future<List<CategoryModel>>getSubCategory({String id="30624"})async{
  //   String url="https://mycima.fun/appweb/posts/archived_category[$id]/";
  //   if (kDebugMode) {
  //     print (url);
  //   }
  //   var response = (await http.get(Uri.parse(url))) ;
  //   if(response.statusCode==200){
  //     List data=jsonDecode(response.body);
  //     return data.map((e) => CategoryModel.fromJson(e)).toList();
  //     //return jsonResponse.map((data) => Data.fromJson(data)).toList();
  //   }else{
  //     throw Exception('error');
  //   }
  // }
  // Future<List<DetailsModels1>>getDetailsCategory({String id="413323"})async{
  //   String url="https://mycima.is/appweb/post/[$id]/";
  //   if (kDebugMode) {
  //     print (url);
  //   }
  //   var response = (await http.get(Uri.parse(url))) ;
  //   if(response.statusCode==200){
  //     List data=jsonDecode(response.body);
  //     return data.map((e) => DetailsModels1.fromJson(e)).toList();
  //    // List<DetailsModels1>data=DetailsModels1.fromJson(jsonDecode(response.body)).toList();
  //     //return jsonResponse.map((data) => Data.fromJson(data)).toList();
  //   }else{
  //     throw Exception('error');
  //   }
  // }

  Future<List<dynamic>?> getSearch({required String title})async{
    if(title.trim().isNotEmpty){
      String url="https://mycima.buzz:2096/appweb/search/$title";
      if (kDebugMode) {
        print (url);
      }
      var response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        List data=jsonDecode(response.body)["posts"];
        return data;
        // return data.map((e) => SearchModel.fromJson(e)).toList();
        //return jsonResponse.map((data) => Data.fromJson(data)).toList();
      }else{
        throw Exception('error');
      }
    }else{
      if (kDebugMode) {
        print(title) ;
      }
      return null;
    }
  }
  Future<List<CategoryModel>>getEpisodsSearies({required String termId})async{
    globals.termId=termId;
    String url="https://mycima.buzz:2096/appweb/posts/series|$termId/";
    if (kDebugMode) {
      print(url);
    }
    var response=(await http.get(Uri.parse(url)));
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      return data.map((e) =>CategoryModel.fromJson(e)).toList();
    }else{
      throw Exception('error');
    }
  }

// Future<List<SearchModel>> getSearch({required String title})async{
//
//   String url="https://mycima.fun/appweb/search/$title/";
//   if (kDebugMode) {
//     print (url);
//   }
//   var response=await http.get(Uri.parse(url));
//   if(response.statusCode==200){
//     List data=jsonDecode(response.body);
//    // return data;
//      return data.map((e) => SearchModel.fromJson(e)).toList();
//     //return jsonResponse.map((data) => Data.fromJson(data)).toList();
//   }else{
//     throw Exception('error');
//   }
// }




  //https://mycima.buzz/appweb/posts/category|12/{release-year,any-name}|{5365,1234}/

 /*
  Future<List<dynamic>> getFilterDataItem({
    required String categoryId,
    required String filterName,
    required int termIds,


  }) async {
    globals.categoryId = categoryId;
    globals.filterName = filterName;
    globals.termIds = termIds;

    String url="https://mycima.buzz/appweb/posts/category|$categoryId/$filterName|$termIds/";
    if (kDebugMode) {
      print (url);
    }
    var response = (await http.get(Uri.parse(url))) ;
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      return data;
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
}
*/

Future<List<dynamic>> getFilterDataItem({
  required String categoryId,
  required String filterName,
  required int termIds,
  required int page,


}) async {
  globals.categoryId = categoryId;
  globals.filterName = filterName;
  globals.termIds = termIds;
  globals.page=page;
  //https://mycima.buzz/appweb/posts?page=3&limit=20/category|12/genre|2/

  String url="https://mycima.buzz/appweb/posts?page=$page/category|$categoryId/$filterName|$termIds/";
  if (kDebugMode) {
    print (url);
  }
  var response = (await http.get(Uri.parse(url))) ;
  if(response.statusCode==200){
    List data=jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
    }
    return data;
    //return jsonResponse.map((data) => Data.fromJson(data)).toList();
  }else{
    throw Exception('error');
  }
}
}