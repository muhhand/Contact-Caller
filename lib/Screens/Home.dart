import 'package:contact_app/DB/sqldb.dart';
import 'package:contact_app/Screens/editeNote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {


  SqlDb sqlDb = SqlDb();
  List contacts = [];
  bool isLoading = true;
  String number2 = "+201283537869";

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM contact");
    contacts.addAll(response);
    isLoading = false;
    if (this.mounted){
      setState((){

      });
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts Caller',),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("addcontact");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contacts.length,
                itemBuilder: (context,i){
                  return Card(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.contacts),
                      ),
                      title: Text("${contacts[i]['name']}"),
                      subtitle: Text("${contacts[i]['number']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () async {
                            int response = await sqlDb.deletedata("DELETE FROM contact WHERE id = ${contacts[i]['id']} ");
                            if (response > 0){
                              contacts.removeWhere((element) => element['id'] == contacts[i]['id']);
                              setState((){
                              });
                            }
                          },
                              icon: Icon(Icons.delete,color: Colors.red,)),
                          IconButton(onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditeNote(
                                name : contacts[i]['name'],
                                number: contacts[i]['number'],
                                id: contacts[i]['id'],
                              ))
                            );
                          },
                              icon: Icon(Icons.edit,color: Colors.blue,)),
                          IconButton(onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber("${contacts[i]['number']}");
                          },
                              icon: Icon(Icons.call,color: Colors.blue,)),
                        ],
                      ),
                    ),
                  );
                }
             )
          ],
        ),
      ),
    );
  }
}
