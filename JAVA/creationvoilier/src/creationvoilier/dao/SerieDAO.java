/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creationvoilier.dao;

import creationvoilier.model.Serie;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author david
 */
public class SerieDAO {
    
    public static ArrayList<Serie> findAll() throws SQLException{
        ArrayList<Serie>series = new ArrayList<>();
        Connection c= DBConnect.getConnection();
        Statement stm;
        String sql ="SELECT * FROM serie";
        stm= c.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        
        while(rs.next()){
            int id =rs.getInt("serie_id");
            String nom =rs.getString("serie_nom");
            Serie serie = new Serie(id,nom);
            series.add(serie);
        }
        
        return series;
    }
    
    public static Serie findOnebyId(int id) throws SQLException{
        Serie serie = null;
        Connection c= DBConnect.getConnection();
        Statement stm;
        stm = c.createStatement();
        String sql ="SELECT * FROM serie WHERE serie_id="+id;
        ResultSet rs=stm.executeQuery(sql);
        if(rs.next()){
            String nom =rs.getString("serie_nom");
            serie = new Serie(id,nom);
        
        }
        rs.close();
        return serie;
    }
}
