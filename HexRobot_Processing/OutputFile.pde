

//write data to a text file
class OutputFile_rawtxt {
  PrintWriter output;
  String fname;
  private int rowsWritten;
  
  OutputFile_rawtxt(float fs_Hz) {

    //build up the file name
    fname = "SavedData\\openBCI_raw_";
   
    //add year month day to the file name
    fname = fname + year() + "-";
    if (month() < 10) fname=fname+"0";
    fname = fname + month() + "-";
    if (day() < 10) fname = fname + "0";
    fname = fname + day(); 
    
    //add hour minute sec to the file name
    fname = fname + "_";
    if (hour() < 10) fname = fname + "0";
    fname = fname + hour() + "-";
    if (minute() < 10) fname = fname + "0";
    fname = fname + minute() + "-";
    if (second() < 10) fname = fname + "0";
    fname = fname + second();
   
    //add the extension
    fname = fname + ".txt";
    
    //open the file
    output = createWriter(fname);
  
    //add the header
    writeHeader(fs_Hz);
  }

  public void writeHeader(float fs_Hz) {
    output.println("%OpenBCI Raw EEG Data");
    output.println("%");
    output.println("%Sample Rate = " + fs_Hz + " Hz");
    output.println("%First Column = SampleIndex");
    output.println("%Other Columns = EEG data in microvolts");
    output.flush();
  }

  
  public void writeRawData_dataPacket(DataPacket_ADS1299 data,float scale_to_uV) {
    int nchan = data.values.length;
    rowsWritten = 0;
   
    if (output != null) {
      output.print(Integer.toString(data.sampleIndex));
      for (int Ichan = 0; Ichan < nchan; Ichan++) {
        output.print(", ");
        if (abs(scale_to_uV-1.0) < 1e-6) {
          output.print(Integer.toString(data.values[Ichan]));
        } else {
          output.print(String.format("%.2f",scale_to_uV * float(data.values[Ichan])));
        }
      }
      output.println();
      //output.flush();
    }
  }
  
  
  public void closeFile() {
    output.flush();
    output.close();
  }
  
  public int getRowsWritten() {
    return rowsWritten;
  }
};


