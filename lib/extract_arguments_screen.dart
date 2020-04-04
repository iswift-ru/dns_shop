import 'package:flutter/material.dart';
import 'package:dnsshop/my_widget.dart';
import 'package:http/http.dart' as http;

final myControllerGitHub =
    TextEditingController(text: 'https://github.com/iswift-ru');
final myControllerSummary = TextEditingController(
    text: 'https://spb.hh.ru/resume/0ab0f473ff07ce16eb0039ed1f57695958746e');
String gitHub;
String summary;
String server;


class ExtractArgumentsScreen extends StatefulWidget {
  static const routeName = '/extractArguments';

  @override
  _ExtractArgumentsScreenState createState() => _ExtractArgumentsScreenState();
}

class _ExtractArgumentsScreenState extends State<ExtractArgumentsScreen> {
  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    print(args.firstName);
    print(args.lastName);
    print(args.phone);
    print(args.email);
    print(args.token);

    return Scaffold(
      appBar: AppBar(
        title: Text('Отправка данных'),
      ),
      body: SingleChildScrollView(child: MyForm2()),
    );
  }
}

class MyForm2 extends StatefulWidget {
  @override
  State createState() => MyFormState2();
}

class MyFormState2 extends State<MyForm2> {
  final _formKey2 = GlobalKey<FormState>();
  Future serverFuture;
  bool runFutureBuilder = false;

  @override
  void initState() {
    super.initState();
    serverFuture = _makePostRequestRegistration();
  }

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
                if (value.isEmpty)
                  return 'Пожалуйста введите ссылку на github';
                else {
                  gitHub = myControllerGitHub.text;
                }
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
                if (value.isEmpty)
                  return 'Пожалуйста введите ссылку на резюме';
                else {
                  summary = myControllerSummary.text;
                }
              },
            ),
            RaisedButton(
              child: Text('Зарегистрироваться'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey2.currentState.validate()) {
                  runFutureBuilder = true;
                  _makePostRequestRegistration();

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(server??'Нажмите кнопку ещё раз'),
                    backgroundColor: Colors.green,

                  ));
                }
              },

            ),
            Text(
                'Чтобы увидеть ответ сервера на экране нажмите повторно кнопку Зарегистрироваться'),
          ],
        ),
      ),
    );
  }
}

_makePostRequestRegistration() async {

  String url = 'https://vacancy.dns-shop.ru/api/candidate/summary';

  String json =
      '{"firstName": "$firstName", "lastName": "$lastName", "phone": "$phone", "email": "$email","githubProfileUrl": "$gitHub", "summary": "$summary"}';


  var response = await http.post(url, body: json, headers: {
    "Content-type": "application/json",
    "authorization": "Bearer $token"
  });

  print("Response status: ${response.statusCode}");

  if (response.statusCode == 200) {


    server = response.body;

    print('Ответ сервера $server');

  } else {
    throw Exception('Failed to load!');
  }
}
