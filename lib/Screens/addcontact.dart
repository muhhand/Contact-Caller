import 'package:contact_app/DB/sqldb.dart';
import 'package:contact_app/Screens/Home.dart';
import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SqlDb sqlDb = SqlDb();
    GlobalKey<FormState> formstate = GlobalKey();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController numbercontroller = TextEditingController();

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
                      int response = await sqlDb.insertData('''INSERT INTO contact (name,number) VALUES ("${namecontroller.text}","${numbercontroller.text}")''');
                      print("Inserted Successfully");
                      if(response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
                      }
                    },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Add Contact',style: TextStyle(color: Colors.white),),
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
