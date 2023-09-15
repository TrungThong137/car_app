import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, required this.name, 
    required this.profession,
  });

  final String name, profession;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.amber,
        child: Icon(Icons.person_outline, color: Colors.white,),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.black
        ),
      ),

      subtitle: Text(
        profession,
        style: const TextStyle(
          color: Colors.black
        ),
      ),
    );
  }
}