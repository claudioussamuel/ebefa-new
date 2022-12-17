import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constants.dart';
import 'package:min_id/min_id.dart';
import '../../generating_pdf/pdf_api.dart';
import '../../generating_pdf/pdf_invoice_api.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constant/firbase.dart';
import '../../models/UsersWhoBoughtTheTickectModel.dart';
import '../../models/ticket.dart';

class PaymentScreen extends StatelessWidget {
  final String url;
  final TickectModel ticket;
  
  const PaymentScreen({Key? key, required this.url, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'Flutter;Webview',
        navigationDelegate:  (navigation) async {
          if (navigation.url.contains('https://google.com') ) {
            
             Get.snackbar(
                        'Successfully Bought',
                        'Thank You',
                      );
                                
                      // add to the admin side
                      final userTickectId = MinId.getId();
                      

                        cartController.addTicket(
                          ticket,
                          UsersWhoBoughtTheTickectModel(
                            email: auth.currentUser?.email,
                            name: authController.userModel.value.name,
                            id: userTickectId,
                          ));

                      cartController.addTicketBought(
                          ticket,
                          UsersWhoBoughtTheTickectModel(
                            email: auth.currentUser?.email,
                            name: authController.userModel.value.name,
                            id: userTickectId,
                            event: ticket.name,
                          ));

                     

                       final pdfFile = await PdfInvoiceApi.generate(ticket,userTickectId);
                     PdfApi.openFile(pdfFile);


                     
            Navigator.of(context).pop(); //close webview

          }
          if (navigation.url.contains('https://facebook.com')) {
            Navigator.of(context).pop(); //close webview
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
