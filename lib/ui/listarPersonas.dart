import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:notificaciones_topicos_avanzados/model/persona.dart';
import 'package:notificaciones_topicos_avanzados/ui/registrarPersona.dart';
import 'package:notificaciones_topicos_avanzados/ui/mostrarPersona.dart';


class ListViewPersona extends StatefulWidget {
  @override
  _ListViewPersonaState createState() => _ListViewPersonaState();
}

final personaReference = FirebaseDatabase.instance.reference().child('PERSONA');

class _ListViewPersonaState extends State<ListViewPersona> {
  List<Persona> items;
  //agregar usuario
  StreamSubscription<Event> _onPersonaAddedSubscription;
  StreamSubscription<Event> _onPersonaChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onPersonaAddedSubscription =
        personaReference.onChildAdded.listen(_onProductAdded);
    _onPersonaChangedSubscription =
        personaReference.onChildChanged.listen(_onProductUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onPersonaAddedSubscription.cancel();
    _onPersonaChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PERSONA'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,          
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 3.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),                    
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(                      
                        child: Row(
                          children: <Widget>[
                            //nuevo imagen
                              
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    '${items[position].nombre}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${items[position].correo}'+'\n'+'${items[position].celular}'+'\n'+'${items[position].edad}años'+'\n'+'${items[position].direccion} ',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  onTap: () => _navigateToProductInformation(
                                      context, items[position])),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _showDialog(context, position),
                                ),
                                
                            //onPressed: () => _deleteProduct(context, items[position],position)),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () =>
                                    _navigateToProduct(context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: () => _crearPersona(context),
        ),
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('estas segu?'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.purple,
                ),
                onPressed: () =>
                  _deleteProduct(context, items[position], position,),                                        
                    ),                   
            new FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onProductAdded(Event event) {
    setState(() {
      items.add(new Persona.fromSnapShot(event.snapshot));
    });
  }

  void _onProductUpdate(Event event) {
    var oldProductValue =
        items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
          new Persona.fromSnapShot(event.snapshot);
    });
  }

  void _deleteProduct(
      BuildContext context, Persona product, int position) async {
    await personaReference.child(product.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToProductInformation(
      BuildContext context, Persona product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrarPersona(product)),
    );
  }

  void _navigateToProduct(BuildContext context, Persona product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MostrarPersona(product)),
    );
  }

  void _crearPersona(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RegistrarPersona(Persona(null, '', '', '', '', ''))),
    );
  }

  
}