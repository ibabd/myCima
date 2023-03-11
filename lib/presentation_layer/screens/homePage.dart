
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:mycima_app_last/business_layer/my_cima_cubit.dart';
import 'package:mycima_app_last/constant.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/dataLayer/models/drawerModel.dart';
import 'package:mycima_app_last/dataLayer/models/filterModel.dart';
import 'package:mycima_app_last/dataLayer/models/searchModel.dart';
import 'package:mycima_app_last/dataLayer/services/services_data.dart';
import 'package:mycima_app_last/presentation_layer/screens/filmDetails.dart';
import 'package:mycima_app_last/presentation_layer/widgets/category_item.dart';
import 'package:mycima_app_last/presentation_layer/widgets/search_item.dart';
import 'package:mycima_app_last/global_config.dart' as globals;

class HomePage extends StatefulWidget {
  static const route = '/';
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController myController = TextEditingController();
  var isExpanded = false;
  bool selected = false;
  //int selectedIndex=1;
  List<int> expandedExpansionTiles = [];
  // late List<Character> allCharacters;
  CimaApi cimaApi = CimaApi();
  late List<CategoryModel> categoryData;
  late List<CategoryModel> filterData;
  CategoryModel categoryModel = CategoryModel();
  MenuModel menuModel = MenuModel();
  FilterModel filterModel = FilterModel();
  Terms terms = Terms();
  late List<MenuModel> menuData;
  late List<Posts> searchResult;
  late List<CategoryModel> searchedForCategory;
  bool isSearched = false;
  late List<FilterModel> filters;
  bool isLoading=false;

  final _searchedTextController = TextEditingController();
  List<Terms> _selectedTerms = [];
  final ScrollController _scrollController=ScrollController();
  // void setupScrollController(context){
  //   _scrollController.addListener(() {
  //     if(_scrollController.position.atEdge){
  //       if(_scrollController.position.pixels !=0){
  //         BlocProvider.of<MyCimaCubit>(context).loadCategoryData();
  //       }
  //     }
  //   });
  // }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchedTextController,
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
        hintText: 'films or series ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style: const TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (searchedCategory) {
        //الفانكشن دى هتاخد الى حاجه الى ببحث عنها وتجيب لية كل العناصر الى بتبدا بالحرف دة
        addSearchedForItemsToSearchedList(searchedCategory);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String category) {
    //دى ليسته عاوز احط فيها الحاجات الى عاوز املاها
    //where is meaning condition such as if
    searchedForCategory = categoryData
        .where((character) => character.title!.toLowerCase().contains(category))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (isSearched) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ))
      ];
    }
  }

  void _startSearch() {
    // this is mean navigate to another screen or provide stack
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearched = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearched = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchedTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'MYCIMA',
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    categoryData = BlocProvider.of<MyCimaCubit>(context)
        .getCategoryItems(menuModel.id ?? "38365");
    if (kDebugMode) {
      print(categoryData);
    }
    // filters=BlocProvider.of<CimaCubit>(context).getFilter() ;
    // if (kDebugMode) {
    //   print(categoryData);
    // }
    // filterData =BlocProvider.of<CimaCubit>(context).getFilterItems(menuModel.id ?? "38365",filterModel.taxonomy??"genre",terms.termId!);
    // if (kDebugMode) {
    //   print(categoryData);
    // }
    super.initState();
  }
