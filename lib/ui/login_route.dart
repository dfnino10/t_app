import 'package:flutter/material.dart';
import 'package:t_app/service/ConnectivityService.dart';
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
  String _password;
  String _username;
  DateTime _birthDate;
  String _gender;
  bool _isLoginForm;
  bool _isLoading;

  var dateFieldController = TextEditingController();

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
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password, _username, _birthDate, _gender);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null && userId.length > 0 && _isLoginForm) {
          print(userId);
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
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
        onSaved: (value) => _email = value.trim(),
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
                print(_birthDate);
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
            decoration: InputDecoration(
                labelText: "Género",
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ))));
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
