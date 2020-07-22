import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: "Corona App",
    debugShowCheckedModeBanner: false,
    home: COVID(),
  ));
}

class COVID extends StatefulWidget {
  @override
  _COVIDState createState() => _COVIDState();
}

class _COVIDState extends State<COVID> {
  // for loading icon
  bool loading = true;
  List listcountry; // for list of country data

  // taking data from API
  Future<String> _getWorldData() async {
    var response = await http.get("https://brp.com.np/covid/country.php");
    var getData = json.decode(response.body);

    if (this.mounted) {
      setState(() {
        // setstate can be done only in stateful widget
        loading = false;
        listcountry = [getData];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
      _getWorldData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID19 Tracker"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getWorldData();
              }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listcountry == null
                      ? 0
                      : listcountry[0]["countries_stat"].length,
                  itemBuilder: (context, i) {
                    return listitem(i);
                  }),
        ],
      ),
    );
  }

  Widget listitem(int i) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            listcountry[0]["countries_stat"][i]["country_name"],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        listcountry[0]["countries_stat"][i]["active_cases"],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Text(
                        'Affected',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              Expanded(
                child: Container(
                  color: Colors.red[800],
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        listcountry[0]["countries_stat"][i]["deaths"],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Text(
                        'Deaths',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              Expanded(
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        listcountry[0]["countries_stat"][i]["total_recovered"],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                      Text(
                        'Total Recovered',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.deepOrange,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      listcountry[0]["countries_stat"][i]["new_deaths"],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(
                      'New Deaths',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            Expanded(
              child: Container(
                color: Colors.red[300],
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      listcountry[0]["countries_stat"][i]["new_cases"],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(
                      'New Cases',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            Expanded(
              child: Container(
                color: Colors.grey,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      listcountry[0]["countries_stat"][i]["active_cases"],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(
                      'Active Cases',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
