class Doctor {
  final String name;
  final String description;
  final String imagePath;

  Doctor(
      {required this.name, required this.description, required this.imagePath});
}

List<Doctor> getDoctorList() {
  List<Doctor> list = [];

  list.add(Doctor(
      name: 'Dr. Romesh Jayasinghe ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Shanez Fernando ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Prof. Dr. Irshad Ahmed ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Shanez Fernando ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Sathya Samaraweera ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Hemamala Karunarathne ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Romesh Jayasinghe ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Shanez Fernando ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Prof. Dr. Irshad Ahmed ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Shanez Fernando ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Sathya Samaraweera ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  list.add(Doctor(
      name: 'Dr. Hemamala Karunarathne ',
      description: 'Therapists',
      imagePath: 'lib/images/doctor1.jpg'));

  return list;
}
