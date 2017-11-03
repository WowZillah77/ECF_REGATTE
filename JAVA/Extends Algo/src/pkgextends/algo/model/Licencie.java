/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgextends.algo.model;

import pkgextends.algo.exception.NoPointsAddedException;

/**
 *
 * @author david
 */
public class Licencie extends Personne{
    private int numlicence;
    private double pointsFFV;
    private int anneeLicence;

/**
 * 
 * @param nom last name of the person(String)
 * @param prenom first name of the person(String)
 * @param email email address of the person(String)
 * @param numlicence license number(INT)
 * @param pointsFFV number of points(Double)
 * @param anneeLicence year of the license(INT)
 */
    public Licencie(String nom, String prenom, String email,int yob,int numlicence, double pointsFFV, int anneeLicence) {
        super(nom,prenom,email, yob);
        this.numlicence = numlicence;
        this.pointsFFV = pointsFFV;
        this.anneeLicence = anneeLicence;
    }

    @Override
    public String toString() {
        return "Licencie{" + "numlicence=" + numlicence + ", pointsFFV=" + pointsFFV + ", anneeLicence=" + anneeLicence +super.toString()+ '}';
    }

    public int getNumlicence() {
        return numlicence;
    }

    public void setNumlicence(int numlicence) {
        this.numlicence = numlicence;
    }

    public double getPointsFFV() {
        return pointsFFV;
    }

    public void setPointsFFV(double pointsFFV) {
        this.pointsFFV = pointsFFV;
    }

    public int getAnneeLicence() {
        return anneeLicence;
    }

    public void setAnneeLicence(int anneeLicence) {
        this.anneeLicence = anneeLicence;
    }
    
    public void calculPoints(double point,int year) throws NoPointsAddedException{
        if(year==anneeLicence){
            pointsFFV+=point;
        }else{
            throw new NoPointsAddedException("No points Added");
        }
      
    }
    
}
