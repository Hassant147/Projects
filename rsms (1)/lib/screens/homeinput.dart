import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsms/models/home.dart';
import 'package:rsms/providers/homeprovider.dart';

class userInputScreen extends StatefulWidget {
  static const routeName = '/addproperty';

  @override
  userInputScreenState createState() => userInputScreenState();
}

class userInputScreenState extends State<userInputScreen> {
  final _rentFocusNode = FocusNode();
  final _furnishedFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _areaUnitFocusNode = FocusNode();
  final _adTitleFocusNode = FocusNode();
  final _bathroomsFocusNode = FocusNode();
  final _featuresFocusNode = FocusNode();
  final _bedroomsFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _storeysFocusNode = FocusNode();
  final _imageurlController = TextEditingController();
  final _imageurlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedhome = Home(
    id: '',
    description: '',
    adpostedby: 'a',
    adTitle: '',
    areaUnit: '',
    bathrooms: 0,
    features: '',
    bedrooms: 0,
    furnished: false,
    imageurl: '',
    location: '',
    rent: 0,
    storeys: 0,
  );
  var _initialValues = {
    'description': '',
    'adTitle': '',
    'areaUnit': '',
    'bathrooms': '',
    'features': '',
    'bedrooms': '',
    'imageurl': '',
    'location': '',
    'rent': '',
    'furnished': '',
    'storeys': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageurlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final homeId = ModalRoute.of(context)?.settings.arguments;
      if (homeId != null) {
        _editedhome = Provider.of<Homes>(context, listen: false)
            .findById(homeId as String);
        _initialValues = {
          'adTitle': _editedhome.adTitle,
          'description': _editedhome.description,
          'imageurl': _editedhome.imageurl,
          'areaUnit': _editedhome.areaUnit,
          'bathrooms': _editedhome.bathrooms.toString(),
          'features': _editedhome.features,
          'bedrooms': _editedhome.bedrooms.toString(),
          'furnished': _editedhome.furnished.toString(),
          'location': _editedhome.location,
          'rent': _editedhome.rent.toString(),
          'storeys': _editedhome.storeys.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageurlFocusNode.removeListener(_updateImageUrl);
    _rentFocusNode.dispose();
    _furnishedFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _areaUnitFocusNode.dispose();
    _adTitleFocusNode.dispose();
    _bathroomsFocusNode.dispose();
    _featuresFocusNode.dispose();
    _bedroomsFocusNode.dispose();
    _locationFocusNode.dispose();
    _storeysFocusNode.dispose();
    _imageurlController.dispose();
    _imageurlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageurlFocusNode.hasFocus) {
      if ((!_imageurlController.text.startsWith('http') &&
              !_imageurlController.text.startsWith('https')) ||
          (!_imageurlController.text.endsWith('.png') &&
              !_imageurlController.text.endsWith('.jpg') &&
              !_imageurlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Homes>(context, listen: false).addHome(_editedhome);
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                //Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  //   setState(() {
  //     _isLoading = false;
  //   });
  //   Navigator.of(contex).pop;
  //   // Navigator.of(context).pop();
  // }
  String? furnish;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initialValues['adTitle'],
                      decoration: InputDecoration(labelText: 'Ad Title'),
                      textInputAction: TextInputAction.next,
                      focusNode: _adTitleFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_rentFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a Title.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: value as String,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bedrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['rent'],
                      decoration: InputDecoration(labelText: 'Rent'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _rentFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Rent.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bedrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: int.parse(value!),
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_areaUnitFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: value as String,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bedrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['areaUnit'],
                      decoration: InputDecoration(labelText: 'Area Unit'),
                      textInputAction: TextInputAction.next,
                      focusNode: _areaUnitFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_bedroomsFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide its Area.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: value as String,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bedrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['bedrooms'],
                      decoration:
                          InputDecoration(labelText: 'Number of Bedrooms'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _bedroomsFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_bathroomsFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter number of bedrooms..';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: int.parse(value!),
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['bathrooms'],
                      decoration:
                          InputDecoration(labelText: 'Number of Bathrooms'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _bathroomsFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_storeysFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter number of Bathrooms..';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: int.parse(value!),
                          bedrooms: _editedhome.bedrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['storeys'],
                      decoration:
                          InputDecoration(labelText: 'Number of Storeys'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _storeysFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_featuresFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter number of Storeys';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bathrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: int.parse(value!),
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['features'],
                      decoration:
                          InputDecoration(labelText: 'Add its Features'),
                      textInputAction: TextInputAction.next,
                      focusNode: _featuresFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_furnishedFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide its features.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bedrooms,
                          features: value as String,
                          furnished: _editedhome.furnished,
                          location: _editedhome.location,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    Column(children: [
                      Text("Is it furnished?"),
                      Divider(),
                      RadioListTile(
                        focusNode: _furnishedFocusNode,
                        title: Text("Furnished"),
                        value: true,
                        groupValue: furnish,
                        onChanged: (value) {
                          setState(() {
                            (value) {
                              _editedhome = Home(
                                adTitle: _editedhome.adTitle,
                                description: _editedhome.description,
                                imageurl: _editedhome.imageurl,
                                id: _editedhome.id,
                                isFavourite: _editedhome.isFavourite,
                                adpostedby: _editedhome.adpostedby,
                                areaUnit: _editedhome.areaUnit,
                                bathrooms: _editedhome.bathrooms,
                                bedrooms: _editedhome.bedrooms,
                                features: _editedhome.features,
                                furnished: value as bool,
                                location: _editedhome.location,
                                rent: _editedhome.rent,
                                storeys: _editedhome.storeys,
                              );
                            };
                            print(value);
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Not Furnished"),
                        value: false,
                        activeColor: Colors.orangeAccent,
                        focusNode: _furnishedFocusNode,
                        groupValue: furnish,
                        onChanged: (value) {
                          setState(() {
                            (value) {
                              _editedhome = Home(
                                adTitle: _editedhome.adTitle,
                                description: _editedhome.description,
                                imageurl: _editedhome.imageurl,
                                id: _editedhome.id,
                                isFavourite: _editedhome.isFavourite,
                                adpostedby: _editedhome.adpostedby,
                                areaUnit: _editedhome.areaUnit,
                                bathrooms: _editedhome.bathrooms,
                                bedrooms: _editedhome.bedrooms,
                                features: _editedhome.features,
                                furnished: value as bool,
                                location: _editedhome.location,
                                rent: _editedhome.rent,
                                storeys: _editedhome.storeys,
                              );
                            };
                            print(value);
                          });
                        },
                      ),
                    ]),
                    TextFormField(
                      initialValue: _initialValues['location'],
                      decoration: InputDecoration(labelText: 'location'),
                      textInputAction: TextInputAction.next,
                      focusNode: _locationFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_storeysFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide it\'s location.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedhome = Home(
                          adTitle: _editedhome.adTitle,
                          description: _editedhome.description,
                          imageurl: _editedhome.imageurl,
                          id: _editedhome.id,
                          isFavourite: _editedhome.isFavourite,
                          adpostedby: _editedhome.adpostedby,
                          areaUnit: _editedhome.areaUnit,
                          bathrooms: _editedhome.bathrooms,
                          bedrooms: _editedhome.bedrooms,
                          features: _editedhome.features,
                          furnished: _editedhome.furnished,
                          location: value as String,
                          rent: _editedhome.rent,
                          storeys: _editedhome.storeys,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageurlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageurlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageurlController,
                            focusNode: _imageurlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedhome = Home(
                                adTitle: _editedhome.adTitle,
                                description: _editedhome.description,
                                imageurl: value as String,
                                id: _editedhome.id,
                                isFavourite: _editedhome.isFavourite,
                                adpostedby: _editedhome.adpostedby,
                                areaUnit: _editedhome.areaUnit,
                                bathrooms: _editedhome.bathrooms,
                                bedrooms: _editedhome.bedrooms,
                                features: _editedhome.features,
                                furnished: _editedhome.furnished,
                                location: _editedhome.location,
                                rent: _editedhome.rent,
                                storeys: _editedhome.storeys,
                              );
                              // print(_editedhome.isFavourite);

                              // print(_editedhome.id);
                              // print(_editedhome.adpostedby);
                              // print(_editedhome.adTitle);
                              // print(_editedhome.rent);
                              // print(_editedhome.description);
                              // print(_editedhome.areaUnit);
                              //print(_editedhome.bedrooms);
                              // print(_editedhome.bathrooms);
                              // print(_editedhome.storeys);
                              // print(_editedhome.features);
                              // print(_editedhome.furnished);
                              // print(_editedhome.location);
                              // print(_editedhome.imageurl);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
