From: Sebastian Reichel <sre@kernel.org>
Subject: Immutable branch for axp288 power-supply/mfd
Date: Wed, 4 Jan 2017 22:13:50 +0100
Message-ID: <20170104211349.mwqlokjwytg2sn2e@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5m4q6qqfjq3lixei"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761097AbdADVYP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Jan 2017 16:24:15 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org


--5m4q6qqfjq3lixei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lee,

Here is the promised immutable branch for the axp288 power-supply
changes, that also touch the mfd subsystem.

-- Sebastian

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git psy-mfd-axp288-immutable

for you to fetch changes up to 888f97435a856c2c5c6ca0b3337b68d595b5639e:

  power: supply: axp288_fuel_gauge: Drop platform_data dependency (2017-01-04 21:56:10 +0100)

----------------------------------------------------------------
Hans de Goede (3):
      power: supply: axp288_charger: Make charger_init_hw_regs propagate i2c errors
      power: supply: axp288_charger: Drop platform_data dependency
      power: supply: axp288_fuel_gauge: Drop platform_data dependency

 drivers/power/supply/axp288_charger.c    | 132 +++++-----
 drivers/power/supply/axp288_fuel_gauge.c | 405 +++----------------------------
 include/linux/mfd/axp20x.h               |  29 ---
 3 files changed, 96 insertions(+), 470 deletions(-)

--5m4q6qqfjq3lixei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhtZYsACgkQ2O7X88g7
+prhwg/8CeJ4szIRtfdRG7/Aiwd1cRdXzQAjIjNrGquEVpW4Rl40Cf0LyrqV+Q79
361RUyaQOmD26IaNQT1NgktBBOVtdKWVl/NwmgbkqMMAjOmK66d6sEnKVP+V1ncB
TIlTt+oZaEu3TNH8qPVzG+C8sh14rTp9GNVWmAIuWQ7/QK0TUnitYhYte7HSvYQA
QGjJW2A+qxWl6diFsmL0b/wN5ra0BcmwXWktWCPA5wK1RIrQHioBg03u3D9EM0oL
5RZRwu/lRBipDs91ui+yKGFqnsZpqNMwM4eBfYkrmRkXKEOBYQTId/V+5vop1vnF
wt/vzzmZh6zbjFzqd8+TijIyVd8T4qKZtT/5pGbFxUQ1yInROvRoY8FC4Th/TO/Q
WpcQKP+8axYzfxwmPhG+QvKfK0/Nf6bzydxQF+WSBiihss3eRoXbTWLAwUxn3kcN
19S5wWcmZ/ih5rUFL7vzvhzMtqC6NP04Eaa+lxUlGA4wJdCTkD4kmC+nD+1KigH4
gZ4wiui2//Y4NmBuUjw7sKjHEo+SDMN1VpacrCKmqnZXGBuIuLxNJR2V5iXL04lo
ZBBxONoDnBIBhFEInroXQFYTsAIo6TMxxJSH8o2Zn3g2+Oe08g4uKLBehEUjqvht
Gpoc58FP9cGztLnpfulTTwUPyDAM3jZXPXdqNoEKPBidM09DJfg=
=Y0/a
-----END PGP SIGNATURE-----

--5m4q6qqfjq3lixei--
