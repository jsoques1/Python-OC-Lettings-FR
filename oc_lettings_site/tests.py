import pytest
from django.urls import reverse


@pytest.mark.django_db
def test_home(client):
    url = reverse('index')
    response = client.get(url)

    assert response.status_code == 200
    assert b"<title>Holiday Homes</title>" in response.content
    assert b"<h1>Welcome to Holiday Homes</h1>" in response.content
    assert b'<div><a href="/profiles/">Profiles</a></div>' in response.content
    assert b'<div><a href="/lettings/">Lettings</a></div>' in response.content


def test_dummy():
    assert 1
