import pytest
from playwright.sync_api import Page


BASE_URL = "http://127.0.0.1:5000"


@pytest.mark.ui
def test_signup_page_loads(page: Page):
    page.goto(f"{BASE_URL}/signup")

    assert "Sign up for" in page.locator("body").inner_text()


@pytest.mark.ui
def test_login_page_loads(page: Page):
    page.goto(f"{BASE_URL}/login")

    assert "Login" in page.locator("body").inner_text()


@pytest.mark.ui
def test_invalid_login_shows_error(page: Page):
    page.goto(f"{BASE_URL}/login")

    page.locator("input[name='email']").fill("admin")
    page.locator("input[name='password']").fill("wrongpassword")
    page.locator("button[type='submit']").click()

    assert "Invalid email address" in page.locator("body").inner_text()


@pytest.mark.ui
def test_login_form_has_required_fields(page: Page):
    page.goto(f"{BASE_URL}/login")

    assert page.locator("input[name='email']").count() == 1
    assert page.locator("input[name='password']").count() == 1
    assert page.locator("button[type='submit']").count() == 1


@pytest.mark.ui
def test_signup_page_has_email_field(page: Page):
    page.goto(f"{BASE_URL}/signup")

    assert page.locator("input[name='email']").count() == 1
