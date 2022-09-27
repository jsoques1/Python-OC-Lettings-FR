import pytest
from django.urls import reverse
from django.contrib.auth.models import User
from .models import Profile


@pytest.mark.django_db
def test_profiles_list(client):
    url = reverse('profiles:index')
    response = client.get(url)
    assert response.status_code == 200
    assert b"<title>Profiles</title>" in response.content


@pytest.mark.django_db
def test_profile_detail(client):
    user = User(
        username="Napoleon",
        password="Bonaparte",
        first_name="Napoleon",
        last_name="Bonaparte",
        email="Napoleon.Bonaparte@email.com"
    )
    user.save()
    profile = Profile(user=user, favorite_city="Paris")
    profile.save()

    response = client.get(reverse('profiles:profile', args=["Napoleon"]))

    assert response.status_code == 200
    assert b"<title>Napoleon</title>" in response.content
    assert b"<h1>Napoleon</h1>" in response.content
    assert b"First name: Napoleon</p>" in response.content
    assert b"<p>Last name: Bonaparte</p>" in response.content
    assert b"<p>Email: Napoleon.Bonaparte@email.com</p>" in response.content
    assert b"<p>Favorite city: Paris</p>" in response.content
