import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:learning2/dsr_entry_screen/Meeting_with_new_purchaser.dart';
import 'package:learning2/dsr_entry_screen/any_other_activity.dart';
import 'package:learning2/dsr_entry_screen/btl_activites.dart';
import 'package:learning2/dsr_entry_screen/check_sampling_at_site.dart';
import 'package:learning2/dsr_entry_screen/internal_team_meeting.dart';
import 'package:learning2/dsr_entry_screen/office_work.dart';
import 'package:learning2/dsr_entry_screen/on_leave.dart';
import 'package:learning2/dsr_entry_screen/phone_call_with_builder.dart';
import 'package:learning2/dsr_entry_screen/phone_call_with_unregisterd_purchaser.dart';
import 'package:learning2/dsr_entry_screen/work_from_home.dart';
import 'package:learning2/screens/Home_screen.dart';
import 'Meetings_With_Contractor.dart';
import 'dsr_retailer_in_out.dart';

class DsrEntry extends StatefulWidget {
  const DsrEntry({Key? key}) : super(key: key);

  @override
  _DsrEntryState createState() => _DsrEntryState();
}

class _DsrEntryState extends State<DsrEntry> {
  // Process dropdown state
  String? _processItem = 'Select';
  final List<String> _processdropdownItems = [
    'Select',
    'Add',
    'Update',
  ];

  // Activity dropdown state
  String? _activityItem = 'Select';
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

  // Date picker state
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Manages dynamic upload rows
  List<int> _uploadRows = [0];
  // List to hold the selected images for each row
  List<File?> _selectedImages = [null]; // Initialize with null for the first row

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _dateController.dispose();
    // Dispose of other controllers if they were added
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

  void _addRow() {
    setState(() {
      _uploadRows.add(_uploadRows.length);
      _selectedImages.add(null); // Add null for the new row's image
    });
  }

  void _removeRow() {
    if (_uploadRows.length <= 1) return;
    setState(() {
      _uploadRows.removeLast();
      _selectedImages.removeLast(); // Remove the last image entry
    });
  }

  // Function to handle image picking for a specific row
  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImages[index] = File(pickedFile.path);
      });
    } else {
      print('No image selected.'); // Important for debugging
    }
  }

  // Function to show the selected image in a dialog
  void _showImageDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Adjust as needed
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Instructions header
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

                // Process Type
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

                // Activity Type
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

                //! Submission Date
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

                //! Report Date
                // Note: This Report Date field currently uses the same controller and pick function as Submission Date.
                // If Report Date should be a separate date, you'll need a new controller and pick function.
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: const Text(
                    'Report Date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dateController, // Using the same controller
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Select Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _pickDate, // Calling the same pick function
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: _pickDate, // Calling the same pick function
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                _buildTextField('Topic Discussed'),
                const SizedBox(height: 10),
                _buildTextField('Ugai Recovery Plans'),
                const SizedBox(height: 10),
                _buildTextField('Any Purchaser Grievances'),
                const SizedBox(height: 10),
                _buildTextField('Any Other Points'),
                const SizedBox(height: 20),

                // Dynamic Upload Supporting rows
                const Text(
                  'Upload Supporting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),

                Column(
                  children: _uploadRows.map((i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _pickImage(i), // Call _pickImage with the index
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
                                // implement view logic for row i
                                if (_selectedImages[i] != null) {
                                  _showImageDialog(_selectedImages[i]!); //show image
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

                //! 3 submit button
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: implement submit and new logic
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid. Submit and New.');
                          // Add your submission logic here
                        }
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
                        // TODO: implement submit and exit logic
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid. Submit and Exit.');
                          // Add your submission logic here and then navigate back
                        }
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
                        // TODO: implement view submitted data logic
                        print('View Submitted Data button pressed');
                        // Add logic to view submitted data
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
                          child: const Text('Click to see Submitted Data')),
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
          // Add validator if the field is required
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter $label';
          //   }
          //   return null;
          // },
        ),
      ],
    );
  }
}
