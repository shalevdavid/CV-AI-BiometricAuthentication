//package VideoStreamJPanelOpenCV;
//
//
////Import the basic graphics classes.  
//// The problem here is that we read the image with OpenCV into a Mat object.  
//// But OpenCV for java doesn't have the method "imshow", so, we got to use  
//// java for that (drawImage) that uses Image or BufferedImage.  
//// So, how to go from one the other... Here is the way...  
//import java.awt.*;  
//import java.awt.image.BufferedImage;  
//import javax.swing.*;  
//import org.opencv.core.Mat;  
//import org.opencv.core.Core;
////import org.opencv.Highgui.VideoCapture;  
//import org.opencv.video.Video;
//import org.opencv.highgui.VideoCapture;
//
//public class VideoStreamJPanelOpenCV extends JPanel{  
//	private static final long serialVersionUID = 1L;  
//	private BufferedImage image;
//	
//	// Create a constructor method  
//	public VideoStreamJPanelOpenCV(){  
//		super();  
//	}
//	
//	private BufferedImage getimage(){  
//		return image;  
//	}
//	
//	private void setimage(BufferedImage newimage){  
//		image=newimage;  
//		return;  
//	}
//	
//	/**  
//	 * Converts/writes a Mat into a BufferedImage.  
//	 *  
//	 * @param matrix Mat of type CV_8UC3 or CV_8UC1  
//	 * @return BufferedImage of type TYPE_3BYTE_BGR or TYPE_BYTE_GRAY  
//	 */  
//	public static BufferedImage matToBufferedImage(Mat matrix) {  
//		int cols = matrix.cols();  
//		int rows = matrix.rows();  
//		int elemSize = (int)matrix.elemSize();  
//		byte[] data = new byte[cols * rows * elemSize];  
//		int type;  
//		matrix.get(0, 0, data);  
//		switch (matrix.channels()) {  
//		case 1:  
//			type = BufferedImage.TYPE_BYTE_GRAY;  
//			break;  
//		case 3:  
//			type = BufferedImage.TYPE_3BYTE_BGR;  
//			// bgr to rgb  
//			byte b;  
//			for(int i=0; i<data.length; i=i+3) {  
//				b = data[i];  
//				data[i] = data[i+2];  
//				data[i+2] = b;  
//			}  
//			break;  
//		default:  
//			return null;  
//		}  
//		BufferedImage image2 = new BufferedImage(cols, rows, type);  
//		image2.getRaster().setDataElements(0, 0, cols, rows, data);  
//		return image2;  
//	}
//	
//	public void paintComponent(Graphics g){  
//		BufferedImage temp=getimage();  
//		g.drawImage(temp,10,10,temp.getWidth(),temp.getHeight(), this);  
//	}
//	
//	public static void main(String arg[]){  
//		// Load the native library.  
//		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
//		JFrame frame = new JFrame("BasicPanel");  
//		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
//		frame.setSize(400,400);  
//		VideoStreamJPanelOpenCV panel = new VideoStreamJPanelOpenCV();  
//		frame.setContentPane(panel);       
//		frame.setVisible(true);       
//		Mat webcam_image = new Mat();  
//		BufferedImage temp;  
//		VideoCapture capture =new VideoCapture(0);
//		
//		if( capture.isOpened())  
//		{  
//			while( true )  
//			{  
//				capture.read(webcam_image);  
//				if( !webcam_image.empty() )  
//				{  
//					frame.setSize(webcam_image.width()+40,webcam_image.height()+60);  
//					temp=matToBufferedImage(webcam_image);  
//					panel.setimage(temp);  
//					panel.repaint();  
//				}  
//				else  
//				{  
//					System.out.println(" --(!) No captured frame -- Break!");  
//					break;  
//				}  
//			}  
//		}  
//		return;  
//	}
//	
//	public static void VideoStreamJpanelInFrame(){  
//		JFrame frame = new JFrame("BasicPanel");  
//		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
//		frame.setSize(400,400);  
//		VideoStreamJPanelOpenCV panel = new VideoStreamJPanelOpenCV();  
//		frame.setContentPane(panel);       
//		frame.setVisible(true);       
//		Mat webcam_image = new Mat();  
//		BufferedImage temp;  
//		VideoCapture capture = new VideoCapture(0);
//		
//		if( capture.isOpened())  
//		{  
//			while( true )  
//			{  
//				capture.read(webcam_image);  
//				if( !webcam_image.empty() )  
//				{  
//					frame.setSize(webcam_image.width()+40,webcam_image.height()+60);  
//					temp=matToBufferedImage(webcam_image);  
//					panel.setimage(temp);  
//					panel.repaint();  
//				}  
//				else  
//				{  
//					System.out.println(" --(!) No captured frame -- Break!");  
//					break;  
//				}  
//			}  
//		}  
//		return;  
//	}
//	
//}  
//




package VideoStreamJPanelOpenCV;



//package TestOpenCV;

//

//import org.opencv.core.Core;

//

//public class TestOpenCV {

//

//          /**

//          * @param args

