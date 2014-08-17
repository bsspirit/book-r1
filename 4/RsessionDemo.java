package org.conan.r.rsession;

import java.io.File;
import java.util.Properties;

import org.math.R.RLogPanel;
import org.math.R.RserverConf;
import org.math.R.Rsession;
import org.rosuda.REngine.REXPMismatchException;

public class RsessionDemo {

    public static void main(String args[]) throws REXPMismatchException {
        RserverConf rconf = new RserverConf("192.168.1.201", 6311, "conan", "conan", new Properties());
        Rsession s = Rsession.newInstanceTry(System.out, rconf);
        
        new RLogPanel(); 

        // 执行R脚本
        double[] rand = s.eval("rnorm(5)").asDoubles();
        for (double ran : rand) {
            System.out.print(ran + ",");
        }

        // 创建一个R对象
        s.set("demo", Math.random());
        s.eval("ls()");

        // 保存R环境到本地到文件
        s.save(new File("./output/save.Rdata"), "demo");

        // 删除R对象demo
        s.rm("demo");
        s.eval("ls()");

        // 从文件加载R环境
       s.load(new File("./output/save.Rdata"));
        s.eval("ls()");
        s.eval("print(demo)");

        // 创建一个data.frame对象
        s.set("df", new double[][] { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 }, { 10, 11, 12 } }, "x1", "x2", "x3");
        double df$x1_3 = s.eval("df$x1[3]").asDouble();
        System.out.println(df$x1_3);
        s.rm("df");

        // 在本地生成一个图形文件
        s.toJPEG(new File("./output/plot.png"), 400, 400, "plot(rnorm(10))");

        // 以HTML格式输出
        String html = s.asHTML("summary(rnorm(100))");
        System.out.println(html);

        // 以文本格式输出
        String txt = s.asString("summary(rnorm(100))");
        System.out.println(txt);

        // 安装新类库
        System.out.println(s.installPackage("sensitivity", true));

        s.end();
    }

}
