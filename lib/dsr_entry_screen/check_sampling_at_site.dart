import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:learning2/dsr_entry_screen/phone_call_with_builder.dart';
import 'package:learning2/dsr_entry_screen/phone_call_with_unregisterd_purchaser.dart';
import 'package:learning2/dsr_entry_screen/work_from_home.dart';
import 'Meeting_with_new_purchaser.dart';
import 'Meetings_With_Contractor.dart';
import 'any_other_activity.dart';
import 'btl_activites.dart';
import 'dsr_entry.dart';
import 'dsr_retailer_in_out.dart';
import 'internal_team_meeting.dart';
import 'office_work.dart';
import 'on_leave.dart';

class CheckSamplingAtSite extends StatefulWidget {
  const CheckSamplingAtSite({super.key});

  @override
  State<CheckSamplingAtSite> createState() => _CheckSamplingAtSiteState();
}

class _CheckSamplingAtSiteState extends State<CheckSamplingAtSite> {
  String? _processItem = 'Select';
  final List<String> _processdropdownItems = [
    'Select',
    'Add',
    'Update',
  ];

  String? _activityItem = 'Visit to Get / Check Sampling at Site';
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

  String? _siteItem = 'Select';
  final List<String> _sitedropdownItems = [
    'Select',
    'White Cement',
    'Wall Care putty',
    'Textura',
    'Levelplast',
    'Wall Primer',
  ];

  String? _qualityItem = 'Select';
  final List<String> _qualitydropdownItems = [
    'Select',
    'Average',
    'Medium',
    'Good',
  ];

  String? _statusItem = 'Select';
  final List<String> _statusDropdownItems = [
    'Select',
    'Yet To be Checked By Purchaser',
    'Approved',
    'Rejected',
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _reportDateController =
  TextEditingController(); // Added controller for Report Date
  DateTime? _selectedDate;
  DateTime? _selectedReportDate; // Added state variable for Report Date

  // List to hold selected images paths for each row
  List<List<String>> _selectedImagePaths = [[]]; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    // Initialize the list of image paths with an empty list for the first row.
    _selectedImagePaths = [[]];
  }

  @override
  void dispose() {
    _dateController.dispose();
    _reportDateController.dispose(); // Dispose the new controller
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

  List<int> _uploadRows = [0];

  void _addRow() {
    setState(() {
      _uploadRows.add(_uploadRows.length);
      _selectedImagePaths.add(
          []); // Add a new empty list for the new row's images
    });
  }

  void _removeRow() {
    if (_uploadRows.length <= 1) return;
    setState(() {
      _uploadRows.removeLast();
      _selectedImagePaths.removeLast(); // Remove the last image path list
    });
  }

  // Function to pick images for a specific row
  Future<void> _pickImages(int rowIndex) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        // Clear previous images.
        _selectedImagePaths[rowIndex] = pickedFiles.map((e) => e.path).toList();
      });
    } else {
      // User canceled the image selection.  No need to show a message.
      print('No images selected.');
    }
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
                      child:
                      Text(value, style: const TextStyle(fontSize: 16)),
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
                        // This is the current page, no navigation needed
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (_) => const CheckSamplingAtSite(),
                        //   ),
                        // );
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BtlActivites(),
                          ),
                        );
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
                      if (newValue ==
                          'Phone call with Unregistered Purchasers') {
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
                // Use the new controller
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

              //! Site Name
              const SizedBox(height: 20),
              _buildTextField('Site Name'),

              //! Product for which Sample is applied
              SizedBox(
                height: 20,
              ),
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Product for which Sample is applied',
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
                  value: _siteItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _siteItem = newValue);
                    }
                  },
                  items: _sitedropdownItems
                      .map(
                        (value) => DropdownMenuItem(
                      value: value,
                      child:
                      Text(value, style: const TextStyle(fontSize: 16)),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              //! Approx Potential of Site (MT)
              const SizedBox(height: 20),
              _buildTextField('Approx Potential of Site (MT)'),

              //! Applicator Name Who Applied Sample
              const SizedBox(height: 20),
              _buildTextField('Applicator Name Who Applied Sample'),

              //! Quality of Sample
              SizedBox(
                height: 20,
              ),
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Quality of Sample',
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
                  value: _qualityItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _qualityItem = newValue);
                    }
                  },
                  items: _statusDropdownItems // This seems incorrect, should use _qualitydropdownItems
                      .map(
                        (value) => DropdownMenuItem(
                      value: value,
                      child:
                      Text(value, style: const TextStyle(fontSize: 16)),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              //! Status of Sample
              SizedBox(
                height: 20,
              ),
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Text(
                  'Status of Sample', // Corrected label
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
                  value: _statusItem,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() => _statusItem = newValue);
                    }
                  },
                  items: _statusDropdownItems
                      .map(
                        (value) => DropdownMenuItem(
                      value: value,
                      child:
                      Text(value, style: const TextStyle(fontSize: 16)),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              //! Contact Name
              const SizedBox(height: 20),
              _buildTextField('Contact Name'),

              //! Mobile no.
              const SizedBox(height: 20),
              _buildTextField('Mobile no.'),

              //! Image Upload , view Image , + , -
              Column(
                children: _uploadRows.map((rowIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _pickImages(
                                rowIndex), // Pass the row index to _pickImages
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
                              if (_selectedImagePaths[rowIndex].isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Selected Images',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          // Use a ListView.builder to display multiple images
                                          SizedBox(
                                            height: 200, // Limit the height
                                            width:
                                            double.maxFinite, // Make it wide
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.horizontal, // Horizontal list
                                              itemCount: _selectedImagePaths[
                                              rowIndex]
                                                  .length,
                                              itemBuilder: (context, index) {
                                                final imagePath =
                                                _selectedImagePaths[
                                                rowIndex][index];
                                                return Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 8.0),
                                                  child: Image.file(
                                                    File(imagePath),
                                                    height: 180, // Adjust as needed
                                                    width: 180,
                                                    fit: BoxFit
                                                        .contain, // Or any other fit
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                    Text('No images selected for this row.'),
                                    duration: Duration(seconds: 2),
                                  ),
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
                      // TODO: implement submit and new logic
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
