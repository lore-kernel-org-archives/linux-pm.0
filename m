From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.8-rc
Date: Wed, 17 Aug 2016 12:50:46 +0200
Message-ID: <20160817105046.52u4hvo2p25vo5wp@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dl7wwx3jkuywmivt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33646 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbcHQKuw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Aug 2016 06:50:52 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--dl7wwx3jkuywmivt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.8-rc

for you to fetch changes up to 33e7664a0af6e9a516f01014f39737aaa119b6d9:

  power_supply: tps65217-charger: fix missing platform_set_drvdata() (2016-08-15 23:10:44 +0200)

----------------------------------------------------------------
Power Supply Fixes for 4.8 cycle

----------------------------------------------------------------
Andy Yan (1):
      power: reset: reboot-mode: fix build error of missing ioremap/iounmap on UM

Arvind Yadav (1):
      power: reset: hisi-reboot: Unmap region obtained by of_iomap

Sven Van Asbroeck (1):
      power: supply: max17042_battery: fix model download bug.

Wei Yongjun (1):
      power_supply: tps65217-charger: fix missing platform_set_drvdata()

 drivers/power/max17042_battery.c  | 15 +++++++++------
 drivers/power/reset/Kconfig       |  2 +-
 drivers/power/reset/hisi-reboot.c |  5 ++++-
 drivers/power/tps65217_charger.c  |  1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

--dl7wwx3jkuywmivt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtEGCAAoJENju1/PIO/qawpcQAId4Q9zWmmln4WZlV1NBFiRI
Z9udt8Ew20t+hElD8lAuFXZrHEaXLfXcB9BoVJmyo6d/ohsHH5xP/hoioEd7cttY
jCDAo6YXeGtUJ8Bk8lzKRd6eU8F+cCruy3PdAqD3hL4TyPAH1gx2a9/033jytgfC
iz2tySekkCL+Q3uMK9S2FnADc2Dk3+ScUTgxtirSBc/+XaW7/nburU2uaqNmui8g
+UL3+nKAQQhro6VKCY3seXbB60608tdBQphsa9YmCS7gPgYhNwD4tNlYPtrlzwNB
PatOyjpPwLYVgukzAodMMGbwz2fbgh99M7CQLkZGrmeTbh4JpFrJzQBXD4QUGbJg
uIw71BHS8wlTho4RHLwic0slhKDOENX+WEXYgY++yCwRtUQxUe+Q9tqkOQYLmOE0
SedUBGmJQw0yNi09JrZDmeAuBvYKM7bVS7dQHXawDkkBP/8XlhK2MSuzCMGBFYjW
U5iN2OMD+Xfz0ayYx5t0YO2NF+nL8RSxqUXHqHDy0OnmHd9skOaBiOjrmrgYDJX+
eyojXxBYMrqsWqh3rkmaqC06xR1CZvyZ2vtcJ42h1zhvqEM+JdsBB76F4N3EVAo3
zVhDKOpum+DBRUsWod6EsdqwNHZRzM1H2oQH0S1Oe1SiBcLwYfKiQ6Mv8mHKDI0O
BVcHCNJYsKBlhhkSNDsv
=+0l5
-----END PGP SIGNATURE-----

--dl7wwx3jkuywmivt--
