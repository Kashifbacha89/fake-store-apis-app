import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store_app/models/ProductsModel.dart';
import 'package:store_app/services/api_handler.dart';

import '../consts/global_colors.dart';

class ProductsDetailScreen extends StatefulWidget {
  const ProductsDetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductsModel?productsModel;
  Future<void> getProductDetail()async{
    productsModel = await APIHandler.getProductById(id: widget.id);
    setState(() {});
  }
  @override
  void didChangeDependencies() {
    getProductDetail();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: productsModel==null?
        const Center(child: CircularProgressIndicator(),):
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18,
              ),
             const  BackButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
  //=======================category Name======================================================================
                    Text(
                      productsModel!.category!.name.toString(),
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
  //==========================name&price of product===========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 3,
                            child: Text(
                              productsModel!.title.toString(),
                              textAlign: TextAlign.start,
                              style: titleStyle,
                            )),
                        Flexible(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                                text: '\$',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromRGBO(33, 150, 243, 1)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: productsModel!.price.toString(),
                                      style: TextStyle(
                                          color: lightTextColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
 //===========================swiper card=================================================================
              SizedBox(
                height: size.height * 0.4,
                child: Swiper(
                  autoplay: true,
                  itemCount: 3,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      )),
                  itemBuilder: (context, index) {
                    return FancyShimmerImage(
                      width: double.infinity,
                      imageUrl: productsModel!.images![index].toString(),
                      boxFit: BoxFit.fill,
                    );
                  },
                ),
              ),
 //=====================description of product=============================================================
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: titleStyle),
                    const SizedBox(
                      height: 18,
                    ),
                     Text(
                       productsModel!.description.toString(),

                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
