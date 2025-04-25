import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning2/dsr_entry_screen/phone_call_with_unregisterd_purchaser.dart';
import 'package:learning2/dsr_entry_screen/work_from_home.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'dart:io'; // Import dart:io for File
import 'package:learning2/dsr_entry_screen/dsr_entry.dart';

import 'Meeting_with_new_purchaser.dart';
import 'Meetings_With_Contractor.dart';
import 'any_other_activity.dart';
import 'btl_activites.dart';
import 'check_sampling_at_site.dart';
import 'dsr_retailer_in_out.dart';
import 'internal_team_meeting.dart';
import 'office_work.dart';
import 'on_leave.dart';

class PhoneCallWithBuilder extends StatefulWidget {
  const PhoneCallWithBuilder({super.key});

  @override
  State<PhoneCallWithBuilder> createState() => _PhoneCallWithBuilderState();
}

final _formKey = GlobalKey<FormState>();

class _PhoneCallWithBuilderState extends State<PhoneCallWithBuilder> {
  String? _processItem = 'Select';
  final List<String> _processdropdownItems = [
    'Select',
    'Add',
    'Update',
  ];

  String? _purchaserItem = 'Select';
  final List<String> _purchaserdropdownItems = [
    'Select',
    'Purchaser(Non Trade)',
    'AUTHORISED DEALER',
  ];

  String? _metWthItem = 'Select';
  final List<String> _metWithdropdownItems = [
    'Select',
    'Builder',
    'Contractor',
  ];

  String? _activityItem = 'Phone Call with Builder/Stockist';
  final List<String> _activityDropDownItems = [
    'Select',
    'Personal Visit',
    'Phone Call with Builder/Stockist',
    'Meetings With Contractor / Stockist',
    'Visit to Get / Check Sampling at Site',
    'Meeting with New Purchaser(Trade Purchaser)/Retailer',
    'BTL Activities',
    'Internal Team Meetings / Review Meetings',
    'Office Work',
    'On Leave / Holiday / Off Day',
    'Work From Home',
    'Any Other Activity',
    'Phone call with Unregistered Purchasers',
  ];

  String _areaCode = 'Select';
  final List<String> _majorCitiesInIndia = [
    'Select',
    'Agra',
    'Ahmedabad',
    'Ajmer',
    'Akola',
    'Aligarh',
    'Allahabad',
    'Alwar',
    'Ambala',
    'Amravati',
    'Amritsar',
    'Anand',
    'Anantapur',
    'Aurangabad',
    'Asansol',
    'Bareilly',
    'Bengaluru',
    'Belgaum',
    'Bhagalpur',
    'Bhavnagar',
    'Bhilai',
    'Bhiwandi',
    'Bhopal',
    'Bhubaneswar',
    'Bikaner',
    'Bilaspur',
    'Bokaro Steel City',
    'Chandigarh',
    'Chennai',
    'Coimbatore',
    'Cuttack',
    'Dehradun',
    'Delhi',
    'Dhanbad',
    'Durgapur',
    'Erode',
    'Faridabad',
    'Firozabad',
    'Gandhinagar',
    'Ghaziabad',
    'Gorakhpur',
    'Guntur',
    'Gurgaon',
    'Guwahati',
    'Gwalior',
    'Haldwani',
    'Haridwar',
    'Hubli-Dharwad',
    'Hyderabad',
    'Imphal',
    'Indore',
    'Itanagar',
    'Jabalpur',
    'Jaipur',
    'Jalandhar',
    'Jammu',
    'Jamshedpur',
    'Jhansi',
    'Jodhpur',
    'Junagadh',
    'Kakinada',
    'Kalyan-Dombivli',
    'Kanpur',
    'Kochi',
    'Kolhapur',
    'Kolkata',
    'Kollam',
    'Kota',
    'Kozhikode',
    'Kurnool',
    'Lucknow',
    'Ludhiana',
    'Madurai',
    'Malappuram',
    'Mangalore',
    'Meerut',
    'Mira-Bhayandar',
    'Moradabad',
    'Mumbai',
    'Mysuru',
    'Nagpur',
    'Nanded',
    'Nashik',
    'Navi Mumbai',
    'Nellore',
    'Noida',
    'Patna',
    'Pimpri-Chinchwad',
    'Prayagraj',
    'Pune',
    'Raipur',
    'Rajkot',
    'Rajahmundry',
    'Ranchi',
    'Rohtak',
    'Rourkela',
    'Saharanpur',
    'Salem',
    'Sangli-Miraj & Kupwad',
    'Shillong',
    'Shimla',
    'Siliguri',
    'Solapur',
    'Srinagar',
    'Surat',
    'Thane',
    'Thiruvananthapuram',
    'Thrissur',
    'Tiruchirappalli',
    'Tirunelveli',
    'Tiruppur',
    'Udaipur',
    'Ujjain',
    'Ulhasnagar',
    'Vadodara',
    'Varanasi',
    'Vasai-Virar',
    'Vijayawada',
    'Visakhapatnam',
    'Warangal',
    'Yamunanagar',
  ];

