import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_21312007/app/controllers/auth_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universitas Teknokrat Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Nama",
              ),
            ),
            TextField(
              controller: controller.cPass,
              decoration: InputDecoration(
                labelText: "Npm",
              ),
            ),
            SizedBox(
              height: 10,


            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                child: Text("Reset"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => cAuth.Login(
                controller.cEmail.text, 
                controller.cPass.text),
              child: Text("Login")
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum Punya Akun ?"),
                TextButton(
                  onPressed: ()=> Get.toNamed(Routes.SIGNUP), 
                  child: Text("Daftar Disini")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () => cAuth.LoginGoogle(),
              child: Text ("Login with Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 238, 203, 6),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}