//          */

//          public static void main(String[] args) {

//                          // TODO Auto-generated method stub

//                          System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

//          }

//

//}



//Import the basic graphics classes.  

//The problem here is that we read the image with OpenCV into a Mat object.  

//But OpenCV for java doesn't have the method "imshow", so, we got to use  

//java for that (drawImage) that uses Image or BufferedImage.  

//So, how to go from one the other... Here is the way...  

import java.awt.*;  
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;  
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.swing.*;  
import org.opencv.core.Mat;  
import org.opencv.core.Core;
import org.opencv.video.Video;

import javafx.scene.paint.Color;

import org.opencv.highgui.Highgui;
import org.opencv.highgui.VideoCapture;
import uploadImageAndClassifyRemoteServerPHP.*;

public class VideoStreamJPanelOpenCV extends JPanel implements ActionListener {

	private static final long serialVersionUID = 1L;  
	private BufferedImage image;  

	// Create a constructor method  
	public VideoStreamJPanelOpenCV(){  
		super();  
		lastObjCreated = this;
		//System.load("C:/Users/user/opencv/build/java/x64/opencv_java2411.dll");
		
		createTempDir();
		
		String dllPathOpenCv = null;
		
//		 //Another way to get the app running directory.
//		try {
//			dllPathOpenCv = this.getClass().getProtectionDomain().getCodeSource().getLocation().toURI().getPath();
//			File file = new File(dllPathOpenCv);
//			dllPathOpenCv = file.getParentFile().getAbsolutePath() + "/DLLs/" + "opencv_java2411.dll";
//			
//		} catch (URISyntaxException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		dllPathOpenCv = System.getProperty("user.dir") + "\\DLLs\\opencv_java2411.dll";
		
		System.load(dllPathOpenCv);
		
//		try {
//			System.load(dllPathOpenCv);
//		}
//		catch(Exception ex)
//		{
//
//		}
	}
	
	public VideoStreamJPanelOpenCV(JButton btnStartPreview)
	{
		super();
		_btnStartPreview = btnStartPreview;
	}

	private BufferedImage getimage(){  
		return image;  
	}

	public void setimage(BufferedImage newimage){  
		image = newimage;  
		return;  
	}  

	private BufferedImage capturedBimg;

