From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] thermal-soc management updates for v3.19 #2
Date: Tue, 9 Dec 2014 00:02:28 -0400
Message-ID: <20141209040226.GA2245@developer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rui,

(sorry for duplicates, now copying the list)

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.=
git linus

to receive Thermal-SoC Management updates for v3.19 with top-most

184a4bf623fa587067851d25435fcb2f41de445b:

  thermal: of: Extend current of-thermal.c code to allow setting emulated t=
emp (2014-12-08 21:10:00 -0400)

on top of e920f9b632a687834de5a78c60ac5c4c62327b1d:

  thermal: armada: Remove support for A375-Z1 SoC (2014-11-24 16:55:42 -040=
0)

Specifics:

Continuing the content for thermal-soc, I am sending now a specific extensi=
on in OF thermal.
In this pull, we have a change that extends the of thermal to allow drivers=
 to register and use
its functionality in a better way. The content here does not exploits therm=
al core. The new=20
API entries are intended to only access and properly implement the function=
alities already
implemented in thermal core.

BR,

Eduardo Valentin

----------------------------------------------------------------
Lukasz Majewski (5):
      thermal: of: Extend of-thermal.c to provide number of trip points
      thermal: of: Extend of-thermal.c to provide check if trip point is va=
lid
      thermal: of: Rename struct __thermal_trip to struct thermal_trip
      thermal: of: Extend of-thermal to export table of trip points
      thermal: of: Extend current of-thermal.c code to allow setting emulat=
ed temp

 drivers/thermal/of-thermal.c   | 109 ++++++++++++++++++++++++++++++++++---=
----
 drivers/thermal/thermal_core.h |  18 +++++++
 include/linux/thermal.h        |  18 +++++++
 3 files changed, 127 insertions(+), 18 deletions(-)

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhnRKAAoJEMLUO4d9pOJWf1cH/3hJ3Duu2Inq7FXcQwiovKYy
LDm4CJbgUXVe6+PpcdeKJTQCnKK2aEeFeLhdohgvPGhVuThC5lR98jg1RkqFnheG
9Ff2TuSbf7OG1NUNDnnog03GTx6Ea4gedcyXmLrhbVu3PTH50j7ySZXwxmgBcMp0
6UnHYA5b4SLuPIgX9/nKlR1MmwwqY60CERV+Y/aULnYeCI/tuOtcayaGgpOszz9v
Z08t6Dn/4yAwgV8GUJOKbfilprQ9vuP3aMMsV2GEoIGosdNb20tG7nECtyccVVPX
W1THbV15YIbn3aUFIPMVyIXBerTkz25sAqrGnnsQm/0Y2wKfvHXXHZ9rdAIPwy4=
=nXlx
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
