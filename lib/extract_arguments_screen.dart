import 'package:flutter/material.dart';
import 'package:dnsshop/my_widget.dart';
import 'package:http/http.dart' as http;

final myControllerGitHub = TextEditingController();
final myControllerSummary = TextEditingController();
String gitHub;
String summary;
String server;

// A widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatefulWidget {
  static const routeName = '/extractArguments';

  @override
  _ExtractArgumentsScreenState createState() => _ExtractArgumentsScreenState();
}

class _ExtractArgumentsScreenState extends State<ExtractArgumentsScreen> {
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    print(args.firstName);
    print(args.lastName);
    print(args.phone);
    print(args.email);
    print(args.token);

    return Scaffold(
      appBar: AppBar(
        title: Text('Отправка данных '), //${args.firstName}
      ),

      body: SingleChildScrollView(child: MyForm2()),
      );

  }



}

class MyForm2 extends StatefulWidget {


  @override
  State createState() => MyFormState2();
}

class MyFormState2 extends State {

  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey2,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'GitHub',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: myControllerGitHub,
              decoration: InputDecoration(labelText: 'ссылка на github'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите ссылку на github';
                else{gitHub = myControllerGitHub.text;}
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Резюме',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: myControllerSummary,
              decoration:
              InputDecoration(labelText: 'Введите ссылку на резюме'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите ссылку на резюме';
                else{
                  summary = myControllerSummary.text;
                }
              },
            ),
            RaisedButton(
              child: Text('Зарегистрироваться'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  if (_formKey2.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Все поля заполнены верно, регистрируемся'),
                      backgroundColor: Colors.green,
                    ));
                    _makePostRequestRegistration();


                  }
                });

              },
              //padding: EdgeInsets.all(15.0),
            ),

            //Text(args.firstName),
            //Text(args.lastName),
            //Text(args.phone),
            //Text(args.email),
            //Text(args.token??'сука'),
            Text('Ответ от сервера: $server')

          ],
        ),
      ),
    );
  }
}

_makePostRequestRegistration() async {
  // set up POST request arguments
  String url =
      'https://vacancy.dns-shop.ru/api/candidate/summary';

  String json =
      '{"firstName": "$firstName", "lastName": "$lastName", "phone": "$phone", "email": "$email","githubProfileUrl": "$gitHub", "summary": "$summary"}';
  //'{"firstName": "Артём", "lastName": "Лобазин", "phone": "+7771515", "email": "123@example.com", "githubProfileUrl": "https://github.com/1", "summary": "https://ligalise.ru/abc"}';

  //var response = await http.post(url, body: json, headers: {"Content-type": "application/json", "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicnJyciIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3N1cm5hbWUiOiJ0dHR0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiI3Nzc3NzciLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiI0NTY3QDEyMy5ydSIsImV4cCI6MTU4NjAxMTg0NSwiaXNzIjoiZG5zLmhlYWRodW50ZXIiLCJhdWQiOiJjYW5kaWRhdGUifQ.KwMEKQIbbt6D3bEDaG7jKpMv5H17r7Ch8inEn03p3DE"});
  var response = await http.post(url, body: json, headers: {"Content-type": "application/json", "authorization": "Bearer $token"});
  print("Response status: ${response.statusCode}");

  if (response.statusCode == 200){
    //print("Response body: ${response.body}");
    server = response.body;
    print('Вот такой ответ мы получаем от сервера $server');

  }
  else{
    throw Exception('Failed to load');
  }
  // check the status code for the result


}