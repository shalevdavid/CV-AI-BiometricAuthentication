package uploadImageAndClassifyRemoteServerPHP;
//package ServerTask;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sun.rmi.runtime.Log;
//import java.lang.Object.org.apache.http.entity.mime.MultipartEntityBuilder;
import HttpRequstMultPartiFormUtility.*;
import HttpRequstMultPartiFormUtility.HttpRequstMultPartiFormUtility.*;

public class uploadImageAndClassifyRemoteServerPHP {


//*******************************************************************************
//Push image processing task to server
//*******************************************************************************

//public class ServerTask  extends AsyncTask<String, Integer , Void>
//{
	public byte[] dataToServer;

	//Task state
	private final int UPLOADING_PHOTO_STATE  = 0;
	private final int SERVER_PROC_STATE  = 1;

//	private ProgressDialog dialog;

	private static final String TAG = "uploadImageAndClassifyRemoteServerPHP";
	
//	Preview mPreview; 
//	ResultView mResultView;
//	private Context mContext = this;
	
	/** PLEASE PUT YOUR SERVER URL **/
	//private final String SERVERURL = "http://10.100.102.20/computeSIFT.php";
    // Shalev - change the server_url to be my own computer.
    //private final String SERVERURL = "http://10.100.102.2/computeSIFT_website/computeSIFT.php";
    //private final String SERVERURL = "http://shalevdavid.ddns.net/computeSIFT_website/computeSIFT.php";
    //private final String SERVERURL = "http://10.100.102.2/ImageProcessingOnMobile3562IDCCourseProject/Project.php";
    //private final String SERVERURL = "http://10.100.102.3/ScanVision/Project.php";
	
//    private final String SERVERURL = "http://127.0.0.1/ScanVision/Project.php";
//    private final String SERVERURL2 = "http://127.0.0.1/ScanVision/UploadImage.php";
//    private final String SERVERURL3 = "http://127.0.0.1/ScanVision/ResearchScript.php";
	
    public final String ScanVisionAmazonSERVERURL = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/ScanVision/Project.php";
    public final String ScanVisionAmazonSERVERURL2 = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/ScanVision/UploadImage.php";
    public final String ScanVisionAmazonSERVERURL3 = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/ScanVision/ResearchScript.php";
    
//    public final String BiometricsSERVERURL = "http://127.0.0.1/ImageProcessingOnMobile3562IDCCourseProject/Project.php";
//	  public final String BiometricsSERVERURL = "http://127.0.0.1/ImageProcessingOnMobile3562IDCCourseProject/ProjectSmartphoneShalev.php";
//    public final String BiometricsSERVERURL2 = "http://127.0.0.1/ImageProcessingOnMobile3562IDCCourseProject/UploadImage.php";
//    public final String BiometricsSERVERURL3 = "http://127.0.0.1/ImageProcessingOnMobile3562IDCCourseProject/ResearchScript.php";
    
    public final String BiometricsSERVERURL = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/BioAuth/Project.php";
    //public final String BiometricsSERVERURL = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/BioAuth/ProjectSmartphoneShalev.php";
    public final String BiometricsSERVERURL2 = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/BioAuth/UploadImage.php";
    public final String BiometricsSERVERURL3 = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/BioAuth/ResearchScript.php";
    
    //private final String SERVERURL = "http://app.scanvision.io/ScanVision/Project.php";
    //private final String SERVERURL = "http://ec2-52-50-126-218.eu-west-1.compute.amazonaws.com/ScanVision/Project.php";
    
    public String SERVERURL = ScanVisionAmazonSERVERURL;
    public String SERVERURL2 = ScanVisionAmazonSERVERURL2;
    public String SERVERURL3 = ScanVisionAmazonSERVERURL3;
    
//    public String SERVERURL = BiometricsSERVERURL;
//    public String SERVERURL2 = BiometricsSERVERURL2;
//    public String SERVERURL3 = BiometricsSERVERURL3;
		

	private final static String INPUT_IMG_FILENAME = "/temp.jpg"; //name for storing image captured by camera view
	
