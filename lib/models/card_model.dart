/// The `CardModel` class represents a credit/debit card with its various attributes.
class CardModel {
  /// The current balance on the card.
  final String balance;

  /// The card number, typically in a format like "1234 5678 9012 3456".
  final String number;

  /// The card's expiry date, typically in a format like "MM/YY".
  final String expiry;

  /// The color associated with the card, represented as an integer.
  final int color;

  /// Constructs a new `CardModel` instance with the provided balance, number, expiry, and color.
  ///
  /// All parameters are required.
  CardModel({
    required this.balance,  // The current balance on the card.
    required this.number,   // The card number.
    required this.expiry,   // The card's expiry date.
    required this.color,    // The color associated with the card.
  });

  /// Generates a map representation of the `CardModel` object.
  ///
  /// This can be useful for serialization and for testing purposes.
  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'number': number,
      'expiry': expiry,
      'color': color,
    };
  }

  /// Creates a `CardModel` from a map representation.
  ///
  /// This can be useful for deserialization and for testing purposes.
  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      balance: map['balance'],
      number: map['number'],
      expiry: map['expiry'],
      color: map['color'],
    );
  }

  /// Provides a string representation of the `CardModel` object.
  ///
  /// This can be useful for debugging and logging purposes.
  @override
  String toString() {
    return 'CardModel(balance: $balance, number: $number, expiry: $expiry, color: $color)';
  }

  /// Compares this `CardModel` to another for equality.
  ///
  /// This can be useful for testing purposes.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardModel &&
        other.balance == balance &&
        other.number == number &&
        other.expiry == expiry &&
        other.color == color;
  }

  /// Generates a hash code for the `CardModel`.
  ///
  /// This can be useful for using the object in collections.
  @override
  int get hashCode {
    return balance.hashCode ^
    number.hashCode ^
    expiry.hashCode ^
    color.hashCode;
  }
}