  // City coordinates mapping
  final Map<String, Map<String, double>> _cityCoordinates = {
    'Agra': {'latitude': 27.1767, 'longitude': 78.0081},
    'Ahmedabad': {'latitude': 23.0225, 'longitude': 72.5714},
    'Ajmer': {'latitude': 26.4499, 'longitude': 74.6399},
    'Akola': {'latitude': 20.7063, 'longitude': 77.0202},
    'Aligarh': {'latitude': 27.8974, 'longitude': 78.0880},
    // Add more cities here as required
  };

  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  List<int> _uploadRows = [0];
  List<File?> _selectedImages = [null]; // To hold selected images for each row
  final ImagePicker _picker = ImagePicker();


  void _addRow() {
    setState(() {
      _uploadRows.add(_uploadRows.length);
      _selectedImages.add(null); // Initialize with null for the new row
    });
  }

  void _removeRow() {
    if (_uploadRows.length <= 1) return;
    setState(() {
      _uploadRows.removeLast();
      _selectedImages.removeLast(); // Remove the last image entry
    });
  }

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImages[index] = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _showImageDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: FileImage(imageFile),
              ),
            ),
          ),
        );
      },
    );
  }

  // Location controllers
  final TextEditingController _yourLatitudeController = TextEditingController();
  final TextEditingController _yourLongitudeController = TextEditingController();
  final TextEditingController _custLatitudeController = TextEditingController();
  final TextEditingController _custLongitudeController = TextEditingController();

  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DsrEntry()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'DSR Entry',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //! Process Type
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Process type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: Container(),
                  value: _processItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _processItem = newValue);
                    }
                  },
                  items: _processdropdownItems
                      .map(
                        (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              // ! Activity type
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Activity Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  value: _activityItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _activityItem = newValue);

                      if (newValue != null) {
                        setState(() => _activityItem = newValue);

                        // 🔹 Navigate on Personal Visit
                        if (newValue == 'Personal Visit') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const DsrRetailerInOut(),
                            ),
                          );
                        }
                      }
                      // 🔹 Navigate on Phone Call with Builder/Stockist
                      if (newValue == 'Phone Call with Builder/Stockist') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PhoneCallWithBuilder(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Meetings With Contractor / Stockist
                      if (newValue == 'Meetings With Contractor / Stockist') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MeetingsWithContractor(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Visit to Get / Check Sampling at Site
                      if (newValue == 'Visit to Get / Check Sampling at Site') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CheckSamplingAtSite(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Meeting with New Purchaser(Trade Purchaser)/Retailer
                      if (newValue == 'Meeting with New Purchaser(Trade Purchaser)/Retailer') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MeetingWithNewPurchaser(),
                          ),
                        );
                      }

                      // 🔹 Navigate on BTL Activities
                      if (newValue == 'BTL Activities') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BtlActivites(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Internal Team Meetings / Review Meetings
                      if (newValue == 'Internal Team Meetings / Review Meetings') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const InternalTeamMeeting(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Office Work
                      if (newValue == 'Office Work') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OfficeWork(),
                          ),
                        );
                      }

                      // 🔹 Navigate on On Leave / Holiday / Off Day
                      if (newValue == 'On Leave / Holiday / Off Day') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OnLeave(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Work From Home
                      if (newValue == 'Work From Home') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkFromHome(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Any Other Activity
                      if (newValue == 'Any Other Activity') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AnyOtherActivity(),
                          ),
                        );
                      }

                      // 🔹 Navigate on Phone call with Unregistered Purchasers
                      if (newValue == 'Phone call with Unregistered Purchasers') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PhoneCallWithUnregisterdPurchaser(),
                          ),
                        );
                      }
                    }
                  },
                  items: _activityDropDownItems
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(fontSize: 16)),
                  ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 20),

              // ! Submission Date
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Submission Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDate,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: _pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ! Report Date
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Report Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDate,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: _pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),

              // ! Area Code
              const SizedBox(height: 16),
              _buildLabel('Area code *:'),
              const SizedBox(height: 8),
              _searchableDropdownField(
                selected: _areaCode,
                items: _majorCitiesInIndia,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _areaCode = val;
                      // Set latitude and longitude based on the selected area code
                      if (_cityCoordinates.containsKey(val)) {
                        _custLatitudeController.text =
                            _cityCoordinates[val]!['latitude']!.toString();
                        _custLongitudeController.text =
                            _cityCoordinates[val]!['longitude']!.toString();
                      }
                    });
                  }
                },
              ),

              // ! Purchaser
              SizedBox(
                height: 20,
              ),
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Purchaser',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: Container(),
                  value: _purchaserItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _purchaserItem = newValue);
                    }
                  },
                  items: _purchaserdropdownItems
                      .map(
                        (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              // ! Code with search icon
              _buildLabel('Code *:'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: _inputDecoration('Purchaser code'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _iconButton(Icons.search, () {
                    // TODO: perform code search
                  }),
                ],
              ),

              // ! Site Name
              const SizedBox(height: 20),
              _buildTextField('Site Name'),

              //! Contractor Working at Site
              const SizedBox(height: 20),
              _buildTextField('Contractor Working at Site'),

              //! Met With
              SizedBox(
                height: 20,
              ),
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Met With',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: Container(),
                  value: _metWthItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _metWthItem = newValue);
                    }
                  },
                  items: _metWithdropdownItems
                      .map(
                        (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              //! Name and Designation of Person
              const SizedBox(height: 20),
              _buildTextField('Name and Designation of Person'),

              //! Topic Discussed
              const SizedBox(height: 20),
              _buildTextField('Topic Discussed'),

              //! Ugai Recovery Plans
              const SizedBox(height: 20),
              _buildTextField('Ugai Recovery Plans'),

              //! Any Purchaser Grievances
              const SizedBox(height: 20),
              _buildTextField('Any Purchaser Grievances'),

              //! Any other Point
              const SizedBox(height: 20),
              _buildTextField('Any other Point'),

              //! Image Upload , View Image , + , -
              Column(
                children: _uploadRows.map((i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _pickImage(i), // Call _pickImage with the index
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Upload Image'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              if (_selectedImages[i] != null) {
                                _showImageDialog(
                                    _selectedImages[i]!); // Show image for the current row
                              } else {
                                // Optionally show a message if no image is selected
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'No image selected to view.')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('View Image'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _addRow,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                            child: const Text('+'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _removeRow,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                            child: const Text('-'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),

              //! 3 Submit Button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // implement upload logic for row i
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: const Text('Submit & New')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // implement upload logic for row i
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: const Text('Submit & Exit')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // implement upload logic for row i
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child:
                        const Text('Click to see Submitted Data')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
  );

  Widget _searchableDropdownField({
    required String selected,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      DropdownSearch<String>(
        items: items,
        selectedItem: selected,
        onChanged: onChanged,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.black),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          itemBuilder: (context, item, isSelected) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(item, style: const TextStyle(color: Colors.black)),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: 'Select',
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
      );

  InputDecoration _inputDecoration(String hint, {IconData? suffix}) =>
      InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: _pickDate)
            : null,
      );

  Widget _iconButton(IconData icon, VoidCallback onPressed) => Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(10)),
    child: IconButton(
        icon: Icon(icon, color: Colors.white), onPressed: onPressed),
  );
}
