import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/models/card_model.dart';

void main() {
  group('CardModel', () {
    // Test data
    const testBalance = '1234.56';
    const testNumber = '1234 5678 9012 3456';
    const testExpiry = '12/34';
    const testColor = 0xFF123456;

    // Sample CardModel instance
    final card = CardModel(
      balance: testBalance,
      number: testNumber,
      expiry: testExpiry,
      color: testColor,
    );

    test('should create an instance with correct values', () {
      expect(card.balance, testBalance);
      expect(card.number, testNumber);
      expect(card.expiry, testExpiry);
      expect(card.color, testColor);
    });

    test('toMap should return correct map', () {
      final map = card.toMap();
      expect(map['balance'], testBalance);
      expect(map['number'], testNumber);
      expect(map['expiry'], testExpiry);
      expect(map['color'], testColor);
    });

    test('fromMap should create correct instance', () {
      final map = {
        'balance': testBalance,
        'number': testNumber,
        'expiry': testExpiry,
        'color': testColor,
      };
      final cardFromMap = CardModel.fromMap(map);
      expect(cardFromMap, card);
    });

    test('toString should return correct string representation', () {
      const stringRepresentation = 'CardModel(balance: $testBalance, number: $testNumber, expiry: $testExpiry, color: $testColor)';
      expect(card.toString(), stringRepresentation);
    });

    test('equality operator should compare correctly', () {
      final identicalCard = CardModel(
        balance: testBalance,
        number: testNumber,
        expiry: testExpiry,
        color: testColor,
      );
      final differentCard = CardModel(
        balance: '5678.90',
        number: '9876 5432 1098 7654',
        expiry: '11/22',
        color: 0xFF654321,
      );
      expect(card, identicalCard);
      expect(card == differentCard, false);
    });

    test('hashCode should be consistent', () {
      final identicalCard = CardModel(
        balance: testBalance,
        number: testNumber,
        expiry: testExpiry,
        color: testColor,
      );
      expect(card.hashCode, identicalCard.hashCode);
    });
  });
}
