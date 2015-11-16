// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_input_test;

import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_input_char_counter.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-input>', () {
    group('basic', () {
      test('setting value sets the input value', () {
        PaperInput input = fixture('basic');
        input.value = 'foobar';
        expect(input.inputElement.value, equals(input.value));
      });

      test('placeholder does not overlap label', () {
        PaperInput input = fixture('placeholder');
        expect(input.inputElement.placeholder, equals(input.placeholder));
        expect(input.noLabelFloat, isFalse);
        var floatingLabel = (input.$$('paper-input-container')
            as PaperInputContainer).$$('.label-is-floating');
        expect(floatingLabel, isNotNull);
      });

      test('always-float-label attribute works without placeholder', () {
        PaperInput input = fixture('always-float-label');
        PaperInputContainer container = input.$$('paper-input-container');
        var inputContent = container.$$('.input-content');
        expect(inputContent.classes.contains('label-is-floating'), isTrue);
      });

      test('error message is displayed', () {
        PaperInput input = fixture('error');
        forceXIfStamp(input);
        var error = input.$$('paper-input-error');
        expect(error, isNotNull);
        expect(error.getComputedStyle().display, isNot(equals('none')));
      });

      test('empty required input shows error', () {
        PaperInput input = fixture('required');
        forceXIfStamp(input);
        var error = input.$$('paper-input-error');
        expect(error, isNotNull);
        expect(error.getComputedStyle().display, isNot(equals('none')));
      });

      test('character counter is displayed', () {
        PaperInput input = fixture('char-counter');
        forceXIfStamp(input);
        PaperInputCharCounter counter = input.$$('paper-input-char-counter');
        expect(counter, isNotNull);
        expect(
            counter.jsElement['_charCounterStr'], equals(input.value.length));
      });

      test('validator is used', () {
        PaperInput input = fixture('validator');
        expect(input.inputElement.invalid, isTrue);
      });

      test('caret position is preserved', () {
        PaperInput input = fixture('basic');
        var ironInput = input.$$('input[is="iron-input"]');
        input.value = 'nananana';
        ironInput.selectionStart = 2;
        ironInput.selectionEnd = 2;
        input.updateValueAndPreserveCaret('nanananabatman');
        expect(ironInput.selectionStart, equals(2));
        expect(ironInput.selectionEnd, equals(2));
      });
    });

    group('focus/blur events', () {
      PaperInput input;

      setUp(() {
        input = fixture('basic');
      });

      test('focus/blur events fired on host element', () {
        var nFocusEvents = 0;
        var nBlurEvents = 0;
        input.on['focus'].take(1).listen((event) {
          nFocusEvents += 1;
          expect(input.focused, isTrue);
          blur(input.inputElement);
        });

        input.on['blur'].take(1).listen((event) {
          nBlurEvents += 1;
          expect(input.focused, isFalse);
        });

        focus(input.inputElement);
        expect(nFocusEvents >= 1, isTrue);
        expect(nBlurEvents >= 1, isTrue);
      });
    });

    group('focused styling (integration test)', () {
      test('underline is colored when input is focused', () async {
        PaperInput input = fixture('basic');
        PaperInputContainer container = input.$$('paper-input-container');
        var line = container.$$('.underline');
        expect(line.classes.contains('is-highlighted'), isFalse);
        focus(input.inputElement);
        await requestAnimationFrame();
        expect(line.classes.contains('is-highlighted'), isTrue);
      });
    });

    group('validation', () {
      test('invalid attribute updated after calling validate()', () {
        PaperInput input = fixture('required-no-auto-validate');
        forceXIfStamp(input);
        input.validate();
        var error = input.$$('paper-input-error');
        expect(error, isNotNull);
        expect(error.getComputedStyle().visibility, equals('visible'));
        expect(input.invalid, isTrue);
      });
    });

    group('a11y', () {
      test('has aria-labelledby', () {
        PaperInput input = fixture('label');
        expect(input.inputElement.attributes.containsKey('aria-labelledby'),
            isTrue);
        expect(input.inputElement.attributes['aria-labelledby'],
            equals(input.$$('label').id));
      });

      test('has aria-describedby for error message', () {
        PaperInput input = fixture('required');
        forceXIfStamp(input);
        expect(input.inputElement.attributes.containsKey('aria-describedby'),
            isTrue);
        expect(input.inputElement.attributes['aria-describedby'],
            equals(input.$$('paper-input-error').id));
      });

      test('has aria-describedby for character counter', () {
        PaperInput input = fixture('char-counter');
        forceXIfStamp(input);
        var inputElement = input.$['input'];
        expect(inputElement.attributes.containsKey('aria-describedby'), isTrue);
        expect(inputElement.attributes['aria-describedby'],
            equals(input.$$('paper-input-char-counter').id));
      });

      test('has aria-describedby for character counter and error', () {
        PaperInput input = fixture('required-char-counter');
        forceXIfStamp(input);
        var inputElement = input.$['input'];
        expect(inputElement.attributes.containsKey('aria-describedby'), isTrue);
        expect(
            inputElement.attributes['aria-describedby'],
            equals(input.$$('paper-input-error').id +
                ' ' +
                input.$$('paper-input-char-counter').id));
      });
    });
  });
}
