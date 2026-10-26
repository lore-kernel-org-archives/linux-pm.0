Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033576;
	b=zjDWBW4x/7pgAtA0WznpMWLOrirOKYSB/jh9MFeJxW21zrK/ESxr09zVVSVLlqSqbC+c
	 De5aAUkMt6rhXgwCUO8PTEr2PQ5q2V0FY0Xme8kLdIUryku3HQw82oZlcxaGNIraSV5y3
	 rBwlHdV2aPsllOG8n8KTXbaqWNW9+9JGganJd7bWnk4p1FLIK5Y8NkXJfHpd00BlVbHg2
	 pgBKVztEZ90deoXhK1CANIdkwk4XhHkqzXv106/C4mTDdX0XKbArxmKmh7qetkBKoZ+Mo
	 I8BLTnKL4RPv3Hsfh+r6zahje5h5v6Bt6L4t3/7/M4DYUAwmyzi2gG4ghGN1lbw5dnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033576;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=V8PvGXZ7VCsMB0ruiPuEvtUOu6j7X/roxqJhe5mrWAM=;
	b=RvvZAWF47ZUNtpr36xrGGArRreIta4RFxB2HsVBRU+zPnve94xYRUapKkk8sPQp1izk5
	 8/BJxBI/cWYfdkWSW1m1g0s68A4lpvZmpMWTb6dl5VitvB8ZKOBgCxMHCKglqdqAfTjaU
	 f/zjDt8SN8pmOAchJdkQz9n8my1lO7RbIykI9z4Tb1DacTf/cHdecYB70x3uhonaG5Ujm
	 NzjPpevWYTvbqVa8temwz4RxANbhkSvo6a5YmhV2hbINnVh0hDqxzyXVtkXS+SofNO2aF
	 EE5b/QU/LAMMrUIy4vgEf8vBVSvVSLIBWOzpTyYuUAXOP2P2JtungBXwu115gHQF4Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WL4CmMux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179C606A31A;
	Mon, 26 Oct 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WL4CmMux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955B01F01825;
	Mon, 26 Oct 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793033575;
	bh=V8PvGXZ7VCsMB0ruiPuEvtUOu6j7X/roxqJhe5mrWAM=;
	h=Date:From:To:Cc:Subject;
	b=WL4CmMuxAg/ZGy1bOfU+tg5BTB9JnMCnrkHeqRyBoXqp7WSDJdXJFfDDroRm6k81Y
	 PQRhCuvVFoTJeIMmE4UaFhoYty5CzTeUyKuncx1eQtLFLRUS4nDEUhYTnRFyuZeXi+
	 TtOb/YQWAcVYlLJ6jme7uBfPlpMdWWgy7d29JhpfDURIQ3aDI5tpqvH7xpW6vlHfYD
	 RG/BkAN7fWEpAFXx5FaMyGZpkxqZlzcfh73uHn1sv82ZiC06eDqHKaePjNW9dxn5F+
	 TV0ai87s9Bg+FbIU609n9yL8V418U0iRQo1d5KFWpw60QXU5NsWaw87mWhc9EfN/XH
	 Vm52pdlURzuww==
Received: by venus (Postfix, from userid 1000)
	id 821BC1806C8; Mon, 26 Oct 2026 17:52:53 +0100 (CET)
Date: Mon, 26 Oct 2026 17:52:53 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.4
Message-ID: <at-FRLALI5DhW7Lh@venus>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bw5hswutkyqd2qag"
Content-Disposition: inline


--bw5hswutkyqd2qag
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 7.4
MIME-Version: 1.0

Hi Linus,

The following changes since commit 5b4bd13e0552926648a46c2c9a12a24dfaee3715:

  power: supply: core: prevent unregistering a power supply while a callbac=
