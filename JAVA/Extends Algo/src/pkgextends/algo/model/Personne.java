/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgextends.algo.model;

import java.util.Calendar;

/**
 *
 * @author david
 */
public class Personne {
    protected  String nom;
   protected String prenom;
    protected String email;
    protected int yob;

    public Personne(String nom, String prenom, String email, int yob) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.yob = yob;
    }

    public int getYob() {
        return yob;
    }

    public void setYob(int yob) {
        this.yob = yob;
    }

    public Personne() {
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Personne{" + "nom=" + nom + ", prenom=" + prenom + ", email=" + email +" yob="+yob+ '}';
    }
    
    public int calculAge(int annee){
        int year = Calendar.getInstance().get(Calendar.YEAR);
        int age= year-annee;
        return age;
    }

 
    
    
}
