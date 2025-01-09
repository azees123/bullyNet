/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bn;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author LuckyCharm
 */
public class database {

    public static boolean validate(String email, String pass) {
        boolean status = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");
            PreparedStatement ps = con.prepareStatement(
                    "select * from users where email=? and password=?");
            ps.setString(1, email);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            status = rs.next();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        return status;
    }
    
       public static boolean Adminvalidate(String email, String pass) {
        boolean status = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");
            PreparedStatement ps = con.prepareStatement(
                    "select * from admin where email=? and password=?");
            ps.setString(1, email);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            status = rs.next();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        return status;
    }
    
    

}

