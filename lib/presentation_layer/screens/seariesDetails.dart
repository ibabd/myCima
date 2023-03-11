import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/dataLayer/models/detailsModel.dart';
import 'package:mycima_app_last/dataLayer/services/services_data.dart';
import 'package:mycima_app_last/presentation_layer/widgets/related_item.dart';
import 'package:mycima_app_last/presentation_layer/widgets/video_player.dart';

class SeariesInfo extends StatefulWidget {
  static const route = '/details1';
  final CategoryModel categoryModel;
  // final SeariesModel seariesModel;
  const SeariesInfo({Key? key, required this.categoryModel}) : super(key: key);
  @override
  _SeariesInfoState createState() => _SeariesInfoState();
}

class _SeariesInfoState extends State<SeariesInfo> {
  DetailsModel detailsModel=DetailsModel();
  DetailsModel ? detailModel;
  CimaApi cimaApi=CimaApi();
  bool isLoading=false;
  // List<CategoryModel>? categoryData;
  List<double> tabsSize = [430, 1100, 1100];
  int tabsindex = 0;
  // Future<void> getEposide() async {
  //   setState(() {
  //     isLoading=true;
  //   });
  //   // to get the details you must give id that find in seriesEpisoud
  //   categoryData=CimaApi().getEpisodsSeries(termId: "${widget.categoryModel.termId}") as List<CategoryModel>;
  //   //detailModel = await CimaApi().getDetailsCategory(id: "${categoryData.first.id}");
  //   setState(() {
  //     isLoading=false;
  //   });
  // }