	//upload photo to server
	HttpURLConnection uploadPhoto(String inputImageFilePath) throws FileNotFoundException
	{
		//create file stream for captured image file
		File inputFile = new File(inputImageFilePath);
		FileInputStream fileInputStream  = new FileInputStream(inputFile);
		
		
		final String serverFileName = "test"+ (int) Math.round(Math.random()*1000) + ".jpg";		
		final String lineEnd = "\r\n";
		final String twoHyphens = "--";
		final String boundary = "*****";

		try
		{
			URL url = new URL(SERVERURL);
			// Open a HTTP connection to the URL
			final HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			// Allow Inputs
			conn.setDoInput(true);				
			// Allow Outputs
			conn.setDoOutput(true);				
			// Don't use a cached copy.
			conn.setUseCaches(false);

			// Use a post method.
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setRequestProperty("Content-Type", "multipart/form-data;boundary="+boundary);

			DataOutputStream dos = new DataOutputStream( conn.getOutputStream() );

			dos.writeBytes(twoHyphens + boundary + lineEnd);
			dos.writeBytes("Content-Disposition: form-data; name=\"uploadedfile\";filename=\"" + serverFileName +"\"" + lineEnd);
			dos.writeBytes(lineEnd);

			// create a buffer of maximum size
			int bytesAvailable = fileInputStream.available();
			int maxBufferSize = 1024;
			int bufferSize = Math.min(bytesAvailable, maxBufferSize);
			byte[] buffer = new byte[bufferSize];

			// read file and write it into form...
			int bytesRead = fileInputStream.read(buffer, 0, bufferSize);

			while (bytesRead > 0)
			{
				dos.write(buffer, 0, bufferSize);
				bytesAvailable = fileInputStream.available();
				bufferSize = Math.min(bytesAvailable, maxBufferSize);
				bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			}

			// send multipart form data after file data...
			dos.writeBytes(lineEnd);
			dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);
//			publishProgress(SERVER_PROC_STATE);
			// close streams
			fileInputStream.close();
			dos.flush();

			return conn;
		}
		catch (MalformedURLException ex){
//			Log.e(TAG, "error: " + ex.getMessage(), ex);
			return null;
		}
		catch (IOException ioe){
//			Log.e(TAG, "error: " + ioe.getMessage(), ioe);
			return null;
		}
	}
	
	HttpURLConnection uploadParams(Map<String, String> multiParamPairs) throws IOException
	{
		String charset = "UTF-8";
		String requestURL = SERVERURL3;
		HttpRequstMultPartiFormUtility multipart = new HttpRequstMultPartiFormUtility(requestURL, charset);
		
		for (Map.Entry<String, String> item : multiParamPairs.entrySet()) 
		{
			multipart.addFormField(item.getKey(),item.getValue());
		}
		
		// create dummy empty file for now. 
		PrintWriter writer = new PrintWriter("dummyEmptyFile.txt", "UTF-8");
		writer.close();
		
		multipart.addFilePart("uploadedfile", new File("dummyEmptyFile.txt"));
		
		multipart.PreFinish();
		
		return multipart.GetHttpURLConnection();
		
	}
	
	HttpURLConnection uploadPhotoAndParams(String requestURL, String filePath , Map<String, String> multiParamPairs) throws IOException
	{
		String charset = "UTF-8";
		HttpRequstMultPartiFormUtility multipart = new HttpRequstMultPartiFormUtility(requestURL, charset);
		
		for (Map.Entry<String, String> item : multiParamPairs.entrySet()) 
		{
			multipart.addFormField(item.getKey(),item.getValue());
		}
		multipart.addFilePart("uploadedfile", new File(filePath));
				
		multipart.PreFinish();
		//List<String> response = multipart.finish(); // response from server.
		
		return multipart.GetHttpURLConnection();
		
	}

	//get image result from server and display it in result view
	void getResultImage(HttpURLConnection conn){		
		// retrieve the response from server
		InputStream is;
		try {
			is = conn.getInputStream();
			//get result image from server
			BufferedInputStream bufferedInputStream = new BufferedInputStream(is);

			try {
				BufferedInputStreamToOutputFile(bufferedInputStream, _outputFilePath);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
//			Bitmap bmp = BitmapFactory.decodeStream(bufferedInputStream);
//			
//			mResultView.resultImage = BitmapFactory.decodeStream(is);
//			is.close();		        
//			mResultView.IsShowingResult = true;
		} catch (IOException e) {
//			Log.e(TAG,e.toString());
			e.printStackTrace();
		}
	}

	//Main code for processing image algorithm on the server

	void processImageClassification(String inputImageFilePath, Map<String, String> multiParamPairs){			
//		publishProgress(UPLOADING_PHOTO_STATE);
		
		try {

			//upload photo
			final HttpURLConnection conn = uploadPhotoAndParams(SERVERURL, inputImageFilePath, multiParamPairs);

			//get processed photo from server
			if (conn != null)
			{
				getResultImage(conn);
			}

		}
		catch (FileNotFoundException ex){
//			Log.e(TAG, ex.toString());
		}
		catch (IOException ex){
//			Log.e(TAG, ex.toString());
		}
	}
	
	void processUploadImageForEnrollment(String inputImageFilePath, Map<String, String> multiParamPairs){			
//		publishProgress(UPLOADING_PHOTO_STATE);
		
		try {

			//upload photo
			final HttpURLConnection conn = uploadPhotoAndParams(SERVERURL2, inputImageFilePath, multiParamPairs);

			//get processed photo from server
			if (conn != null)
			{
				getResultImage(conn);
			}

		}
		catch (FileNotFoundException ex){
//			Log.e(TAG, ex.toString());
		}
		catch (IOException ex){
//			Log.e(TAG, ex.toString());
		}
	}
	
	void ProcessEnrollment(Map<String, String> multiParamPairs) {
		try {

			//upload photo
			final HttpURLConnection conn = uploadParams(multiParamPairs);

			//get processed photo from server
			if (conn != null)
			{
				getResultImage(conn);
			}

		}
		catch (FileNotFoundException ex){
//			Log.e(TAG, ex.toString());
		}
		catch (IOException ex){
//			Log.e(TAG, ex.toString());
		}
	}
	

	private String _outputFilePath;

	public void BufferedInputStreamToOutputFile(BufferedInputStream fin, String outputfilePath) throws Exception {
		//BufferedInputStream fin = new BufferedInputStream(new FileInputStream("in.dat"));
		BufferedOutputStream fout = new BufferedOutputStream(new FileOutputStream(outputfilePath));
		
		int i;
		
		do {
			i = fin.read();
			if (i != -1)
				fout.write(i);
		} while (i != -1);
		fin.close();
		fout.close();
	}

	public uploadImageAndClassifyRemoteServerPHP(String outputFilePath) {
		_outputFilePath = outputFilePath;
	}		
	
	public void ipChangeToBiometricsServer()
	{
		SERVERURL = BiometricsSERVERURL;
		SERVERURL2 = BiometricsSERVERURL2;
		SERVERURL3 = BiometricsSERVERURL3;
	}
	
	// Upload Image And Get Classification Result
	public void executeUploadImageAndClassify(String uploadFilePath, Map<String, String> multiParamPairs)
	{
		processImageClassification(uploadFilePath, multiParamPairs);
	}
	
	// Upload Image And Get Classification Result
	public void executeUploadImageForEnrollemnt(String uploadFilePath, Map<String, String> multiParamPairs)
	{
		processUploadImageForEnrollment(uploadFilePath, multiParamPairs);
	}
	
	public void exceuteEnrollemnt(Map<String, String> multiParamPairs)
	{
		ProcessEnrollment(multiParamPairs);
	}

//	public ServerTask() {
//		dialog = new ProgressDialog(mContext);
//	}	
//	
//	protected void onPreExecute() {
//		this.dialog.setMessage("Photo captured");
//		this.dialog.show();
//	}
//	@Override
//	protected Void doInBackground(String... params) {			//background operation 
//		String uploadFilePath = params[0];
//		processImage(uploadFilePath);
//		//release camera when previous image is processed
//		mCameraReadyFlag = true; 
//		return null;
//	}		
//	//progress update, display dialogs
//	@Override
//	protected void onProgressUpdate(Integer... progress) {
//		if(progress[0] == UPLOADING_PHOTO_STATE){
//			dialog.setMessage("Uploading");
//			dialog.show();
//		}
//		else if (progress[0] == SERVER_PROC_STATE){
//			if (dialog.isShowing()) {
//				dialog.dismiss();
//			}	    	 
//			dialog.setMessage("Processing");
//			dialog.show();
//		}	         
//	}		
//	@Override
//	protected void onPostExecute(Void param) {
//		if (dialog.isShowing()) {
//			dialog.dismiss();
//		}
//	}
	
//}
	
}