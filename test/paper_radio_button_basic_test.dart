// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_radio_button_basic_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_radio_button.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('defaults', () {
    PaperRadioButton r1;
    setUp(() {
      r1 = fixture('NoLabel');
    });
    test('check button via click', () async {
      var completer = new Completer();
      r1.on['click'].take(1).listen((event) {
        expect(r1.attributes['aria-checked'], 'true');
        expect(r1.checked, isTrue);
        completer.complete();
      });

      tap(r1);
      await completer.future;
    });

    test('toggle button via click', () async {
      r1.checked = true;
      var completer = new Completer();
      r1.on['click'].take(1).listen((event) {
        expect(r1.attributes['aria-checked'], 'false');
        expect(r1.checked, isFalse);
        completer.complete();
      });

      tap(r1);
      await completer.future;
    });

    test('disabled button cannot be clicked', () async {
      r1.disabled = true;
      r1.checked = true;
      tap(r1);

      await wait(1);

      expect(r1.attributes['aria-checked'], 'true');
      expect(r1.checked, isTrue);
    });
  });

  group('a11y', () {
    PaperRadioButton r1;
    PaperRadioButton r2;

    setUp(() {
      r1 = fixture('NoLabel');
      r2 = fixture('WithLabel');
    });

    test('has aria role "radio"', () {
      expect(r1.attributes['role'], equals('radio'));
      expect(r2.attributes['role'], equals('radio'));
    });

    test('button with no label has no aria label', () {
      expect(r1.attributes['aria-label'], isEmpty);
    });

    test('button with a label sets an aria label', () {
      expect(r2.attributes['aria-label'], equals("Batman"));
    });

    test('button respects the user set aria-label', () {
      var c = fixture('AriaLabel');
      expect(c.attributes['aria-label'], equals("Batman"));
    });

    // TODO(jakemac): Investigate these.
    // a11ySuite('NoLabel');
    // a11ySuite('WithLabel');
    // a11ySuite('AriaLabel');
  });
}
