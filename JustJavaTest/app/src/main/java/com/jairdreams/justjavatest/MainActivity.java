package com.jairdreams.justjavatest;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.text.NumberFormat;

public class MainActivity extends AppCompatActivity {

    public int numberOf = 0;
    public double price;
    public double priceOfCoffee = 2.99;
    public double priceOfToppings;
    public String priceMessage;
    public String customerName = "Kalli";
    public boolean hasWhippedCream = false;
    public boolean hasChocolate = false;
    public String[] emailAddress = {"skyweldor@gmail.com"};
    public String emailSubject;
    TextView priceTextView;
    TextView priceHeader;
    CheckBox whippedCreamCheckbox;
    CheckBox chocolateCheckbox;
    EditText nameEditText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        priceTextView = (TextView) findViewById(R.id.price_text_view);
        priceHeader = (TextView) findViewById(R.id.price_header_text_view);
        whippedCreamCheckbox = (CheckBox) findViewById(R.id.checkbox_whipped_cream);
        chocolateCheckbox = (CheckBox) findViewById(R.id.checkbox_chocolate);
        nameEditText = (EditText) findViewById(R.id.editText_name);
    }

    // Button controls
    public void increment(View view) {
        displayQuantity(numberOf += 1);
        price = calculatePrice();
        displayPrice(price);
    }

    public void decrement(View view) {
        if (numberOf == 0) {
            Toast.makeText(getApplicationContext(), R.string.below_zero_toast, Toast.LENGTH_SHORT).show();
        } else {
            displayQuantity(numberOf -= 1);
            price = calculatePrice();
            displayPrice(price);
        }
    }

    public void submitOrder(View view) {
        createOrderSummary();
        addToppings();
        writeSubjectLine();
        composeEmail(emailAddress, emailSubject, priceMessage);
        //displayPriceMessage(priceMessage);
    }

    public void creamCheckBoxClick(View view) {
        hasWhippedCream = whippedCreamCheckbox.isChecked();

        if (hasWhippedCream) {
            priceOfToppings += .75;
        } else {
            priceOfToppings -= .75;
        }

        calculatePrice();
        displayPrice(price);
    }

    public void chocolateCheckBoxClick(View view) {
        hasChocolate = chocolateCheckbox.isChecked();

        if (hasChocolate) {
            priceOfToppings += 1.00;
        } else {
            priceOfToppings -= 1.00;
        }

        calculatePrice();
        displayPrice(price);
    }

    /*
    public void editName (View view) {
        customerName = nameEditText.getText().toString();
    }
    */

    // Display methods
    private void displayQuantity(int numberOfCoffees) {
        TextView quantityTextView = (TextView) findViewById(R.id.quantity_text_view);
        quantityTextView.setText("" + numberOfCoffees);
    }

    private void displayPrice(double price) {
        priceTextView.setText(NumberFormat.getCurrencyInstance().format(price));
        priceHeader.setText(R.string.price_header);
    }

    /* Price message now shown in an email. Display method to be used in later app?

    private void displayPriceMessage(String priceMessage) {
        priceTextView.setText(priceMessage);
        priceHeader.setText("Order Summary");
    }
    */

    // Calculations
    private double calculatePrice() {
        price = numberOf * priceOfCoffee + priceOfToppings;
        return price;
    }

    private String createOrderSummary() {
        customerName = nameEditText.getText().toString();
        hasChocolate = chocolateCheckbox.isChecked();
        hasWhippedCream = whippedCreamCheckbox.isChecked();

        if (numberOf == 0) {
            priceMessage = "It's free!";
        } else {
            priceMessage =
                    "Name: " + customerName +
                            "\nQuantity: " + numberOf +
                            "\nTotal: " + NumberFormat.getCurrencyInstance().format(price) +
                            "\nThank you!";
        }
        return priceMessage;
    }

    private String addToppings() {
        if (hasWhippedCream) {
            priceMessage += "\nHas whipped cream!";
            if (hasChocolate) {
                priceMessage += "\nHas chocolate!";
                return priceMessage;
            } else {
                return priceMessage;
            }
        } else if (hasChocolate) {
            priceMessage += "\nHas chocolate!";
            return priceMessage;
        } else {
            return priceMessage;
        }
    }

    private String writeSubjectLine() {
        emailSubject = customerName + ": " + numberOf + " Coffee(s) with ";
        if (hasWhippedCream) {
            emailSubject += "Whipped Cream";
            if (hasChocolate) {
                emailSubject += " and Chocolate";
                return emailSubject;
            } else {
                return emailSubject;
            }
        } else if (hasChocolate) {
            emailSubject += "Chocolate";
            return emailSubject;
        } else {
            return emailSubject;
        }
    }

    // Intent(s)
    public void composeEmail(String[] address, String subject, String text) {
        Intent intent = new Intent(Intent.ACTION_SENDTO);
        intent.setData(Uri.parse("mailto:"));
        intent.putExtra(Intent.EXTRA_EMAIL, address);
        intent.putExtra(Intent.EXTRA_SUBJECT, subject);
        intent.putExtra(Intent.EXTRA_TEXT, text);
        if (intent.resolveActivity(getPackageManager()) != null) {
            startActivity(intent);
        }
    }
}
