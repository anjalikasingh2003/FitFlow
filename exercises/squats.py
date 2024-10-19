import cv2
import math
from tkinter import *
from PIL import Image, ImageTk
import mediapipe as md

# Importing necessary libraries

md_drawing = md.solutions.drawing_utils
md_drawing_style = md.solutions.drawing_styles
md_pose = md.solutions.pose

count = 0
position = None
phase = "standing"  # Possible phases: standing, squat

cap = cv2.VideoCapture(0)

# Initializing variables and capturing video

root = Tk()
root.title("SQUAT COUNTER")
root.geometry('500x400+268+82')
root.configure(bg="#FFD700")

# Creating the Tkinter window

f1 = LabelFrame(root, bg="#0000FF").place(relx=0.5, rely=0.5)  # this is vid background

label = Label(root, text="Squat Count: 0", font=("Arial", 24))
label.pack(pady=10)

# Creating labels for displaying information

Label(root, text="2021-MC-06 HASSAN ALI", font=("Calibri", 20), bg="#0000FF", fg="#fffdd0").place(relx=0.75, rely=0.2)
Label(root, text="2021-MC-08 MUEEZ ALI", font=("Calibri", 20), bg="#0000FF", fg="#fffdd0").place(relx=0.75, rely=0.25)

# Creating labels for authors' information

video_label = Label(root)
video_label.pack()

# Creating a label for displaying video

def close():
    root.destroy()

# Function to close the application

Button(f1, text="Exit the Application", bg='#fffdd0', fg='red', font=("Calibri", 14, "bold"), command=close).place(relx=0.11, rely=0.8, anchor="center")

# Creating an exit button

pose = md_pose.Pose(
    min_detection_confidence=0.5,
    min_tracking_confidence=0.7
)

# Initializing the Pose object for pose estimation

def update_squat():
    global count
    label.config(text=f"SQUATS: {count}")
    label.after(1000, update_squat)

# Function to update the squat count every second

def process_frame():
    global position, count, phase

    success, image = cap.read()
    if not success:
        print("Empty Camera")
        return

    image = cv2.cvtColor(cv2.flip(image, 1), cv2.COLOR_BGR2RGB)
    result = pose.process(image)

    if result.pose_landmarks:
        md_drawing.draw_landmarks(
            image, result.pose_landmarks, md_pose.POSE_CONNECTIONS,
            landmark_drawing_spec=md_drawing_style.get_default_pose_landmarks_style()
        )

        imlist = []
        for id, lm in enumerate(result.pose_landmarks.landmark):
            h, w, _ = image.shape
            X, Y = int(lm.x * w), int(lm.y * h)
            imlist.append([id, X, Y])

        if len(imlist) != 0:
            # Define the positions for squat detection
            hip_y = imlist[11][2]  # Left hip
            knee_y = imlist[13][2]  # Left knee
            ankle_y = imlist[15][2]  # Left ankle

            # Check phases of squat
            if phase == "standing" and knee_y > hip_y:  # Start squat
                phase = "squat"
            elif phase == "squat" and knee_y < hip_y:  # Squatting position
                position = "down"
            elif phase == "squat" and knee_y > hip_y and position == "down":  # Standing up
                phase = "standing"
                count += 1
                print(count)

    frame = ImageTk.PhotoImage(Image.fromarray(image))
    video_label.config(image=frame)
    video_label.image = frame

    root.after(1, process_frame)

# Function to open the webcam for video capture

def open_webcam():
    global cap
    cap.release()
    cap = cv2.VideoCapture(0)

# Function to open the video captured for detection of squats

def open_video():
    global cap
    cap.release()
    cap = cv2.VideoCapture("Squats.mkv")  # Replace with your video file if needed

button_frame = Frame(root)
button_frame.pack(pady=10)

# Creating a frame to hold the buttons

webcam_button = Button(button_frame, text="Open WebCam", command=open_webcam)
webcam_button.grid(row=0, column=0, padx=10)

# Creating a button to open the webcam

video_button = Button(button_frame, text="Open Video", command=open_video)
video_button.grid(row=0, column=1, padx=10)

# Creating a button to open a video file

update_squat()
process_frame()

# Updating the squat count and processing video frames

root.mainloop()

cap.release()
cv2.destroyAllWindows()