  // @override
  // void initState() {
  // //  categoryData=CimaApi().getEpisodsSeries(termId: "${widget.categoryModel.termId}") as List<CategoryModel>;
  //   Future.delayed(Duration.zero, () async {
  //     await  getEposide();
  //     if (kDebugMode) {
  //       print("============");
  //      // print(detailModel!.toJson());
  //       print(categoryData);
  //       print("=============================================");
  //     }
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child:FutureBuilder(
            future:CimaApi().getEpisodsSearies(termId: "${widget.categoryModel.termId}"),
            //CimaApi().getDetailsCategory(id: "${categoryData!.first.id}") ,
            builder:(context,snapshot)  {
              if(snapshot.hasData){
                final data = snapshot.data as List<CategoryModel>;
                // detailModel =  CimaApi().getDetailsCategory(id: "${data.first.id}") as DetailsModel?;
                return FutureBuilder(
                    future: CimaApi().getDetailsCategory(id:"${data.first.id}" ),
                    builder:(context,snapshot1){
                      if(snapshot1.hasData){
                        final data1 = snapshot1.data as DetailsModel;
                        return NestedScrollView(
                            headerSliverBuilder: ((context, innerBoxIsScrolled) {
                              return [
                                SliverAppBar(
                                    backgroundColor: Colors.black,
                                    expandedHeight: 300,
                                    flexibleSpace: FlexibleSpaceBar(
                                      background: Stack(
                                          alignment: Alignment.centerRight,
                                          fit: StackFit.passthrough,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: data1.thumbnailUrl.toString(),
                                              placeholder: (context, url) => const CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                            Center(
                                              child: Positioned(
                                                  child: CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor: Colors.red,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(url:
                                                          // "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
                                                          data1.watchUrl .toString(),
                                                          )));
                                                          //  Get.to(() => const SamplePlayer());
                                                        },
                                                        icon: const Icon(
                                                            Icons.play_arrow_outlined,
                                                            color: Colors.white
                                                        )),
                                                  )),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                height: 100,
                                                width: Get.width,
                                                child: Container(
                                                    decoration: BoxDecoration(boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(
                                                              .2),
                                                          blurRadius: 100,
                                                          spreadRadius: 50,
                                                          offset: const Offset(-10, 5)),
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(
                                                              .2),
                                                          blurRadius: 100,
                                                          spreadRadius: 50,
                                                          offset: const Offset(-10, 7)),
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(
                                                              .3),
                                                          blurRadius: 100,
                                                          spreadRadius: 50,
                                                          offset: const Offset(-10, 10)),
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(
                                                              .4),
                                                          blurRadius: 100,
                                                          spreadRadius: 50,
                                                          offset: const Offset(-10, 13)),
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(
                                                              .4),
                                                          blurRadius: 100,
                                                          spreadRadius: 50,
                                                          offset: const Offset(-2, 17))
                                                    ]))),
                                            Positioned(
                                                bottom: 0,
                                                child: SizedBox(
                                                  height: 40,
                                                  width: Get.width,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 15),
                                                            child: Text(
                                                              data1.imdbRating
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors.white),
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.yellow,
                                                            size: 20,
                                                          )
                                                        ]),
                                                      ),
                                                      const SizedBox(
                                                        width: 80,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          data1.runtime.toString(),
                                                          //"${detailModel!.runtime}",
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          data1.season.toString(),
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ]),
                                    ),
                                    leading: Container(),
                                    actions: [
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios_new_outlined,
                                          )),
                                    ])
                              ];
                            }),
                            body: ListView(children: [
                              const SizedBox(
                                height: 15,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(35, 40, 72, 1),
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    height: 40,
                                    width: Get.width * .4,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "الحلقه التاليه",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(35, 40, 72, 1),
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    height: 40,
                                    width: Get.width * .4,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "الحلقه السابقه",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                ],
                              ),

                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),

                                child: Container(
                                  color: Colors.blue,
                                  width: Get.width,
                                  height: tabsSize[tabsindex],

                                  // problem in high
                                  child: ContainedTabBarView(
                                    initialIndex: tabsindex,
                                    callOnChangeWhileIndexIsChanging: true,
                                    onChange: (index) {
                                      setState(() {
                                        tabsSize[2] =(data1.downloads!.length) * 700.0;
                                        tabsindex = index;
                                      });
                                    },
                                    tabBarViewProperties: const TabBarViewProperties(
                                        physics: NeverScrollableScrollPhysics()),
                                    tabBarProperties: TabBarProperties(
                                      background: Container(
                                        color: Colors.black,
                                      ),
                                      indicatorColor: Colors.blue,
                                      labelColor: Colors.white,
                                    ),
                                    tabs: const [
                                      Text('نبذه عنا'),
                                      Text('ذات صله'),
                                      Text('الحلقات'),
                                    ],
                                    views: [
                                      Container(
                                        color: Colors.black,
                                        child: ListView(
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: [
                                            const Text("الاسم",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15)),
                                            Text("${data1.title}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            const Text("النوع",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15)),
                                            // Wrap(
                                            //   children: List.generate(
                                            //     data1.genre!.length,
                                            //         (i) => Text(
                                            //           data1
                                            //           .genre![i].name
                                            //           .toString(),
                                            //       style:
                                            //       const TextStyle(
                                            //         color: Colors.white,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            const Text("القصة",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15)),
                                            Text("${data1.story}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            const Text("الجودة",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15)),
                                            Wrap(
                                              children: List.generate(
                                                data1.quality!.length,
                                                    (i) => Text(
                                                  data1
                                                      .quality![i].name
                                                      .toString(),
                                                  style:
                                                  const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.black,
                                        child: FutureBuilder<List<CategoryModel>>(
                                          future: CimaApi().getDataRelated(id: "${widget.categoryModel.id}"),
                                          builder:
                                              (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              // final data = snapshot.data as List<RelatedModel>;
                                              tabsSize[1] = snapshot.data.length * 200.0;

                                              return Container(
                                                decoration: const BoxDecoration(),
                                                child: Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                    GridView.builder(
                                                        physics:
                                                        const NeverScrollableScrollPhysics(),
                                                        gridDelegate:
                                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                                            mainAxisExtent: 250,
                                                            maxCrossAxisExtent: 300),
                                                        itemCount: snapshot.data.length,
                                                        scrollDirection: Axis.vertical,
                                                        itemBuilder: ((context, index2) {
                                                          return RelatedItem(
                                                              categoryModel:
                                                              snapshot.data[index2]);
                                                        }))
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                  child: CircularProgressIndicator(
                                                    color: Colors.yellow,));
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                          color: Colors.black,
                                          child: FutureBuilder<List<CategoryModel>>(
                                            future:cimaApi.getEpisodsSearies(termId: "${widget.categoryModel.termId}") ,
                                            builder: (context,snapshot){
                                              if(snapshot.hasData){
                                                final data = snapshot.data as List<CategoryModel>;
                                                return GridView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: data.length,
                                                    padding: const EdgeInsets.all(5),
                                                    gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 3,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 20),
                                                    itemBuilder: ((context, index) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(
                                                              10),
                                                          color: const Color.fromRGBO(
                                                              35, 40, 72, 1),
                                                        ),
                                                        child: ListTile(
                                                            leading: IconButton(
                                                                onPressed: () {
                                                                  Navigator.pushNamed(context, SeariesInfo.route);
                                                                },
                                                                icon: const Icon(
                                                                    Icons.play_arrow,
                                                                    color: Colors.white)),
                                                            title: Text("الحلقه ${index + 1} ",
                                                                style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight
                                                                        .bold))),
                                                      );
                                                      /*
                                         CategoryItem(
                                          categoryModel:data[index]
                                        )
                                         */
                                                    }));
                                              }else if(snapshot.hasError){
                                                return Center(
                                                  child: Text("${snapshot.hasError}"),
                                                );
                                              }else{
                                                return const Center(
                                                    child: CircularProgressIndicator(
                                                      color: Colors.yellow,));
                                              }
                                            },
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                // DetailsRow(),
                              ),
                            ]));
                      }else if(snapshot1.hasError){
                        return Text("${snapshot1.hasError}");
                      }else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                );
              }else if(snapshot.hasError){
                return Text("${snapshot.hasError}");
              }else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } ,
          ),

        )
    );
  }
  Widget buildSliverAppBar() {
    return SliverAppBar(
      //sliverAppBar دة الى بتحكم فى الصورة والتكست بقدر اعمل زووم كل دة من خلال ٍ
        expandedHeight: 400,
        pinned: true,
        stretch: true,
        backgroundColor:Colors.grey,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            alignment: Alignment.center,
            //fit: StackFit.passthrough,
            children: [
              Hero(
                tag: widget.categoryModel.id.toString(),
                child: Image.network(
                  widget.categoryModel.thumbnailUrl.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                // bottom: 200,
                //   top: 200,
                //   right: 200,
                //   left: 200,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(
                        Icons.play_arrow_outlined,
                        color:Colors.white
                    ),),
                ),),
              Positioned(
                bottom: 0,
                height: 100,
                width: Get.width,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 100,
                        spreadRadius: 50,
                        offset: const Offset(-10, 5)),
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 100,
                        spreadRadius: 50,
                        offset: const Offset(-10, 7)),
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 100,
                        spreadRadius: 50,
                        offset: const Offset(-10, 10)),
                    BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 100,
                        spreadRadius: 50,
                        offset: const Offset(-10, 13)),
                    BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 100,
                        spreadRadius: 50,
                        offset: const Offset(-2, 17))
                  ],),),),
              Positioned(
                bottom: 0,
                child: SizedBox(
                    height: 40,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                          children: [
                            Text(
                              "${detailModel!.imdbRating}",
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          ],
                        ),
                        Text(
                          "${detailModel!.runtime}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "${detailModel!.season}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
        leading:  Container(),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
              )),
        ]

    );
  }
}







