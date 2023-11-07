import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// repos
import 'package:password_manager/database/repositories/account_repository.dart';

// pages
import 'package:password_manager/pages/GeneratePassword/generate_password.dart';

class Analyse extends StatefulWidget {
  const Analyse({super.key});

  @override
  State<Analyse> createState() => _AnalyseState();
}

class _AnalyseState extends State<Analyse> {
  final _accountRepository = AccountRepository();

  late int? risk = 0;
  late int? safe = 0;
  late int? weak = 0;
  late String? progressSecurity = '0%';

  @override
  void initState() {
    progressSecurity = '0%';
    super.initState();
    _accountRepository.getAccounts();
    getAllLevels();
  }

  void getAllLevels() async {
    risk = await _accountRepository.getAccountsSecurityLevelZero();
    safe = await _accountRepository.getAccountsSecurityLevelOne();
    weak = await _accountRepository.getAccountsSecurityLevelTwo();

    if (safe! < risk! && weak! <= risk!) {
      setState(() {
        progressSecurity = '10%';
      });
    }

    if (safe! < risk! && weak! >= risk!) {
      setState(() {
        progressSecurity = '20%';
      });
    }

    if (safe == risk && weak == 0 || safe == risk && weak! >= risk!) {
      setState(() {
        progressSecurity = '40%';
      });
    }

    if (safe! > risk! && weak! == risk!) {
      setState(() {
        progressSecurity = '60%';
      });
    }

    if (safe! > risk! && weak! > risk!) {
      setState(() {
        progressSecurity = '80%';
      });
    }

    if (safe! > risk! && safe! > weak! && weak! <= 3) {
      setState(() {
        progressSecurity = '90%';
      });
    }

    if (safe! > risk! && weak == 0 && risk! == 0) {
      setState(() {
        progressSecurity = '100%';
      });
    }
  }

  void _goEditPasswordOfAccount(id, email, website, category, icon, password, security) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => GeneratePassword(
          itemId: id,
          itemEmail: email,
          itemWebsite: website,
          itemCategory: category,
          itemIcon: icon,
          itemPassword: password,
          itemSecurity: security
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'analyse',
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              Container(
                color: const Color(0xFF00a093),
                height: 180,
                child: Column(
                  children: [
                    Text(
                      'Segurança',
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.displayMedium,
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 95, 217, 99),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 2,
                                color: Colors.transparent,
                                style: BorderStyle.solid)),
                        child: Container(
                          width: 90,
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                  style: BorderStyle.solid)),
                          child: Text('$progressSecurity'),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        '$progressSecurity seguro.',
                        style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color(0xFF00a093),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 238, 238),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    border: Border.all(
                      width: 1,
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1, color: const Color(0xFFB4B4B4))),
                          child: Column(
                            children: [
                              Text(
                                '$safe',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Seguro',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1, color: const Color(0xFFB4B4B4))),
                          child: Column(
                            children: [
                              Text(
                                '$weak',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Fraca',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1, color: const Color(0xFFB4B4B4))),
                          child: Column(
                            children: [
                              Text(
                                '$risk',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Risco',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25, left: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Analise',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                          future: _accountRepository.getAccounts(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: ((context, index) {
                                    return buildAccounts(snapshot, index);
                                  }));
                            } else {
                              return const Center(
                                child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator()),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildAccounts(AsyncSnapshot<dynamic> snapshot, int index) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFf8f7fe),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
              ),
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      Image.file(File(snapshot.data[index]['image'])).image),
            ),
            Container(
              width: 220,
              height: 100,
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snapshot.data[index]['link'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  Text(snapshot.data[index]['password'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFc7c7ca))),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 190,
                    height: 5,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 205, 202, 202),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        margin: EdgeInsets.only(
                          right: snapshot.data[index]['security'] == 1
                              ? 0
                              : snapshot.data[index]['security'] == 2
                                  ? 50
                                  : 125,
                        ),
                        height: 5,
                        decoration: BoxDecoration(
                            color: snapshot.data[index]['security'] == 1
                                ? const Color.fromARGB(255, 95, 217, 99)
                                : snapshot.data[index]['security'] == 2
                                    ? Colors.amber
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ),
            Container(
                height: 80,
                width: 50,
                margin: const EdgeInsets.only(bottom: 0.0),
                child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: () {
                      _goEditPasswordOfAccount(
                          snapshot.data[index]['id'],
                          snapshot.data[index]['contact'],
                          snapshot.data[index]['link'],
                          snapshot.data[index]['categoryId'],
                          snapshot.data[index]['image'],
                          snapshot.data[index]['password'],
                          snapshot.data[index]['security']);
                    })),
          ],
        ),
      ),
    );
  }
}
