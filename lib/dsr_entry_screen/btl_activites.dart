import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // Import for File
// Ensure these imports are correct. If these files are in the same directory, you do not need the 'dsr_entry_screen' path.
import 'Meeting_with_new_purchaser.dart'; //Corrected import paths.
import 'Meetings_With_Contractor.dart';
import 'any_other_activity.dart';
import 'btl_activites.dart';
import 'check_sampling_at_site.dart';
import 'dsr_entry.dart';
import 'dsr_retailer_in_out.dart';
import 'internal_team_meeting.dart';
import 'office_work.dart';
import 'on_leave.dart';

//Added these imports as the original code had them, and they are used within the code.
import 'phone_call_with_builder.dart';
import 'phone_call_with_unregisterd_purchaser.dart';
import 'work_from_home.dart';

class BtlActivites extends StatefulWidget {
  const BtlActivites({super.key});

  @override
  State<BtlActivites> createState() => _BtlActivitesState();
}

class _BtlActivitesState extends State<BtlActivites> {
  String? _processItem = 'Select';
  final List<String> _processdropdownItems = [
    'Select',
    'Add',
    'Update',
  ];

  String? _activityItem = 'BTL Activities';
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

  String _activityTypeItem = 'Select';
  final List<String> _activityTypedropdownItems = [
    'Select', // 👈 Add this
    'Retailer Meet',
    'Stokiest Meet',
    'Painter Meet',
    'Architect Meet',
    'Counter Meet',
    'Painter Training Program',
    'Other BTL Activities',
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _reportDateController =
  TextEditingController(); // Added controller for Report Date
  DateTime? _selectedDate;
  DateTime? _selectedReportDate; // Added state variable for Report Date

  // Added controllers for new fields
  final TextEditingController _noOfParticipantsController =
  TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _learningsController = TextEditingController();

  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker
  List<int> _uploadRows = [0];
  List<File?> _selectedImages = [null]; // To hold selected image files


  @override
  void dispose() {
    _dateController.dispose();
    _reportDateController.dispose(); // Dispose the new controller
    _noOfParticipantsController.dispose(); // Dispose new controllers
    _townController.dispose();
    _learningsController.dispose();
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

  Future<void> _pickReportDate() async {
    // Function to pick report date
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedReportDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedReportDate = picked;
        _reportDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _addRow() {
    setState(() {
      _uploadRows.add(_uploadRows.length);
      _selectedImages.add(null); // Add null for the new row
    });
  }

  void _removeRow() {
    if (_uploadRows.length <= 1) return;
    setState(() {
      _uploadRows.removeLast();
      _selectedImages.removeLast();
    });
  }

  // Adapted image picking logic from AnyOtherActivity
  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImages[index] = File(pickedFile.path);
      });
    } else {
      print('No image selected for row $index.');
    }
  }

  // Adapted image viewing logic from AnyOtherActivity
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
          icon: const Icon(
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
          // Added Form key for validation if needed later
          key: GlobalKey<FormState>(),
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

                      // 🔹 Navigate on Personal Visit
                      if (newValue == 'Personal Visit') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const DsrRetailerInOut(),
                          ),
                        );
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
                      if (newValue ==
                          'Meeting with New Purchaser(Trade Purchaser)/Retailer') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MeetingWithNewPurchaser(),
                          ),
                        );
                      }

                      // 🔹 Navigate on BTL Activities
                      if (newValue == 'BTL Activities') {
                        // This is the current page, no navigation needed
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (_) => const BtlActivites(),
                        //   ),
                        // );
                      }

                      // 🔹 Navigate on Internal Team Meetings / Review Meetings
                      if (newValue ==
                          'Internal Team Meetings / Review Meetings') {
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
                            builder: (_) =>
                            const PhoneCallWithUnregisterdPurchaser(),
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
                controller: _reportDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickReportDate, // Use the new function
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: _pickReportDate,
                // Use the new function
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //! Type Of Activity
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Type Of Activity',
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
                  value: _activityTypeItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _activityTypeItem = newValue);
                    }
                  },
                  items: _activityTypedropdownItems
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

              //! No. Of Participants
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'No. Of Participants',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _noOfParticipantsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of participants',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of participants';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //! Town in Which Activity conducted
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Town in Which Activity Conducted',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _townController,
                decoration: InputDecoration(
                  hintText: 'Enter town',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter town';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //! Learning's From Activity
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Learning\'s From Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _learningsController,
                maxLines: 3, // Added for a multi-line input
                decoration: InputDecoration(
                  hintText: 'Enter your learnings',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your learnings';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //! Image view + -
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
                                _pickImage(i), // Call the adapted _pickImage function
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
                                    _selectedImages[i]!); // Call the adapted _showImageDialog
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
              const SizedBox(
                height: 30,
              ),

              //! 3 Submit Button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: implement submit and new logic
                      // Add form validation check here if needed
                      // if (_formKey.currentState!.validate()) {
                      //   print('Form is valid. Submit and New.');
                      // }
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: implement submit and exit logic
                      // Add form validation check here if needed
                      // if (_formKey.currentState!.validate()) {
                      //   print('Form is valid. Submit and Exit.');
                      // }
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: implement view submitted data logic
                      print('View Submitted Data button pressed');
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
                  const SizedBox(
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

  //! Methods
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
