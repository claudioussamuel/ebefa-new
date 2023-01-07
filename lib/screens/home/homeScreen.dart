import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constants.dart';
import '../contact/contact_us.dart';
import '../tickets_bought/tickets_payed.dart';
import 'Ticket_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: kPrimaryColor),
             elevation: 0,
        title: Text(
                '3b3fa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              centerTitle: true,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // SliverAppBar(
          //   flexibleSpace: FlexibleSpaceBar(
              
          //   ),
          //   floating: true,
           
          // ),
        ],
        body: Obx(
          () => homeController.connectionStatus.value == 1
              ? Container(
                  color: Colors.white30,
                  child: const TicketWidget(),
                )
              : Container(
                  color: kPrimaryLightColor,
                  child: Center(
                    child: Text('No Internet',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  ),
                ),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children: [
            Obx(() => UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                accountName: Text(
                  authController.userModel.value.name ?? "",
                  style: TextStyle(
                      //  color: Colors.white,
                      ),
                ),
                accountEmail:
                    Text(authController.userModel.value.email ?? ""))),
            ListTile(
              onTap: () {
                Get.to(() => TickectsBought());
              },
              leading: Icon(Icons.book_rounded),
              title: Text("Tickects Bought"),
            ),
            ListTile(
              onTap: () {
                Get.to(() => TermsAndConditions());
              },
              leading: Icon(Icons.help),
              title: Text("Terms and Conditions"),
            ),
            ListTile(
              onTap: () {
                authController.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
