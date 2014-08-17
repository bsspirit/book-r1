package org.conan.r.rjava;

import org.rosuda.JRI.Rengine;

public class DemoRJava {

    public static void main(String[] args) {
        DemoRJava demo = new DemoRJava();
        demo.callRJava();
    }

    public void callRJava() {
        Rengine re = new Rengine(new String[] { "--vanilla" }, false, null);
        if (!re.waitForR()) {
            System.out.println("Cannot load R");
            return;
        }
        
        String version = re.eval("R.version.string").asString();
        System.out.println(version);

        double[] arr = re.eval("rnorm(10)").asDoubleArray();
        for (double a : arr) {
            System.out.print(a + ",");
        }
        re.end();
    }
}
