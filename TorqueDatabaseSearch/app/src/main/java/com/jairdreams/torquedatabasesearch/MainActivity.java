package com.jairdreams.torquedatabasesearch;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    public String url;
    public EditText modelYear;
    public EditText carModel;
    public EditText engineSize;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        modelYear = (EditText) findViewById(R.id.editTextModelYear);
        carModel = (EditText) findViewById(R.id.editTextModel);
        engineSize = (EditText) findViewById(R.id.editTextEngine);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                url = CreateURL();
                new SearchConfirm(url);
            }
        });
    }

    public String CreateURL() {

        String stringModelYear = modelYear.getText().toString();
        String stringModel = carModel.getText().toString();
        String stringEngineSize = engineSize.getText().toString();
        stringModel = stringModel.toUpperCase();

        String stringURL =
                "https://spreadsheets.google.com/tq?" +
                        "tqx=out:html" +
                        "&tq=SELECT%20A%2C%20B%2C%20C%2C%20D%2C%20E%2C%20F%2C%20G%20" +
                        "WHERE%20A%20CONTAINS%20" +
                        "%27" +
                        stringModel +
                        "%27" +
                        "%20AND%20B%20CONTAINS%20" +
                        "%27" +
                        stringModelYear +
                        "%27" +
                        "%20AND%20C%20CONTAINS%20" +
                        "%27" +
                        stringEngineSize +
                        "%27" +
                        "&key=1xefWHvn1jiY41xLsZBgXAhkfOVLOUFLBjQLDoGn3GTM";
                        //"&gid=660774806";
        Log.println(Log.ASSERT, "testurl", stringURL);
        return stringURL;
    }

    public class SearchConfirm {

        private String searchUrl;

        public SearchConfirm(String url) {
            searchUrl = url;
            openWebPage(searchUrl);
        }

        public void openWebPage(String url) {
            Uri webpage = Uri.parse(url);
            Intent intent = new Intent(Intent.ACTION_VIEW, webpage);
            if (intent.resolveActivity(getPackageManager()) != null) {
                startActivity(intent);
            }
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}