package videoCameraCaptureFrames;

import java.awt.EventQueue;
import java.awt.Image;

import javax.swing.JFrame;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import java.awt.BorderLayout;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Color;
import javax.swing.JTextField;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.*;
import org.opencv.highgui.*;
import org.opencv.highgui.Highgui;
import org.opencv.highgui.Highgui.*;
import org.opencv.highgui.VideoCapture;
import org.opencv.imgproc.Imgproc;

import com.sun.javafx.iio.ImageStorage.ImageType;
import VideoStreamJPanelOpenCV.*;

//import com.sun.prism.Image;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import java.awt.image.*;
import javax.swing.UIManager;
import java.awt.SystemColor;
import java.awt.Dialog.ModalExclusionType;

public class MyFrame extends JFrame implements ActionListener {

	private JFrame mainFrame;
	private JTextField textField;
	private VideoCapture camera;
	private JButton btnPreview;
	//private VideoStreamJPanelOpenCV _vidStreamJPanelOpenCV;
	private JPanel _vidStreamJPanelOpenCV;
	
	private BufferedImage _rgbBufferedImg;
	private boolean _preview = false;
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MyFrame window = new MyFrame();
					window.mainFrame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public MyFrame() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		
		mainFrame = new JFrame();
		mainFrame.getContentPane().setBackground(SystemColor.controlDkShadow);
		mainFrame.getContentPane().setForeground(UIManager.getColor("CheckBox.darkShadow"));
		mainFrame.setBounds(100, 100, 761, 560);
		mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		mainFrame.getContentPane().setLayout(null);
		
		JButton btnStar = new JButton("start");
		btnStar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				textField.setText("Test Start button!");
				camera = new VideoCapture(0);
			}
		});
		btnStar.setBackground(new Color(153, 204, 204));
		btnStar.setBounds(10, 488, 70, 23);
		mainFrame.getContentPane().add(btnStar);
		
		textField = new JTextField();
		textField.setBounds(10, 446, 106, 31);
		mainFrame.getContentPane().add(textField);
		textField.setColumns(10);
		
//		JLabel lblNewLabel = new JLabel("camera preview");
//		lblNewLabel.setBackground(Color.WHITE);
//		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
//		lblNewLabel.setBounds(51, 11, 762, 422);
//		mainFrame.getContentPane().add(lblNewLabel);
		

		
		
		btnPreview = new JButton("preview");
		
		_vidStreamJPanelOpenCV = new VideoStreamJPanelOpenCV(btnPreview);
		_vidStreamJPanelOpenCV.setBounds(51, 11, 646, 417);
		mainFrame.getContentPane().add(_vidStreamJPanelOpenCV);
		//mainFrame.setContentPane(_vidStreamJPanelOpenCV);
		
		//btnPreview.addActionListener(this); //{
		btnPreview.addActionListener((ActionListener) _vidStreamJPanelOpenCV); //{
			//public void actionPerformed(ActionEvent e) {
				
				//VideoStreamJPanelOpenCV.VideoStreamJpanelInFrame();
				
