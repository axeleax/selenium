package com.esrx.test.google.drivers;

import org.openqa.selenium.Platform;
import org.openqa.selenium.SessionNotCreatedException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.RemoteWebDriver;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.TimeUnit;

public class Chrome extends WebExplorer {

    private WebDriver webDriver;
    private static String DRIVERS_PATH = "C:\\selenium\\driver\\";

    public Chrome() {
        super();
        System.setProperty("webdriver.chrome.driver", DRIVERS_PATH + "chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.setCapability("browserVersion", "80.0.3987.149");
        options.setCapability("platformName", Platform.WINDOWS);
        options.setHeadless(true);

        try {
            String currentExecution = System.getProperty("execution", "local");
            if ("local".equals(currentExecution)) {
                webDriver = new ChromeDriver();
            } else {
                webDriver = new RemoteWebDriver(new URL("http://localhost:4444/wd/hub"), options);
            }
            webDriver.manage().timeouts().implicitlyWait(60, TimeUnit.SECONDS);
            // webDriver.manage().window().maximize();
        } catch (MalformedURLException e) {
            System.out.println("Wrong RemoteWebDriver URL: " + e.getMessage());
        } catch (SessionNotCreatedException e) {
            System.out.println("Remote execution failed: " + e.getMessage());
            webDriver.quit();
        }
    }

    public WebDriver getRemoteDriver() {

        return webDriver;

    }
}