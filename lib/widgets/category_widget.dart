import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/models/CategoriesModel.dart';
class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final categoriesProvider=Provider.of<CategoriesModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),

          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  width: size.width*0.47,
                  height: size.width*0.45,
                  errorWidget: const Icon(IconlyBold.danger,color: Colors.red,size: 28,),
                  imageUrl: categoriesProvider.image.toString(),
                  boxFit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(categoriesProvider.name.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  backgroundColor: lightCardColor.withOpacity(0.3),
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
