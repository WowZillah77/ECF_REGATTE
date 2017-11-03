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
public class Proprietaire extends Personne{

    public Proprietaire(String nom, String prenom, String email, int yob) {
         super(nom, prenom, email,yob);
    }

    @Override
    public String toString() {
        return "Proprietaire{"+ super.toString() + '}';
    }
    
    
}
