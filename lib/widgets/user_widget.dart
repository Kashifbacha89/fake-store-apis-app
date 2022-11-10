import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/models/UsersModel.dart';
class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final userProvider=Provider.of<UsersModel>(context);
    return ListTile(
      leading: FancyShimmerImage(
        width: size.width*0.15,
        height: size.width*0.15,
        errorWidget: const Icon(
          IconlyBold.danger,
          size: 28,
            color: Colors.red,
        ),
        imageUrl: userProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title:  Text(userProvider.name.toString()),
      subtitle:  Text(userProvider.email.toString()),
      trailing: Text(userProvider.role.toString(),style: TextStyle(
        color: lightIconColor,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
