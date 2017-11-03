/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ecfregateemailfonction.checks;

/**
 *
 * @author david
 */
public class Iscorrect {

    /**
     *
     * @param email
     * @return true if the email entered is correct
     */
    public Boolean isEmail(String email) {
        //check if there is only one @
        String[] e = email.split("@");
        if (e.length == 2) {
            //check if there is at least one . on the right side
            String[] rightside = e[1].split("\\.");
            if (rightside.length >= 2) {
                //check if there is at least 2 characters before and after the .
                if (rightside[0].length() >= 2 && rightside[1].length() >= 2) {
                    if (e[0].length() >= 2) {
                        return true;
                    }
                }
        

            }

        }
        return false;
    }

}
