import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(214, 5, 22, 21)),
              accountName: Text('name'.toUpperCase()),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              accountEmail: Text('email'.toUpperCase())),
          DrawerListTile(
              iconData: Icons.person_rounded,
              title: 'Profile',
              onTilePressed: () {}),
          DrawerListTile(
              iconData: Icons.group_rounded,
              title: 'Actors',
              onTilePressed: () {}),
          DrawerListTile(
              iconData: Icons.movie_rounded,
              title: 'Movies',
              onTilePressed: () {}),
          DrawerListTile(
              iconData: Icons.tv_rounded,
              title: 'TV Shows',
              onTilePressed: () {}),
          DrawerListTile(
              iconData: Icons.bookmark_rounded,
              title: 'Whislist',
              onTilePressed: () {}),
          DrawerListTile(
              iconData: Icons.settings_rounded,
              title: 'Settings',
              onTilePressed: () {}),
          const Divider(),
          DrawerListTile(
              iconData: Icons.logout_rounded,
              title: 'Log Out',
              onTilePressed: () {}),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.onTilePressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
