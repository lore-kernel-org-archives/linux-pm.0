From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.8
Date: Mon, 25 Jul 2016 22:50:28 +0200
Message-ID: <20160725205027.GA30042@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60218 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbcGYUuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Jul 2016 16:50:35 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.8

for you to fetch changes up to 4fcd504edbf7c793325511c2df8dcd083958e28a:

  power: reset: add reboot mode driver (2016-07-06 17:16:27 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.8 series

 * introduce reboot mode driver
 * add DT support to max8903
 * add power supply support for axp221
 * misc. fixes

----------------------------------------------------------------
Andrew F. Davis (3):
      power_supply: bq27xxx_battery: Fix copy/paste error in header comment
      power_supply: bq27xxx_battery: Index register numbers by enum
      power_supply: bq27xxx_battery: Group register mappings into one table

Andy Yan (2):
      dt-bindings: power: reset: add document for reboot-mode driver
      power: reset: add reboot mode driver

Ben Dooks (1):
      power/reset: make syscon_poweroff() static

Chanwoo Choi (2):
      power: axp288_charger: Replace deprecatd API of extcon
      extcon: Remove the deprecated extcon functions

Chris Brand (1):
      docs: Move brcm,bcm21664-resetmgr.txt

Chris Lapa (7):
      max8903: store pointer to pdata instead of copying it.
      max8903: cleans up confusing relationship between dc_valid, dok and dcm.
      max8903: adds requesting of gpios.
      max8903: removes non zero validity checks on gpios.
      max8903: remove unnecessary 'out of memory' error message.
      max8903: adds documentation for device tree bindings.
      max8903: adds support for initiation via device tree

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for power supply device tree bindings

Hans de Goede (1):
      power: axp20x_usb: Add support for usb power-supply on axp22x pmics

Krzysztof Kozlowski (1):
      power: reset: keystone: Enable COMPILE_TEST

Rhyland Klein (1):
      power_supply: fix return value of get_property

Sebastian Reichel (1):
      Merge remote-tracking branch 'chanwoo-extcon/ib-extcon-powersupply-4.8' into psy-next

Stephen Boyd (1):
      power: qcom_smbb: Make an extcon for usb cable detection

 .../devicetree/bindings/power/max8903-charger.txt  |  25 ++
 .../{ => power}/reset/brcm,bcm21664-resetmgr.txt   |   0
 .../bindings/power/reset/reboot-mode.txt           |  25 ++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  35 +++
 .../bindings/power_supply/axp20x_usb_power.txt     |   3 +-
 MAINTAINERS                                        |   2 +
 drivers/extcon/extcon.c                            | 201 ++-------------
 drivers/power/Kconfig                              |   1 +
 drivers/power/axp20x_usb_power.c                   |  92 +++++--
 drivers/power/axp288_charger.c                     |  77 ++++--
 drivers/power/bq27xxx_battery.c                    | 284 ++++++++++-----------
 drivers/power/bq27xxx_battery_i2c.c                |   2 +-
 drivers/power/max8903_charger.c                    | 239 ++++++++++++-----
 drivers/power/power_supply_core.c                  |   6 +-
 drivers/power/power_supply_sysfs.c                 |   2 +-
 drivers/power/qcom_smbb.c                          |  21 ++
 drivers/power/reset/Kconfig                        |  17 +-
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 140 ++++++++++
 drivers/power/reset/reboot-mode.h                  |  14 +
 drivers/power/reset/syscon-poweroff.c              |   2 +-
 drivers/power/reset/syscon-reboot-mode.c           |  99 +++++++
 include/linux/extcon.h                             |  80 ++----
 include/linux/power/max8903_charger.h              |   6 +-
 include/linux/power_supply.h                       |   1 +
 25 files changed, 875 insertions(+), 501 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt
 rename Documentation/devicetree/bindings/{ => power}/reset/brcm,bcm21664-resetmgr.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXlnuPAAoJENju1/PIO/qaxYEP/16keT1vU5zn7L+6GOVO9KbQ
LUXRWI2x9rII+eHKFwoP6fDiQdNyQujwarTPRC0AUvIXj21n7rMt2t0gb57U/2LL
2Ibr2GGuh3An9UI7FHfUB6umBCsiJEog+IX65pzmp1FcQradmD1iFuNmlIwXNlph
CI/g5qG0/oqHWJu4XaD1LwJQNHgCbquwLwKDh961YXHhKlbcSBhzZoBlzFejgZ4W
/aa9Qa9hoXXVOII3XEoZQAt84QnX7G1ubmU8+2suUE1XDFUFmf80tykDZnhVKS9F
FyU9/SDly3C/rc/gzAypkRMWnzpkFGrKDxYRIwLtO5rzCUorvv0+AXbX5BNHKz6i
iDAnYhS5seF6RpPhHoIUANP+sEF5mN9PHGxP+kf2+SWF9Dzf4+yZUMjJdCs2FGbk
Ot092Eykechrw1posFa/yi5oYc+qonAjSN3FmqEvPKV2YcRWkm6zp0L3SXSYi3PZ
CEEBgkXd40HBZVvrKtBBlJkzYKUsHvu/8zJ8gjrEkSmwD3jhYMrBTrZBUN9lpoyy
LA5is+Fpo6lXYQpgcC9WpTkfl+CLL3iZxSfwIupVfUZ23YLPuIWzeSZNr1iqLF3r
RrMdTEis8qppnrhXqekKCuYeljZSR2JdLSDr9y+34rkysxrfcNGcYq1cJLiutDGn
kWhnBzYsDWv+oaCt3c7Z
=1z0q
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
