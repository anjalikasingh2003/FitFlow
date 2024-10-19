import cv2
from tkinter import *
from PIL import Image, ImageTk
import mediapipe as md

# Setup MediaPipe Pose
md_drawing = md.solutions.drawing_utils
md_drawing_style = md.solutions.drawing_styles
md_pose = md.solutions.pose

# Global variables
count = 0
position = None
cap = cv2.VideoCapture(0)

# Tkinter setup
root = Tk()
root.title("PUSH-UP COUNTER")
root.geometry('700x600+200+100')
root.configure(bg="#000000")

# Header frame for title
header_frame = Frame(root, bg="#00008B", height=70)
header_frame.pack(fill=X)
header_label = Label(header_frame, text="PUSH-UP COUNTER", font=("Arial", 28, "bold"), fg="white", bg="#00008B")
header_label.pack(pady=10)

# Main frame to hold video feed and count
main_frame = Frame(root, bg="#000000")
main_frame.pack(pady=20)

# Push-up count display
count_label = Label(main_frame, text="Push-Up Count: 0", font=("Arial", 24), bg="#00008B", fg="white")
count_label.pack(pady=10)

# Video feed label
video_label = Label(main_frame)
video_label.pack()

# Footer frame with buttons
footer_frame = Frame(root, bg="#00008B", height=70)
footer_frame.pack(fill=X, side=BOTTOM)

# Stop button
stop_button = Button(footer_frame, text="Stop", font=("Arial", 16, "bold"), bg="#DC143C", fg="white", command=lambda: stop_counting())
stop_button.pack(side=RIGHT, padx=20, pady=10)

pose = md_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.7)

# Function to stop the counter
def stop_counting():
    global cap
    cap.release()
    root.quit()

# Update the push-up count
def update_push():
    global count
    if count >= 10:  # Stop after 10 counts
        stop_counting()
        return
    count_label.config(text=f"Push-Up Count: {count}")
    count_label.after(1000, update_push)

# Process each frame from the webcam
def process_frame():
    global position, count
    success, image = cap.read()
    if not success:
        print("Empty Camera")
        return

    # Convert image to RGB and flip for mirror effect
    image = cv2.cvtColor(cv2.flip(image, 1), cv2.COLOR_BGR2RGB)
    result = pose.process(image)

    # Draw pose landmarks if detected
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

        # Logic to detect push-up movement
        if len(imlist) != 0:
            if imlist[11][2] > imlist[13][2] and imlist[12][2] > imlist[14][2]:  # Down position
                position = "down"
            if imlist[11][2] < imlist[13][2] and imlist[12][2] < imlist[14][2] and position == "down":  # Up position
                position = "up"
                count += 1
                print(f"Push-Up count: {count}")

    # Display the frame on Tkinter video label
    frame = ImageTk.PhotoImage(Image.fromarray(image))
    video_label.config(image=frame)
    video_label.image = frame
    root.after(1, process_frame)

# Start counting and process frames
update_push()
process_frame()

root.mainloop()
cap.release()
cv2.destroyAllWindows()
