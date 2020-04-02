import 'package:flutter/material.dart';
//import 'package:routing_prep/main.dart';
import 'package:dnsshop/second_screen.dart';
import 'package:dnsshop/my_widget.dart';
import 'package:dnsshop/route_generator.dart';




class SecondScreen extends StatelessWidget {

  final String data;
  SecondScreen({
    Key key,
    @required this.data,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Отправка данных')), body: MyForm2());
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
              decoration: InputDecoration(labelText: 'ссылка на github'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите ссылку на github';
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
              decoration:
              InputDecoration(labelText: 'Введите ссылку на резюме'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите ссылку на резюме';
              },
            ),
            RaisedButton(
              child: Text('Зарегистрироваться'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey2.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Все поля заполнены верно, регистрируемся'),
                    backgroundColor: Colors.green,
                  ));
                }
              },
              //padding: EdgeInsets.all(15.0),
            ),
            Text(
              data??'Нифига не передалось почему то?!',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}