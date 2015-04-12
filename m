From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Last minutes thermal-SoC management updates for v4.0
Date: Sat, 11 Apr 2015 19:46:13 -0700
Message-ID: <20150412024611.GA12807@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.0-rc7 with top-most

541d529f9845d249d1cb84f1b395e48f0a117e3f:

  drivers: thermal: st: remove several sparse warnings (2015-04-07 13:43:28 -0700)

on top of commit f8b3d8a5af7559a58613384cd23fc03a3c787acf:

  Merge tag 'usb-4.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2015-04-04 12:26:28 -0700)

Specifics:
- Minor fixes on ST and RCAR thermal drivers.
- Avoid flooding kernel log when driver returns -EAGAIN.

Note: I am sending this pull on Rui's behalf while he fixes issues in
his Linux box.

BR,

Eduardo Valentin
----------------------------------------------------------------
Eduardo Valentin (1):
      drivers: thermal: st: remove several sparse warnings

Fabian Frederick (1):
      thermal: constify of_device_id array

Geert Uytterhoeven (1):
      thermal: rcar: Fix typo in r8a73a4 SoC name

Hans de Goede (1):
      thermal: Do not log an error if thermal_zone_get_temp returns -EAGAIN

 Documentation/devicetree/bindings/thermal/rcar-thermal.txt |  2 +-
 drivers/thermal/st/st_thermal.c                            |  2 +-
 drivers/thermal/st/st_thermal_memmap.c                     | 10 +++++-----
 drivers/thermal/st/st_thermal_syscfg.c                     | 14 +++++++-------
 drivers/thermal/thermal_core.c                             |  6 ++++--
 5 files changed, 18 insertions(+), 16 deletions(-)

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVKdxmAAoJEMLUO4d9pOJW6lgH/3VGTzyVPxUAD8T3Zm5KP64H
/mtwnzhVyfQurDWb9tg7UK1ExN2menpab3Wr27loZgPMMCuQHDkuDVrKCEiu2etA
WBu/PWuS25qA5XPK6L/gs3u4DYP59wt2HcvHhcQqhkcBM49nQzUc4nk8a2URSRd2
nuzGfTLhxHWHWv6EYz3NqC1TlxU8hUAMiBQdanV3pf2EgBSXkKwzmYo8AEQT08TV
3RUfkbwQWyStHgLpMX7Eekt8RdDDuqTPtVgvZzBg8stXpraNV8CkkGRXCzTXWUHG
IrB1NYtIvXk47W4Rxec8yM/uJ0L4Ul1p7Z2a4/3/OCIpFXX3oJ2efikpL4CsYho=
=cyKs
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
