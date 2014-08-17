package org.conan.r.rserve;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class Demo1 {
    
   /**
    * Main方法用于启动Java应用  
    */
    public static void main(String[] args) throws RserveException, REXPMismatchException {
        Demo1 demo = new Demo1();
        demo.callRserve();
    }

    /**
     * 访问Rserve 
     */
    public void callRserve() throws RserveException, REXPMismatchException {
        RConnection c = new RConnection("192.168.1.201"); //创建访问连接
        REXP x = c.eval("R.version.string"); //执行一条R的语句
        System.out.println(x.asString()); //在Java中打印返回结果

        double[] arr = c.eval("rnorm(10)").asDoubles(); //执行rnorm(10)语句
        for (double a : arr) { //在Java中循环打印返回结果
            System.out.print(a + ",");
        }
    }
}
