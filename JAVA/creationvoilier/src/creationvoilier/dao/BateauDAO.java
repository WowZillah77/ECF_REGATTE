/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creationvoilier.dao;

import creationvoilier.model.Bateau;
import creationvoilier.model.Classe;
import creationvoilier.model.Proprietaire;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author david
 */
public class BateauDAO {

    public static void create(Bateau bateau) throws SQLException {
        Connection c = DBConnect.getConnection();
        PreparedStatement stm;

        stm = c.prepareStatement("INSERT INTO bateau (bateau_nom,bateau_voile,proprietaire_id,classe_id) VALUE(?,?,?,?)");
        stm.setString(1, bateau.getNom());
        stm.setInt(2, bateau.getVoile());
        stm.setInt(3, bateau.getProprietaire().getId());
        stm.setInt(4, bateau.getClasse().getId());

        stm.execute();
        stm.close();

    }
    
    public static ArrayList<Bateau> findAll() throws SQLException{
        ArrayList<Bateau> bateaux=new ArrayList();
        Classe classe;
        Proprietaire proprietaire;
        
       Connection c = DBConnect.getConnection();
       Statement stm;
       String sql ="SELECT * FROM bateau";
       stm=c.createStatement();
       ResultSet rs = stm.executeQuery(sql);
       
       while(rs.next()){
        int id=rs.getInt("bateau_id");
        String nom =rs.getString("bateau_nom");
        int voile = rs.getInt("bateau_voile");
        proprietaire=ProprietaireDAO.findOneById(rs.getInt("proprietaire_id"));
        classe = ClasseDAO.findOneById(rs.getInt("classe_id"));
        Bateau bateau = new Bateau(id,nom,voile,proprietaire,classe);
    }
        
        return bateaux;
    }
}
