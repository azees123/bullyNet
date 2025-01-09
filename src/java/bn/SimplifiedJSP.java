/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package bn;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author LuckyCharm
 */
public class SimplifiedJSP extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bn";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          int blockedCount = getBlockedTweetCount();
        int allCount = getAllTweetCount();

        // Set attributes to pass to JSP
        request.setAttribute("blockedCount", blockedCount);
        request.setAttribute("allCount", allCount);
        request.setAttribute("blockedTweets", getBlockedTweets());

        // Forward to the JSP
        request.getRequestDispatcher("graph.jsp").forward(request, response);
    }

    // Method to get the count of blocked tweets
    private int getBlockedTweetCount() {
        int count = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as blocked_count FROM blocked")) {
             
            if (rs.next()) {
                count = rs.getInt("blocked_count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Method to get the count of all tweets
    private int getAllTweetCount() {
        int count = 0;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total_count FROM tweets")) {
             
            if (rs.next()) {
                count = rs.getInt("total_count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Method to get blocked tweets with user info
    private ResultSet getBlockedTweets() {
        ResultSet rs = null;

        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            Statement stmt = conn.createStatement();
            String sql = "SELECT b.tweet_id, b.users_id, t.message, t.file_path, u.username "
                       + "FROM blocked b JOIN tweets t ON b.tweet_id = t.id "
                       + "JOIN users u ON b.users_id = u.id";
            rs = stmt.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
