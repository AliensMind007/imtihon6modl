import 'package:flutter/material.dart';
import 'package:imtihon6modl/Pages/AddcardPage.dart';
import 'package:imtihon6modl/Pages/Models/Models.dart';
import 'package:imtihon6modl/Pages/Servises/Servises.dart';
class CreditCardPage extends StatefulWidget {
  const CreditCardPage({Key? key}) : super(key: key);
  static const String id = "CreditCardPage";
  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  String data = '';
  String response = '';
  List<CardModel> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  // void _showResponse(String response){
  //   List <CardModel> list = Network.parsePostList(response);
  //   posts.clear();
  //     setState(() {
  //       data = list;
  //     });
  //   }
  void _apiPostList() {
    isLoading = true;
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      print(response!),
      _resPostList(response),
    });
  }

  void _resPostList(String response) {
    List<CardModel> list = Network.parsePostList(response);
    posts.clear();
    setState(() {
      isLoading = false;
      posts = list;
    });
  }

  void _apiPostDelete(CardModel post) {
    Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => {
      _resPostDelete(response),
    });
  }

  void _resPostDelete(String? response) {
    setState(() {
      isLoading = false;
    });
    if (response != null) _apiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
       title: _buildTitleSection(
            title: "Good morning,",
            subTitle: "Abdulbari"

        ),
      ),
    body: SingleChildScrollView(
        child: Container(
         width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              _buildCreditCard(
                  color: Color(0xFF090943),
                  cardExpiration: "sdfd",
                  cardHolder: "abd SELMI",
                  cardNumber: "3546 7532 XXXX 9742"),
              SizedBox(
                height: 15,
              ),
              _buildCreditCard(
                  color: Color(0xFF000000),
                  cardExpiration: "05/2024",
                  cardHolder: "HOUSSEM SELMI",
                  cardNumber: "9874 4785 XXXX 6548"),
              _buildAddCardButton(context),

            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.circle_outlined),
              label: 'circle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
            ),
          ],
        ),

    );
  }
  Widget _buildTitleSection({required title, required subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16.0),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Text(
                '$subTitle',
                style: TextStyle(fontSize: 21, color: Colors.black45),
              ),
            )
          ],
        ),
        Container(height: 50,width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: AssetImage("assets/images/mansProfile.png"),
          ),
        ),),
      ],
    );
  }
  Widget  _buildCreditCard(
      {required Color color,
        required String cardNumber,
        required String cardHolder,
        required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }
 Widget _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/vizaicon.png",
          height: 20,
          width: 18,
          fit: BoxFit.cover,
        ),
        Image.asset(
          "assets/images/vizaicon.png",
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Widget _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Widget _buildAddCardButton(context) {
    return Card(
        elevation: 1.0,
        color: Colors.white54,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
    ),
    child: MaterialButton(
      onPressed: (){
         Navigator.pushNamed(context, AddCardPage.id);
      },
      child: Container(
      height: 200,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

        Container(height: 100,width: 100,child: Image(
          image: AssetImage("assets/images/add.jpg"),
        ),),
        Text("Add new card",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ],),),
      ),
    ));
  }
}

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//        title: _buildTitleSection(
//             title: "Good morning,",
//             subTitle: "Abdulbari"
//
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//          width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//
//               _buildCreditCard(
//                   color: Color(0xFF090943),
//                   cardExpiration: "08/2022",
//                   cardHolder: "HOUSSEM SELMI",
//                   cardNumber: "3546 7532 XXXX 9742"),
//               SizedBox(
//                 height: 15,
//               ),
//               _buildCreditCard(
//                   color: Color(0xFF000000),
//                   cardExpiration: "05/2024",
//                   cardHolder: "HOUSSEM SELMI",
//                   cardNumber: "9874 4785 XXXX 6548"),
//               _buildAddCardButton(context),
//
//             ],
//           ),
//         ),
//       ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.circle_outlined),
//               label: 'circle',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu),
//               label: 'menu',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'profile',
//             ),
//           ],
//         ),
//     );
//   }
//
//   /// Build the title section
//   Row _buildTitleSection({required title, required subTitle}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, top: 16.0),
//               child: Text(
//                 '$title',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
//               child: Text(
//                 '$subTitle',
//                 style: TextStyle(fontSize: 21, color: Colors.black45),
//               ),
//             )
//           ],
//         ),
//         Container(height: 50,width: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           image: DecorationImage(
//             image: AssetImage("assets/images/mansProfile.png"),
//           ),
//         ),),
//       ],
//     );
//   }
//
//   // Build the credit card widget
//   Card _buildCreditCard(
//       {required Color color,
//         required String cardNumber,
//         required String cardHolder,
//         required String cardExpiration}) {
//     return Card(
//       elevation: 4.0,
//       color: color,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Container(
//         height: 200,
//         padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             _buildLogosBlock(),
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Text(
//                 '$cardNumber',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 21,
//                     fontFamily: 'CourrierPrime'),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 _buildDetailsBlock(
//                   label: 'CARDHOLDER',
//                   value: cardHolder,
//                 ),
//                 _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Build the top row containing logos
//   Row _buildLogosBlock() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Image.asset(
//           "assets/images/vizaicon.png",
//           height: 20,
//           width: 18,
//           fit: BoxFit.cover,
//         ),
//         Image.asset(
//           "assets/images/vizaicon.png",
//           height: 50,
//           width: 50,
//           fit: BoxFit.cover,
//         ),
//       ],
//     );
//   }
//
// // Build Column containing the cardholder and expiration information
//   Column _buildDetailsBlock({required String label, required String value}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           '$label',
//           style: TextStyle(
//               color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           '$value',
//           style: TextStyle(
//               color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }
//
// // Build the FloatingActionButton
//   Widget _buildAddCardButton(context) {
//     return Card(
//         elevation: 1.0,
//         color: Colors.white54,
//         shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//     ),
//     child: MaterialButton(
//       onPressed: (){
//          Navigator.pushNamed(context, AddCardPage.id);
//       },
//       child: Container(
//       height: 200,
//       padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
//       child: Center(child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//
//         Container(height: 100,width: 100,child: Image(
//           image: AssetImage("assets/images/add.jpg"),
//         ),),
//         Text("Add new card",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//       ],),),
//       ),
//     ));
//   }
