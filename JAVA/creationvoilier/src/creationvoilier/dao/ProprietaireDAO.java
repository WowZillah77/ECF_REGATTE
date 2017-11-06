/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creationvoilier.dao;

import creationvoilier.model.Club;
import creationvoilier.model.Personne;
import creationvoilier.model.Proprietaire;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author david
 */
public class ProprietaireDAO {
    
    public static void create(Proprietaire proprietaire){
        try {
            Connection c = DBConnect.getConnection();
            PreparedStatement stm;
            
            stm = c.prepareStatement("INSERT INTO proprietaire (personne_id,club_id) VALUE(?,?)");
            stm.setInt(1,proprietaire.getPersonneId());
            stm.setInt(2, proprietaire.getClub().getId());
            
            
            stm.execute();
            stm.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProprietaireDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
        
    
    public static ArrayList<Proprietaire> findAll(){
        try {
            ArrayList<Proprietaire> proprietaires=new ArrayList();
            Personne personne;
            Club club;
            
            Connection c = DBConnect.getConnection();
            Statement stm;
            String sql ="SELECT * FROM proprietaire";
            stm=c.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            
            while(rs.next()){
                int id=rs.getInt("proprietaire_id");
                personne= PersonneDAO.findOneById(rs.getInt("personne_id"));
                club=ClubDAO.findOneById(rs.getInt("club_id"));
                Proprietaire proprietaire =new Proprietaire(id,club, personne.getPersonneId(), personne.getPrenom(), personne.getNom(), personne.getEmail(), "test", personne.getAddresse1(), personne.getAddresse2(), personne.getVille(), personne.getPays(), personne.getLangue(), personne.getTel());
                proprietaires.add(proprietaire);
            }
            return proprietaires;
        } catch (SQLException ex) {
            Logger.getLogger(ProprietaireDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static Proprietaire findOneById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
