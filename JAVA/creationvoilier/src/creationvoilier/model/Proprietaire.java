/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creationvoilier.model;

/**
 *
 * @author david
 */
public class Proprietaire extends Personne {
    
    private int id;
    private Club club;

    public Proprietaire(int id, Club club, int personne_id, String prenom, String nom, String email, String mdp, String addresse1, String addresse2, String ville, String pays, String langue, String tel) {
        super(personne_id, prenom, nom, email, mdp, addresse1, addresse2, ville, pays, langue, tel);
        this.id = id;
        this.club = club;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Club getClub() {
        return club;
    }

    public void setClub(Club club) {
        this.club = club;
    }

}