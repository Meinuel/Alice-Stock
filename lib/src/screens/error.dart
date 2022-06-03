import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Function reload;
  const ErrorPage({Key? key , required this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error , revisa tu conexion'),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () => reload(), child: const Text('Reintentar'))
          ],
        ),
      ),
    );
  }
}