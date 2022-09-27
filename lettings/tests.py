import pytest
from django.urls import reverse

from .models import Address, Letting


@pytest.mark.django_db
def test_lettings_list(client):
    url = reverse('lettings:index')
    response = client.get(url)
    assert response.status_code == 200
    assert b"<title>Lettings</title>" in response.content


@pytest.mark.django_db
def test_letting_detail(client):
    address = Address(
        number=1,
        street="Rue de la Paix",
        city="Paris",
        state="PR",
        zip_code=7500,
        country_iso_code="FR"
    )
    address.save()
    letting = Letting(
        title="Le bistrot",
        address=address
    )
    letting.save()
    url = reverse("lettings:letting",  args=[1])
    response = client.get(url, data={})
    assert response.status_code == 200
    assert b"<title>Le bistrot</title>" in response.content
    assert b"<p>1 Rue de la Paix</p>" in response.content
    assert b"<p>Paris, PR 7500</p>" in response.content
    assert b"<p>FR</p>" in response.content