// @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    // setupScrollController(context);
    // BlocProvider.of<MyCimaCubit>(context).loadCategoryData();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        title: isSearched ? _buildSearchField() : _buildAppBarTitle(),
        centerTitle: true,
        actions: _buildAppBarActions(),
      ),
      drawer: buildDrawer(),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocConsumer<MyCimaCubit, MyCimaState>(
              builder: (BuildContext context, state) {
                var cubit = BlocProvider.of<MyCimaCubit>(context);
                return cubit.myShearches.isNotEmpty
                    ? buildSerchBlocWidget()
                    : buildBlocWidget();
              },
              listener: (BuildContext context, Object? state) {},
            );
          } else {
            return buildNoInternet();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }

  Widget buildNoInternet() {
    return Center(
      child: Container(
        color: const Color.fromRGBO(14, 19, 49, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'can\t connect ... check The Internet ',
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
            Image.asset('assets/images/No Internet.png')
          ],
        ),
      ),
    );
  }

  Widget buildSerchBlocWidget() {
    return BlocBuilder<MyCimaCubit, MyCimaState>(builder: (context, state) {
      if (state is SearchItemLoaded) {
        searchResult = (state).searchItems;
        return buildSearchList();
        // loading // كيف ؟
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MyCimaCubit,MyCimaState>(builder: (context, state) {
      //انا عند state وحدة اسمهاcharactersLoaded
      if (state is CategoryLoaded) {
        categoryData = (state).categories;
        return buildLoadedList();
      }
      // else if(state is FilterItemLoaded){
      //   filterData = (state).categoryItems;
      //   return buildLoadedList();
      // }
      else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildSearchList() {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromRGBO(14, 19, 49, 1),
        child: Column(
          children: [
            buildsearch(),
          ],
        ),
      ),
    );
  }

  Widget buildLoadedList() {
    return SingleChildScrollView(
      child: Stack(
        // scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(top: 70),
            color: const Color.fromRGBO(14, 19, 49, 1),
            child: Column(
              children: [
                buildCategoryList(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [buildFilterData1()],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _searchedTextController.text.isEmpty
          ? categoryData.length
          : searchedForCategory.length,
      itemBuilder: (context, index) {
        return CategoryItem(
          categoryModel: _searchedTextController.text.isEmpty
              ? categoryData[index]
              : searchedForCategory[index],
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    );
  }

  Widget buildsearch() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(
                      categoryModel: categoryData[index],
                    )));
          },
          child: SearchItem(
            posts: searchResult[index],
          ),
        );
      },
    );
  }

  Widget buildDrawer() {
    return Drawer(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(35, 40, 72, 1),
                ),
                child: BlocConsumer<MyCimaCubit, MyCimaState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    var cubit = BlocProvider.of<MyCimaCubit>(context);
                    return TextFormField(
                      controller: myController,
                      onFieldSubmitted: (text) async {
                        if (text.trim().isNotEmpty) {
                          await cubit.getSearchItem(text.trim().toLowerCase());
                          Navigator.pop(context);
                        }
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(35, 40, 72, 1),
                            ),
                          ),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                          hintText: '  إبحث فى ماي سيما',
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              // if (myController.text.trim().isNotEmpty) {
                              //   await cubit
                              //       .getSearchItem(myController.text.trim().toLowerCase());
                              //   Navigator.pop(context);
                              // }
                            },
                          )),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    selected=true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:selected?Colors.grey :
                    const Color.fromRGBO(14, 19, 49, 1),
                    //const Color.fromRGBO(14, 19, 49, 1),
                  ),
                  height: 60,
                  width: double.infinity,
                  child: ListTile(
                    onTap: () {
                      // setState(() {
                      //   selected=true;
                      // });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    title: const Text(
                      'الصفحه الرئيسية',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.home,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<MenuModel>>(
                  future: CimaApi().getDataMenu(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<MenuModel>;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            //height: 70,
                            margin: const EdgeInsets.only(
                                top: 2, left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: const Color.fromRGBO(35, 40, 72, 0.1)
                            ),
                            child: BlocConsumer<MyCimaCubit,MyCimaState>(
                              listener: (context, state) {
                                // `TODO: implement listener
                              },
                              builder: (context, state) {
                                var cubit = BlocProvider.of<MyCimaCubit>(context);
                                return ExpansionTile(
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  childrenPadding:
                                  const EdgeInsets.only(right: 15),
                                  trailing: data[index].children!.isNotEmpty
                                      ? null
                                      : const Text(""),
                                  onExpansionChanged: (value) {
                                    if (value) {
                                      setState(() {
                                        expandedExpansionTiles.add(index);
                                      });
                                    } else {
                                      setState(() {
                                        expandedExpansionTiles.remove(index);
                                      });
                                    }
                                  },
                                  tilePadding: EdgeInsets.zero,
                                  title: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(icons[index],
                                            color: (expandedExpansionTiles
                                                .contains(index))
                                                ? iconsColors[index]
                                                : Colors.black),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            globals.isSearies =
                                            (index == 1) ? true : false;
                                            cubit.getCategoryItems(
                                                "${data[index].id}");
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "${data[index].name}",
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxHeight: 400, minHeight: 10.0),
                                      child: ListView.builder(
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        //scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        //physics: const BouncingScrollPhysics(),
                                        itemCount: data[index].children!.length,
                                        itemBuilder: (context, index2) {
                                          final name = data[index]
                                              .children![index2]
                                              .name;
                                          return GestureDetector(
                                            onTap: () {
                                              globals.isSearies =
                                              (index == 1) ? true : false;
                                              cubit.getCategoryItems(
                                                  "${data[index].children![index2].id}");

                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                name!,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                //textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      if (kDebugMode) {
                        print(snapshot.error.toString());
                      }
                      return const Text('has error');
                    } else {
                      return showLoadingIndicator();
                    }
                  }),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(14, 19, 49, 1),
                ),
                height: 60,
                width: double.infinity,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  title: const Text(
                    'انيمي وكرتون',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.twitter,
                    color: Color.fromARGB(255, 105, 0, 1),
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(14, 19, 49, 1),
                ),
                height: 60,
                width: double.infinity,
                child: ListTile(
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  title: const Text(
                    'مصارعه حرة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.dumbbell,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(14, 19, 49, 1),
                ),
                height: 60,
                width: double.infinity,
                child: ListTile(
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  title: const Text(
                    'برامج تليفزيونية',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.satelliteDish,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  Widget buildFilterData1() {
    return FutureBuilder<List<FilterModel>>(
        future: CimaApi().getFilterData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<FilterModel>;
            return SizedBox(
              height: 70,
              //  width: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    String? filterName = data[index].taxonomy;
                    List<Terms>? filterTerms = data[index].terms;
                    final List<MultiSelectItem<Terms>> _items;
                    if (filterName == data[0].taxonomy) {
                      _items = filterTerms!
                          .map((term) =>
                          MultiSelectItem<Terms>(term, term.slug!))
                          .toList();
                    } else {
                      _items = filterTerms!
                          .map((term) =>
                          MultiSelectItem<Terms>(term, term.name!))
                          .toList();
                    }
                    return Container(
                      alignment: Alignment.topRight,
                      // height: 40,
                      width: 150,
                      margin:
                      const EdgeInsets.only(top: 2, right: 10, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          //  border: Border.all(color: Colors.black),
                          color: Colors.white54
                        //grey.shade600,
                      ),

                      child: ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog(
                                items: _items,
                                title: Text("$filterName"),
                                separateSelectedItems: true,
                                searchable: true,
                                selectedColor: Colors.blue,
                                initialValue: _selectedTerms,
                                onConfirm: (List<Terms> values) {
                                  /*
                                  setState(() {
                                    _selectedTerms = values;

                                    categoryData =
                                        BlocProvider.of<MyCimaCubit>(context)
                                            .getCategoryFilterItems(
                                            menuModel.id ?? "38365",
                                            filterName!,
                                            _selectedTerms[index].termId!);
                                    if (kDebugMode) {
                                      print(categoryData);
                                    }
                                  });
                                  */
                                  setState(() {
                                    _selectedTerms = values;
                                    for(int i=0;i<_selectedTerms.length;i++){
                                      categoryData =
                                          BlocProvider.of<MyCimaCubit>(context)
                                              .getCategoryFilterItems(
                                              menuModel.id ?? "38365",
                                              filterName!,
                                              _selectedTerms[index].termId!,
                                              i,
                                          );
                                      if (kDebugMode) {
                                        print(categoryData);
                                      }
                                    }
                                  });
                                  // if (kDebugMode) {
                                  //   print("${_selectedTerms.length}");
                                  // }
                                },
                                // dialogWidth: MediaQuery.of(context).size.width * 0.7,
                              );
                            },
                          );
                        },
                        title: Row(
                          children: [
                            const Icon(
                              Icons.filter_list,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "$filterName",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return showLoadingIndicator();
          }
        });
  }

}
