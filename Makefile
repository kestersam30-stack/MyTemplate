.PHONY: help env deps clean lint test test-backend test-ui build agent-setup agent-resetdb agent-smoke agent-test security

VENV_PYTHON=env/bin/python
AGENT_TEST_FILES=$(shell git ls-files 'tests/*.py')

help:
	@echo "  env          create a development environment using virtualenv"
	@echo "  deps         install dependencies using pip"
	@echo "  clean        remove unwanted files like .pyc's"
	@echo "  lint         check style with ruff"
	@echo "  test         run all tests"
	@echo "  test-backend run backend/API tests"
	@echo "  test-ui      run Playwright UI tests"
	@echo "  build        run lint and all tests"
	@echo "  agent-setup  install dependencies in ./env for AI/code agents"
	@echo "  agent-resetdb reset and seed local development database"
	@echo "  agent-smoke  run fast smoke tests"
	@echo "  agent-test   run full test suite with coverage"

env:
	python -m venv env
	$(VENV_PYTHON) -m pip install -r requirements.txt

deps:
	pip install -r requirements.txt

clean:
	find . | grep -E "(__pycache__|\.pyc|\.DS_Store|\.db|\.pyo$$)" | xargs rm -rf

lint:
	mkdir -p reports
	ruff check . --exclude env --exclude venv --output-format=json > reports/ruff.json || true

security:
	mkdir -p reports
	bandit -r appname -f json -o reports/bandit.json || true

test-backend:
	mkdir -p reports
	APPNAME_ENV=test python -m pytest -q tests --ignore=tests/test_ui_playwright.py

test-ui:
	APPNAME_ENV=test python -m pytest -q tests/test_ui_playwright.py

test:
	mkdir -p reports
	APPNAME_ENV=test python -m pytest -q --junitxml=reports/junit.xml --cov=appname --cov-report=term-missing --cov-report=xml:reports/coverage.xml --cov-report=html:reports/htmlcov

build: lint security test
	@echo "Build completed successfully."

agent-setup:
	python -m venv env
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PYTHON) -m pip install -r requirements.txt

agent-resetdb:
	@if [ ! -x "$(VENV_PYTHON)" ]; then echo "Run 'make agent-setup' first."; exit 1; fi
	APPNAME_ENV=dev $(VENV_PYTHON) manage.py resetdb

agent-smoke:
	@if [ ! -x "$(VENV_PYTHON)" ]; then echo "Run 'make agent-setup' first."; exit 1; fi
	APPNAME_ENV=test $(VENV_PYTHON) -m pytest -q tests/test_urls.py tests/test_login.py

agent-test:
	@if [ ! -x "$(VENV_PYTHON)" ]; then echo "Run 'make agent-setup' first."; exit 1; fi
	APPNAME_ENV=test $(VENV_PYTHON) -m pytest --cov-report=term-missing --cov=appname $(AGENT_TEST_FILES)