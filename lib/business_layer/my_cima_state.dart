part of 'my_cima_cubit.dart';

@immutable
abstract class MyCimaState {}

class MyCimaInitial extends MyCimaState {}
class CategoryLoaded extends MyCimaState{
  //فى حاله البيانات اتحملت الكونستركتور هيكون فية ليست من البيانات
  final List<CategoryModel>categories;

  CategoryLoaded(this.categories);
}
class SearchItemLoaded extends MyCimaState{
  //فى حاله البيانات اتحملت الكونستركتور هيكون فية ليست من البيانات
  final List<Posts>searchItems;

  SearchItemLoaded(this.searchItems);
}
class CategoryFilterItemLoaded extends MyCimaState{
  //فى حاله البيانات اتحملت الكونستركتور هيكون فية ليست من البيانات
  final List<CategoryModel>categories;

  CategoryFilterItemLoaded(this.categories);
}
// class DataFilterLoaded extends MyCimaState{
//   final List<CategoryModel> categoryData;
//   DataFilterLoaded(this.categoryData);
// }
// class DataFilterLoading extends MyCimaState{
//   final List<CategoryModel> oldCategoryData;
//   final bool isFirstFetch;
//   DataFilterLoading(this.oldCategoryData,{this.isFirstFetch=false});
// }
