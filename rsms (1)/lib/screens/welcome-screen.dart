import 'package:flutter/material.dart';
import 'package:rsms/widgets/app_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const routeName = 'welcome';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        drawer: AppDrawer(),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: deviceSize.height * .3,
                  width: deviceSize.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.menu),
                                  color: Colors.white,
                                  iconSize: 30,
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  }),
                              Text(
                                "RSMS",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                                size: 30,
                              )
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search Properties...",
                            contentPadding: EdgeInsets.all(20),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: Container(
                    height: deviceSize.height * .7,
                    width: deviceSize.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(children: [
                      Container(
                        width: deviceSize.width * .9,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 2),
                              blurRadius: 8,
                              color: Color.fromARGB(255, 228, 228, 228),
                            )
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Browse Properties",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                // width: 110,
                                margin: EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.blue, width: 2))),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.home_outlined,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      "Homes",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 2,
                              ),
                              Container(
                                height: 220,
                                width: 400,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image(
                                    image: AssetImage('assets/House1.jpg'),
                                  ),
                                ),
                              )
                            ]),
                      )
                    ]),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
