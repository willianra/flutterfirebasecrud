import 'package:firebase_database/firebase_database.dart';


class Persona {
  String _id;
  String _nombre;
  String _correo;
  String _direccion;
  String _celular;
  String _edad;

  Persona(this._id,this._nombre,this._correo,this._direccion,
      this._celular,this._edad);

  Persona.map(dynamic obj){
    this._nombre = obj['nombre'];
    this._correo = obj['correo'];
    this._direccion = obj['direccion'];
    this._celular = obj['celular'];
    this._edad = obj['edad'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get correo => _correo;
  String get direccion => _direccion;
  String get celular => _celular;
  String get edad => _edad;

  Persona.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _correo = snapshot.value['correo'];
    _direccion = snapshot.value['direccion'];
    _celular = snapshot.value['celular'];
    _edad = snapshot.value['edad'];
  }
}