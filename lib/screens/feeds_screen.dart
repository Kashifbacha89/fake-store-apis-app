import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/ProductsModel.dart';
import 'package:store_app/services/api_handler.dart';

import '../consts/global_colors.dart';
import '../widgets/feeds_widget.dart';
class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);


  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductsModel> productsList= [];
  late TextEditingController _controller;
  bool _Loading= false;
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

  Future<void> getProducts()async{
    productsList= await APIHandler.getAllProducts();
    setState(() {

    });

  }
  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               const SizedBox(height: 10,),
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

              productsList.isEmpty?const Center(child: CircularProgressIndicator(),):
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                          itemCount: productsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0,
                            childAspectRatio: 0.7,

                          ),

                          itemBuilder: (context,index){
                            return ChangeNotifierProvider.value(
                                value: productsList[index],
                                child: const FeedsWidget());
                          }),

                    ],
                  ),
                )
              ),





            ],
          ),
        ),
      )
    );
  }
}
