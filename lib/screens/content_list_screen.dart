import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:techdaily/models/TechDailyContent.dart';
import 'package:techdaily/models/api_owner_model.dart';
import 'package:techdaily/screens/search_screen.dart';
import 'package:techdaily/services/api_manager.dart';
import 'package:techdaily/widgets/chips_filter_widget.dart';
import 'package:techdaily/widgets/content_list_widget.dart';
import 'package:techdaily/widgets/drawer_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techdaily/widgets/shimmer_widget_home.dart';

class ContentListScreen extends StatefulWidget {
  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  bool _isSorted = false;
  bool _isLoading = true;
  bool _isLoadingNewCont = false;

  int currentOwner;
  int recentOwner;
  Object redrawObject;

  List<TechDailyContent> allContents = [];
  List<TechDailyContent> sortedContents = [];

  List<TechDailyOwner> owners = [];
  Map<int, String> ownersMap = {};

  List contentTitles = [];

  ScrollController _fullController = ScrollController();

  int pageNumber = 1;
  int pageNumberOwner = 1;
  int _ownerId;

  @override
  Widget build(BuildContext context) {
    print("'ContentListScreen' Widget building");
    return RefreshIndicator(
      onRefresh: refreshContents,
      child: Scaffold(
        // key: _scaffoldKey,
        drawer: DrawerWidget(),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: CustomScrollView(
            controller: _fullController,
            slivers: [
              SliverAppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                        onPressed: () => showSearch(
                            context: context,
                            delegate: SearchScreen(allContents, ownersMap)),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  )
                ],
                backgroundColor: Colors.black,
                floating: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                }),
                title: Container(
                  margin: EdgeInsets.only(right: 0, left: 15),
                  child: Transform.scale(
                    scale: .70,
                    child: GestureDetector(
                        onTap: () => _scrollToTop(),
                        child: Image.asset('assets/images/techlogo.png')),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child:_isLoading?Container(height: 1000,child: ShimmerHome(),): Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 6, top: 30),
                        child: ListView.builder(
                          key: ValueKey<Object>(redrawObject),
                          shrinkWrap: true,
                          itemCount: owners.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ChipFilter(
                              ownerName: owners[index].name,
                              shouldSelect: currentOwner == owners[index].id
                                  ? true
                                  : false,
                              onSelect: () {
                                setState(() {
                                  currentOwner = owners[index].id;
                                  redrawObject = Object();
                                });

                                handleOnSelect(owners[index].id);
                              },
                              onUnselect: () {
                                print('unselected chip ownerId: ' +
                                    owners[index].id.toString());

                                setState(() {
                                  redrawObject = Object();
                                  // recentOwner = owners[index].id;
                                  currentOwner = -1;
                                });
                                handleOnUnselect();
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      //   _isLoading?
                      // // Container(height: 1000,child: ShimmerHome())
                      //        Container(
                      //       child: Center(child: CircularProgressIndicator()),
                      //         )
                      //       :
                      !_isSorted
                          ? Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 10),
                                  shrinkWrap: true,
                                  itemCount: allContents.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ContentList(
                                          title: allContents[index].title,
                                          img: allContents[index].imgUrl,
                                          uploadTime:
                                              allContents[index].pubDate,
                                          id: allContents[index].id,
                                          owner: ownersMap[allContents[index]
                                                  .owner_id] ??
                                              allContents[index]
                                                  .owner_id
                                                  .toString(),
                                          url: allContents[index].url,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                if (_isLoadingNewCont)
                                  Center(child: CircularProgressIndicator()),
                              ],
                            )
                          : _isSorted
                              ? Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: 10),
                                      shrinkWrap: true,
                                      itemCount: sortedContents.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ContentList(
                                              title:
                                                  sortedContents[index].title,
                                              img: sortedContents[index].imgUrl,
                                              uploadTime:
                                                  sortedContents[index].pubDate,
                                              owner: ownersMap[
                                                      sortedContents[index]
                                                          .owner_id] ??
                                                  sortedContents[index]
                                                      .owner_id
                                                      .toString(),
                                              url: sortedContents[index].url,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    if (_isLoadingNewCont)
                                      CircularProgressIndicator(),
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    'No Data',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleOnSelect(int ownerId) {
    print('selected chip ownerId: ' + ownerId.toString());
    setState(() {
      sortedContents = [];
      sortedContents.addAll(allContents.where((TechDailyContent content) {
        return content.owner_id == currentOwner;
      }));
      _isSorted = true;

      _ownerId = ownerId;
    });

    getSortedContents(ownerId);
  }

  void getSortedContents(ownerId) {
    ApiManager()
        .getContentsByOwner(ownerId, pageNumberOwner)
        .then((List<TechDailyContent> value) {
      if (ownerId == currentOwner) {
        setState(() {
          sortedContents = value;
          _isLoadingNewCont = false;
        });
      }
    });
  }

  void handleOnUnselect() {
    setState(() {
      _isSorted = false;
    });
  }

  void _scrollToTop() {
    _fullController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void getMoreContents() {
    setState(() {
      _isLoadingNewCont = true;
    });
    ApiManager().getContents(pageNumber).then((List<TechDailyContent> value) {
      setState(() {
        allContents.addAll(value);
        pageNumber += 1;
        _isLoadingNewCont = false;
      });
    });
  }

  void getMoreSortedContents(int ownerId) {
    setState(() {
      _isLoadingNewCont = true;
    });
    print(ownerId);
    ApiManager()
        .getContentsByOwner(ownerId, pageNumber)
        .then((List<TechDailyContent> value) {
      setState(() {
        sortedContents.addAll(value);
        pageNumber += 1;
      });
    });
  }

  Future<void> refreshContents() async {
    setState(() {
      _isLoading = true;
    });
    ApiManager().getContents(1).then((List<TechDailyContent> value) {
      setState(() {
        allContents = value;
        _isLoading = false;
        pageNumber = 2;
      });
    });
  }

  @override
  void initState() {
    ApiManager().getContents(pageNumber).then((List<TechDailyContent> value) {
      setState(() {
        allContents = value;
        pageNumber++;
      });
    });

    ApiManager().getOwners().then((List<TechDailyOwner> value) {
      Map<int, String> map = {};
      for (TechDailyOwner owner in value) {
        map[owner.id] = owner.name;
      }
      setState(() {
        ownersMap = map;
        owners = value;

        _isLoading = false;
      });
    });

    // Setup the listener.
    _fullController.addListener(() {
      // var index = ((_fullController.position.pixels ) / 100.0).round() -3 ;
      // print('Scroll Index '+index.toString());
      //
      // var dif = allContents.length - index;
      // print('difference = '+dif.toString());
      //
      // if(dif<=3){
      //   _isSorted?getMoreSortedContents(_ownerId):
      //       getMoreContents();
      // }

      // if (_fullController.position.extentAfter < 300) {
      //
      //   _isSorted ? getMoreSortedContents(_ownerId) : getMoreContents();

      // if (_isLoadingNewCont) {
      //   setState(() {
      //     _atBottom = true;
      //   });
      // } else {
      //   setState(() {
      //     _atBottom = false;
      //   });
      // }

      // }

      if (_fullController.position.atEdge) {
        if (_fullController.position.pixels == 0) {
          // You're at the top.
        } else {
          // You're at the bottom.
          print('eitto eshe gechi');
          _isSorted ? getMoreSortedContents(_ownerId) : getMoreContents();
        }
      }
    });

    super.initState();
  }
}
