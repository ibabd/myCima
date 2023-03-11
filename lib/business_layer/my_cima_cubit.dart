import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mycima_app_last/dataLayer/data_repository/repository.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/dataLayer/models/drawerModel.dart';
import 'package:mycima_app_last/dataLayer/models/searchModel.dart';
part 'my_cima_state.dart';

class MyCimaCubit extends Cubit<MyCimaState> {
  final DataRepository dataRepository;
  List<CategoryModel>myCategories=[];
  List<Posts>myShearches=[];
  List<MenuModel>myMenus=[];
  MenuModel menuModel=MenuModel();
  int page=1;
  // void loadCategoryData(){
  //   if(state is DataFilterLoading) return;
  //   final currentState=state;
  //   var oldCategoryData=<CategoryModel>[];
  //   if(currentState is DataFilterLoaded){
  //     oldCategoryData=currentState.categoryData;
  //   }
  //   emit(DataFilterLoading(oldCategoryData,isFirstFetch: page==1));
  //   dataRepository.fetchAllCategoryItemFilter(globals.categoryId, globals.filterName, globals.termIds, page).then((newCategoryData){
  //     page++;
  //     final categoryDatas=(state as DataFilterLoading).oldCategoryData;
  //     categoryDatas.addAll(newCategoryData);
  //     emit(DataFilterLoaded(categoryDatas));
  //   });
  // }
  MyCimaCubit(this.dataRepository) : super(MyCimaInitial());
  List<CategoryModel>getCategoryItems(String id){
    dataRepository.fetchAllCategory(id).then((categories) {
      emit(CategoryLoaded(categories));
      myCategories=categories;
    });
    return myCategories;
  }
  // List<CategoryModel>getCategoryFilterItems(String id,String filterName, int termIds ,int page ){
  //   dataRepository.fetchAllCategoryItemFilter(id,filterName,termIds,page).then((categories) {
  //     emit(CategoryLoaded(categories));
  //     myCategories=categories;
  //   });
  //   return myCategories;
  // }
  List<CategoryModel>getCategoryFilterItems(String id,String filterName, int termIds,int page){
    dataRepository.fetchAllCategoryItemFilter(id,filterName,termIds,page).then((categories) {
      emit(CategoryLoaded(categories));
      myCategories=categories;
    });
    return myCategories;
  }
  Future<List<Posts>> getSearchItem(String title)async{
    await dataRepository.fetchDataSearch(title).then((items) {
      myShearches=items;
      emit(SearchItemLoaded(items));
    });
    return myShearches;
  }

}
