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
public class Personne {
    private int personne_id;
    private String prenom;
    private String nom;
    private String email;
    private String mdp;
    private String addresse1;
    private String addresse2;
    private String ville;
    private String pays;
    private String langue;
    private String tel;

    public Personne(int personne_id, String prenom, String nom, String email, String mdp, String addresse1, String addresse2, String ville, String pays, String langue, String tel) {
        this.personne_id = personne_id;
        this.prenom = prenom;
        this.nom = nom;
        this.email = email;
        this.mdp = mdp;
        this.addresse1 = addresse1;
        this.addresse2 = addresse2;
        this.ville = ville;
        this.pays = pays;
        this.langue = langue;
        this.tel = tel;
    }

    public int getId() {
        return personne_id;
    }

    public void setId(int id) {
        this.personne_id = id;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public String getAddresse1() {
        return addresse1;
    }

    public void setAddresse1(String addresse1) {
        this.addresse1 = addresse1;
    }

    public String getAddresse2() {
        return addresse2;
    }

    public void setAddresse2(String addresse2) {
        this.addresse2 = addresse2;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public String getLangue() {
        return langue;
    }

    public void setLangue(String langue) {
        this.langue = langue;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Personne() {
    }
}
