import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:t_app/service/ConnectionStatusSingleton.dart';
import 'package:t_app/service/authentication.dart';
import 'package:t_app/ui/custom_dropdown.dart';

//Code adapted from https://github.com/tattwei46/flutter_login_demo/blob/master/lib/pages/login_signup_page.dart
class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _errorMessage;
  String _email;
  String _phoneNumber;
  String _password;
  String _username;
  DateTime _birthDate;
  String _gender;
  bool _isLoginForm;
  bool _isLoading;

  bool _connected;

  bool _flushBarOn;

  var dateFieldController = TextEditingController();

  ConnectionStatusSingleton conn;

  StreamSubscription _streamSubscription;

  Flushbar flushbar;

  void _validateConnection(dynamic hasConnection) {
    if (hasConnection == false) {
      if (_flushBarOn == false) {
        setState(() {
          _connected = hasConnection;
          _flushBarOn = true;
          flushbar.show(context);
        });
      }
    } else {
      if (_flushBarOn == true) {
        setState(() {
          _connected = hasConnection;
          _flushBarOn = false;
          flushbar.dismiss(true);
        });
      }
    }
  }

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave() && _connected) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          if (userId != null && userId.length > 0) {
            widget.loginCallback();
            print('Signed in: $userId');
          } else {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text("Usuario o contraseña incorrectos"),
                    children: <Widget>[
                      SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Aceptar"))
                    ],
                  );
                });
          }
        } else {
          userId = await widget.auth.signUp(
              _email, _phoneNumber, _password, _username, _birthDate, _gender);
          if (userId != null && userId.length > 0) {
            widget.loginCallback();
            print('Signed up user: $userId');
          } else {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title:
                        Text("El correo electrónico ingresado ya está en uso"),
                    children: <Widget>[
                      SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Aceptar"))
                    ],
                  );
                });
          }
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _formKey.currentState.reset();
        });
      }
    } else {
      if(_connected == false) {
        setState(() {
          _isLoading = false;
        });
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title:
                Text("No hay conexión con el servidor"),
                children: <Widget>[
                  SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Aceptar"))
                ],
              );
            });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    flushbar = Flushbar(message: "Sin conexión");
    _connected = true;
    _flushBarOn = false;
    conn = ConnectionStatusSingleton.getInstance();
    conn.initialize();
    _streamSubscription = conn.connectionChange.listen(_validateConnection);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        _showForm(),
        _showCircularProgress(),
      ],
    ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    if (_isLoginForm) {
      return _showLoginForm();
    } else {
      return _showSignupForm();
    }
  }

  Widget _showLoginForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
            ],
          ),
        ));
  }

  Widget _showSignupForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showEmailInput(),
              showPhoneNumberInput(),
              showUsernameInput(),
              showBirthdateInput(),
              showGenderInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
            ],
          ),
        ));
  }

  Widget showErrorSnackbar(context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(_isLoginForm
          ? "Hubo un problema en el servidor para iniciar sesión"
          : "Hubo un problema en el servidor para registrarse"),
      action: SnackBarAction(
        label: "Aceptar",
        onPressed: () {},
      ),
      duration: Duration(seconds: 60),
    ));
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        autovalidate: true,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        maxLength: 64,
        decoration: new InputDecoration(
            labelText: 'Correo electrónico',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) =>
            !RegExp('^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$')
                    .hasMatch(value)
                ? 'Ingresa un correo electrónico válido'
                : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPhoneNumberInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        autovalidate: true,
        maxLines: 1,
        maxLength: 10,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Número de teléfono celular',
            icon: new Icon(
              Icons.phone,
              color: Colors.grey,
            )),
        validator: (value) => !RegExp("[3][0-9]{9}\$").hasMatch(value)
            ? 'Ingresa un número de teléfono válido'
            : null,
        onSaved: (value) => _phoneNumber = value.trim(),
      ),
    );
  }

  Widget showUsernameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        autovalidate: true,
        maxLines: 1,
        maxLength: 32,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Nombre y apellidos',
            icon: new Icon(
              Icons.text_format,
              color: Colors.grey,
            )),
        validator: (value) => !RegExp("^([a-zA-Z]+[ ]*)*\$").hasMatch(value)
            ? 'Ingresa un nombre y apellido válidos'
            : null,
        onSaved: (value) => _username = value.trim(),
      ),
    );
  }

  Widget showBirthdateInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: InkWell(
          onTap: () async {
            final date = await showDatePicker(
                context: context,
                initialDate: new DateTime.now(),
                firstDate: new DateTime(1940),
                lastDate: new DateTime(2020));
            if (date != null) {
              setState(() {
                _birthDate = date;
                dateFieldController.text = _birthDate.day.toString() +
                    "/" +
                    _birthDate.month.toString() +
                    "/" +
                    _birthDate.year.toString();
              });
            }
          },
          child: IgnorePointer(
            child: TextFormField(
              controller: dateFieldController,
              decoration: InputDecoration(
                labelText: "Fecha de nacimiento",
                icon: Icon(Icons.calendar_today, color: Colors.grey),
              ),
              onSaved: (String val) {},
            ),
          ),
        ));
  }

  Widget showGenderInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: MyDropDown(
        items: ["Masculino", "Femenino", "Otro"],
        onChanged: (value) {
          setState(() => {_gender = value});
        },
        decoration: InputDecoration(
            labelText: "Género",
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        autovalidate: true,
        maxLines: 1,
        maxLength: 128,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Contraseña',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Ingresa una contraseña' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm
                ? 'Crear cuenta'
                : '¿Ya tienes una cuenta? Inicia sesión',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Theme.of(context).accentColor,
            child: new Text(_isLoginForm ? 'Iniciar sesión' : 'Crear cuenta',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
