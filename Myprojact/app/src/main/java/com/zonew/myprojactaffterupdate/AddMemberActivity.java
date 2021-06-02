package com.zonew.myprojactaffterupdate;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class AddMemberActivity extends AppCompatActivity {
    EditText etPhoneNumber,etName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_member);

        etPhoneNumber = findViewById(R.id.idEtPhoneNumber);
        etName = findViewById(R.id.idEtName);

    }

    public void addMember(View view){
        Toast.makeText(getApplicationContext(),"add",Toast.LENGTH_SHORT).show();
        String strPhoneNumber,strName;
        strPhoneNumber = etPhoneNumber.getText().toString() ;
        strName        = etName.getText().toString()        ;

        // create Database
        SqliteDatabase dh = new SqliteDatabase(getApplicationContext()) ;
        android.database.sqlite.SQLiteDatabase db = dh.getWritableDatabase()        ; // อยากเขียน DB ใช้อันนี้

        dh.addMember(strPhoneNumber,strName,db);
        dh.close();

        // Reload current fragment
        Fragment frg = null;
        frg = getSupportFragmentManager().findFragmentByTag("MemberFragment");
        final FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
        ft.detach(frg);
        ft.attach(frg);
        ft.commit();

    }
}