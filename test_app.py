import pytest
import csv
from flask import Flask

app = Flask(__name__)

@app.route('/', methods=['GET'])
def helloWorld():
    return 'Hello World'

@app.route('/aboutUs')
def aboutUs():
    return 'this is about us page'

@app.route('/contactus', methods=['POST'])
def contactUs():
    return 'this is contact us page'

if __name__ == '__main__':
    app.run(port=3000, debug=False)


def test_helloWorld():
    with app.test_client() as client:
        response = client.get('/')
        assert response.status_code == 200
        assert response.get_data(as_text=True) == 'Hello World'


    with open('results.csv', 'a') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['test_helloWorld', 'passed'])


def test_aboutUs():
    with app.test_client() as client:
        response = client.get('/aboutUs')
        assert response.status_code == 200
        assert response.get_data(as_text=True) == 'this is about us page'

    with open('results.csv', 'a') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['test_aboutUs', 'passed'])


def test_contactUs():
    with app.test_client() as client:
        response = client.post('/contactus')
        assert response.status_code == 200
        assert response.get_data(as_text=True) == 'this is contact us page'

    with open('results.csv', 'a') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['test_contactUs', 'passed'])