//				if (_preview == true) // in this case we need to stop and Do Nothing
//				{
//					btnPreview.setText("preview");
//					_preview = false;
//					return; // Do Nothing
//				}
//				
//				//// preview = false case (no preview at the moment)
//				
//				if (!camera.isOpened())
//				{
//					btnPreview.setLabel("Camera not opened properly");
//					return;
//				}
//				
//				int width = (int)(camera.get(Highgui.CV_CAP_PROP_FRAME_WIDTH));
//				int hight = (int)(camera.get(Highgui.CV_CAP_PROP_FRAME_HEIGHT));
//				//int cvType = camera.get(Highgui.cv_cap_prop_);
//				//Mat imageMat = new Mat(width,hight,cvType);
//				//Highgui.CV_CAP_ANDROID_COLOR_FRAME_RGB
//				
//				Mat imageMat = new Mat(width,hight,CvType.CV_8UC3);
//				
//				//Imgproc.cvtColor(imageMat, imageMat, Imgproc.COLOR_RGB2YCrCb);
//				
//				btnPreview.setText("stop preview");
//				_preview = true;
//				
//				//while (_preview) {
//
//					if (!camera.read(imageMat))
//					{
//						btnPreview.setLabel("Couldn't read camera images");
//						return;
//					}
//
//					_rgbBufferedImg = mat2bimg(imageMat);
//
//					lblNewLabel.setText(null);
//					lblNewLabel.setIcon(new ImageIcon(_rgbBufferedImg));
//					
////					try {
////						lblNewLabel.getTreeLock().wait();
////					} catch (InterruptedException e2) {
////						// TODO Auto-generated catch block
////						e2.printStackTrace();
////					}
//					
////					try {
////						synchronized( btnPreview )
////						{
////							btnPreview.getTreeLock().wait();
////						}
////					} catch (InterruptedException e1) {
////						// TODO Auto-generated catch block
////						e1.printStackTrace();
////					}
//				//}
//					
//					camera.release();
//					JPanelOpenCV jpanelOpenCV = new JPanelOpenCV();
//					try {
//						jpanelOpenCV.MainJPanelOpenCV();
//					} catch (InterruptedException e1) {
//						// TODO Auto-generated catch block
//						e1.printStackTrace();
//					}
					
					
			//}
		//});
		btnPreview.setBounds(130, 488, 124, 23);
		mainFrame.getContentPane().add(btnPreview);
		
	}
	
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == btnPreview) {
        
        }
    }
	
	public static BufferedImage mat2bimg(Mat in)
	{
		BufferedImage out;
		int sizeX = in.width(), sizeY = in.height();
		
		byte[] data = new byte[sizeX*sizeY*(int)in.elemSize()];
		
		in.get(0,0,data);
		
		out = new BufferedImage(sizeX,sizeY,BufferedImage.TYPE_3BYTE_BGR);
		
		out.getRaster().setDataElements(0, 0, sizeX, sizeY, data);
		
		return out;
	}
	
	public int BufferedImageTypeToCvType(int bufferedImageType)
	{
		int curCVtype = -1;
		
		switch(bufferedImageType) {
		case BufferedImage.TYPE_3BYTE_BGR:
		    curCVtype = CvType.CV_8UC3;
		    break;
		case BufferedImage.TYPE_BYTE_GRAY:
		case BufferedImage.TYPE_BYTE_BINARY:
		    curCVtype = CvType.CV_8UC1;
		    break;
		case BufferedImage.TYPE_INT_BGR:
		case BufferedImage.TYPE_INT_RGB:
		    curCVtype = CvType.CV_32SC3;
		    break;
		case BufferedImage.TYPE_INT_ARGB:
		case BufferedImage.TYPE_INT_ARGB_PRE:
		    curCVtype = CvType.CV_32SC4;
		    break;
		case BufferedImage.TYPE_USHORT_GRAY:
		    curCVtype = CvType.CV_16UC1;
		    break;
		case BufferedImage.TYPE_4BYTE_ABGR:
		case BufferedImage.TYPE_4BYTE_ABGR_PRE:
		    curCVtype = CvType.CV_8UC4;
		    break;
		default:
		    // BufferedImage.TYPE_BYTE_INDEXED;
		    // BufferedImage.TYPE_CUSTOM;
			curCVtype = -1;
			break;
		}
		
		return curCVtype;
	}
	
	public int CvTypeToBufferedImageType(int cvType)
	{
		int bufferedImageCVtype = -1;
		
		if (cvType == CvType.CV_8UC3)
		{
			bufferedImageCVtype = BufferedImage.TYPE_3BYTE_BGR;
		}
		else if (cvType == CvType.CV_8UC1)
		{
			bufferedImageCVtype = BufferedImage.TYPE_BYTE_GRAY;
			bufferedImageCVtype = BufferedImage.TYPE_BYTE_BINARY;
		}
		else if (cvType == CvType.CV_32SC3)
		{
			bufferedImageCVtype = BufferedImage.TYPE_INT_BGR;
			bufferedImageCVtype = BufferedImage.TYPE_INT_RGB;
		}
		else if (cvType == CvType.CV_32SC4)
		{
			bufferedImageCVtype = BufferedImage.TYPE_INT_ARGB_PRE;
			bufferedImageCVtype = BufferedImage.TYPE_INT_ARGB;
		}
		else if (cvType == CvType.CV_16UC1)
		{
			bufferedImageCVtype = BufferedImage.TYPE_USHORT_GRAY;
		}
		else if (cvType == CvType.CV_8UC4)
		{
			bufferedImageCVtype = BufferedImage.TYPE_4BYTE_ABGR; 
			bufferedImageCVtype = BufferedImage.TYPE_4BYTE_ABGR_PRE;
		}
		else
		{
		    // BufferedImage.TYPE_BYTE_INDEXED;
		    // BufferedImage.TYPE_CUSTOM;
			bufferedImageCVtype = -1;
		}
		
		return bufferedImageCVtype;
	}
}
