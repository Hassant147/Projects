import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsms/providers/auth.dart';
import 'package:rsms/screens/homeinput.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('RSMS!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Property'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(userInputScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Properties'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.space_dashboard_outlined),
            title: Text('Dashboard'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).errorColor,
            ),
            title: Text('Log Out'),
            textColor: Theme.of(context).errorColor,
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
