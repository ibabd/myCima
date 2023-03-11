


// ignore_for_file: file_names

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycima_app_last/dataLayer/models/categoryModel.dart';
import 'package:mycima_app_last/dataLayer/models/detailsModel.dart';
import 'package:mycima_app_last/dataLayer/services/services_data.dart';
import 'package:mycima_app_last/presentation_layer/widgets/related_item.dart';
import 'package:mycima_app_last/presentation_layer/widgets/video_player.dart';


class Details extends StatefulWidget {
  final CategoryModel categoryModel;
  static const route = '/details';
  const Details({Key? key,required this.categoryModel}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DetailsModel detailsModel=DetailsModel();
  DetailsModel ? detailModel;
  bool isLoading=false;
  CategoryModel categoryModel=CategoryModel();
  late List<CategoryModel> categoryData;
  List<double> tabsSize = [430, 1100];
  // List<double> tabsSize = [430, 1100, 700];
  int tabsindex = 0;
  Future<void> getDetails() async {
    setState(() {
      isLoading=true;
    });
    detailModel = await CimaApi().getDetailsCategory(id: "${widget.categoryModel.id}");
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await getDetails();
      if (kDebugMode) {
        print("============");
        print(detailModel!.toJson());
        print("=============================================");
      }
    });

    super.initState();
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child:isLoading?const Center(child: CircularProgressIndicator()):
          NestedScrollView(
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
                              Image.network(
                                widget.categoryModel.thumbnailUrl!,
                                fit: BoxFit.fill,
                              ),
                              Center(
                                child: Positioned(
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.red,
                                      child: IconButton(
                                          onPressed: () {
                                            // Get.to(() => SamplePlayer(
                                            //   url: data!["watch_url"],
                                            // ));
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayer(url:
                                            // "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
                                            detailModel!.watchUrl .toString(),
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
                                                detailModel!.imdbRating
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
                                            detailModel!.runtime.toString(),
                                            //"${detailModel!.runtime}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            detailModel!.season.toString(),
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
                  height: 10,
                ),
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
                          //tabsSize[2] =(detailModel!.downloads!.length) * 66.0;
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
                        //  Text('الحلقات'),
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
                              Text("${detailModel?.title}",
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
                              Wrap(
                                children: List.generate(
                                  detailModel!.genre!.length,
                                      (i) => Text(
                                    detailModel!
                                        .genre![i].name
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
                              const Text("القصة",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 15)),
                              Text("${detailModel?.story}",
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
                                  detailModel
                                  !.quality!.length,
                                      (i) => Text(
                                    detailModel!
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
                        // Container(
                        //   color: Colors.black,
                        //   child:buildBlocWidget() ,
                        // )
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
                                            /*OpenContainer(
                              closedColor:Colors.blue,

                              closedBuilder:
                                  (_, closedBuilder) =>
                              // GridViewBodyCard(
                              //   title: snapshot.data[index2]
                              //   ["title"],
                              //   imageUrl:
                              //   snapshot.data[index2]
                              //   ["thumbnailUrl"],
                              // ),
                              CategoryItem(categoryModel: snapshot.data[index2],),
                              openBuilder:
                                  (_, openBuilder) {
                                // mediaController.isFirstScreen.value =
                                //     false;
                                // // Get.toNamed("/movie_info",
                                // //     arguments: mediaController.media.last[index]);
                                // return MovieInfoScreen(
                                //     arguments: mediaController
                                //         .media.last[index]);
                                return Details(
                                  // arguments:
                                  // MediaControllerData(
                                  //   mediaID: snapshot
                                  //       .data[index2]["id"],
                                  //   mediaTitle:
                                  //   snapshot.data[index2]
                                  //   ["title"],
                                  //   mediaImage:
                                  //   snapshot.data[index2]
                                  //   ["thumbnailUrl"],
                                  //   mediaYear:
                                  //   "${snapshot.data[index2]['year']}",
                                  // ),
                                    categoryModel: CategoryModel()
                                );
                              },
                            );*/
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
                        /*  Container(
                            color: Colors.black,
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: detailModel!.downloads!.length,
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
                                            onPressed: () {},
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
                                }))
                        ),*/
                      ],
                    ),
                  ),

                  // DetailsRow(),
                ),
              ])),
        ));
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