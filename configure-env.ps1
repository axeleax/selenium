[Net.ServicePointManager]::SecurityProtocol = "Ssl3, Tls, Tls11, Tls12";

$currentDir = (Get-Item -Path "C:/selenium/").FullName;
$driversDirName = Join-Path $currentDir "driver";
$isWindows = [System.Boolean](Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue);
$webClient = New-Object System.Net.WebClient;

function Ensure-Driver-Exists($browserName, $exeName, $download, $zipName) {

    $localExeName = Join-Path $driversDirName $exeName;
    if (Test-Path $localExeName) {
        Write-Host "${browserName}: Driver already located at $localExeName." -f Red;
        return;
    }

    if ($zipName -eq $null) {
        $localDownloadLocation = Join-Path $driversDirName $exeName;
    } else {
        $download = "$download$zipName";
        $localDownloadLocation = Join-Path $driversDirName $zipName;
    }

    Write-Host "${browserName}: Downloading driver..." -f Yellow;
    Write-Host "${browserName}: URL" $download -f Yellow;
    $webClient.downloadFile($download, $localDownloadLocation);

    if (!($zipName -eq $null)) {
        Write-Host "${browserName}: Extracting driver ..." -f Yellow;
        Expand-Archive -DestinationPath $driversDirName -Path $localDownloadLocation;
        Remove-Item $localDownloadLocation;
    }

    Write-Host "${browserName}: Driver placed in $localExeName." -f Yellow;
}

 

function Ensure-Chrome-Driver() {

    Ensure-Driver-Exists "Chrome" "chromedriver.exe" "https://chromedriver.storage.googleapis.com/80.0.3987.16/" "chromedriver_win32.zip"
}

 

function Ensure-Gecko-Driver() {

    Ensure-Driver-Exists "Gecko (Firefox)" "geckodriver.exe" "https://github.com/mozilla/geckodriver/releases/download/v0.29.1/" "geckodriver-v0.29.1-win64.zip";
}

 

function Ensure-Edge-Driver() {

    if ($isWindows) {
        Ensure-Driver-Exists "Edge" "msedgedriver.exe" "https://msedgedriver.azureedge.net/80.0.361.109/" "edgedriver_win64.zip"
    }
}

 

function Ensure-Selenium-Hub-Jar() {

    if ($isWindows) {
        $jarName = "selenium-server-standalone-3.141.59.jar"
        $localJarName = Join-Path $currentDir $jarName;
        if (Test-Path $localJarName) {
            Write-Host "Selenium HUB: Driver already located at $localJarName." -f Red;
            return;
        }

        Write-Host "Downloading Selenium HUB jar..." -f Green;
        $download = "https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar "
        $webClient.downloadFile($download, $localJarName);
        Write-Host "Selenium HUB: Jar placed in $localJarName." -f Green;
    }
}

function Add-Path-Variables() {

    if ($isWindows) {
        Write-Host "Editing PATH variable, adding webdrivers locations..." -f Blue;
        $drivers = @("IEDriverServer.exe","MicrosoftWebDriver.exe","geckodriver.exe","chromedriver.exe")
        # Perform iteration to create the same file in each folder
        $newPath = "";
        foreach ($driver in $drivers) {
            $driverLocation = Join-Path $driversDirName $driver;
            $newPath = $newPath + $driverLocation + ";";
        }

        $oldPath = [Environment]::GetEnvironmentVariable('path', 'user');
        [Environment]::SetEnvironmentVariable('path', "$($newPath);$($oldPath)",'user');
        Write-Host "PATH updated ($newPath) were added." -f Blue;

    }
}

New-Item -Force -ItemType directory -Path $driversDirName > $null;

Ensure-Chrome-Driver;
Ensure-Gecko-Driver;
Ensure-Edge-Driver;
Ensure-Selenium-Hub-Jar;
Add-Path-Variables;