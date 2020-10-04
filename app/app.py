from flask import Flask, request
import flask
import joblib
from numpy import array

app = Flask(__name__)

model = joblib.load('models/linear_svm.joblib')
vectorizer = joblib.load('models/tfidf_vectorizer.joblib')


@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'GET':
        return flask.render_template('index.html')

    if request.method == 'POST':
        input_text = request.form['input_for_model']
        print(f'Text: {input_text}')

        input_text_prep = array([input_text])

        input_text_prep = vectorizer.transform(input_text_prep)
        prediction = model.predict(input_text_prep)[0]
        print(f'Prediction: {prediction}')
        prediction = 'Positive' if prediction == 1 else 'Negative'

        return flask.render_template('prediction_result.html',
                                     inp_text=input_text,
                                     result=prediction)


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)
