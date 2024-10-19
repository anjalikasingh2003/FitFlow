from flask import Flask, jsonify
from flask_cors import CORS
import subprocess

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes
CORS(app, resources={r"/*": {"origins": "*"}})  # Allow all origins for all routes



@app.route('/Tree_pose', methods=['GET'])
def jumping_jacks():
    try:
        result = subprocess.run(['python3', 'yoga_poses/Tree_pose.py'], 
                                check=True, 
                                stdout=subprocess.PIPE, 
                                stderr=subprocess.PIPE)

        # If the script runs successfully, return the output
        return result.stdout.decode(), 200
    except subprocess.CalledProcessError as e:
        return f"An error occurred: {e.stderr.decode()}", 500
    except FileNotFoundError:
        return "Python interpreter not found", 500



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)