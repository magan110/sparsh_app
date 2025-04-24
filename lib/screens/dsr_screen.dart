import 'package:flutter/material.dart';

import 'Home_screen.dart';



class DsrScreen extends StatefulWidget {
  const DsrScreen({super.key});

  @override
  State<DsrScreen> createState() => _DsrScreenState();
}

class _DsrScreenState extends State<DsrScreen> {


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
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'DSR DATA',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Basic Data',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
                textField('Process Type'),
                textField('Retailer Company'),
                textField('Area'),
                textField('District'),
                const Text(
                  'Register With  PAN/GST',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue, // Match the blue color
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Adjust padding as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0), // Make it rounded
                          ),
                        ),
                        child: const Text(
                          'GST',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0, // Adjust font size as needed
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue, // Match the blue color
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Adjust padding as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0), // Make it rounded
                          ),
                        ),
                        child: const Text(
                          'PAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0, // Adjust font size as needed
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                textField('GST Number'),
                textField('PAN Number'),
                textField('Firm Name '),
                textField('Mobile'),
                textField('Official Telephone'),
                textField('E - Mail Id'),
                textField('Address Name 1 '),
                textField('Address Name 2 '),
                textField('Address Name 3 '),
                const Text(
                  'Contact Details',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
                textField('Stockiest Code'),
                textField('Tally Retailer Code'),
                textField('Concern Employee'),
                const Text(
                  'Retailer Profile Image',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Match the blue color
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Adjust padding as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust roundness as needed
                        ),
                      ),
                      icon: const Icon(
                        Icons.upload_outlined, // Use the upload icon
                        color: Colors.white,
                        size: 24.0, // Adjust icon size as needed
                      ),
                      label: const Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, // Adjust font size as needed
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye,size: 40,color: Colors.blue,))
                  ],
                ),
                SizedBox(height: 50,),
                const Text(
                  'PAN/GST No Image Upload ',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Match the blue color
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Adjust padding as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust roundness as needed
                        ),
                      ),
                      icon: const Icon(
                        Icons.upload_outlined, // Use the upload icon
                        color: Colors.white,
                        size: 24.0, // Adjust icon size as needed
                      ),
                      label: const Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, // Adjust font size as needed
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye,size: 40,color: Colors.blue,))
                  ],
                ),
                textField('Scheme required '),
                textField('Aadhar card No.'),
                const Text(
                  'Aadhar card Upload',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Match the blue color
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Adjust padding as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Adjust roundness as needed
                        ),
                      ),
                      icon: const Icon(
                        Icons.upload_outlined, // Use the upload icon
                        color: Colors.white,
                        size: 24.0, // Adjust icon size as needed
                      ),
                      label: const Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, // Adjust font size as needed
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye,size: 40,color: Colors.blue,))
                  ],
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AFEF), // Use the specified hex color
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 18.0), // Adjust padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Make it rounded
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0, // Adjust font size as needed
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }



  Padding textField(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: '$title',
          labelStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
