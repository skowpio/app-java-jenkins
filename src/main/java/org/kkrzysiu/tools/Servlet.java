package org.kkrzysiu.tools;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.net.InetAddress;
import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import com.jcabi.manifests.Manifests;

public class Servlet {

    public static void main(String[] args) throws LifecycleException,
            InterruptedException, ServletException {

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(16385);

        Context ctx = tomcat.addContext("/", new File(".").getAbsolutePath());

        Tomcat.addServlet(ctx, "Embedded", new HttpServlet() {
            @Override
            protected void service(HttpServletRequest req, HttpServletResponse resp) 
                    throws ServletException, IOException {
                
                Writer w = resp.getWriter();
                w.write("<h1>This is an example Web application built with help of Jenkins.<ul><li>The version of application is: " + Manifests.read("Implementation-Version") + "</li><li>The application has been deployed by: " + System.getProperty("deployedBy") + "</li><li>The application has been started on system user: " + System.getProperty("user.name") + "</li><li>The application runs on host: " + InetAddress.getLocalHost().getHostName() + "</li></ul></h1>\n");
                w.flush();
                w.close();
            }
        });

        ctx.addServletMapping("/*", "Embedded");

        tomcat.start();
        tomcat.getServer().await();
    }
}
