import 'package:flutter/material.dart';
import 'doctor_details_page.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  final List<Map<String, dynamic>> doctors = const [
    {
      "name": "Dr. Sarah Ahmed",
      "speciality": "ADHD Specialist",
      "rating": 4.5,
      "location": "Cairo, Egypt",
      "image": "assets/doctors/doctor1.png",
      "about":
          "Dr. Sarah Ahmed is the top most cardiologist specialist in Crist Hospital in London, UK. She achieved several awards for her wonderful contribution.",
    },
    {
      "name": "Dr. Ali Hassan",
      "speciality": "ADHD Specialist",
      "rating": 4.7,
      "location": "Cairo, Egypt",
      "image": "assets/doctors/doctor2.png",
      "about":
          "Dr. Ali Hassan has over 10 years of experience in ADHD treatment and counseling.",
    },
    {
      "name": "Dr. Mona Kamal",
      "speciality": "ADHD Specialist",
      "rating": 4.3,
      "location": "Cairo, Egypt",
      "image": "assets/doctors/doctor3.png",
      "about":
          "Dr. Mona Kamal is an experienced ADHD specialist with a passion for helping children.",
    },
    {
      "name": "Dr. Ahmed Khaled",
      "speciality": "ADHD Specialist",
      "rating": 4.6,
      "location": "Cairo, Egypt",
      "image": "assets/doctors/doctor4.png",
      "about":
          "Dr. Ahmed Khaled focuses on ADHD diagnosis and treatment for all ages.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Recommended Doctors",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsPage(
                    name: doctor["name"],
                    speciality: doctor["speciality"],
                    rating: doctor["rating"],
                    location: doctor["location"],
                    image: doctor["image"],
                    about: doctor["about"],
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.blue, width: 1),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // صورة الدكتور أكبر + فريم
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        doctor["image"],
                        width: 90, // أكبر
                        height: 90, // أكبر
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // بيانات الدكتور
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor["name"],
                            style: const TextStyle(
                              fontSize: 18, // أكبر من قبل
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            doctor["speciality"],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                doctor["rating"].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                doctor["location"],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
