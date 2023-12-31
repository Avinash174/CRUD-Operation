import 'package:crud_operation/dbHealper.dart';
import 'package:crud_operation/model/user_model.dart';
import 'package:crud_operation/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel();
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home Screen',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
            SizedBox(
              width: width * .01,
            )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: FutureBuilder(
                  future: UserViewModel().fetchUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                        ),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(right: 20),
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Text(
                              snapshot.data!.data![index].firstName.toString(),
                            ),
                          );
                          // return ListTile(
                          //   leading: CircleAvatar(
                          //     child: ClipRRect(
                          //       borderRadius:
                          //           const BorderRadius.all(Radius.circular(20)),
                          //       child: Image(
                          //         image: NetworkImage(
                          //           snapshot.data!.data![index].avatar.toString(),
                          //         ),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          //   title: Text(
                          //     snapshot.data!.data![index].firstName.toString(),
                          //   ),
                          //   subtitle: Text(
                          //     snapshot.data!.data![index].lastName.toString(),
                          //   ),
                          // );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveDataToLocalDatabase(Map<String, dynamic> data) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.saveData(data);
  }
}
