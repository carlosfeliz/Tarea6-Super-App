import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de Mi'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://media-mia3-2.cdn.whatsapp.net/v/t61.24694-24/325950629_1426530754420584_1281439311613197920_n.jpg?stp=dst-jpg_s96x96&ccb=11-4&oh=01_Q5AaIABnFf4U4umpSWw1rMkp2FqR5GBYH5jvegeAPpO6lX_e&oe=668F0029&_nc_sid=e6ed6c&_nc_cat=105'),  
            ),
            SizedBox(height: 20),
            Text(
              'Carlos Alberto Feliz Recio',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Email: carlosa_feliz@outlook.com',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Teléfono: 829 329 1204',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
