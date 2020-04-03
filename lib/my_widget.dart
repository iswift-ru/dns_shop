import 'package:validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dnsshop/extract_arguments_screen.dart';
import 'dart:convert';


final myControllerFirstName = TextEditingController();
final myControllerLastName = TextEditingController();
final myControllerPhone = TextEditingController();
final myControllerEmail = TextEditingController();
String firstName;
String lastName;
String email;
String phone;
String token;
String data;


class MyWidget extends StatefulWidget {
  @override
  createState() => new MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Введите Ваши данные'),
      ),
      body: SingleChildScrollView(child: MyForm()),

    );
  }
}

class MyForm extends StatefulWidget {
  @override
  State createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();


 // Future<Album> futureAlbum;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Имя',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: myControllerFirstName,
              decoration: InputDecoration(labelText: 'Введите ваше имя'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите своё Имя';
                else{
                  firstName = myControllerFirstName.text;
                  //print(firstName);
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Фамилия',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: myControllerLastName,
              decoration: InputDecoration(labelText: 'Введите свою фамилию'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {return 'Пожалуйста введите свою фамилию';}
                else{
                  lastName = myControllerLastName.text;
                  //print(lastName);
                }

              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Email',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: myControllerEmail,
              decoration: InputDecoration(labelText: 'Введите свой Email'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите свой Email';
                if (!isEmail(value))
                  {return 'У вас ошибка в емейле, или вы пытаетесь сделать незаконную инъекцию';}
                else {
                email = myControllerEmail.text;
                //print(email);
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Телефон',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: myControllerPhone,
              decoration: InputDecoration(labelText: 'Введите свой телефон'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {return 'Пожалуйста введите свой телефон';}
                else{
                  phone = myControllerPhone.text;
                  //print(phone);
                }
              },
            ),
            RaisedButton(
              child: Text('Получить ключ'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Все поля заполнены верно, идём получать токен'),
                    backgroundColor: Colors.green,
                  ));
                  _formKey.currentState.save();

                  _makePostRequest();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
                  Navigator.pushNamed(
                    context,
                    ExtractArgumentsScreen.routeName,
                    arguments: ScreenArguments(
                      firstName, lastName, phone, email, token

                    ),
                  );



                 // Navigator.pushNamed(context, '/second', arguments: phone);
                }
              },
              //padding: EdgeInsets.all(15.0),
            ),
            /*RaisedButton(
              child: Text('Отправить Json'),
              onPressed: _makePostRequest,
            )*/
          ],
        ),
      ),
    );
  }
}


_makePostRequest() async {
  // set up POST request arguments
  String url =
      'https://vacancy.dns-shop.ru/api/candidate/token';

  String json =
      '{"firstName": "$firstName", "lastName": "$lastName", "phone": "$phone", "email": "$email"}';

  // make POST request
  var response = await http.post(url, body: json, headers: {"Content-type": "application/json"});
  //print("Response status: ${response.statusCode}");

  if (response.statusCode == 200){
    //print("Response body: ${response.body}");

    Map<String, dynamic> extractData = jsonDecode(response.body);

    print('Получили токен ${extractData['data']}');
    token = extractData['data'];

    print('записали токен в токен $token');

  }
  else{
    throw Exception('Failed to load');
  }
  // check the status code for the result


}

class ScreenArguments {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String token;

  ScreenArguments(this.firstName, this.lastName, this.phone, this.email, this.token);


}
