package Paint;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.*;
public class Paint{
	//Dimensions for picture will be saved here because I couldn't figure out a better plan
	public static int intHeight;
	public static int intLength;
	public static int[][] clicked;
	
	public static void main(String args[]) {
		//create input window for dimensions
		JFrame frame = new JFrame("paint");
		frame.setPreferredSize(new Dimension(200, 200));
		frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(new GridBagLayout());
		
		//GridBagLayout allows for custom grid layout, a button can be multiple grids long
		GridBagConstraints gbc = new GridBagConstraints();
		
		JLabel input = new JLabel("Please input dimensions");
		//dimensions indicate where label is placed
		gbc.gridx = 0;
		gbc.gridy = 0;
		//gridwidth = 2 means label is 2 grids long
		gbc.gridwidth = 2;
		frame.add(input, gbc);

		JLabel inHeight = new JLabel("height: ");
		gbc.gridx = 0;
		gbc.gridy = 1;
		//attribute gridwidth of object gbc is overwritten once here, saved for remaining fields
		gbc.gridwidth = 1;
		frame.add(inHeight, gbc);
		
		JTextField height = new JTextField();
		gbc.gridx = 1;
		gbc.gridy = 1;
		//fill is necessary to let textfield take on entire width of frame
		gbc.fill = GridBagConstraints.HORIZONTAL;
		frame.add(height, gbc);
		
		JLabel inLength = new JLabel("length: ");
		gbc.gridx = 0;
		gbc.gridy = 2;
		frame.add(inLength, gbc);

		JTextField length = new JTextField();
		gbc.gridx = 1;
		gbc.gridy = 2;
		frame.add(length, gbc);

		//button to finish process
		JButton submit = new JButton("submit");
		gbc.gridx = 0;
		gbc.gridy = 3;
		gbc.gridwidth = 2;
		frame.add(submit, gbc);
		
		//ActionListener for button
		ActionListener click = new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				//start at 8 because "height" would be counted as input otherwise
				String hei = height.getText();
				String len = length.getText();
				
				//check for valid input
				try {
					intHeight = Integer.parseInt(hei);
					intLength = Integer.parseInt(len);
					//hide frame
					frame.setVisible(false);
					paintPicture();
				}
				//error shows up until correct input is given
				catch(Exception err) {
					input.setText("only enter integer numbers!");
				}
			}
			
		};
		
		//add things to frame
		submit.addActionListener(click);
		frame.pack();
		frame.setVisible(true);
	}
	//method creates field of buttons that can be clicked to create pattern
	public static void paintPicture() {
		JFrame field = new JFrame("design a pattern and click the green button to confirm!");
		//fullscreen
		field.setExtendedState(JFrame.MAXIMIZED_BOTH); 
		field.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		//specified dimensions from earlier
		field.getContentPane().setLayout(new GridLayout(intHeight, intLength));		

		//create array with buttons
		JButton[][] butts = new JButton[intHeight][intLength];
		//confirmation button
		JButton one = new JButton();
		one.setBackground(Color.green);
		field.add(one);
		one.setActionCommand("submit");
		butts[0][0] = one;

		//create every other button
		for(int i=0; i<butts.length; i++) {
			for(int j = 0; j<butts[i].length; j++) {
				//top left is already made
				if(i == 0 && j == 0) {
					continue;
				}
				JButton butt = new JButton();
				field.add(butt);
				//actioncommand are the coordinates
				butt.setActionCommand(i+","+j);
				butts[i][j] = butt;
			}
		}
		//int array to save if a button is currently black or not
		clicked = new int[intHeight][intLength];
		for(int i = 0; i<clicked.length; i++) {
			for(int j = 0; j<clicked[i].length; j++) {
				clicked[i][j] = 0;
			}
		}

		ActionListener design = new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				String[] coordinates = e.getActionCommand().split(",");
				int x = Integer.parseInt(coordinates[0]);
				int y = Integer.parseInt(coordinates[1]);
				//zero is standard color, one is black
				if(clicked[x][y] == 0) {
					clicked[x][y] = 1;
					butts[x][y].setBackground(Color.black);
				}
				else {
					clicked[x][y] = 0;
					butts[x][y].setBackground(null);
				}
			}
		};
		
		ActionListener confirm = new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				field.setVisible(false);
				drawMosaic();
			}
		};
		//finally add actionlisteners
		for(int i = 0; i<butts.length; i++) {
			for(int j = 0; j<butts[i].length; j++) {
				if(i==0 && j==0) {
					one.addActionListener(confirm);
					continue;
				}
				butts[i][j].addActionListener(design);
			}
		}
		field.setVisible(true);
	}
	
	public static void drawMosaic() {
		/*IMPORTANT: array declaration is int[][] arr = new arr[height][length], that means
		 the first number indicates the number of rows, the second indicates the number of 
		 columns. But BufferedImage takes the number of columns and then the number of rows. Sucks.*/
		BufferedImage img = new BufferedImage(intLength, intHeight, BufferedImage.TYPE_3BYTE_BGR);
		
		for(int i = 0; i<clicked.length; i++) {
			for(int j = 0; j<clicked[i].length; j++) {
				if(i==0 && j==0) {
					Color white = new Color(255,255,255);
					img.setRGB(j, i, white.getRGB());
				}
				if(clicked[i][j] == 0) {
					Color white = new Color(255,255,255);
					img.setRGB(j, i, white.getRGB());
				}
				else {
					Color black = new Color(0,0,0);
					img.setRGB(j, i, black.getRGB());
				}
			}
		}
		/* Display image if needed.
		JFrame picture = new JFrame();
		picture.setExtendedState(JFrame.MAXIMIZED_BOTH);
		picture.getContentPane().setLayout(new GridBagLayout());
		GridBagConstraints gbc = new GridBagConstraints();
		gbc.fill = GridBagConstraints.HORIZONTAL;
		picture.getContentPane().add(new JLabel(new ImageIcon(img)));
		picture.setVisible(true);
		*/
		
		try {
		    File outputfile = new File("mosaic.png");
		    ImageIO.write(img, "png", outputfile);
		} catch (IOException e) {
		    System.out.println("something went horribly wrong");
		}
	}
}

