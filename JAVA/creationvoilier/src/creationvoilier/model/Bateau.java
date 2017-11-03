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
public class Bateau {
    private int id;
    private String nom;
    private int voile;
    private Proprietaire proprietaire;
    private Classe classe;

    public Bateau(int id, String nom, int voile, Proprietaire proprietaire, Classe classe) {
        this.id = id;
        this.nom = nom;
        this.voile = voile;
        this.proprietaire = proprietaire;
        this.classe = classe;
    }

    public Bateau() {
    }

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

    public int getVoile() {
        return voile;
    }

    public void setVoile(int voile) {
        this.voile = voile;
    }

    public Proprietaire getProprietaire() {
        return proprietaire;
    }

    public void setProprietaire(Proprietaire proprietaire) {
        this.proprietaire = proprietaire;
    }

    public Classe getClasse() {
        return classe;
    }

    public void setClasse(Classe classe) {
        this.classe = classe;
    }
    
}
