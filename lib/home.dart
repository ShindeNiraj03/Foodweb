import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'RecipeView.dart';
import 'model.dart';
import 'search.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];
  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = new RecipeModel();
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);
        setState(() {
          isLoading = false;
        });
        log(recipeList.toString());
      });
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: [
          Image.network(
            'https://minimalistbaker.com/wp-content/uploads/2015/08/AMAZING-Mexican-Pinwheels-with-Refried-Beans-Avocado-Onion-Cilantro-and-Tomato-Such-a-delicious-vegan-friendly-finger-food-recipe-healthy-snack-mexican.jpg',width: 500, // Replace with your image URL,
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(color: Colors.yellow),
          ),
          SingleChildScrollView(
            child: Column(
              children: [


                //Search Bar
                SafeArea(
                  child: Container(
                    //Search Wala Container

                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Search(searchController.text)));
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's Cook Something!"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 490),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's Cook Something...",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "DELICIOUS",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(6, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


































































// Container(
//     child: isLoading ? CircularProgressIndicator() : ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: recipeList.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipeList[index].appurl)));
//             },
//             child: Card(
//
//               color: Colors.transparent,
//               margin: EdgeInsets.all(50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               elevation: 0.0,
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(30.0),
//                       child: Image.network(
//                         recipeList[index].appimgUrl,
//                         fit: BoxFit.cover,
//                         width:170 ,
//                         height: 200,
//                       )),
//                   Positioned(
//                       top: 100,
//                       left:180,
//                       right: 0,
//                       bottom:0,
//                       child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 10),
//                           decoration: BoxDecoration(
//                               color: Colors.transparent),
//                           child: Text(
//                             recipeList[index].applabel,
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 20),
//                           ))),
//                   Positioned(
//                     right: 0,
//                     height: 40,
//                     width: 80,
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10)
//                             )
//                         ),
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.local_fire_department, size: 15,),
//                               Text(recipeList[index].appcalories.toString().substring(0, 6)),
//                             ],
//                           ),
//                         )),
//                   )
//                 ],
//               ),
//             ),
//           );
//         })),
