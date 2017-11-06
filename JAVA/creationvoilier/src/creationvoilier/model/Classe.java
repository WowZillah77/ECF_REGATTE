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
public class Classe {
    private int id;
    private String nom;
    private float coeff;
    private Serie serie;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public float getCoeff() {
        return coeff;
    }

    public void setCoeff(float coeff) {
        this.coeff = coeff;
    }

    public Serie getSerie() {
        return serie;
    }

    public void setSerie(Serie serie) {
        this.serie = serie;
    }

    public Classe() {
    }

    public Classe(int id, String nom, float coeff, Serie serie) {
        this.id = id;
        this.nom = nom;
        this.coeff = coeff;
        this.serie = serie;
        
        
    }

    @Override
    public String toString() {
        return  nom ;
    }
    
}
