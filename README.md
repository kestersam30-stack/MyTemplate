# MyTemplate

MyTemplate is a Flask web application template with user authentication and other basic features.

## Requirements

* Python 3
* pip

## Setup

Clone the repository and create a virtual environment:

```bash
python -m venv venv
```

Activate it on Windows:

```bash
venv\Scripts\activate
```

Install the dependencies:

```bash
pip install -r requirements.txt
```

## Run the Application

Start the Flask application:

```bash
python manage.py server
```

The application will be available at:

```text
http://127.0.0.1:5000
```

## Run Tests

Run the complete test suite:

```bash
python -m pytest tests/ -v
```

The project includes:

* Backend tests using pytest
* UI tests using Playwright

## Coverage

Run tests with coverage:

```bash
python -m pytest tests/ --cov=appname --cov-report=term-missing
```

To generate HTML coverage:

```bash
python -m pytest tests/ --cov=appname --cov-report=html
```

The HTML report will be created in:

```text
htmlcov/
```

## Code Quality and Security

Run Ruff:

```bash
ruff check .
```

Run Bandit:

```bash
bandit -r appname
```

## Build Pipeline

The project includes a Makefile and GitHub Actions workflow.

The GitHub Actions workflow runs on pushes and pull requests and checks the application using Python 3.12 and 3.13.

The build generates:

* Unit test report
* Coverage report
* Ruff report
* Bandit security report

These reports are uploaded as GitHub Actions artifacts.

## Project Structure

```text
MyTemplate/
├── appname/
├── tests/
├── documentation/
├── .github/
├── Makefile
├── manage.py
└── requirements.txt
```

## License

This project is based on the original Flask application template and is being used for assessment purposes.
