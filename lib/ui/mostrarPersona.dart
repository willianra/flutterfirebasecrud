import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:notificaciones_topicos_avanzados/model/persona.dart';


class MostrarPersona extends StatefulWidget {
  final Persona persona;
  MostrarPersona(this.persona);
  @override
  _MostrarPersonaState createState() => _MostrarPersonaState();
}

final personaReference = FirebaseDatabase.instance.reference().child('PERSONA');

class _MostrarPersonaState extends State<MostrarPersona> {

  @override
  void initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOSTRAR PERSONA'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[                
                new Text("Name : ${widget.persona.nombre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("correo : ${widget.persona.correo}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("direccion : ${widget.persona.direccion}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("celular : ${widget.persona.celular}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Edad : ${widget.persona.edad}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
