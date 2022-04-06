import sqlite3
import json
from flask import Flask

app = Flask(__name__)

@app.route('/animals/<idx>')
def animals(idx):
    con = sqlite3.connect('animal.db')
    cursor = con.cursor()
    query = f"""
        select * from animals_fin
        left join outcomes on outcomes.animal_id=animals_fin.animal_id
        where animals_fin.id = {idx}
    """

    cursor.execute(query)
    result = cursor.fetchall()
    con.close()

    if len(result) == 1:
        line = result[0]
        result_dict = {
            'id': line[0],
            'animal_id': line[1],
            'type_id': line[2],
            'name': line[2],
            'breed_id': line[3],
            'date_of_birth': line[4],
            'outcome_id': line[5],
            'age_upon_outcome': line[6],
            'outcome_subtype': line[7],
            'outcome_type': line[8],
            'outcome_month': line[9],
            'outcome_year': line[10],
        }
    else:
        result_dict = {}
    return json.dumps(result_dict)


app.run(debug=True, port=5000)



