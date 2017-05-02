From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.12-rc1 #1
Date: Mon, 1 May 2017 21:26:48 -0700
Message-ID: <20170502042645.GA18904@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rui,

Please pull the following changes to get the Thermal SoC updates
for 4.12-rc1. Here we have:
- Removal of non-DT booting on TI-SoC driver. Also, support to
fetching coefficients from DT.
- Refactoring of RCAR Gen3.
- New driver: support for BCM 2835.
- New driver: support for Broadcom Northstar.
- New folder for broadcom drivers.
- New driver: support for DA9062/61.
- Small fix on MTK thermal.

These branch has been gone through kernel-ci and linux-next.

BR,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal =
linus

for you to fetch changes up to 05d7839aa290901429d8edcd8f7974c9df2bcaa5:

  thermal: mt8173: minor mtk_thermal.c cleanups (2017-04-23 09:01:42 -0700)

----------------------------------------------------------------
Dawei Chien (1):
      thermal: mt8173: minor mtk_thermal.c cleanups

Keerthy (3):
      thermal: ti-soc-thermal: Fetch slope and offset from DT
      thermal: ti-soc-thermal: Remove redundant constants
      thermal: ti-soc-thermal: Remove redundant code

Niklas S=C3=B6derlund (7):
      thermal: rcar_gen3_thermal: add delay in .thermal_init on r8a7796
      thermal: rcar_gen3_thermal: remove unneeded mutex
      thermal: rcar_gen3_thermal: check that TSC exists before memory alloc=
ation
      thermal: rcar_gen3_thermal: record and check number of TSCs found
      thermal: rcar_gen3_thermal: enable hardware interrupts for trip points
      thermal: rcar_gen3_thermal: store device match data in private struct=
ure
      thermal: rcar_gen3_thermal: add suspend and resume support

Rafa=C5=82 Mi=C5=82ecki (4):
      dt-bindings: thermal: add support for Broadcom's Northstar thermal
      thermal: broadcom: add Northstar thermal driver
      thermal: broadcom: ns: specify myself as MODULE_AUTHOR
      thermal: bcm2835: move to the broadcom subdirectory

Stefan Wahren (2):
      dt-bindings: Add thermal zone to bcm2835-thermal example
      thermal: bcm2835: add thermal driver for bcm2835 SoC

Steve Twiss (2):
      Documentation: devicetree: thermal: da9062/61 TJUNC temperature bindi=
ng
      thermal: da9062/61: Thermal junction temperature monitoring driver

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  32 ++-
 .../devicetree/bindings/thermal/brcm,ns-thermal    |  37 +++
 .../devicetree/bindings/thermal/da9062-thermal.txt |  36 +++
 drivers/thermal/Kconfig                            |  15 +
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/broadcom/Kconfig                   |  16 ++
 drivers/thermal/broadcom/Makefile                  |   2 +
 drivers/thermal/broadcom/bcm2835_thermal.c         | 314 +++++++++++++++++=
+++
 drivers/thermal/broadcom/ns-thermal.c              | 106 +++++++
 drivers/thermal/da9062-thermal.c                   | 315 +++++++++++++++++=
++++
 drivers/thermal/mtk_thermal.c                      |   2 +-
 drivers/thermal/rcar_gen3_thermal.c                | 199 ++++++++++++-
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  10 -
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    |   4 -
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   6 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   4 -
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   4 -
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 158 +----------
 drivers/thermal/ti-soc-thermal/ti-thermal.h        |  16 --
 19 files changed, 1061 insertions(+), 217 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-therm=
al
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-therma=
l.txt
 create mode 100644 drivers/thermal/broadcom/Kconfig
 create mode 100644 drivers/thermal/broadcom/Makefile
 create mode 100644 drivers/thermal/broadcom/bcm2835_thermal.c
 create mode 100644 drivers/thermal/broadcom/ns-thermal.c
 create mode 100644 drivers/thermal/da9062-thermal.c

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCAp/AAoJEA6VkvSQfF5T/EEP/AiotunlBeChXOE6NoDEoZFU
2hrlCb7OkCBkXW87zhmPYH8rgwg7FZblVe/QN3rvVMoevtqrFfhU71cVwCdjmRXY
M+VoPErcKaW+J0rzXYz/+PiuDa1V6G8hdC3008LrLKULCTBMPSOgJaejyq/+jOeJ
SvISfPDyCiDD+byAeztnIAkAqNffuaFFR8hho5eKLxkXhXRsI5RChkel+1IRZmZU
jnM3bv38y1caGFwxoW42djB9uI4HUL1IYfLOgcwlodoyoFn4y+IetEJ9NC2H59t9
Hx9mfJnol3QWL8MUPqeph5KfqzYk4sKGADGtPaL86IO+ilvTxIDp0pPDh0FNq5Nc
p7gGxvNOC3zRkIsz5+x7mt2ctaLnkCRBUzI8QAa6qZ93ifK2XXGEbpyg4Plh4iCu
x5M1+bH9rqLFST0LFOVumyfS6KnLRo/3xtCzqes2zvdyaL35eedrqEUJ2iNTwV+Q
m71ORFXyZjLkKa2LJh42Q6YszQh5jPcR9GVM93ZuAyWmXUU2YZZBrFttmNfw89Kr
Ju3xz7/vm6MR6SpZnXJZMmYXAB9bUBj1fUvFVnHYWQVM5U7T3/BGGyE0wSo7+FAZ
AGCyvlRBKXk0Sp6XLnMfvnWPO4/uX9xpjwiufXOxNgHIUKoIrpj9RvEFgkZSQ3ni
x3sgZ5MpqmkPvGPLC4qO
=OMdZ
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
