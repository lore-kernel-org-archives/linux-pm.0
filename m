From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.10
Date: Wed, 14 Dec 2016 14:45:30 +0100
Message-ID: <20161214134529.nvr3rrszv5uzrkih@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytfwc7oz7hsm2spa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--ytfwc7oz7hsm2spa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not much this time around, since I was quite busy this merge window.
I still have quite a few unreviewed patches, so expect a bigger pull
request for v4.11 (and probably a second one for v4.10 with fixes
that I missed so far). Here is the usual output of request-pull,
that looks fine to me. As side-effect of me being busy all patches
have been in linux-next for at least 3 weeks :)

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.10

for you to fetch changes up to 6480af4915d6ffb66afc39eee4e9e66cbf59b938:

  power_supply: wm97xx_battery: use power_supply_get_drvdata (2016-11-23 23:48:12 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.10 series

* New driver for Intel PIIX4
* lots of module autoload fixes
* misc. fixes

----------------------------------------------------------------
Andrew F. Davis (1):
      power: supply: bq27xxx_battery: Fix register map for BQ27510 and BQ27520

Dan Carpenter (1):
      power: supply: lp8788: remove an unneeded NULL check

Javier Martinez Canillas (6):
      power: supply: max8997_charger: Fix module autoload
      power: supply: axp288_fuel_gauge: Fix module autoload
      power: reset: at91-reset: Fix module autoload
      power: reset: at91-poweroff: Fix module autoload
      power: reset: syscon-reboot-mode: Fix module autoload
      power: reset: zx-reboot: Fix module autoload

Julia Lawall (2):
      power: supply: improve function-level documentation
      wm8350_power: use permission-specific DEVICE_ATTR variants

Liu Xiang (1):
      power: supply: max17040: Change register transaction length from 8 bits to 16 bits

Matt Ranostay (1):
      power: supply: bq27xxx_battery: don't update poll_interval param if same

Paul Burton (1):
      power: reset: Add Intel PIIX4 poweroff driver

Robert Jarzmik (1):
      power_supply: wm97xx_battery: use power_supply_get_drvdata

Russell King (1):
      power: ipaq_micro_battery: fix alias

Tony Lindgren (1):
      bq24190_charger: Fix PM runtime use for bq24190_battery_set_property

 drivers/input/touchscreen/wm97xx-core.c    |   2 +-
 drivers/power/reset/Kconfig                |  10 +++
 drivers/power/reset/Makefile               |   1 +
 drivers/power/reset/at91-poweroff.c        |   1 +
 drivers/power/reset/at91-reset.c           |   2 +
 drivers/power/reset/piix4-poweroff.c       | 113 +++++++++++++++++++++++++++++
 drivers/power/reset/syscon-reboot-mode.c   |   1 +
 drivers/power/reset/zx-reboot.c            |   1 +
 drivers/power/supply/ab8500_fg.c           |   8 +-
 drivers/power/supply/axp288_fuel_gauge.c   |   1 +
 drivers/power/supply/bq24190_charger.c     |   2 +-
 drivers/power/supply/bq27xxx_battery.c     |  44 ++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |   4 +-
 drivers/power/supply/ipaq_micro_battery.c  |   2 +-
 drivers/power/supply/lp8788-charger.c      |   3 -
 drivers/power/supply/max17040_battery.c    |  52 +++++--------
 drivers/power/supply/max8997_charger.c     |   1 +
 drivers/power/supply/power_supply_core.c   |   4 +-
 drivers/power/supply/wm8350_power.c        |   2 +-
 drivers/power/supply/wm97xx_battery.c      |  25 +++----
 include/linux/power/bq27xxx_battery.h      |   3 +-
 21 files changed, 217 insertions(+), 65 deletions(-)
 create mode 100644 drivers/power/reset/piix4-poweroff.c

--ytfwc7oz7hsm2spa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRTPkACgkQ2O7X88g7
+pr5zw/9Fw53BpE3QJZIyT3Q8AeMkH3SR9HBWDYUn31V65ZPlo7ll+w/cd8l9YaF
j2dOQ4nAoWK0p5cVvAbGP4Mx38Oc3gF59DkS7EoBXgEZ9yZOPp4qphSzNVLtw0V/
fDTYrhh1NlZKZLlUy5tEh/OG/7OCENCfuHp7qM4awPHdVxr137osaVzKVaiwrd6c
4uvx/PZ12letLn0xbgNaIEwM+2XOPzQoXcwoQYQqiFlEZHgbZsXwJaSscg4sziA2
PxzXMCx/UUx1nPoL/vKWtPPfuOYeZ+BFrrcyzF4JtyzztEOu6JxFCpPX06urCOjj
CH709qQoLgvKyLbopiqaAJ3US2j2/fxKZexD6E6b0wSTc8ZiWc+X+j/R1nOoXVy2
GOpBUfBd/ZaSsEt2dNg/qxBWTV6jSBT1Akx/bOQbCiTxv8BHemjcIfk49wIAibS7
ey/q8hZJPth22EJNcYAkEpVP4rxH9UzuwVy4eZseN2l2LtgN0goDc3ls6JDLfE2m
Kcnci2AQtWck6L+mBR0hVrDVynjYr9NR2snfdqGb/wWi5xmGG/5Di+bhjKpcQv9F
tGC4BMV+p11q+K69Bt99aXz3wMQOQhEqtT4RNJ9nruslzgidHIp1z98KV9t0n4Zv
BziiKlnf5XNBXCibsp9gFGFSGTe6qLn7FzVULrCfApZPswQhfls=
=l0+d
-----END PGP SIGNATURE-----

--ytfwc7oz7hsm2spa--
