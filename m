From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.1-rc4
Date: Mon, 11 May 2015 16:50:07 -0700
Message-ID: <20150511235006.GB4810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32954 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbbEKQuH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 12:50:07 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, lklm@localhost.localdomain


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.1-rc4 with top-most

efa86858e1d8970411a140fa1e0c4dd18a8f2a89:

  thermal: armada: Update Armada 380 thermal sensor coefficients (2015-05-09 01:00:31 -0700)


on top of commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

Specifics:
- Thermal soc drivers fixes on Armada (380) and TI (dra7 and OMAP5).

BR,

Eduardo Valentin
----------------------------------------------------------------
Keerthy (2):
      thermal: ti-soc-thermal: dra7: Implement Workaround for Errata i814
      thermal: ti-soc-thermal: OMAP5: Implement Workaround for Errata i813

Nadav Haklai (1):
      thermal: armada: Update Armada 380 thermal sensor coefficients

 drivers/thermal/armada_thermal.c                   |  6 +-
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  3 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 78 +++++++++++++++++++++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  6 ++
 5 files changed, 89 insertions(+), 7 deletions(-)

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVUUAnAAoJEMLUO4d9pOJW7ZsH/RqQY04kTfjfDwP5tX+JENdI
A9HFrLU1IlMVruU2BV3iAgKOOlH9lTJ/O4GoQCw4yCFwPYrAmgNmiMIQXnARN4Y3
pfu17jjVIRC6RaQC7rM2IBdxd9Yf9dt9z8lxSsEOpM2k8l/o8fGgWPcyKtniOejo
kJpbEoCyK/LeMoypG+YoBkUGEzJUwLpsyC460mK81Pj37E3k/GrK1WRuAMjPMPl1
9/vx2+tJEAzxggdAOuagUG4cEEm5eUY9eKS00wZXuaSRQ7dWX19ueMinZTNBfvdV
+TcaM97u20fh+rX8/BvSmOQ10YzVKE4dpTVihFPgnSY2Eu8nqPoaqvh1Es41p/0=
=VCDz
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