	private void SaveImageToFile(String fileNameFullPath, BufferedImage bImg)
	{
		capturedBimg = bImg;
		
		// retrieve image
		File outputfile = new File(fileNameFullPath);
		try {
			ImageIO.write(bImg, "jpg", outputfile);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void createTempDir()
	{
		File tempDir = new File(getTempDir());
		if (!tempDir.exists())
		{
			tempDir.mkdirs();
		}
	}
	
	public String getTempDir()
	{
		return System.getProperty("user.dir") + "\\temp";
	}
	
	private void saveImagetoDataBaseRemoteServer()
	{
		Map<String, String> multiParamPairs = new HashMap<String, String>();
		multiParamPairs.put("ItemType", jTextBoxItemType.getText());
		multiParamPairs.put("ItemId", jTextBoxItemID.getText() );
		//multiParamPairs.put("PictureName", "1.jpeg");
		
		/*
		 *  Capture (get image from stream) and Save image to file
		 */
		String uploadFilePath = getTempDir() + "\\" + jTextBoxItemIdImageNum.getText() + ".jpg";
		SaveImageToFile(uploadFilePath, getimage());
		
		/*
		 *  Run Matlab from Remote server
		 */		
		String outputFileName = getTempDir() + "\\outputImageRemoteServerResponse.jpg";
		
		uploadImageAndClassifyRemoteServerPHP uploadImageToDB = new uploadImageAndClassifyRemoteServerPHP(outputFileName);
		if (jTextBoxItemType.getText().equals("openedHand") )
		{
			uploadImageToDB.ipChangeToBiometricsServer();
		}
		uploadImageToDB.executeUploadImageForEnrollemnt(uploadFilePath, multiParamPairs);
			
		/*
		 *  Display Result on MSPaint for simplicity (T.B.D)
		 */
		String commandToRun = "mspaint " + outputFileName;
		Runtime rt = Runtime.getRuntime();
		try {
			Process pr = rt.exec(commandToRun);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void saveImageToDataBaseLocal(BufferedImage bImg)
	{
		capturedBimg = bImg;

		//String curDirAbsolutePath = "D:/shalev/Projects/WorkspaceEclipseMars2/videoCameraCaptureFrames/";
		String curDirAbsolutePath = getCurrentDatabasePathLocal();
		
		File theDir = new File(curDirAbsolutePath + jTextBoxItemType.getText() + "/");
	    try{
			if (!theDir.exists()) 
			{
				theDir.mkdir();
			}
	    } 
	    catch(SecurityException se){
	        //handle it
	    } 
		
		theDir = new File(curDirAbsolutePath + jTextBoxItemType.getText() + "/" + jTextBoxItemID.getText() + "/");
		try{
			if (!theDir.exists()) 
			{
				theDir.mkdir();
			}
		} 
	    catch(SecurityException se){
	        //handle it
	    }  
		
		theDir = new File(curDirAbsolutePath + jTextBoxItemType.getText() + "/" + jTextBoxItemID.getText() + "/" + "Learning/");
		try{
			if (!theDir.exists()) 
			{
				theDir.mkdir();
			}
		} 
	    catch(SecurityException se){
	        //handle it
	    } 
	    
		String fileName = curDirAbsolutePath + jTextBoxItemType.getText() + "/" + jTextBoxItemID.getText() + "/" + "Learning/" + jTextBoxItemIdImageNum.getText() + ".jpg";
		
		try {
				// retrieve image
				File outputfile = new File(fileName);
				if (!outputfile.exists())
				{
					ImageIO.write(bImg, "jpg", outputfile);
				}
				else
				{ // To avoid DataBase corruption
					infoBox("file already exists please choose other name",null);
				}
		} catch (IOException e) {
			e.getStackTrace();
		}
	}
	
	private void captureAndClassifyRemoteServer(String IP)
	{
		// use php script
		
		Map<String, String> multiParamPairs = new HashMap<String, String>();
		multiParamPairs.put("DBtype", jTextBoxItemType.getText());
		
		if (jTextBoxItemType.getText().equals("openedHand") )
		{
			multiParamPairs.put("ItemId", jTextBoxItemID.getText()); // authentication (not classification).
		}
		
		/*
		 *  Capture (get image from stream) and Save image to file
		 */
		String uploadFilePath = getTempDir() + "\\inputImage.jpg";
		SaveImageToFile(uploadFilePath, getimage());
		
		/*
		 *  Run Matlab from Remote server
		 */
		
		String outputFileName = getTempDir() + "\\outputImageRemoteServerResponse.jpg";
		
		uploadImageAndClassifyRemoteServerPHP uploadAndClassifyRemote = new uploadImageAndClassifyRemoteServerPHP(outputFileName);
		if (jTextBoxItemType.getText().equals("openedHand") )
		{
			uploadAndClassifyRemote.ipChangeToBiometricsServer();
		}
		uploadAndClassifyRemote.executeUploadImageAndClassify(uploadFilePath, multiParamPairs);
		
		/*
		 *  Display Result on MSPaint for simplicity (T.B.D)
		 */
		String commandToRun = "mspaint " + outputFileName;
		Runtime rt = Runtime.getRuntime();
		try {
			Process pr = rt.exec(commandToRun);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private void captureAndClassifyLocal()
	{
		// call matlab locally
		// D: & cd "D:/shalev/Projects/WorkspaceMatlab/ScanVision/" & matlab -wait -nojvm -nodesktop -nodisplay -r "Project('D:\shalev\Projects\WorkspaceEclipseMars2\videoCameraCaptureFrames\tmpImage.jpg','D:\shalev\Projects\WorkspaceEclipseMars2\videoCameraCaptureFrames\outImage.jpg','watches');exit"
		
		/*
		 *  Capture (get image from stream) and Save image to file
		 */
		String inputFileName = getTempDir() + "\\inputImage.jpg";
		SaveImageToFile(inputFileName, getimage());
		
		/*
		 *  Run Matlab locally.
		 */
		String geresh = "\"";
		String[] splited = getCurrentMatlabWorkingDirPathLocal().split(new String("/"));
		
		String outputFileName = getTempDir() + "\\outputImage.jpg"; 
		String commandToRun = new String();
		
		if (jTextBoxItemType.getText().equals("openedHand") )
		{
			commandToRun = splited[0] + " & cd " + geresh + getCurrentMatlabWorkingDirPathLocal() + geresh + " & matlab -wait -nodesktop -nodisplay -r \"Project('" +  inputFileName  + "','"  + outputFileName + "','" + jTextBoxItemType.getText() + "'," + jTextBoxItemID.getText() + ");exit\"";
		}
		else
		{
			commandToRun = splited[0] + " & cd " + geresh + getCurrentMatlabWorkingDirPathLocal() + geresh + " & matlab -wait -nojvm -nodesktop -nodisplay -r \"Project('" +  inputFileName  + "','"  + outputFileName + "','" + jTextBoxItemType.getText() + "');exit\"";
		}
		
		String batchFilePath = getTempDir() + "\\tmpBatchFile.bat";
		createBatchFileExecuteAndWaitForCompletion(batchFilePath, commandToRun);
		
		/*
		 *  Display Result on MSPaint for simplicity (T.B.D)
		 */
		commandToRun = "mspaint " + outputFileName;
		Runtime rt = Runtime.getRuntime();
		try {
			Process pr = rt.exec(commandToRun);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void classifyImageFromFileLocal()
	{
		//T.B.D
		// call matlab locally
		infoBox("Not Implemented yet", "function classifyImageFromFileLocal");
	}
	
	private String getCurrentMatlabWorkingDirPathLocal()
	{
		//return "D:/shalev/Projects/WorkspaceMatlab/ScanVision/";
		
		if (jTextBoxItemType.getText().equals("openedHand") )
		{
			return "C:/wamp/www/ImageProcessingOnMobile3562IDCCourseProject/";
		}
		else
		{
			return "C:/wamp/www/ScanVision/";
		}
	}
	
	private String getCurrentDatabasePathLocal()
	{
		return getCurrentMatlabWorkingDirPathLocal() + "DataBase/";
	}
	
	private void buildBatchFile(String batchFileName, String oneCmdLine)
	{
		PrintWriter writer;
		try {
			writer = new PrintWriter(batchFileName, "UTF-8");
			writer.println(oneCmdLine);
			writer.close();
		} catch (FileNotFoundException | UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	private void createBatchFileExecuteAndWaitForCompletion(String batchFilePath, String commandToRun)
	{
		buildBatchFile(batchFilePath,commandToRun);
		
		try {
			Runtime rt = Runtime.getRuntime();
			Process pr = rt.exec(batchFilePath);
			try {
				pr.waitFor();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void enrollmentLocal()
	{
		//String commandToRun = "D: & cd D:/shalev/Projects/WorkspaceMatlab/ScanVision & matlab -wait -nojvm -nodesktop -nodisplay -r \"ResearchScript('','watches',0,3,3);exit\"";
		String geresh = "\"";
		String[] splited = getCurrentMatlabWorkingDirPathLocal().split("/");
		
		if (!jTextBoxItemID.getText().isEmpty() && !jTextBoxItemType.getText().isEmpty())
		{
			String commandToRun = splited[0] + " & cd " + geresh + getCurrentMatlabWorkingDirPathLocal() + geresh + " & matlab -wait -nojvm -nodesktop -nodisplay -r \"ResearchScript('','"+ jTextBoxItemType.getText().toString() +"',0," + jTextBoxItemID.getText().toString() + "," + jTextBoxItemID.getText().toString() + "," + jTextBoxItemIdImageNum.getText().toString() +");exit\"";
			if (jTextBoxItemType.getText().equals("openedHand"))
			{
				commandToRun = splited[0] + " & cd " + geresh + getCurrentMatlabWorkingDirPathLocal() + geresh + " & matlab -wait -nodesktop -nodisplay -r \"ResearchScript('','"+ jTextBoxItemType.getText().toString() +"',0," + jTextBoxItemID.getText().toString() + "," + jTextBoxItemID.getText().toString() + "," + jTextBoxItemIdImageNum.getText().toString() +");exit\"";
			}
			String batchFilePath = getTempDir() + "\\tmpBatchFile.bat";
			createBatchFileExecuteAndWaitForCompletion(batchFilePath,commandToRun);
			
			
			// T.B.D - outputFileName should be inside the matlab script like in capture and classify.
			String outputfileName =  getCurrentDatabasePathLocal() + "\\" + jTextBoxItemType.getText() + "\\" + jTextBoxItemID.getText() + "\\AnswerForClient\\pictureWithId.jpg";
			
			commandToRun = "mspaint " + outputfileName;
			Runtime rt = Runtime.getRuntime();
			try {
				Process pr = rt.exec(commandToRun);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else
		{
			infoBox("error: not chossen item", "local enrollment");
		}
	}
	
	private void enrollmentRemoteServer()
	{
		Map<String, String> multiParamPairs = new HashMap<String, String>();
		multiParamPairs.put("ItemType", jTextBoxItemType.getText());
		multiParamPairs.put("ItemId", jTextBoxItemID.getText() );
		multiParamPairs.put("AnswerBaseImage", jTextBoxItemIdImageNum.getText());
		
		/*
		 *  Run Matlab from Remote server
		 */
		String outputFileName = getTempDir() + "\\outputImageRemoteServerResponse.jpg";
		
		uploadImageAndClassifyRemoteServerPHP enrollmentRemote = new uploadImageAndClassifyRemoteServerPHP(outputFileName);
		if (jTextBoxItemType.getText().equals("openedHand") )
		{
			enrollmentRemote.ipChangeToBiometricsServer();
		}
		
		enrollmentRemote.exceuteEnrollemnt(multiParamPairs);
			
		/*
		 *  Display Result on MSPaint for simplicity (T.B.D)
		 */
		String commandToRun = "mspaint " + outputFileName;
		Runtime rt = Runtime.getRuntime();
		try {
			Process pr = rt.exec(commandToRun);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
    public static void infoBox(String infoMessage, String titleBar)
    {
        JOptionPane.showMessageDialog(null, infoMessage, "InfoBox: " + titleBar, JOptionPane.INFORMATION_MESSAGE);
    }
    
	/**  
	 * Converts/writes a Mat into a BufferedImage.  
	 *  
	 * @param matrix Mat of type CV_8UC3 or CV_8UC1  
	 * @return BufferedImage of type TYPE_3BYTE_BGR or TYPE_BYTE_GRAY  
	 */  

	public static BufferedImage matToBufferedImage(Mat matrix) {  

		int cols = matrix.cols();  
		int rows = matrix.rows();  
		int elemSize = (int)matrix.elemSize();  
		byte[] data = new byte[cols * rows * elemSize];  
		int type;  
		matrix.get(0, 0, data);  

		switch (matrix.channels()) {  
		case 1:  
			type = BufferedImage.TYPE_BYTE_GRAY;  
			break;  
		case 3:  
			type = BufferedImage.TYPE_3BYTE_BGR;  
			// bgr to rgb  
			byte b;  
			for(int i=0; i<data.length; i=i+3) {  
				b = data[i];  
				data[i] = data[i+2];  
				data[i+2] = b;  
			}  
			break;  
		default:  
			return null;  
		}
		
		BufferedImage image2 = new BufferedImage(cols, rows, type);  
		image2.getRaster().setDataElements(0, 0, cols, rows, data);  
		return image2;  
	}

	@Override
	public void paintComponent(Graphics g) {
		BufferedImage temp = getimage();
		if ( temp != null )
		{
			g.drawImage(temp,10,10,temp.getWidth(),temp.getHeight(), this);
		}
		else
		{
			super.paintComponent(g);
		}
	}

	private VideoCapture vidCapture;
	
	public void startCameraAndPreview()
	{
		Mat webcam_image = new Mat();  
		BufferedImage temp;
		
		//vidCapture = new VideoCapture(0); //default
		
		//vidCapture = new VideoCapture("http://ivideon.com/my");
		//vidCapture = new VideoCapture("https://www.ivideon.com/my/?dummy=param.h264");
		//vidCapture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com/my>/video.cgi?.h264");
		//vidCapture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com/my>/video.cgi?.mjpg");
		//vidCapture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com/my>/?dummy=param.mjpg");
		//vidCapture = new VideoCapture("https://www.ivideon.com/my/watch/200-2accb39981d01e274061fc4240d710f7/0");
		
		//vidCapture = new VideoCapture()
		//vidCapture.open("http://ivideon.com/my/?dummy=param.mjpg");
		
		if( vidCapture.isOpened())  
		{  
			while( true )  
			{  
				vidCapture.read(webcam_image);  
				if( !webcam_image.empty() )  
				{  
					temp = matToBufferedImage(webcam_image);  
					setimage(temp);
					//repaint();
					//paintComponent(temp.getGraphics());
					paintComponent(this.getGraphics());
				}  
				else  
				{  
					System.out.println(" --(!) No captured frame -- Break!");  
					break;  
				}  
			}  
		}

		return;  
		
//		JFrame frame = new JFrame("BasicPanel");
//		frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE); 
//		frame.setSize(400,400);
//		VideoStreamJPanelOpenCV panel = new VideoStreamJPanelOpenCV();
//		frame.setContentPane(panel);       
//		frame.setVisible(true);
//		Mat webcam_image = new Mat();  
//		BufferedImage temp;  
//		VideoCapture capture = new VideoCapture(0);
//
//		jbuttonCaptureImage.addActionListener(panel);
//		frame.add(jbuttonCaptureImage);
//
//		if( capture.isOpened())  
//		{  
//			while( true )  
//			{  
//				capture.read(webcam_image);  
//				if( !webcam_image.empty() )  
//				{  
//					frame.setSize(webcam_image.width()+40,webcam_image.height()+60);  
//					temp = matToBufferedImage(webcam_image);  
//					panel.setimage(temp);  
//					panel.repaint();
//				}  
//				else  
//				{  
//					System.out.println(" --(!) No captured frame -- Break!");  
//					break;  
//				}  
//			}  
//		}
//
//		return;  
//		
	}
	
	static VideoStreamJPanelOpenCV lastObjCreated;

	public static void main(String arg[]) throws IOException {
		// Load the native library.
		//System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		//System.load("C:/Users/user/opencv/build/java/x64/opencv_java2411.dll");
		//System.load("C:\\Users\\user\\opencv\\build\\java\\x64\\opencv_java2411.dll");
		//System.load("D:/shalev/Projects/WorkspaceEclipseMars2/videoCameraCaptureFrames/src/DLLs/opencv_java2411.dll");

		//String dllPath = System.getProperty("user.dir") + "\\DLLs\\";
		//String dllPathOpenCv = dllPath + "opencv_java2411.dll";
		//System.load(dllPathOpenCv);
		
		//String dllPath = "DLLs\\";
		//File dllPathDir = new File(dllPath);
		//String dllPathOpenCv = dllPathDir.getAbsolutePath() + "\\opencv_java2411.dll";
		//System.load(dllPathOpenCv);
		
		//String dllPathOpenCv = new File(".").getCanonicalPath() + "\\DLLs\\" + "opencv_java2411.dll";
		//System.load(dllPathOpenCv);
		
		//String dllPathOpenCv = lastObjCreated.getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
		//System.load(dllPathOpenCv);
		
		int camSizeWidth = 640;
		int camSizeHeight = 480;
		
		JFrame frame = new JFrame("BasicPanel");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); 
		frame.setSize(camSizeWidth+40,camSizeHeight+60);
		VideoStreamJPanelOpenCV panel = new VideoStreamJPanelOpenCV();
		frame.setContentPane(panel);       
		frame.setVisible(true); 
		
		
		
		jbuttonCaptureImage = new JButton();
		jbuttonCaptureImage.setText("capture");
		jbuttonCaptureImage.setBounds(0,0,100,30);
		jbuttonCaptureImage.setSize(100, 30);
		frame.add(jbuttonCaptureImage);
		
		jbuttonCaptureImageAndClassify = new JButton();
		jbuttonCaptureImageAndClassify.setText("Capture & Classify");
		jbuttonCaptureImageAndClassify.setBounds(camSizeWidth-200,0,200,30);
		jbuttonCaptureImageAndClassify.setSize(200, 30);
		frame.add(jbuttonCaptureImageAndClassify);
		
		jbuttonEnroll = new JButton();
		jbuttonEnroll.setText("Enrollement");
		jbuttonEnroll.setBounds(120,0,120,30);
		jbuttonEnroll.setSize(120,30);
		frame.add(jbuttonEnroll);

		JLabel jLabelItemType = new JLabel();
		JLabel jLabelItemID = new JLabel();
		JLabel jLabelItemIdImageNum = new JLabel();
		JLabel jLabelRemoteServer = new JLabel();
		
		jTextBoxItemType = new JTextField();
		jTextBoxItemType.setBounds(35,40,100,30);
		jTextBoxItemType.setSize(100, 30);
		frame.add(jTextBoxItemType);
		// Label Corresponding
		jLabelItemType.setText("Item");
		jLabelItemType.setHorizontalAlignment(JLabel.CENTER);
		jLabelItemType.setOpaque(true);
		jLabelItemType.setBackground(java.awt.Color.BLUE);
		jLabelItemType.setForeground(java.awt.Color.WHITE);
		jLabelItemType.setBounds(0,40,35,30);
		jLabelItemType.setSize(35, 30);
		frame.add(jLabelItemType);
		//frame.getContentPane().add(jLabelItemID);

		jTextBoxItemID = new JTextField();
		jTextBoxItemID.setBounds(35,80,100,30);
		jTextBoxItemID.setSize(100, 30);
		frame.add(jTextBoxItemID);
		// Label Corresponding
		jLabelItemID.setText("ID");
		jLabelItemID.setHorizontalAlignment(JLabel.CENTER);
		jLabelItemID.setOpaque(true);
		jLabelItemID.setBackground(java.awt.Color.BLUE);
		jLabelItemID.setForeground(java.awt.Color.WHITE);
		jLabelItemID.setBounds(0,80,35,30);
		jLabelItemID.setSize(35, 30);
		frame.add(jLabelItemID);
		
		jTextBoxItemIdImageNum = new JTextField();
		jTextBoxItemIdImageNum.setBounds(35,120,100,30);
		jTextBoxItemIdImageNum.setSize(100, 30);
		frame.add(jTextBoxItemIdImageNum);
		// Label Corresponding
		jLabelItemIdImageNum.setText("Img #");
		jLabelItemIdImageNum.setHorizontalAlignment(JLabel.CENTER);
		jLabelItemIdImageNum.setOpaque(true);
		jLabelItemIdImageNum.setBackground(java.awt.Color.BLUE);
		jLabelItemIdImageNum.setForeground(java.awt.Color.WHITE);
		jLabelItemIdImageNum.setBounds(0,120,35,30);
		jLabelItemIdImageNum.setSize(35, 30);
		frame.add(jLabelItemIdImageNum);
		
		jbuttonCaptureImage.addActionListener(panel);
		jbuttonCaptureImageAndClassify.addActionListener(panel);
		jbuttonEnroll.addActionListener(panel);
		
		
		jCheckBoxRemoteServer = new JCheckBox();
		jCheckBoxRemoteServer.setBounds(350,0,25,30);
		jCheckBoxRemoteServer.setBackground(java.awt.Color.GRAY);
		frame.add(jCheckBoxRemoteServer);
		// Label Corresponding
		jLabelRemoteServer.setText("RemoteServer");
		jLabelRemoteServer.setHorizontalAlignment(JLabel.CENTER);
		jLabelRemoteServer.setOpaque(true);
		jLabelRemoteServer.setBackground(java.awt.Color.GRAY);
		jLabelRemoteServer.setForeground(java.awt.Color.WHITE);
		jLabelRemoteServer.setBounds(250,0,100,30);
		jLabelRemoteServer.setSize(100, 30);
		frame.add(jLabelRemoteServer);
		
		
		Mat webcam_image = new Mat();  
		BufferedImage temp = null; 
		VideoCapture capture = null;
		
//		loopOpenCameraTillConnect(panel, capture, webcam_image, temp, camSizeHeight, camSizeWidth);
		
		temp = matToBufferedImage(new Mat(camSizeHeight,camSizeWidth,0));
		panel.setimage(temp);  
		panel.repaint();
		
		capture = new VideoCapture(0);
		while(!capture.isOpened())
		{
			capture.open(0);
			SetCameraParams(capture, camSizeWidth, camSizeHeight);
		}
		
		if( capture.isOpened())  
		{  
			
			while( true )  
			{  
				capture.read(webcam_image);  
				if( !webcam_image.empty() )  
				{
//					int width = webcam_image.width()+40;
//					int height = webcam_image.height()+60;
//					frame.setSize(width, height);  
					temp = matToBufferedImage(webcam_image);  
					panel.setimage(temp);  
					panel.repaint();  
				}  
				else  
				{  
					System.out.println(" --(!) No captured frame!");
					//break; 
					
					capture.release();
					
//					loopOpenCameraTillConnect(panel, capture, webcam_image, temp, camSizeHeight, camSizeWidth);
					
					temp = matToBufferedImage(new Mat(camSizeHeight,camSizeWidth,0));
					panel.setimage(temp);  
					panel.repaint();
					
					capture = new VideoCapture(0);
					while(!capture.isOpened())
					{
						capture.open(0);
						SetCameraParams(capture, camSizeWidth, camSizeHeight);
					}
				}  
			}  
		}

		return;  
	}  

	private static void SetCameraParams(VideoCapture capture, int camSizeWidth, int camSizeHeight)
	{
		// for logitech C920 camera.
				capture.set(Highgui.CV_CAP_PROP_FOCUS, 30);
				capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_CONTINUOUS_VIDEO, 0);
				capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_CONTINUOUS_PICTURE, 0);
				
				//capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_INFINITY, 10);
				//capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_FIXED, 10);
				
				//capture.set(Highgui.CV_CAP_PROP_ANDROID_FOCAL_LENGTH, 1);
				//capture.set(Highgui.CV_CAP_PROP_ANDROID_FOCUS_DISTANCE_NEAR, 1);
				//capture.set(Highgui.CV_CAP_PROP_ANDROID_FOCUS_DISTANCE_OPTIMAL, 1);
				//capture.set(Highgui.CV_CAP_PROP_ANDROID_FOCUS_DISTANCE_FAR, 1000);
				
				//capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_FIXED, 10);
				//capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_CONTINUOUS_VIDEO, 0);
				capture.set(Highgui.CV_CAP_PROP_FRAME_WIDTH, camSizeWidth);
				capture.set(Highgui.CV_CAP_PROP_FRAME_HEIGHT, camSizeHeight);
				
				//capture.set(5, 30);   // Highgui.CV_CAP_PROP_FPS
				//capture.set(10, 50);  // CV_CAP_PROP_BRIGHTNESS
				//capture.set(20, 0);   // CV_CAP_PROP_SHARPNESS
				//capture.set(15, 50);  // CV_CAP_PROP_EXPOSURE
				//capture.set(22, 100); // CV_CAP_PROP_GAMMA	
				//capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_CONTINUOUS_VIDEO, 0);
				//capture.set(Highgui.CV_CAP_ANDROID_FOCUS_MODE_FIXED, 10);
				//capture.set(Highgui.CV_CAP_PROP_FOCUS, 1);
				
				//Highgui.CV_CAP_ANDROID_FOCUS_MODE_CONTINUOUS_VIDEO
				//Highgui.CV_CAP_ANDROID_WHITE_BALANCE_AUTO
				//Highgui.CV_CAP_ANDROID_FLASH_MODE_AUTO
				//Highgui.CV_CAP_PROP_PAN
				//Highgui.CV_CAP_PROP_ROLL
				//Highgui.CV_CAP_PROP_TILT
				//Highgui.CV_CAP_ANDROID_ANTIBANDING_50HZ
				//Highgui.CV_CAP_PROP_ANDROID_EXPOSE_LOCK
				//Highgui.CV_CAP_PROP_ZOOM
				
						
				//VideoCapture capture = new VideoCapture("http://ivideon.com/my");
				//VideoCapture capture = new VideoCapture("https://www.ivideon.com/my/?dummy=param.h264");
				//VideoCapture capture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com/my>/video.cgi?.h264");
				//VideoCapture capture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com/my>/video.cgi?.mjpg");
				//VideoCapture capture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com/my>/?dummy=param.mjpg");
				//VideoCapture capture = new VideoCapture("https://www.ivideon.com/my/watch/200-2accb39981d01e274061fc4240d710f7/0");
				
				//VideoCapture capture = new VideoCapture("https://www.ivideon.com/?dummy=param.h264");
				//VideoCapture capture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com>/video.cgi?.h264");
				//VideoCapture capture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com>/video.cgi?.mjpg");
				//VideoCapture capture = new VideoCapture("http://<shalev.david007@gmail.com:xor1@3>@<ivideon.com>/?dummy=param.mjpg");
				
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videofeed");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/video.cgi?.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/?dummy=param.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/?dummy=param.h264");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/?dummy=param.mpeg4");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videostream.cgi&user=shalev.david007@gmail.com&pwd=xor1@3&resolution=32&rate=10.mpeg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videostream.cgi&resolution=32&rate=10.mpeg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videostream.cgi?user=shalev.david007@gmail.com&pwd=xor1@3&resolution=32&rate=10.mpeg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videostream.cgi?user=shalev.david007@gmail.com&pwd=xor1@3&resolution=32&rate=10.mpeg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videostream.cgi?user=shalev.david007@gmail.com&pwd=xor1@3&resolution=32&rate=10.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videostream.cgi?.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videofeed?.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videofeed?user=shalev.david007@gmail.com&pwd=xor1@3.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videofeed?user=shalev.david007@gmail.com&pwd=xor1@3.mpeg4");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/videofeed?user=shalev.david007@gmail.com&pwd=xor1@3.h264");
				//VideoCapture capture = new VideoCapture("http://shalev.david007@gmail.com:xor1@3@10.100.102.4:8080/axis-cgi/mjpg/video.cgi?resolution=640x480&req_fps=30&.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/axis-cgi/mjpg/video.cgi?resolution=640x480&req_fps=30&.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/axis-cgi/mpeg4/video.cgi?.mpeg4");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/axis-cgi/mjpg/video.cgi?.mjpg");
				//VideoCapture capture = new VideoCapture("http://10.100.102.4:8080/axis-cgi/mjpg/videofeed.cgi?.mjpg");
				
				//VideoCapture capture = new VideoCapture("https://www.youtube.com/watch?v=jsUuHKnOPTI");
				//VideoCapture capture = new VideoCapture("https://www.youtube.com/watch?v=jsUuHKnOPTI/video.cgi?.mjpg");
				
				//VideoCapture capture = new VideoCapture("C:/Users/user/Desktop/videofeed.mpg");
				
				//VideoCapture capture = new VideoCapture();
				//capture.open("C:/Users/user/Desktop/videofeed.mpg");
				
				//cmdline: vlc "http://10.100.102.5:8080/videofeed" --sout file/ts:videofeed.mpg
				//VideoCapture capture = new VideoCapture("C:/Users/user/Desktop/videofeed.mpeg");
				//VideoCapture capture = new VideoCapture("C:/Users/user/Desktop/videofeed.mpg");
	}
	
	private static void loopOpenCameraTillConnect(VideoStreamJPanelOpenCV panel, VideoCapture capture,Mat webcam_image, BufferedImage temp, int camSizeHeight, int camSizeWidth)
	{
		temp = matToBufferedImage(new Mat(camSizeHeight,camSizeWidth,0));
		panel.setimage(temp);  
		panel.repaint();
		
		capture = new VideoCapture(0);
		while(!capture.isOpened())
		{
			capture.open(0);
			SetCameraParams(capture, camSizeWidth, camSizeHeight);
		}
	}
	
	public void VideoStreamJpanelInFrame() {
		
		JFrame frame = new JFrame("BasicPanel");  
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
		frame.setSize(400,400);  
		VideoStreamJPanelOpenCV panel = new VideoStreamJPanelOpenCV();  
		frame.setContentPane(panel);       
		frame.setVisible(true);       
		Mat webcam_image = new Mat();  
		BufferedImage temp;  
		VideoCapture capture = new VideoCapture(0);
		
		if( capture.isOpened())  
		{  
			while( true )  
			{  
				capture.read(webcam_image);  
				if( !webcam_image.empty() )  
				{  
					frame.setSize(webcam_image.width()+40,webcam_image.height()+60);  
					temp=matToBufferedImage(webcam_image);  
					panel.setimage(temp);  
					panel.repaint();  
				}  
				else  
				{  
					System.out.println(" --(!) No captured frame -- Break!");  
					break;  
				}  
			}  
		}  
		return;  
	}
	
	public static JButton jbuttonCaptureImage;
	public static JButton jbuttonCaptureImageAndClassify;
	public static JButton jbuttonEnroll;
	public static JTextField jTextBoxItemType;
	public static JTextField jTextBoxItemID;
	public static JTextField jTextBoxItemIdImageNum;
	public static JCheckBox jCheckBoxRemoteServer;
	
	private JButton _btnStartPreview;
	
	public void actionPerformed(ActionEvent e)
	{
		if(e.getSource() == jbuttonCaptureImage)
		{
			if (jCheckBoxRemoteServer.isSelected() == true)
			{
				saveImagetoDataBaseRemoteServer();
			}
			else // locally
			{
				saveImageToDataBaseLocal(getimage());
			}
			return;
		}
		
		if(e.getSource() == jbuttonCaptureImageAndClassify)
		{
			if (jCheckBoxRemoteServer.isSelected() == true)
			{
				captureAndClassifyRemoteServer("T.B.D");
			}
			else // locally
			{
				captureAndClassifyLocal();
			}
			
			return;
		}
		
		if(e.getSource() == jbuttonEnroll)
		{
			if (jCheckBoxRemoteServer.isSelected() == true)
			{
				enrollmentRemoteServer();
			}
			else // locally
			{
				enrollmentLocal();
			}
			
			return;
		}
		
		if (e.getSource() == _btnStartPreview)
		{
			startCameraAndPreview();
			return;
		}
	}

}  
