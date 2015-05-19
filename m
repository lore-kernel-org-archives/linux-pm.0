From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.1-rc4
Date: Mon, 18 May 2015 17:27:58 -0700
Message-ID: <20150519002756.GA4319@localhost.localdomain>
References: <20150511235006.GB4810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150511235006.GB4810@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rui,

On Mon, May 11, 2015 at 04:50:07PM -0700, Eduardo Valentin wrote:
> Hello Rui,
>=20
> Please pull from
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-therma=
l fixes
>=20
> to receive Thermal-SoC Management updates for v4.1-rc4 with top-most
>=20
> efa86858e1d8970411a140fa1e0c4dd18a8f2a89:
>=20
>   thermal: armada: Update Armada 380 thermal sensor coefficients (2015-05=
-09 01:00:31 -0700)
>=20
>=20
> on top of commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:
>=20
>   Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)
>=20
> Specifics:
> - Thermal soc drivers fixes on Armada (380) and TI (dra7 and OMAP5).
>=20


Was there anything wrong with this pull ? Any specific reason that
prevented you from pulling it?

BR,

Eduardo Valentin

> BR,
>=20
> Eduardo Valentin
> ----------------------------------------------------------------
> Keerthy (2):
>       thermal: ti-soc-thermal: dra7: Implement Workaround for Errata i814
>       thermal: ti-soc-thermal: OMAP5: Implement Workaround for Errata i813
>=20
> Nadav Haklai (1):
>       thermal: armada: Update Armada 380 thermal sensor coefficients
>=20
>  drivers/thermal/armada_thermal.c                   |  6 +-
>  .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
>  .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  3 +-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 78 ++++++++++++++++=
+++++-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  6 ++
>  5 files changed, 89 insertions(+), 7 deletions(-)



--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVWoOHAAoJEMLUO4d9pOJWr4IH/2iM9pj4P96cpmvVQnEFe56z
gUjyKZ3iTWRU3oBhKxjfQZgMXoWhZK10D7i5U1x/Mm7IzxgyX1luwXjodGa/kjbX
L+tMw2mX7CV6pjJiDmoFSIFlzfV19/DVqAYDN/caRpo8NcdLp2P6BmaK/F30Bmab
S30B4mAP3pKcO5cMHx+pjrh27JLOS6YSg2Vr4sYwKWtd5sbcAGAQtTns/Jo5mn8J
/UGIq7lhyf5r2e1EqvLwnNTBsqaes7xG34CdC6iay83oa5haOF10pdN8Q/yKwAhj
/gHWwnJYxMPj8OKIXQ2CARC5CQB+IoPRVwMfGeQTh6nDaWRz1PBc0MNUJwbbPns=
=Dx1g
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
