import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_app/models/ProductsModel.dart';
import 'package:store_app/screens/categories_screen.dart';
import 'package:store_app/screens/feeds_screen.dart';
import 'package:store_app/screens/users_screen.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/app_bar_icons.dart';
import 'package:store_app/widgets/feeds_grid_widget.dart';
import 'package:store_app/widgets/feeds_widget.dart';
import 'package:store_app/widgets/sale_widgets.dart';

import '../consts/global_colors.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  /*@override
  void didChangeDependencies() {
    APIHandler.getAllProducts();
    super.didChangeDependencies();
  }*/
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
  //===========================AppBAr=================================================================
      appBar: AppBar(
        title: const Text('Home'),
        leading: AppBarIcons(function: (){
          Navigator.push(context, PageTransition(child: const UsersScreen(),
              type: PageTransitionType.fade));
        }, icon: IconlyBold.user3),
        actions: [
          AppBarIcons(function: (){
            Navigator.push(context, PageTransition(child: const CategoriesScreen(),
                type: PageTransitionType.fade));
          }, icon: IconlyBold.category),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
           const  SizedBox(height: 18,),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconColor,
                  )),
            ),
            const SizedBox(height: 18,),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height* 0.25,
                  child: Swiper(
                    autoplay: true,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      )
                    ),
                    itemCount: 3,
                    itemBuilder: (context,index){
                      return const OnSaleWidget();
                    },
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Latest Products",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        AppBarIcons(
                            function: () {
                              Navigator.push(context, PageTransition(
                                  child: const FeedsScreen(),
                                  type: PageTransitionType.fade));
                            },
                            icon: IconlyBold.arrowRight2),
                      ],
                    ),
                  ),
                  FutureBuilder<List<ProductsModel>>(
                    future: APIHandler.getAllProducts(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        }
                        else if(snapshot.hasError){
                           Center(
                            child: Text('An error occurred${snapshot.error}'),
                          );

                        }
                        else if(snapshot.data==null){
                          const Center(
                            child: Text('No product has been added yet'),
                          );

                        }
                        return FeedsGridWidget(productsList: snapshot.data!);
                      })

                ],
              ),
            ))
          ],
        ),
      )
    );
  }
}