k runs (2026-10-04 18:49:02 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v7.4

for you to fetch changes up to f0f400459bf6a037e70768de623fff3f8920b8bb:

  power: supply: gpio-charger: Report discharging without input power (2026=
-10-18 12:21:00 +0200)

----------------------------------------------------------------
power supply and reset changes for the 7.4 series

 * power-supply core
  - introduce LOAD_SWITCH property
  - pack power_supply_desc to optimize memory
  - prevent power-supply device unregistration while callback runs
  - drop last CONFIG_OF build-time dependencies from the core
  - documentation fixes
 * power-supply drivers
  - bq27xxx: add support for bq27z746, bq28z620
  - ab8500: add AB8505 support
  - bq257xx: fix probe time configuration race condition
  - multiple: convert drivers with custom LOAD_SWITCH properties to the
    new standard one
  - cros_charge-control: restore EC state on resume
  - qcom_battmgr: fix USB type reporting, notify charger online state,
    report full batteries and correct capacity on X1E
  - gpio-charger: always report as discharging if input power is missing
  - bq24190_charger: don't reset registers across system suspend
  - qcom_smbx: a lot of independent fixes
  - lots of error and module removal path fixes
  - misc. fixes
 * reset drivers
  - misc. fixes

----------------------------------------------------------------
Alexey Charkov (5):
      dt-bindings: power: supply: bq27xxx: add BQ28Z620
      power: supply: bq27xxx: add support for BQ28Z620
      power: supply: bq257xx: Use psy directly instead of driver data
      power: supply: bq257xx: Convert parameters setup to the new .init cal=
lback
      power: supply: bq257xx: Describe the dev field in the driver data str=
ucture

Andrew Pam (1):
      power: supply: cros_charge-control: restore EC state on resume

Babanpreet Singh (1):
      power: supply: max17042_battery: Make the fractional macros safe

Bjorn Andersson (1):
      power: supply: qcom_battmgr: report full batteries

Brandon Williams (1):
      power: supply: qcom_battmgr: Notify charger supplies of online changes

Daniel Lezcano (1):
      power: supply: Fix power limit documentation

Derek J. Clark (1):
      Documentation: sysfs-class-power: Update Long_Life description

Fabricio Akio (1):
      power: supply: qcom_smbx: set the charge enable after software control

Fan Wu (1):
      power: supply: bq27xxx: Ensure poll work is cancelled on remove

Hang Nan (1):
      power_supply: serialize property access with unregister

Hemanth Selam (2):
      power: reset: keystone: fix missing space in error message
      power: supply: fix typos in comments

Henrik Grimler (3):
      dt-bindings: power: bq27xxx: bq27z561: allow interrupts property
      dt-bindings: power: bq27xxx: document bq27z746
      power: supply: bq27xxx: add support for bq27z746

Igor Velkov (1):
      power: supply: gpio-charger: Report discharging without input power

Iv=E1n Ezequiel Rodriguez (4):
      power: supply: return -ENOMEM on OCV table alloc failure
      power: supply: restore hwmon if extension update fails
      docs: power: supply: fix power_supply_class.rst status, health and ti=
me_to
      power: supply: use tabs in power_supply_get_property_direct

Joonhoe Kim (1):
      power: supply: qcom_battmgr: report the USB type from USB_ADAP_TYPE

Karl Mehltretter (1):
      power: supply: mp2629: Use the full batt_impedance_compensation name =
in the ABI document

Kees Cook (1):
      power: supply: qcom_smbx: Remove const from desc allocation type

Linmao Li (1):
      power: supply: bq2515x: Propagate charge-enable read errors

Linus Walleij (16):
      dt-bindings: power: supply: ab8500: Add AB8505 charger
      power: supply: ab8500_fg: Accept status from supplied power
      power: supply: ab8500_fg: Report sub-percent charge changes
      power: supply: ab8500: Correct register definitions
      power: supply: ab8500_fg: Drop nonexistent AB8505 controls
      power: supply: ab8500_btemp: Fix event temperature reporting
      power: supply: ab8500: Preserve battery termination current
      power: supply: ab8500_charger: Fix AC charger re-enable
      power: supply: ab8500_charger: Decode AB8505 USB status
      power: supply: ab8500_charger: Respect AB8505 register layout
      power: supply: ab8500_charger: Handle detection errors
      power: supply: ab8500_charger: Skip absent AB8505 main charger
      power: supply: ab8500_charger: Retry AB8505 USB detection
      power: supply: ab8500_charger: Recover inactive AB8505 charger
      power: supply: ab8500_fg: Finalize current measurements
      power: supply: ab8500_fg: Avoid reserved AB8505 CCConf bit

Liviu Nicoara (1):
      power: supply: qcom_battmgr: Report capacity on X1E80100

Matt DeVillier (1):
      power: supply: cros_charge-control: adopt EC charge state on probe

Maurizio Casciano (1):
      power: supply: core: Honor supplied-from with CONFIG_OF=3Dy

Myeonghun Pak (2):
      power: supply: pf1550: drain IRQ work before unregistering supplies
      power: supply: sbs-battery: disable polling before supply teardown

Reza Kurniawan (1):
      power: supply: bq256xx: Expose VBUS state through extcon

Robert Killick (1):
      power: supply: sysfs: Ratelimit "unavailable enum value" warning

Robin Snyders (5):
      power: supply: qcom_smbx: include base when petting watchdog
      power: supply: qcom_smbx: test battery health status bits
      power: supply: qcom_smbx: fix float voltage selector
      power: supply: qcom_smbx: validate battery float voltage
      power: supply: qcom_smbx: notify battery overvoltage recovery

Ryan Brue (3):
      power: supply: bq24190_charger: use the wake irq API
      power: supply: bq24190_charger: don't reset registers across system s=
uspend
      dt-bindings: power: supply: battery: allow 101 ocv-capacity points

Sebastian Reichel (1):
      Merge power-supply fixes branch

Shengzhuo Wei (1):
      power: supply: bq27xxx: synchronize work cancellation on suspend

Sumeet Pawnikar (1):
      power: Use %pe to print error pointers symbolically

Tim Douglas (1):
      power: supply: generic-adc-battery: fix status with no supplier

Uwe Kleine-K=F6nig (3):
      power: supply: axp20x*: Drop check for disabled devices
      power: supply: axp20x_usb: Introduce a helper variable for &pdev->dev
      power: supply: axp20x_usb: Improve probe error reporting

Waqar Hameed (8):
      power: supply: Pack power_supply_desc to eliminate holes
      power: supply: Add sysfs entry for system load control
      power: supply: ltc4162-l: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      power: supply: rt9471: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      power: supply: rt9467: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      power: supply: bq24257: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      power: supply: bq24190: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      power: supply: bq25630: Add support for BATFET control

Wentao Liang (1):
      power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_pro=
be()

Zongmin Zhou (1):
      power: supply: s2mu005-battery: return errors from dev_err_probe() in=
 probe

bui duc phuc (1):
      power: supply: generic-adc-battery: Propagate charged GPIO errors

hpp.iscas (1):
      power: supply: mm8013: Publish the OF module alias

 Documentation/ABI/testing/sysfs-class-power        |  49 ++-
 .../ABI/testing/sysfs-class-power-ltc4162l         |   2 +
 Documentation/ABI/testing/sysfs-class-power-mp2629 |   2 +-
 Documentation/ABI/testing/sysfs-class-power-rt9467 |   2 +
 Documentation/ABI/testing/sysfs-class-power-rt9471 |   2 +
 .../devicetree/bindings/power/supply/battery.yaml  |   3 +-
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |   4 +-
 .../power/supply/stericsson,ab8500-charger.yaml    |  76 +++-
 Documentation/power/power_supply_class.rst         |  23 +-
 drivers/power/reset/keystone-reset.c               |   3 +-
 drivers/power/reset/macsmc-reboot.c                |   4 +-
 drivers/power/supply/Kconfig                       |   1 +
 drivers/power/supply/ab8500-bm.h                   |   8 +-
 drivers/power/supply/ab8500_bmdata.c               |   3 +-
 drivers/power/supply/ab8500_btemp.c                |  30 +-
 drivers/power/supply/ab8500_chargalg.c             |   9 +-
 drivers/power/supply/ab8500_charger.c              | 406 +++++++++++++++++=
+---
 drivers/power/supply/ab8500_fg.c                   | 181 +++------
 drivers/power/supply/axp20x_ac_power.c             |   3 -
 drivers/power/supply/axp20x_battery.c              |   3 -
 drivers/power/supply/axp20x_usb_power.c            |  50 +--
 drivers/power/supply/bq24190_charger.c             | 101 +++--
 drivers/power/supply/bq24257_charger.c             |  43 ++-
 drivers/power/supply/bq2515x_charger.c             |  15 +-
 drivers/power/supply/bq25630_charger.c             |  84 +++++
 drivers/power/supply/bq256xx_charger.c             |  96 ++++-
 drivers/power/supply/bq257xx_charger.c             | 125 +++----
 drivers/power/supply/bq25890_charger.c             |   2 +-
 drivers/power/supply/bq27xxx_battery.c             |  24 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   4 +
 drivers/power/supply/charger-manager.c             |   2 +-
 drivers/power/supply/cpcap-charger.c               |   4 +-
 drivers/power/supply/cros_charge-control.c         | 186 +++++++++-
 drivers/power/supply/da9030_battery.c              |   2 +-
 drivers/power/supply/generic-adc-battery.c         |   5 +-
 drivers/power/supply/gpio-charger.c                |   5 +-
 drivers/power/supply/intel_dc_ti_battery.c         |   2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |   6 +-
 drivers/power/supply/ltc4162-l-charger.c           |  56 ++-
 drivers/power/supply/max17042_battery.c            |  28 +-
 drivers/power/supply/mm8013.c                      |   1 +
 drivers/power/supply/pf1550-charger.c              |  32 +-
 drivers/power/supply/power_supply_core.c           | 110 +++---
 drivers/power/supply/power_supply_sysfs.c          |  20 +-
 drivers/power/supply/qcom_battmgr.c                |  53 ++-
 drivers/power/supply/qcom_smbx.c                   | 113 ++++--
 drivers/power/supply/rt9467-charger.c              |  54 ++-
 drivers/power/supply/rt9471.c                      |  54 ++-
 drivers/power/supply/s2mu005-battery.c             |   4 +-
 drivers/power/supply/sbs-battery.c                 |  11 +
 drivers/power/supply/sbs-charger.c                 |   4 +-
 drivers/power/supply/smb347-charger.c              |   4 +-
 include/linux/power/bq27xxx_battery.h              |   2 +
 include/linux/power_supply.h                       |  18 +-
 54 files changed, 1566 insertions(+), 568 deletions(-)

--bw5hswutkyqd2qag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrfhV0ACgkQ2O7X88g7
+pqsJA/+IyBcvqAxPLwmWikOcPItSgyJan8EeZei/qous06suzUOVIIUdRhstuno
kLR86W5Cj02qN8V72/eTCZSwxvOZ6Y3b/WZYBgxi/bOlNMjN4BZqshPVqntplfxc
N2eklVBVbHEAqUGxveyCcsT6zd0K7YZHPURjCrNL59KUDbm3/GwLOIOvN40TD6uW
t+W0ukQGkof+QHBRLF9hHgOtigrLOYm85Ax0gX1c+hEXmZ5WijVCQuiYmjaPnjdm
VyWGbCIWvDr34/+vz/MnkLjbJ8QXDSX6I5In8/qrRC0Z3K25NYaMQBPSP6J4dZpX
Mn92+hY3ZjfJXhFclTJ0vxC/Vqay0SxhLPb2b1eXUZ4X4gp43C0TzzySQQseGMoz
DjHvtz6JQGweYIiPQ1zfW7TWHMkZoKrQjV51ECBcRjrlVjWxnR+3baeo0bqXN9Wk
LQ3Egq3I1XiLw9vS4Y13/sENwGXpgt11YM2WS9CUp+bLUeOag61CMr0t034iLSRI
yyXYhALq1kGUFw3wN3iY3+hTGnM9pvS2xBxMrAmj6akqQ+K1PnM7bs8fVNI2yzeQ
TJv+X/9mFxK+AgCfry+ZoMZ8untJJISXRtLK3zkG/SDtjzsD9yby6m/MloWXC3CT
2TFrKfZSgzwHp7sfe1yv5ayyRnElZBndZ1xyYJj5yxtxi4Zy7V8=
=0mhb
-----END PGP SIGNATURE-----

--bw5hswutkyqd2qag--
