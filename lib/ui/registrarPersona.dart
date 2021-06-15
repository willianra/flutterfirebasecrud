import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notificaciones_topicos_avanzados/model/persona.dart';

 

class RegistrarPersona extends StatefulWidget {
  final Persona product;
  RegistrarPersona(this.product);
  @override
  _RegistrarPersonaState createState() => _RegistrarPersonaState();
}

final personaReference = FirebaseDatabase.instance.reference().child('PERSONA');

class _RegistrarPersonaState extends State<RegistrarPersona> {


  TextEditingController _nombreController;
  TextEditingController _correoController;
  TextEditingController _direccionController;
  TextEditingController _celularController;
  TextEditingController _edadController;
  
   

   
  
  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.product.nombre);
    _correoController = new TextEditingController(text: widget.product.correo);
    _direccionController = new TextEditingController(text: widget.product.direccion);
    _celularController = new TextEditingController(text: widget.product.celular);
    _edadController = new TextEditingController(text: widget.product.edad);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('personas'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
       
        //height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  
                  TextField(
                    controller: _nombreController,
                    style:
                        TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: 'nombre'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _correoController,
                    style:
                        TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.email_rounded), labelText: 'correo'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _direccionController,
                    style:
                        TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.list), labelText: 'direccion'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _celularController,
                    style:
                        TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone), labelText: 'celular'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _edadController,
                    style:
                        TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_add_sharp), labelText: 'edad'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  FlatButton(
                      onPressed: () {
                        //nuevo imagen
                        if (widget.product.id != null) {
                          //si ya existe el registro actuzalizamos 
                          personaReference.child(widget.product.id).set({
                            'nombre': _nombreController.text,
                            'correo': _correoController.text,
                            'direccion': _direccionController.text,
                            'celular': _celularController.text,
                            'edad': _edadController.text,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        } else {
                          //nuevo 
                          personaReference.push().set({
                            'nombre': _nombreController.text,
                            'correo': _correoController.text,
                            'direccion': _direccionController.text,
                            'celular': _celularController.text,
                            'edad': _edadController.text,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: (widget.product.id != null)
                          ? Text('actualizar')
                          : Text('agregar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
