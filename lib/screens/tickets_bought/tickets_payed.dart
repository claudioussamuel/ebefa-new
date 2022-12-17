import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/constants.dart';

class TickectsBought extends StatelessWidget {
  const TickectsBought({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickects Bought'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: usersBoughtController.userswhoboughttickes.length,
          itemBuilder: (context, index) =>
       
              Card(
            child: ListTile(
              title: Text(
                  usersBoughtController.userswhoboughttickes[index].event ??
                      ''),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  cartController.removeTickectsAdmin(
                      usersBoughtController.userswhoboughttickes[index].id ??
                          '');
                },
              ),
               subtitle: Text(
                 usersBoughtController.userswhoboughttickes[index].id ??
                      ''),
            ),
          ),
        ),
      ),
    );
  }
}
