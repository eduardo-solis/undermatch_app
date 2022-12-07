import 'package:flutter/material.dart';
import 'package:undermatch_app/routes/routes.dart';
import 'drawer_header.dart';
import 'drawer_item.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const BuildDrawerHeader(),
          BuildDrawerItem(
              icon: Icons.home,
              text: 'Inicio',
              onTap: () => {Navigator.pushNamed(context, Routes.INICIO)}),
          BuildDrawerItem(
              icon: Icons.account_circle,
              text: 'Equipos',
              onTap: () => {Navigator.pushNamed(context, Routes.EQUIPOS)}),
          BuildDrawerItem(
              icon: Icons.movie,
              text: 'Jugadores',
              onTap: () => {Navigator.pushNamed(context, Routes.JUGADORES)}),
          BuildDrawerItem(
              icon: Icons.movie,
              text: 'Proveedores',
              onTap: () => {Navigator.pushNamed(context, Routes.PROVEEDORES)}),
          BuildDrawerItem(
              icon: Icons.movie,
              text: 'Empleados',
              onTap: () => {Navigator.pushNamed(context, Routes.EMPLEADOS)}),
          BuildDrawerItem(
              icon: Icons.movie,
              text: 'Arbitros',
              onTap: () => {Navigator.pushNamed(context, Routes.ARBITROS)}),
          Divider(),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
