/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creationvoilier.dao;

import creationvoilier.model.Club;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author david
 */
public class ClubDAO {
    
    public static ArrayList<Club> findAll() throws SQLException{
       ArrayList<Club> clubs = new ArrayList<>();
       
       Connection c = DBConnect.getConnection();
       Statement stm;
       stm=c.createStatement();
       String sql ="SELECT * FROM club";
       ResultSet rs = stm.executeQuery(sql);
       while(rs.next()){
        int id = rs.getInt("club_id");
       String nom = rs.getString("club_nom");
       Club club = new Club(id,nom);
       clubs.add(club);
    }
        return clubs;
    }
    
    public static Club findOneById(int id) throws SQLException{
        Club club = null;
        Connection c = DBConnect.getConnection();
        Statement stm;
        stm=c.createStatement();
        String sql ="SELECT * FROM club WHERE club_id="+id;
        ResultSet rs =stm.executeQuery(sql);
        
        if(rs.next()){
            String nom=rs.getString("club_nom");
            club = new Club(id,nom);
        }
        
        return club;
    }
}
