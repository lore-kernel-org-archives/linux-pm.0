From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.12 (part 2)
Date: Fri, 12 May 2017 14:37:46 +0200
Message-ID: <20170512123746.6wjg4gfmzhttettf@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cnaznjeube5lglmq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdELMhv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 May 2017 08:37:51 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--cnaznjeube5lglmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The power-supply subsystem has a few more changes for
the v4.12 merge window.

-- Sebastian

The following changes since commit 6c381663bb3b4febc15b2fb33f046f0b986ce5c5:

  power: supply: bq24190_charger: Use new extcon_register_notifier_all() (2017-04-14 01:45:06 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.12-2

for you to fetch changes up to 35f4f99ccbc1ccf3a1f1157a5f2f14d6a7d1848f:

  power: supply: cpcap-charger: Keep trickle charger bits disabled (2017-05-04 17:52:00 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.12 series (part 2)

* New battery driver for AXP20X and AXP22X PMICs
* Improve max17042_battery for usage on x86
* Misc small cleanups & fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      power: supply: axp20x_usb_power: add IIO dependency

Colin Ian King (1):
      power: supply: ab8500_charger: spelling: "prechage" -> "precharge"

H. Nikolaus Schaller (2):
      power: supply: twl4030-charger: add writable INPUT_CURRENT_LIMIT property
      power: supply: twl4030-charger: don't check if battery is present

Hans de Goede (13):
      power: supply: bq24190_charger: Add disable-reset device-property
      power: supply: Make power_supply_am_i_supplied return -ENODEV if there are no suppliers
      power: supply: max17042_battery: Use sign_extend32 instead of DIY code
      power: supply: max17047_battery: The temp alert values are 8-bit 2's complement
      power: supply: max17042_battery: Add default platform_data fallback data
      power: supply: max17042_battery: Add support for the STATUS property
      power: supply: max17042_battery: Add external_power_changed callback
      power: supply: max17042_battery: Add support for the TECHNOLOGY attribute
      power: supply: max17042_battery: Add support for the VOLT_MIN property
      power: supply: max17042_battery: mAh readings depend on r_sns value
      power: supply: max17042_battery: Add support for the CHARGE_FULL_DESIGN property
      power: supply: max17042_battery: Add support for the CHARGE_NOW property
      power: supply: max17042_battery: Add support for the SCOPE property

Liam Breck (1):
      power: supply: bq24190_charger: Deprecate battery class and replicate its features in charger

Michael Trimarchi (1):
      power: supply: pda_power: move from timer to delayed_work

Pan Bian (1):
      power: supply: isp1704: Fix unchecked return value of devm_kzalloc

Paul Kocialkowski (2):
      power: supply: sbs-battery: Don't ignore the first external power change
      power: supply: sbs-battery: Correct supply status with current draw

Phil Reid (1):
      power: supply: sbs-battery: Add alert callback

Quentin Schulz (2):
      dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
      power: supply: add battery driver for AXP20X and AXP22X PMICs

Rahul Bedarkar (1):
      power: supply: generic-adc-battery: use SIMPLE_DEV_PM_OPS helper macro

Ryosuke Saito (1):
      power: supply: sbs-battery: fix the sbs interrupt request

Sebastian Reichel (3):
      power: supply: avoid unused twl4030-madc.h
      mailmap: add Sebastian Reichel
      power: supply: twl4030-charger: make twl4030_bci_property_is_writeable static

Tony Lindgren (4):
      power: supply: cpcap-charger: Fix charger name
      power: supply: cpcap-charger: Fix charge voltage configuration
      power: supply: cpcap-charger: Fix enable for 3.8V charge setting
      power: supply: cpcap-charger: Keep trickle charger bits disabled

 .mailmap                                           |   2 +
 .../bindings/power/supply/axp20x_battery.txt       |  20 +
 drivers/power/supply/Kconfig                       |  27 +-
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ab8500_charger.c              |   2 +-
 drivers/power/supply/axp20x_battery.c              | 502 +++++++++++++++++++++
 drivers/power/supply/bq24190_charger.c             | 149 ++++--
 drivers/power/supply/cpcap-charger.c               |  11 +-
 drivers/power/supply/generic-adc-battery.c         |  17 +-
 drivers/power/supply/isp1704_charger.c             |   4 +
 drivers/power/supply/max17042_battery.c            | 181 ++++++--
 drivers/power/supply/pda_power.c                   |  49 +-
 drivers/power/supply/power_supply_core.c           |  20 +-
 drivers/power/supply/rx51_battery.c                |   1 -
 drivers/power/supply/sbs-battery.c                 |  57 ++-
 drivers/power/supply/twl4030_charger.c             |  95 ++--
 drivers/power/supply/twl4030_madc_battery.c        |   1 -
 include/linux/power/max17042_battery.h             |   9 +-
 18 files changed, 975 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
 create mode 100644 drivers/power/supply/axp20x_battery.c

--cnaznjeube5lglmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkVrJQACgkQ2O7X88g7
+pqMhA//e40VjlUCJBpv5sIEf6YKYFb3utI60hAS+LKmeEsVfgTDSVtZIMQVZ8Bb
LPgBoxJcQZ1QIHMdOXIXU7H8a3eU76YcVAnyYnXXpH5JNsy0hQUJUmhaiuu0HxTo
UU+Rw57xBaEVPZURh+tsq3a+i/DthpZ49f8PEp4GmsmmK9e9cfRktU2pxXt6Htg+
QXBmw6Nzlo8RdyyZI4V4ktDXKKLi1/qiOsvmUUCn2+9cJ7/O3JJJ9xf1zPW/qdlD
vpMFkUvygz2tLziWqNslBIQCSS9hV9UGCrvicxijE/4Ge0KHwI4DpkcpQZSHA3X9
JYayeRi9ZNlYVCGnQNcKnXef6jyXUKj/7OJDkG7PJ4gUIl6ADYAjYSRb7fRRwroi
ZizqEn5t2CWkS2HfhirwigVPX0re0XNj2IX8T4wRANkIqsjX0ToMqsVJGdvCxyT3
/3AIGU5Xg6Fz2jBOUIxOk07ItW03iejL5XzcLfTLu/POdheN4Qu6gwnaifgwowkV
GaAhXDgiGqxlJFG0iooWeM2wwRKAM3nYRkAi/cU07jU1HYt5ZggCKMz91n+9/+vy
I9wuKJwHwGCa7yPbs6JQQ7KsAm8rKluwx36mHf08Y95SfNXhs/smdz30HpHCZSUf
mo6lj1c1BiHl5WHVTiySVW2PyZSHKD5y4uuWWeznumyoXLcXa8s=
=XV1V
-----END PGP SIGNATURE-----

--cnaznjeube5lglmq--
