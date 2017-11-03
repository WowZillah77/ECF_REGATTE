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
public class Serie {
    private int serie_id;
    private String nom;

    public Serie(int serie_id, String nom) {
        this.serie_id = serie_id;
        this.nom = nom;
    }

    public int getSerie_id() {
        return serie_id;
    }

    public void setSerie_id(int serie_id) {
        this.serie_id = serie_id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
    
    
}
