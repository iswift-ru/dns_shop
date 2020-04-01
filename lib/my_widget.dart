import 'package:validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
      body: SingleChildScrollView(child: MyForm ()),
    );
  }
}

class MyForm extends StatefulWidget{

  @override
  State createState() => MyFormState();
}

class MyFormState extends State{
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox (height: 10.0,),
            Text ('Имя', style: TextStyle(fontSize: 20.0),),
            TextFormField(
              decoration: InputDecoration(labelText: 'Введите ваше имя'),
              // ignore: missing_return
              validator: (value){
                if(value.isEmpty) return'Пожалуйста введите своё Имя';

              },
            ),
            SizedBox (height: 20.0,),
            Text ('Фамилия', style: TextStyle(fontSize: 20.0),),
            TextFormField(
              decoration: InputDecoration(labelText: 'Введите свою фамилию'),
              // ignore: missing_return
              validator: (value){
                if(value.isEmpty) return'Пожалуйста введите свою фамилию';

              },),
            SizedBox (height: 20.0,),
            Text ('Email', style: TextStyle(fontSize: 20.0),),
            TextFormField(
              decoration: InputDecoration(labelText: 'Введите свой Email'),
              // ignore: missing_return
              validator: (value){
                if(value.isEmpty) return'Пожалуйста введите свой Email';
                if(!isEmail(value)) return 'У вас ошибка в емейле, или вы пытаетесь сделать незаконную инъекцию';

              },
            ),
            SizedBox (height: 20.0,),
            Text ('Телефон', style: TextStyle(fontSize: 20.0),),
            TextFormField(
              decoration: InputDecoration(labelText: 'Введите свой телефон'),
              // ignore: missing_return
              validator: (value){
                if(value.isEmpty) return'Пожалуйста введите свой телефон';

              },),

            RaisedButton(
              child: Text(
            'Получить ключ'
            ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed:() {
                if (_formKey.currentState.validate()){
                  Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Все поля заполнены верно, идём получать токен'),
                  backgroundColor: Colors.green,
                ));

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));

                }
                /*Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(text),
                  backgroundColor: color,
                ));*/
              },
              //padding: EdgeInsets.all(15.0),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Отправка данных')),
      body: MyForm2()
    );
  }
}
class MyForm2 extends StatefulWidget{

  @override
  State createState() => MyFormState2();
}

class MyFormState2 extends State{
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey2,
        child: Column(
          children: <Widget>[
            SizedBox (height: 10.0,),
            Text ('GitHub', style: TextStyle(fontSize: 20.0),),
            TextFormField(
              decoration: InputDecoration(labelText: 'ссылка на github'),
              // ignore: missing_return
              validator: (value){
                if(value.isEmpty) return'Пожалуйста введите ссылку на github';

              },
            ),
            SizedBox (height: 20.0,),
            Text ('Резюме', style: TextStyle(fontSize: 20.0),),
            TextFormField(
              decoration: InputDecoration(labelText: 'Введите ссылку на резюме'),
              // ignore: missing_return
              validator: (value){
                if(value.isEmpty) return'Пожалуйста введите ссылку на резюме';

              },),

            RaisedButton(
              child: Text(
                  'Зарегистрироваться'
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed:() {
                if (_formKey2.currentState.validate()){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Все поля заполнены верно, регистрируемся'),
                    backgroundColor: Colors.green,
                  ));



                }

              },
              //padding: EdgeInsets.all(15.0),
            ),
          ],
        ),
      ),
    );
  }
}