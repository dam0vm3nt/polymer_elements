// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_spinner_test;

import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_spinner.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-spinner>', () {
    group('an accessible paper spinner', () {
      PaperSpinner spinner;
      PaperSpinner activeSpinner;
      setUp(() {
        spinner = fixture('PaperSpinner');
        activeSpinner = fixture('ActivePaperSpinner');
      });
      test('adds an ARIA label when `alt` is supplied', () {
        var ALT_TEXT = 'Loading the next gif...';
        spinner.alt = ALT_TEXT;
        expect(spinner.attributes['aria-label'], equals(ALT_TEXT));
      });
      test('hides from ARIA when inactive', () {
        spinner.active = false;
        expect(spinner.attributes['aria-hidden'], equals('true'));
      });

      test('toggle during cooldown', () async {
        activeSpinner.active = false;

        // Set active to true before cooldown animation completes.
        await wait(100);
        activeSpinner.active = true;

        // Wait for cooldown animation to complete.
        await wait(500);
        expect(activeSpinner.active, isTrue);
      });
    });
  });
}
