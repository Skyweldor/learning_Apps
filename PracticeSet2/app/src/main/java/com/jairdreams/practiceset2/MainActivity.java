package com.jairdreams.practiceset2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    Button btn1;
    Button btn2;
    Button btn3;
    Button btn4;
    Button btn5;
    Button btn6;
    Button btn7;
    TextView textViewScoreA;
    TextView textViewScoreB;
    int scoreTeamA;
    int scoreTeamB;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textViewScoreA = (TextView) findViewById(R.id.text_view_team_A_score);
        textViewScoreB = (TextView) findViewById(R.id.text_view_team_B_score);
        btn1 = (Button) findViewById(R.id.Btn1_teamA);
        btn2 = (Button) findViewById(R.id.Btn2_teamA);
        btn3 = (Button) findViewById(R.id.Btn3_teamA);
        btn4 = (Button) findViewById(R.id.Btn1_teamB);
        btn5 = (Button) findViewById(R.id.Btn2_teamB);
        btn6 = (Button) findViewById(R.id.Btn3_teamB);
        btn7 = (Button) findViewById(R.id.resetBtn);


        btn1.setOnClickListener(this);
        btn2.setOnClickListener(this);
        btn3.setOnClickListener(this);
        btn4.setOnClickListener(this);
        btn5.setOnClickListener(this);
        btn6.setOnClickListener(this);
        btn7.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.Btn1_teamA:
                scoreTeamA += 3;
                displayScoreA(scoreTeamA);
                break;
            case R.id.Btn2_teamA:
                scoreTeamA += 2;
                displayScoreA(scoreTeamA);
                break;
            case R.id.Btn3_teamA:
                scoreTeamA++;
                displayScoreA(scoreTeamA);
                break;
            case R.id.Btn1_teamB:
                scoreTeamB += 3;
                displayScoreB(scoreTeamB);
                break;
            case R.id.Btn2_teamB:
                scoreTeamB += 2;
                displayScoreB(scoreTeamB);
                break;
            case R.id.Btn3_teamB:
                scoreTeamB++;
                displayScoreB(scoreTeamB);
                break;
            case R.id.resetBtn:
                scoreTeamA = 0;
                scoreTeamB = 0;
                displayScoreA(scoreTeamA);
                displayScoreB(scoreTeamB);
                break;
            default:
                break;
        }
    }

    public void displayScoreA (int scoreTeamA){
        textViewScoreA.setText(String.valueOf(scoreTeamA));
    }
    public void displayScoreB (int scoreTeamB) {
        textViewScoreB.setText(String.valueOf(scoreTeamB));
    }
}
