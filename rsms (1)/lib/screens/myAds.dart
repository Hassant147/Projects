// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsms/models/home.dart';
import '../providers/homeprovider.dart';

class MyadsScreen extends StatelessWidget {
  const MyadsScreen({Key? key}) : super(key: key);
  static const routeName = '/myads';

  @override
  Widget build(BuildContext context) {
    final homesdata = Provider.of<Homes>(context);
    final homes = homesdata.items;
    //final home = Provider.of<Home>(context, listen: false);
    Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
      ),
    );
    return ListView.builder(
      padding: const EdgeInsets.all(50.0),
      itemCount: homes.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  homesdata.items[index].imageurl,
                  width: 318,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Card(
                child: ListTile(
                  // leading: FlutterLogo(size: 55),
                  title: Text(homesdata.items[index].adTitle),
                  subtitle: Text(
                    'Rent: ${homesdata.items[index].rent.toString()}',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(
                    Icons.arrow_right_outlined,
                    size: 30,
                  ),
                  isThreeLine: true,
                ),
              ),
              Padding(padding: EdgeInsets.all(50))
            ],
          ),
        );
      },
    );
  }
}
