From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: bq2415x: check for NULL acpi_id to avoid
 null pointer dereference
Date: Sun, 29 Jan 2017 16:17:47 +0100
Message-ID: <20170129151747.musddn4bh2j7kae6@earth>
References: <20170120132506.20514-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k37jotznqqrlaadb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120132506.20514-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--k37jotznqqrlaadb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 20, 2017 at 01:25:06PM +0000, Colin King wrote:
> acpi_match_device can potentially return NULL, so it is prudent to
> check if acpi_id is null before it is dereferenced.  Add a check
> and an error message to indicate the failure.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, queued into power-supply's for-next branch.

-- Sebastian

--k37jotznqqrlaadb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOB5oACgkQ2O7X88g7
+ppGrw//WMjbLaal6WtF+1oIji7vk4V0yc1b9ff8NVdHGvUI4GOVEpvGYHNEbI5K
GFmFnVaTokVUwog7LEkW0oX1yE/pqqkz3qGh1a67yCNbLMllH8+m9sx3UG/KiWbi
t3zeiS2jYs/ko9uDQLKKYIHfI+KR+XcTRisTzaM/qvEmT+rxp0jl0Z5HajaUGl+I
pN5gr1ZimeMg9pKFY6kfEny7UvSqkxNpUF0ZQxmRdB8VeiY3eJgE/EDIuRIBQ46G
5HPfygnHZBBIBbN7cFpBLY3q286qQyQ0YrXKQWYgs53luBTBMKYYHRDICGS1MObh
gMlmQ0OT9feRfA/YoPuEkGPlce9ubzGy8aTaqTQoPAZLiEW1CnfCmnQGh5ynJT+C
X/7Uhq2S3YyfAxTDgBRaVbQnNVZVRxwuNb6bmisT6/PaIcI0XqlB5KxFw9svh9lj
MeqyexB2h2ff1js8sfN7iOym0klkxmXhLAjeEcVPwFpwXazIpWSZbgRVs7EXkHSI
FRN58Wxp2/OMmcN63R/gQGCROb6rUX3Zw1y+YlNcnWL/GgjktkKlXzwsHDoUmSaE
9KdP9qj7ZkaOLiHMj6+jgYyy6KAuEdXyXsJGiCMieoLpv1pWjUT/5uum5M79qbVk
Nk+iWHfY6h+b/STnNiQnqxvXi8fSIS+qyc3Yh+4yOrc7N093lSo=
=6eG/
-----END PGP SIGNATURE-----

--k37jotznqqrlaadb--
