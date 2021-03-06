// Uses Windows powershell to run Tshark program and write to Processing sketch
// Use threading so application doesnt have to wait for Tsharks 10 seconds of collection.

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

void setup(){
  fullScreen();
  background(255,0,0);
  try {
      executeCommand();
    }
    catch (IOException e){
      System.out.println("OH shid");
    }
}
void draw(){
  background(0,255,0);
}




void executeCommand() throws IOException {

  //String command = "powershell.exe  your command";
  //Getting the version
  String command = "powershell.exe  C:\\'Program Files'\\Wireshark\\tshark.exe -i 1 -a duration:4";
  // Executing the command
  Process powerShellProcess = Runtime.getRuntime().exec(command);
  // Getting the results
  powerShellProcess.getOutputStream().close();
  String line;
  System.out.println("Standard Output:");
  BufferedReader stdout = new BufferedReader(new InputStreamReader(
    powerShellProcess.getInputStream()));
  while ((line = stdout.readLine()) != null) {
   text(line,100,100);
  }
  stdout.close();
  System.out.println("Standard Error:");
  BufferedReader stderr = new BufferedReader(new InputStreamReader(
    powerShellProcess.getErrorStream()));
  while ((line = stderr.readLine()) != null) {
   System.out.println(line);
  }
  stderr.close();
  System.out.println("Done");
}
