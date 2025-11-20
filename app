from flask import Flask, render_template
import sqlite3

app = Flask(__name__)

def get_db_connection():
    conn = sqlite3.connect("hospital.db")
    conn.row_factory = sqlite3.Row  # lets us use column names
    return conn

@app.route("/")
def list_index():
    return render_template("index.html")

@app.route("/doctors")
def list_doctors():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT id, name, type, phone FROM doctors")
    doctors = cur.fetchall()

    conn.close()

    # Pass the data to the HTML template
    return render_template("doctors.html", doctors=doctors)

@app.route("/patients")
def list_patients():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT doctorID, name, gender, injury, phone FROM patients")
    patients = cur.fetchall()

    conn.close()

    # Pass the data to the HTML template
    return render_template("patients.html", patients=patients)

#if above doesnt work
if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=8000)
