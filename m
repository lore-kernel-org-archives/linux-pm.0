From: Sebastian Reichel <sre@ring0.de>
Subject: [GIT PULL] power supply changes for 4.2
Date: Tue, 23 Jun 2015 02:53:03 +0200
Message-ID: <20150623005302.GB24028@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:58175 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbbFWAxH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Jun 2015 20:53:07 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.infradead.org/battery-2.6.git tags/for-4.2

for you to fetch changes up to 43df61051ab9af985ec439ee9be9c299e7de34e8:

  power_supply: Correct kerneldoc copy paste errors (2015-06-19 14:21:01 +0=
200)

----------------------------------------------------------------
power supply and reset changes for the v4.2 series

 * New charger drivers: BQ24257, BQ25890, AXP288, RT9455
 * MAX17042 battery: add health & temperature support
 * BQ2415x charger: add ACPI support
 * misc. fixes and cleanups

----------------------------------------------------------------
Anda-Maria Nicolae (7):
      power_supply: bq2415x_charger: Fix coding style issues
      power_supply: bq2415x_charger: Add ACPI support
      of: Add vendor prefix for Richtek Technology Corporation
      Documentation: devicetree: Add Richtek RT9455 bindings
      power_supply: Add support for Richtek RT9455 battery charger
      power_supply: rt9455_charger: Check if CONFIG_USB_PHY is enabled
      power_supply: rt9455_charger: Fix error reported by static analysis t=
ool

Bjorn Andersson (1):
      power_supply: Correct kerneldoc copy paste errors

Frans Klaver (1):
      sbs-battery: add option to always register battery

Hans de Goede (1):
      power: Add devm_power_supply_get_by_phandle() helper function

Heiko St=FCbner (1):
      power: reset: gpio-restart: increase priority slightly

Krzysztof Kozlowski (8):
      power_supply: Fix NULL pointer dereference during bq27x00_battery pro=
be
      power_supply: Fix possible NULL pointer dereference on early uevent
      power: axp288_fuel_gauge: Constify platform_device_id
      power: at91-reset: Constify platform_device_id
      power_supply: Use wrappers to avoid races when registering power supp=
ly
      power_supply: charger-manager: Add parent for power supply
      power_supply: sysfs: Bring back write to writeable properties
      power_supply: max17042: Add OF support for setting thresholds

Laurentiu Palcu (4):
      power_supply: Add TI BQ24257 charger driver
      Documentation: devicetree: Add TI BQ25890 bindings
      power_supply: Add support for TI BQ25890 charger chip
      power_supply: bq25890: make chip_id int

Ramakrishna Pallala (2):
      power: max17042_battery: add HEALTH and TEMP_* properties support
      power: axp288_charger: axp288 charger driver

Takeshi Yoshimura (2):
      power_supply: 88pm860x_charger: Do not call free_irq() twice
      wm831x_power: Fix off-by-one at free_irq()

Thomas Elste (1):
      power: bq24190_charger: Change first_time flag reset condition

Uwe Kleine-K=F6nig (4):
      power: reset: gpio-poweroff: let devm_gpiod_get set direction of gpio
      power: reset: ltc2952: use _optional variant of devm_gpiod_get
      power_supply: bq25890: use flags argument of devm_gpiod_get
      power_supply: bq24257: use flags argument of devm_gpiod_get

 Documentation/devicetree/bindings/power/bq24257.txt                 |   21=
 ++
 Documentation/devicetree/bindings/power/bq25890.txt                 |   46=
 +++
 Documentation/devicetree/bindings/power/rt9455_charger.txt          |   48=
 +++
 Documentation/devicetree/bindings/power_supply/max17042_battery.txt |   13=
 +
 Documentation/devicetree/bindings/vendor-prefixes.txt               |    1=
 +
 drivers/power/88pm860x_charger.c                                    |    1=
 -
 drivers/power/Kconfig                                               |   28=
 ++
 drivers/power/Makefile                                              |    4=
 +
 drivers/power/axp288_charger.c                                      |  941=
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/axp288_fuel_gauge.c                                   |    2=
 +-
 drivers/power/bq2415x_charger.c                                     |   94=
 ++++--
 drivers/power/bq24190_charger.c                                     |   11=
 +-
 drivers/power/bq24257_charger.c                                     |  858=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/bq25890_charger.c                                     |  994=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/charger-manager.c                                     |    3=
 +-
 drivers/power/max17042_battery.c                                    |  199=
 +++++++++++-
 drivers/power/power_supply_core.c                                   |  106=
 ++++++-
 drivers/power/power_supply_leds.c                                   |    4=
 +-
 drivers/power/power_supply_sysfs.c                                  |    4=
 +-
 drivers/power/reset/at91-reset.c                                    |    2=
 +-
 drivers/power/reset/gpio-poweroff.c                                 |   25=
 +-
 drivers/power/reset/gpio-restart.c                                  |    2=
 +-
 drivers/power/reset/ltc2952-poweroff.c                              |    7=
 +-
 drivers/power/rt9455_charger.c                                      | 1752=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++
 drivers/power/sbs-battery.c                                         |   21=
 +-
 drivers/power/wm831x_power.c                                        |    1=
 +
 include/linux/mfd/axp20x.h                                          |    7=
 +
 include/linux/power/max17042_battery.h                              |    4=
 +
 include/linux/power_supply.h                                        |   11=
 +
 29 files changed, 5122 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/bq24257.txt
 create mode 100644 Documentation/devicetree/bindings/power/bq25890.txt
 create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.=
txt
 create mode 100644 drivers/power/axp288_charger.c
 create mode 100644 drivers/power/bq24257_charger.c
 create mode 100644 drivers/power/bq25890_charger.c
 create mode 100644 drivers/power/rt9455_charger.c

-- Sebastian

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJViK3uAAoJENju1/PIO/qalBIP/3IBwNPrx/tU7l/cpa3LVTxW
QGIGHRMRhZ/VuGdUU+xvaC+NSPmZuySQlUdE1I+6UDcMazfBP0pKyJ8hkjjvSxHi
y12sPAz6soJNd52Sgx7U6Suw0tv3s1FM3GzTR+jTCLyvuf6iQh9qMToWvTdXARyW
UNYlrhk2nuWTlrM2mWB87Emszr0Va6oVoYHjoG1OU1vXrJXpmS9nLVxXl8z61YdT
PQ2UNMHkqdaatHRbkSPR0oE6/gY/j9BSPmMXRue5/ylGlPXCHMUQUiA2BW1zbEzk
RF3cdhdd1hyulaQWxTps/VMJQrCL4IByovW1maO6Myr9rE5KKjNvJ8dTlmh1Mfvu
sEbOJSXVqa7MBHY7mZt/RRc6pnekCY7gRZH8CkSmwduDkgemtdsmDYp+PeKEiTy+
MVb3QbTvB5SJ3in10t8oNOhwH1F2XCNbxdkdGE91LKFEWrwhJX7WqgRWeyF7TkRF
ouXks+aNTzDlz7bJgQ7VPMRE+tmvXJGA9NTgutJDjHXucK4pbbsjJpDSJR9tlVPT
fyD6rZZDhCVgcO2XsTk41PgNieXGAmoicTZGjHnBrs4aIt+TSrvhmBBdGozwXMuF
axT0bKTMTaXqGNt1dvBzGoYUZpUYDXettln4CygAF8q3K/kLDvpqRUhEJAeQe4PS
Y9/8KR0wu0JRpX5owCt4
=AAjX
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
