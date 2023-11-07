import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// bloc
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';

// pages
import 'package:password_manager/pages/Available/available.dart';
import 'package:password_manager/pages/Dashboard/dashboard.dart';
import 'package:password_manager/pages/Analyse/analyse.dart';
import 'package:password_manager/pages/SignIn/sign_in.dart';
import 'package:password_manager/pages/About/about.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    super.key,
    required this.pageId,
  });

  final int pageId;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Dashboard(),
    const Analyse(),
    const Available(),
    const About()
  ];

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageId = widget.pageId;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF00a093),
          iconTheme: const IconThemeData(color: Colors.white, size: 40),
          elevation: 0,
          title: Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 2 / 1,
            padding: const EdgeInsets.only(left: 285),
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
        child: _widgetOptions[_selectedIndex == 0 ? pageId : _selectedIndex],
      ),
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
            padding: const EdgeInsets.all(10),
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme:
                      const DividerThemeData(color: Colors.transparent),
                ),
                child: DrawerHeader(
                  child: Lottie.asset('assets/lotties/drawer.json'),
                ),
              ),
              Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    height: 50,
                    left: 0,
                    width: _selectedIndex == 1 ? 280 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3c4950),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.transparent),
                      ),
                    ),
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
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
              Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    height: 50,
                    left: 0,
                    width: _selectedIndex == 2 ? 280 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3c4950),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.transparent),
                      ),
                    ),
                  ),
                  ListTile(
                    selected: _selectedIndex == 2,
                    leading: const Icon(
                      Icons.analytics_outlined,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: Text(
                      'Análise',
                      style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      _onItemTapped(2);
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
              Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    height: 50,
                    left: 0,
                    width: _selectedIndex == 3 ? 280 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3c4950),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.transparent),
                      ),
                    ),
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
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
              Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    height: 50,
                    left: 0,
                    width: _selectedIndex == 4 ? 280 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3c4950),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.transparent),
                      ),
                    ),
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
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: _selectedIndex == 5
                        ? const Color(0xFF3c4950)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1, color: Colors.transparent)),
                child: ListTile(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
