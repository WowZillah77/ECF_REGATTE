/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgextends.algo.model;

/**
 *
 * @author david
 */
public class Commissaire extends Personne {
    private String commite;


    public Commissaire(String nom, String prenom, String email,int yob,String commite) {
        super(nom,prenom,email,yob);
        this.commite = commite;
    }

    public String getCommite() {
        return commite;
    }

    public void setCommite(String commite) {
        this.commite = commite;
    }

    @Override
    public String toString() {
        return "Commissaire{" + "commite=" + commite + super.toString()+'}';
    }
}
