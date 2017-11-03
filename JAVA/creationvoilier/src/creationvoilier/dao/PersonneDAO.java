/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creationvoilier.dao;

import creationvoilier.model.Personne;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author david
 */
public class PersonneDAO {
    public static void create(Personne personne) throws SQLException{
        Connection c=DBConnect.getConnection();
       PreparedStatement stm; 
       
       stm=c.prepareStatement("INSERT INTO personne (personne_prenom,personne_nom,personne_email,personne_mdp,personne_addresse1,personne_addresse2,personne_ville,personne_pays,personne_langue,personne_tel) VALUE(?,?,?,?,?,?,?,?,?,?)");
       stm.setString(1, personne.getPrenom());
       stm.setString(2, personne.getNom());
       stm.setString(3, personne.getEmail());
       stm.setString(4, personne.getMdp());
       stm.setString(5, personne.getAddresse1());
       stm.setString(6, personne.getAddresse2());
       stm.setString(7, personne.getVille());
       stm.setString(8, personne.getPays());
       stm.setString(9, personne.getLangue());
       stm.setString(10, personne.getTel());
       stm.execute();
       stm.close();
        
    }
    
    public static Personne findOneById(int id) throws SQLException{
      Personne personne = null;
      Connection c = DBConnect.getConnection();
      Statement stm;
      stm=c.createStatement();
      
      String sql ="SELECT * FROM personne WHERE personne_id"+id;
      ResultSet rs =stm.executeQuery(sql);
      
      if(rs.next()){
          String prenom = rs.getString("personne_prenom");
          String nom = rs.getString("personne_nom");
          String email = rs.getString("personne_email");
          String mdp = rs.getString("personne_mdp");
          String addresse1 = rs.getString("personne_addresse1");
           String addresse2 = rs.getString("personne_addresse2");
            String ville = rs.getString("personne_ville");
             String pays = rs.getString("personne_pays");
             String langue =  rs.getString("personne_langue");
              String tel = rs.getString("personne_tel");
              personne=new Personne(id,prenom,nom,email,mdp,addresse1,addresse2,ville,pays,langue,tel);
      }
        return personne;
    }
}
