import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/Whather_Helper.dart';
import '../model/Whather_model.dart';
import '../provider/whather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider? providertrue;
  HomeProvider? providerfalse;

  @override
  Widget build(BuildContext context) {
    providertrue = Provider.of<HomeProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/images.jpeg",
                  fit: BoxFit.fill,
                )),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black54,
            ),
            FutureBuilder(
              future: Api_http().weatherdata(providertrue!.city == null
                  ? "Surat"
                  : "${providertrue!.city}"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                if (snapshot.hasData) {
                  Homemodel? h1 = snapshot.data as Homemodel?;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: providertrue!.txtcity,
                            cursorColor: Colors.white70,
                            style: TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  providertrue!.search();
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                              label: Text(
                                "Search City",
                                style: TextStyle(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: Text(
                                "${h1!.name}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${(h1.main!.temp! - 273).toStringAsFixed(0)}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 90,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 72),
                                  child: Text(
                                    ".",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 75),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 11),
                                  child: Text(
                                    "c",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: Text(
                                  "${h1.weather![0].description}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 185),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}