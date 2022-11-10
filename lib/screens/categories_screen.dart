import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/CategoriesModel.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/category_widget.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CatrgoriesScreenState();
}

class _CatrgoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),

      ),
      body: FutureBuilder<List<CategoriesModel>>(
        future:  APIHandler.getAllCategories(),
        builder: (context,snapshot){
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
              child: Text('No Category added yet!')
            );
          }


          return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 1.1,

              ), itemBuilder: (ctx,index){
            return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const CategoryWidget());
          });

        },
      )
    );
  }
}
