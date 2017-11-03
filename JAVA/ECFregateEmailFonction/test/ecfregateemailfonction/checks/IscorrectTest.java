/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ecfregateemailfonction.checks;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author david
 */
public class IscorrectTest {
    Iscorrect iscorrect = new Iscorrect();

    public IscorrectTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    /**
     * Test of emailIsCorrect method, of class Iscorrect.
     */
    @Test
    public void testEmailIsCorrect() {
        assertTrue(iscorrect.isEmail("ab@cd.ef"));
        assertTrue(iscorrect.isEmail("abcdef@ghij.klmn"));
        assertFalse(iscorrect.isEmail("ab@c.f.ef"));
        assertFalse(iscorrect.isEmail("a@ghij.klmn"));
        assertFalse(iscorrect.isEmail("ab@c.de"));
        assertFalse(iscorrect.isEmail("ab@cd.e"));
        assertFalse(iscorrect.isEmail("abcdefghij"));
        assertFalse(iscorrect.isEmail("abcdefghij.kl"));
        assertFalse(iscorrect.isEmail("ab@cdef"));
    }

}
