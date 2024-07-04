import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: AppointmentBookingScreen(),
  ));
}

class AppointmentBookingScreen extends StatefulWidget {
  @override
  _AppointmentBookingScreenState createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedService;
  String? _selectedDoctor;
  String? _selectedTime;

  final List<String> _services = [
    'General Checkup',
    'Dental',
    'Cardiology',
    'Dermatology',
    'Pediatrics',
    'Neurology',
    'Orthopedics',
    'Gastroenterology',
    'Gynecology',
    'ENT (Ear, Nose, Throat)',
    'Rheumatology',
    'Nephrology',
    'Hematology',
  ];

  final Map<String, List<String>> _doctors = {
    'General Checkup': ['Dr. Peter Wanyonyi', 'Dr. Johnson'],
    'Dental': ['Dr. Antony', 'Dr. Davis'],
    'Cardiology': ['Dr. Wilson', 'Dr. Martinez'],
    'Dermatology': ['Dr. Anderson', 'Dr. Taylor'],
    'Pediatrics': ['Dr. Peter Wanyonyi'],
    // Add more doctors for other services as needed
  };

  final Map<String, List<String>> _availableTimes = {
    'Dr. Peter Wanyonyi': ['9:00 AM', '11:00 AM', '2:00 PM'],
    'Dr. Johnson': ['10:00 AM', '1:00 PM', '3:00 PM'],
    'Dr. Antony': ['9:30 AM', '12:00 PM', '2:30 PM'],
    'Dr. Davis': ['10:30 AM', '1:30 PM', '3:30 PM'],
    // Add available times for other doctors as needed
  };

  final List<Map<String, String>> _bookedAppointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Select Date'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedService,
                    decoration: InputDecoration(labelText: 'Select Service'),
                    items: _services.map((service) {
                      return DropdownMenuItem(
                        value: service,
                        child: Text(service),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedService = value;
                        _selectedDoctor = null; // Reset doctor selection when service changes
                        _selectedTime = null; // Reset time selection when service changes
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a service';
                      }
                      return null;
                    },
                  ),
                  if (_selectedService != null) ...[
                    DropdownButtonFormField<String>(
                      value: _selectedDoctor,
                      decoration: InputDecoration(labelText: 'Select Doctor'),
                      items: (_doctors[_selectedService] ?? []).map((doctor) {
                        return DropdownMenuItem(
                          value: doctor,
                          child: Text(doctor),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDoctor = value;
                          _selectedTime = null; // Reset time selection when doctor changes
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a doctor';
                        }
                        return null;
                      },
                    ),
                  ],
                  if (_selectedDoctor != null) ...[
                    DropdownButtonFormField<String>(
                      value: _selectedTime,
                      decoration: InputDecoration(labelText: 'Select Time'),
                      items: (_availableTimes[_selectedDoctor] ?? []).map((time) {
                        return DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTime = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _bookAppointment();
                      }
                    },
                    child: Text('Book Appointment'),
                  ),
                  SizedBox(height: 20),
                  _buildBookedAppointments(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _bookAppointment() {
    setState(() {
      _bookedAppointments.add({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'date': _dateController.text,
        'service': _selectedService!,
        'doctor': _selectedDoctor!,
        'time': _selectedTime!,
      });
    });

    _nameController.clear();
    _phoneController.clear();
    _dateController.clear();
    setState(() {
      _selectedService = null;
      _selectedDoctor = null;
      _selectedTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment booked successfully')),
    );
  }

  Widget _buildBookedAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booked Appointments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ..._bookedAppointments.map((appointment) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text('Service: ${appointment['service']}'),
              subtitle: Text(
                'Doctor: ${appointment['doctor']}\n'
                    'Time: ${appointment['time']}\n'
                    'Date: ${appointment['date']}\n'
                    'Name: ${appointment['name']}\n'
                    'Phone: ${appointment['phone']}',
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _cancelAppointment(appointment);
                },
                child: const Text('Cancel'),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  void _cancelAppointment(Map<String, String> appointment) {
    setState(() {
      _bookedAppointments.remove(appointment);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment canceled successfully')),
    );
  }
}
