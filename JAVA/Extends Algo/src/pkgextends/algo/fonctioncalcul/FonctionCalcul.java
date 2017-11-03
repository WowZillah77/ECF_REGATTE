/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgextends.algo.fonctioncalcul;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import pkgextends.algo.model.Personne;

/**
 *
 * @author david
 */
public class FonctionCalcul {
    /**
     * 
     * @param p a list of type Personne
     * @return a double. the average age of the collection
     */
    
    public static double moyenneAge(ArrayList<Personne> p){
        Personne personne = new Personne();
        double ageSomme =0;
        for (Personne per:p) {
            ageSomme+=personne.calculAge(per.getYob());
            
        }
        double moyenne=ageSomme/p.size();
        
        return moyenne;
    }
    
    public static int medianAge(ArrayList<Personne>p){
        //create a list of the size of the amount of people in the Array List
      int[] ages = new int[p.size()];
      //instanciate the object Personne
       Personne personne = new Personne();
       //declaring the variable i to 'travel the list'
       int i=0;
       // go through the Array list/calculate the age of each person and add it in the list Ages
      for(Personne per:p){
         ages[i]=(personne.calculAge(per.getYob()));
         i++;
      }
      //sort the list Ages
      Arrays.sort(ages);
        int milieu = ages.length/2;
        int median = 0;
        if(ages.length%2==1)
            median = ages[milieu];
        else
            median =(ages[milieu-1]+ages[milieu])/2;
        
        return median;
    }
    
    
}
