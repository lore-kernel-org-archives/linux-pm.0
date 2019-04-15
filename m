From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
Date: Tue, 16 Apr 2019 00:09:58 +0200
Message-ID: <20190415220958.d3hr6ymwoy43npjw@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190323172809.14407-4-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rw2r4of4bpn34oof"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190323172809.14407-4-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org


--rw2r4of4bpn34oof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 23, 2019 at 06:28:09PM +0100, Artur Rojek wrote:
> Add a driver for battery present on Ingenic JZ47xx SoCs.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

I just applied the patch, but it results in the following warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/supply/ingenic-=
battery.o

Please add MODULE_LICENSE & Co and send a v4 of patch 4/4.

-- Sebastian

--rw2r4of4bpn34oof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly1ASsACgkQ2O7X88g7
+pqTVA/+Ik4sVPteTU4wCrybHl8pxCnajSRMODXGm3MxbBSs6vpI4wr5/aqD3P5Z
iWMburw6eg3YZOk5kK9awGkykioyZ4MGlfTURZyKo7QKMPbEruY1RUTnJRBtZ9d6
oV8HxzzuiZlY9pN0Szlw8UYK7aZOKR5CqtTzL3HHsZR+mHTLFZG+W5tQdALQzs/6
GS+V3d48s5o+JVYnZePwFe4b6Qi9cs57f/JFJ6hOnpIdKQzEh1xxbw/6axMaIZBh
nzlh2pdJT0bN/uPOYztunaGefrkht7YH+SCYttAr6Valxa7UJIccYwhggTAtCwFK
UAYDyZVPuhp3i9vBMBeNRIdCoxwqoHUsdffpRrIMlJvxa2Jkvff4dAfcoVtzgJpq
VzbOfRsquhVxlCiOScO5cc9WK+qAifoy7Q+yo8uZ5Y+oniMx72zueeOvG6Kv+idL
jDbMvSxqVv7QdqSv/fA/7X9cjeu90548YvBRB0dkKh9fvNfaD2myGeW6VKl2/m6T
c7OSOaUS0HAD/hfDIaZaJX72fK7cVGNJ7bF8dMPv57Y7oBoH6r4eaLvIdxAv3xnH
kGR6ZGZ1KB0LNxYH/lblosuo5N3lVFSToXsluvhfpjQHbNKtXXZhDJTKSvA0nUu5
yLItgAQ4Qfsc3k30zoQinBbADuD5ibptP9KM/6BPaeCnp7lSKqA=
=S6TG
-----END PGP SIGNATURE-----

--rw2r4of4bpn34oof--
