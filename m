From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.12
Date: Mon, 1 May 2017 10:33:15 +0200
Message-ID: <20170501083315.itn2hhuvunh45d3d@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ankmolxglvr6tx2f"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952059AbdEAIdV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 May 2017 04:33:21 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--ankmolxglvr6tx2f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit c02ed2e75ef4c74e41e421acb4ef1494671585e8:

  Linux 4.11-rc4 (2017-03-26 14:15:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/for-v4.12

for you to fetch changes up to 6c381663bb3b4febc15b2fb33f046f0b986ce5c5:

  power: supply: bq24190_charger: Use new extcon_register_notifier_all() (2=
017-04-14 01:45:06 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.12 series

* New drivers
 - gemini-poweroff
 - cpcap-charger (for Motorola Droid 4)
 - battery-lego-ev3 (for LEGO Mindstorms EV3)
* New chip/feature support
 - bq24190-charger: add runtime PM support
 - bq24190-charger: add bq24192i support
 - register masking for syscon-poweroff
* Misc. small fixes & cleanups

----------------------------------------------------------------
Andi Shyti (1):
      power: supply: charger-manager: simplify return statements

Andy Shevchenko (1):
      power: supply: bq25890: Use gpiod_get()

Arnd Bergmann (1):
      power: bq24190_charger: mark PM functions as __maybe_unused

Chanwoo Choi (1):
      extcon: Add new extcon_register_notifier_all() to monitor all externa=
l connectors

Daniel Perez (1):
      power: supply: sbs-charger: simplified bool function

David Lechner (2):
      dt-bindings: power: supply: New bindings for LEGO MINDSTORMS EV3 batt=
ery
      power: supply: New driver for LEGO MINDSTORMS EV3 battery

Dmitry Torokhov (1):
      power: supply: twl4030_charger: remove incorrect __exit markups

Enric Balletbo i Serra (2):
      dt-bindings: power/supply: rename max8925_batter.txt to max8925_batte=
ry.txt
      power: supply: tps65217: remove debug messages for function calls

Giedrius Statkevi=C4=8Dius (1):
      power: supply: lp8788: prevent out of bounds array access

Guy Shapiro (1):
      power: reset: syscon-poweroff: add a mask property

Hans de Goede (4):
      power: supply: bq24190_charger: Use i2c-core irq-mapping code
      power: supply: bq24190_charger: Add support for bq24192i
      power: supply: bq24190_charger: Use extcon to determine ilimit, 5v bo=
ost
      power: supply: bq24190_charger: Use new extcon_register_notifier_all()

Javier Martinez Canillas (3):
      power: supply: max17040: Add OF device ID table
      power: supply: ltc2941-battery-gauge: Add vendor to compatibles in bi=
nding
      power: supply: ltc2941-battery-gauge: Add OF device ID table

Liam Breck (4):
      power: supply: bq24190_charger: Limit over/under voltage fault logging
      power: supply: bq24190_charger: Clean up extcon code
      power: supply: bq24190_charger: Uniform pm_runtime_get() failure hand=
ling
      power: supply: bq24190_charger: Longer delay while polling reset flag

Linus Walleij (2):
      power: reset: Add Gemini poweroff DT bindings
      power: reset: Add a driver for the Gemini poweroff

Munir Contractor (1):
      power: supply: ab8500: Replaced spaces with tabs in indent

Sebastian Reichel (1):
      Merge remote-tracking branch 'chanwoo-extcon/ib-extcon-4.12' into psy=
-next

Tony Lindgren (3):
      power: bq24190_charger: Check the interrupt status on resume
      power: bq24190_charger: Use PM runtime autosuspend
      power: supply: cpcap-charger: Add minimal CPCAP PMIC battery charger

 .../bindings/power/reset/gemini-poweroff.txt       |  17 +
 .../bindings/power/reset/syscon-poweroff.txt       |  11 +-
 .../bindings/power/supply/cpcap-charger.txt        |  37 ++
 .../bindings/power/supply/lego_ev3_battery.txt     |  21 +
 .../devicetree/bindings/power/supply/ltc2941.txt   |   6 +-
 .../{max8925_batter.txt =3D> max8925_battery.txt}    |   0
 drivers/extcon/devres.c                            |  61 ++
 drivers/extcon/extcon.c                            |  66 ++
 drivers/extcon/extcon.h                            |   3 +
 drivers/power/reset/Kconfig                        |   9 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/gemini-poweroff.c              | 160 +++++
 drivers/power/reset/syscon-poweroff.c              |  19 +-
 drivers/power/supply/Kconfig                       |  15 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/ab8500_bmdata.c               |   8 +-
 drivers/power/supply/bq24190_charger.c             | 427 +++++++++----
 drivers/power/supply/bq25890_charger.c             |   2 +-
 drivers/power/supply/charger-manager.c             |  35 +-
 drivers/power/supply/cpcap-charger.c               | 681 +++++++++++++++++=
++++
 drivers/power/supply/lego_ev3_battery.c            | 228 +++++++
 drivers/power/supply/lp8788-charger.c              |   2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |  19 +-
 drivers/power/supply/max17040_battery.c            |   8 +
 drivers/power/supply/sbs-charger.c                 |   5 +-
 drivers/power/supply/tps65217_charger.c            |   4 -
 drivers/power/supply/twl4030_charger.c             |   4 +-
 include/linux/extcon.h                             |  21 +-
 include/linux/power/bq24190_charger.h              |  16 -
 29 files changed, 1691 insertions(+), 197 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/gemini-po=
weroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-ch=
arger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3=
_battery.txt
 rename Documentation/devicetree/bindings/power/supply/{max8925_batter.txt =
=3D> max8925_battery.txt} (100%)
 create mode 100644 drivers/power/reset/gemini-poweroff.c
 create mode 100644 drivers/power/supply/cpcap-charger.c
 create mode 100644 drivers/power/supply/lego_ev3_battery.c
 delete mode 100644 include/linux/power/bq24190_charger.h

--ankmolxglvr6tx2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkG8ssACgkQ2O7X88g7
+pomRw//WjHURaCRMezRb7hGEffORFZsCZTJ6a8sQNyBcMro+RG6wY8ehuroJ8Og
XXnz/u94xC7VgBeJ7pNOyFix21uWhORTTBvo6fWr9w/F7Qm9XIvgJURN2lOQujwE
3mMEgVkPB/zb1cyRljUhCUG+Cq2nPL71zOMaFTE9/BTP9UFLuyo8XJyPmMtt642B
8LFhuJI3vi1gP4qoFMSkddOHZpAWniXoC/oGOwFLw4SNTG9Y6UtJl4yLtc9ewQhK
PkDPlf1HStiNxqN6Qap+oDRqc2tx73a/3YWK17KgmZeZ8XiKSbsfpk7vajgSsadh
50fh50/YcuezpwEC62YXbL7akSmm9Bwce9u3LRrEC+gvp47sad0Sy7RmCwG/7/SU
8LNsizaEQxj7orgxBLUZbbSyi2kjUI5bLwSpeljvciRE8S57LVYAMNEnps7CeYIX
Wp3ZmmLlX2MOkaxTpwdIBZCiwXono/WfkQ/Ko0cK+OzLVL8HfxKGd0GjuBEWecCa
AauvrUyPFvitAw8oiPcJOPG3MQwsPyyCiyw6O6LlaLgXiA9fMF5D9ObOua2FXGAY
6clL+6dl4YZBtZWA2cqxsUCeycJ0HYH4Zqr2II2Gm0kgEK53Ok04SyPgtqZufsRH
OmLrRI+B/XXJ5qkJ8b07o9juT3loPuqn1uuI+WI1iopPDhWKVMo=
=qEBg
-----END PGP SIGNATURE-----

--ankmolxglvr6tx2f--
