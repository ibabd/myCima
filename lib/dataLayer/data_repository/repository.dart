import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/dataLayer/models/drawerModel.dart';
import 'package:mycima_app_last/dataLayer/models/searchModel.dart';
import 'package:mycima_app_last/dataLayer/services/services_data.dart';

class DataRepository{
  final CimaApi cimaApi;
  MenuModel menuModel=MenuModel();
  DataRepository(this.cimaApi);

  Future<List<CategoryModel>> fetchAllCategory(String id)async{

    final categories=await cimaApi.getCategoryItem(id: id);
    return categories.map((category) => CategoryModel.fromJson(category)).toList();
  }
  Future<List<CategoryModel>> fetchAllCategoryItemFilter(
      String id, String filterName, int termId,
      int page
      ) async {
    final categories = await cimaApi.getFilterDataItem(
      categoryId: id, filterName: filterName, termIds: termId,page: page);
    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }
  // Future<List<MenuModel>> fetchDataMenu()async{
  //   final dataMenus=await cimaApi.getDataMenu();
  //   return dataMenus.map((category) => MenuModel.fromJson(category)).toList();
  // }
  // Future<List<FilterModel>> fetchDataFiltration()async{
  //   final filters=await cimaApi.getFilterData();
  //   return filters.map((filter) => FilterModel.fromJson(filter)).toList();
  // }
  // Future<List<CategoryModel>> fetchCategoryItem(String id)async{
  //   final categories=await cimaApi.getCategory(
  //       id: id
  //   );
  //   return categories.map((category) => CategoryModel.fromJson(category)).toList();
  // }
  // Future<List<DetailsModels1>> fetchDetailsItem(String id)async{
  //   final details=await dataApi.getDetailsCategory(
  //       id: id
  //   );
  //   return details.map((detail) => DetailsModels1.fromJson(detail)).toList();
  // }
  Future<List<Posts>> fetchDataSearch(String title)async{
    final searchList=await cimaApi.getSearch(
        title: title
    );
    return searchList!.map((search) => Posts.fromJson(search)).toList();
  }
}