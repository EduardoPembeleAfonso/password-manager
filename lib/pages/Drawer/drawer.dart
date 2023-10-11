import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// bloc
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';

// pages
import 'package:password_manager/pages/SignIn/sign_in.dart';
import 'package:password_manager/pages/Dashboard/dashboard.dart';
import 'package:password_manager/pages/Analizy/analizy.dart';
import 'package:password_manager/pages/About/about.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Dashboard(),
    Analizy(),
    Text(
      'Index 2: AVALIAR',
      style: optionStyle,
    ),
    About()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF00a093),
          iconTheme: const IconThemeData(color: Colors.white, size: 40),
          elevation: 0,
          title: Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 2 / 1,
            padding: const EdgeInsets.only(left: 285),
            child: const IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                size: 40,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          )),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navega para a tela de login(sign in)
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: _widgetOptions[_selectedIndex],
      ),
      // key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(249, 251, 250, 1),
                Color.fromRGBO(44, 171, 146, 1)
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                selected: _selectedIndex == 1,
                title: Text(
                  'Início',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                leading: const Icon(Icons.home_outlined,
                    color: Colors.white, size: 25.0),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selected: _selectedIndex == 2,
                leading: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.white,
                  size: 25.0,
                ),
                title: Text(
                  'Analise',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selected: _selectedIndex == 3,
                leading: const Icon(
                  Icons.rate_review_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  'Avaliar',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  _onItemTapped(3);
                },
              ),
              ListTile(
                selected: _selectedIndex == 4,
                leading: const Icon(
                  Icons.info_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  'Sobre',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  _onItemTapped(4);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  selected: _selectedIndex == 5,
                  leading: const Icon(
                    Icons.input,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Sair',
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      SignOutRequested(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
