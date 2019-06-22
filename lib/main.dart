import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './pokemon.dart';
import 'dart:convert';
import './pokedetail.dart';

void main() => runApp(
  MaterialApp(
    title: "Pokemon App",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal
    ),
    home: HomePage(),
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokehub pokehub;

  @override
  void initState() {
    super.initState();

    fetchData();
  }
  fetchData() async {
    var res= await http.get(url);
    var decodedValue=jsonDecode(res.body);
    pokehub=Pokehub.fromJson(decodedValue);

    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
      ),
      body: pokehub==null?Center(
        child: CircularProgressIndicator(),)
          : GridView.count(
          crossAxisCount: 2,
          children: pokehub.pokemon.map((Pokemon p)=> Padding(
              padding:const EdgeInsets.all(2.0) ,
              child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
                      pokemon: p,
                    )));
                  },
                  child:Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                      tag: p.img,
                        child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(p.img)),
                      ),
                    )),
                    Text(p.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                  ],
                ),
              )))).toList(),

      ),

      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.refresh),
      ),
    );
  }
}

