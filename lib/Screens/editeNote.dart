import 'package:contact_app/DB/sqldb.dart';
import 'package:contact_app/Screens/Home.dart';
import 'package:flutter/material.dart';

class EditeNote extends StatefulWidget {
  final id;
  final name;
  final number;




  const EditeNote({Key? key, this.id, required this.name, required this.number}) : super(key: key);

  @override
  State<EditeNote> createState() => _EditeNoteState();
}

class _EditeNoteState extends State<EditeNote> {


  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  @override
  void initState(){
    namecontroller.text = widget.name;
    numbercontroller.text = widget.number;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(title: Text("Add Contact"),),
      body: Container(
        margin: EdgeInsets.only(right: 15,left: 15,top: 45,bottom: 15),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(hintText: "Name",
                        suffixIcon: Icon(Icons.contacts),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      autofocus: true,
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: numbercontroller,
                      decoration: InputDecoration(hintText: "Number",
                        suffixIcon: Icon(Icons.call),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      autofocus: true,
                    ),
                    SizedBox(height: 15,),
                    MaterialButton(onPressed: () async {
                    int response = await sqlDb.updateData(
                        '''UPDATE contact SET 
                    name = "${namecontroller.text}",
                    number = "${numbercontroller.text}"
                    WHERE id = ${widget.id}
                    ''');
                    print("insert Success");
                    if (response > 0){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
                    }
                    },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Edit Contact',style: TextStyle(color: Colors.white),),
                      color: Colors.blue,
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
