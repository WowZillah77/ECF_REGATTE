/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgextends.algo;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import pkgextends.algo.exception.NoPointsAddedException;
import pkgextends.algo.fonctioncalcul.FonctionCalcul;
import pkgextends.algo.model.Commissaire;
import pkgextends.algo.model.Licencie;
import pkgextends.algo.model.Personne;
import pkgextends.algo.model.Proprietaire;

/**
 *
 * @author david
 */
public class ExtendsAlgo {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        // instancer le jeu d'essai
        Proprietaire proprietaire1 = new Proprietaire("Stout","Mary","m.stout@gmail.com",1984);
        Proprietaire proprietaire2= new Proprietaire("Sellers","Peter","p.sellers@gmail.com",1977);
        Licencie licencie1 = new Licencie("pain","max","m.Pain@gmail.com",1998,1355,0,1988);
        Licencie licencie2 = new Licencie("butters","yvonne","y.butters@gmail.com",1985,1365,0,2016);
        Licencie licencie3 = new Licencie("Moquette","Roger","r.moquette@gmail.com",1980,1589,0,2017);
        Commissaire commissaire = new Commissaire("commissaire","Plum","c.plum@gmail.com",1972,"Comité des fruits et légumes");
        
        // mettre le jeu d'essai dans une collection
        
        ArrayList<Personne>personnes = new ArrayList();
        personnes.add(licencie3);
        personnes.add(licencie2);
        personnes.add(licencie1);
        personnes.add(commissaire);
        personnes.add(proprietaire2);
        personnes.add(proprietaire1);
        
        //affichage dans la console
        for(Personne p:personnes){
            System.out.println(p);
        }
        double median =FonctionCalcul.medianAge(personnes);
        double moyenne = FonctionCalcul.moyenneAge(personnes);
        System.out.println("median = "+median);
        System.out.println("moyenne = "+moyenne);
        
        //check the function calculPoints()
        //cal1 and cal2 will work
        int cal1 = 1988;
        int cal2 = 2016;
        //cal3 will throw an error
        int cal3 =2011;
        
        //TEST
        try {
            licencie1.calculPoints(5, cal1);
        } catch (NoPointsAddedException ex) {
            Logger.getLogger(ExtendsAlgo.class.getName()).log(Level.SEVERE, null, ex);
            
        }
        System.out.println(licencie1);
        
       
        try {
            licencie3.calculPoints(6, cal3);
        } catch (NoPointsAddedException ex) {
            Logger.getLogger(ExtendsAlgo.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(licencie3);
        
    }
    
}
