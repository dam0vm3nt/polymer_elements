@HtmlImport('iron_behavior_elements.html')
library polymer_elements.test.fixture.iron_behavior_elements;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('test-control')
class TestControl extends PolymerElement with IronControlState {
  TestControl.created() : super.created();
}

@PolymerRegister('test-button')
class TestButton extends PolymerElement
    with IronControlState, IronA11yKeysBehavior, IronButtonState {
  TestButton.created() : super.created();

  void buttonStateChanged() {}
}

@PolymerRegister('nested-focusable')
class NestedFocusable extends PolymerElement with IronControlState {
  NestedFocusable.created() : super.created();
}

@PolymerRegister('test-light-dom')
class LightDom extends PolymerElement
    with IronControlState, IronA11yKeysBehavior,  IronButtonState {
  LightDom.created() : super.created();
}
