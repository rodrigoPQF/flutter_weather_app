

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InicialPage extends StatefulWidget {
  @override
  _InicialPageState createState() => _InicialPageState();
}



class _InicialPageState extends State<InicialPage> {

  TextEditingController txtEstado = TextEditingController();
  TextEditingController txtCidade = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();

  String datas = "";
  String cidade = "";
  int temperatura = null;
  String time = "";
  String currently = "";
  String city = "";
  String condition_slug = "";
  String descricao = "" ;

  String dropdownvalue = "DF";






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: cForm,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 40,
            right: 40,
          ),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 150,
                child: Image.asset("./assets/imgs/weather1.png"),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: txtCidade ,
                validator: validaCidade,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nome da Cidade",
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: txtEstado,
                validator: validaEstado,
                decoration: InputDecoration(
                    labelText: "Estado (Sigla)",
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color(0xFF48639C),
                      Color(0xFF4C4C9D),
                    ],

                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Buscar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Icon(FontAwesomeIcons.searchLocation,
                            color: Colors.white,
                            size: 32,),
                            height: 38,
                            width: 38,
                          ),
                        )

                      ],
                    ),
                    onPressed: getJSONData,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 228,
                height: 178,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Temperatura  °C : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      temperatura!=null ? '$temperatura' : 'Temperatura não encontrada',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    Text(
                      'Hora da análise : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      time!=null? '$time':' Hora não encontrada',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    Text(
                      'Descrição do momento : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      currently!=null?currently:'Descrição não encontrada',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    Text(
                      'Situação meteorológica : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      descricao!=null?descricao:'Situação não informada',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Cidade e Estado : ',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                city!=null?city:'Cidade e Estado não econtrado',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
              ),
              Text(
                'Data : ',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                datas!=null?datas:'Data não informada',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Function validaCidade = ((value){
    if (value == ""){
      return "Digite uma Cidade";
    }
    return null;
  });
  Function validaEstado = ((value){
    if (value == ""){
      return "Digite um Estado";
    }
    return null;
  });

  Future<String> getJSONData() async {
    if(!cForm.currentState.validate())
      return null;

    final String url = 'https://api.hgbrasil.com/weather?key=98b8de85&city_name=${txtCidade.text},${txtEstado.text}';
    var response = await http.get(url);

    Map data = json.decode(response.body);
    setState(() {
      datas = data['results']['date'];
      cidade = data['city'];
      temperatura = data['results']['temp'];
      time = data['results']['time'];
      currently = data['results']['currently'];
      city = data['results']['city'];
      condition_slug = data['results']['condition_slug'];
      descricao = data['results']['description'];

    });
    print(data);
    return "OK";
  }

}
