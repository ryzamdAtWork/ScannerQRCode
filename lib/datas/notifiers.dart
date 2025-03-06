// ValueNotifiers: hold the data
// ValueListenableBuilder: listen to the data (dont need the setState)

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifiers =   ValueNotifier(1);

ValueNotifier<bool> isDarkModeNotifiers = ValueNotifier(true);