Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DB3B14D7;
	Fri, 21 Aug 2026 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318157; cv=none; b=iRFLPLcxcFj8sTX+tyyDU3pgQBcPNzG+vEUDKRFCEVtplBF74wBDvJRFhKBDnS1Pfj5HoIZI0a+BkHsbAuxnpl/SJfg2y5LULSBWm00Z3Z1JlYhc0iamAEfRa90SmPkn9CWV848o3cwHglSbj+zROkyT3vlWe6CgilVOwM+DSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318157; c=relaxed/simple;
	bh=5gQPKAoQCHJIh8xG1mjG0bnsIkmGb081DknXGwJZ2sY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gtf0O2SyeNFnD9sjDBMcqWRc70lPTpYpzk+jdiax7uVmT9MUCMut6ALPmR0tOIqEAlKjH2e8VjYxRaBynTPqwwJBFRjXKT/RgYwfrcOHCAX1xFcjTjPvL09G6K9MKGqsyfD7nIHmg+pO8hSV9WxwPRAep1fpiKJ7tl3UZbpUsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZS723qJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZS723qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3951F000E9;
	Fri, 21 Aug 2026 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787318131;
	bh=0Jb4Bqg33g3p+uIvJwDBOfDlQCFR32GFV3r+DpCLZNQ=;
	h=Date:From:To:Cc:Subject;
	b=dZS723qJcxkw9CcC046PIC/oGTNYyN8B0xn09cLQsDk4FxrCFi8hzma9/oOfaQIfi
	 qrJHv90xHNZPtGY0dWEfjaoahkqiDUAFfrM4l3+f+F6wbf3F1tFiolysIGQKXyZYBg
	 SUEcSVpWtCNtBpYBEHWDZrG8heJG4K74+jNnppfMMMLEIWJm8Pbejssc4c9VrUi332
	 HGjPMnfwR6XuO509JEsAQj7Kb5DXgeHucCbQ0nSZilTg30ZwouLCE58Gs9ZiafImbL
	 J/DQXqayJdN76Q5ckygX7f9u7Bf4GhqWQmJ1ghyZvD3cotk1riFx+6AGyo2hTdACV+
	 EhIPq2i/cSMwA==
Received: by venus (Postfix, from userid 1000)
	id D6B90181F47; Fri, 21 Aug 2026 15:15:29 +0200 (CEST)
Date: Fri, 21 Aug 2026 15:15:29 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.3
Message-ID: <aohPKghrdr9zgDa2@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7atiawyd7e5yl26"
Content-Disposition: inline


--s7atiawyd7e5yl26
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] power-supply changes for 7.3
MIME-Version: 1.0

Hi Linus,

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.3

for you to fetch changes up to 2da28b059e0ddcd2e1956eeae383246207965573:

  power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address (2026-08-13 00:08:50 +0200)

----------------------------------------------------------------
power supply and reset changes for the 7.3 series

 * power-supply core
  - Add PbAc, NiZn, RAM, and ZnAr battery chemistry types
  - Create LED triggers based on properties instead of device type
  - Provide power_supply_get_system_batteries() for usage with USB-C
  - Add registration init callback for race-free device setup
 * power-supply drivers
  - new TI BQ25630 charger driver
  - new SG Micro sgm41542 charger driver
  - bq257xx: Add support for BQ25792
  - max8903: add DC and USB input current-limit controls
  - max17042_battery: Initialize MAX17055 from battery info
  - sbs-battery: map newly introduced battery chemistries
  - drop extra error messages for IRQ request failures
  - lot's of driver removal race condition fixes
  - misc. small cleanups and fixes
 * reset drivers
  - add MCF5441x RCM power-on reason driver
  - misc. small cleanups and fixes

----------------------------------------------------------------
Alexey Charkov (1):
      power: supply: bq257xx: Add support for BQ25792

Amit Sunil Dhamne (1):
      power: supply: Add helpers to get and put arrays of power supply handles

Anas Khan (1):
      power: supply: bq256xx: drop always-true inner condition

Babanpreet Singh (2):
      power: supply: sbs-battery: Use a per-device serial number buffer
      power: supply: sbs-battery: Bound the serial number conversion to 16 bits

Boris Shtrasman (3):
      selftests: helpers: handle multi line in test_sysfs_prop_optional_list
      power: supply: Add PbAc, NiZn, RAM, and ZnAr support
      power: supply: sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support

Bryam Vargas (1):
      power: supply: cros_usbpd-charger: bound the EC-reported port count

Chris Morgan (2):
      dt-bindings: power: supply: sgm41542: document sgm41542
      power: supply: sgm41542: Add SG Micro sgm41542 charger

Elson Serrao (1):
      power: supply: add stubs for notifier registration helpers

Fan Wu (9):
      power: supply: rt9455: quiesce delayed work before teardown
      power: supply: charger-manager: register regulators before exposing sysfs
      power: supply: qcom_battmgr: fix use-after-free
      power: supply: bq24257: fix use-after-free on remove
      power: supply: ab8500_fg: fix use-after-free on remove
      power: supply: lp8788-charger: fix use-after-free on remove
      power: supply: ucs1002: fix use-after-free on remove
      power: supply: bq256xx: drain usb_work before freeing the charger
      power: supply: lp8727: fix use-after-free in lp8727_release_irq()

Henrik Grimler (3):
      power: supply: bq27xxx: bq27520g4: fix REG_TTES address
      power: supply: bq27xxx: bq28z610: fix invalid AverageEnergy address
      power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address

Herman van Hazendonk (2):
      dt-bindings: power: supply: maxim,max8903: add DC and USB input current-limit controls
      power: supply: max8903: add DC and USB input current-limit GPIO controls

Hongyan Xu (2):
      power: supply: isp1704_charger: cancel work on remove
      power: supply: sc2731_charger: cancel work on remove

HyeongJun An (1):
      power: supply: qcom_battmgr: terminate the strings from firmware

Jameson Thies (1):
      power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS

Jean-Michel Hautbois (1):
      power: reset: add MCF5441x RCM power-on reason driver

Jianing Li (3):
      power: supply: max17040: propagate register read errors
      power: supply: max17040: drop incorrect I2C functionality check
      power: supply: max17040: synchronize work cancellation on suspend

Krzysztof Kozlowski (1):
      dt-bindings: power: reset: qcom,pon: Narrow allowed reboot modes

Linmao Li (2):
      power: supply: bq25630: Scope battery information to bq25630_setup()
      power: supply: bq25630: Initialize hardware before exposing the power supply

Ma Ke (1):
      power: supply: bq25890: Fix power_supply reference leak

Maoyi Xie (1):
      power: supply: twl4030_charger: cancel workers via devm

Matti Vaittinen (5):
      power: supply: bd71815: Fix temperature reading
      power: supply: bd71828: Fix current direction
      power: supply: bd71828: Drop duplicate power-supply property
      power: supply: bd71828: Do not hide errors
      power: supply: bd99954: Drop bad register fields

Pan Chuang (43):
      power: reset: pwr-mlxbf: Remove redundant dev_err()/dev_err_probe()
      power: supply: 88pm860x_battery: Remove redundant dev_err()/dev_err_probe()
      power: supply: 88pm860x_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: ab8500_btemp: Remove redundant dev_err()/dev_err_probe()
      power: supply: ab8500_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
      power: supply: act8945a_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: axp20x_ac_power: Remove redundant dev_err()/dev_err_probe()
      power: supply: axp20x_usb_power: Remove redundant dev_err()/dev_err_probe()
      power: supply: axp288_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: axp288_fuel_gauge: Remove redundant dev_err()/dev_err_probe()
      power: supply: bq24190_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: bq24257_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: bq24735-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: bq256xx_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: bq257xx_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: cpcap-battery: Remove redundant dev_err()/dev_err_probe()
      power: supply: cpcap-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: da9150-fg: Remove redundant dev_err()/dev_err_probe()
      power: supply: generic-adc-battery: Remove redundant dev_err()/dev_err_probe()
      power: supply: max14656_charger_detector: Remove redundant dev_err()/dev_err_probe()
      power: supply: max77759_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: max8903_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: max8971_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: mp2629_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: mt6360_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: mt6370-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: pf1550-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: qcom_smbb: Remove redundant dev_err()/dev_err_probe()
      power: supply: qcom_smbx: Remove redundant dev_err()/dev_err_probe()
      power: supply: rk817_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: rn5t618_power: Remove redundant dev_err()/dev_err_probe()
      power: supply: rt9455_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: rt9467-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: rt9471: Remove redundant dev_err()/dev_err_probe()
      power: supply: sbs-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: sc27xx_fuel_gauge: Remove redundant dev_err()/dev_err_probe()
      power: supply: surface-rt-ec: Remove redundant dev_err()/dev_err_probe()
      power: supply: tps65090-charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: tps65217_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: twl4030_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: twl6030_charger: Remove redundant dev_err()/dev_err_probe()
      power: supply: ucs1002_power: Remove redundant dev_err()/dev_err_probe()

Pengpeng Hou (3):
      power: supply: cros_pchg: unregister EC notifier
      power: reset: piix4-poweroff: add missing MODULE_DEVICE_TABLE()
      power: supply: cw2015_battery: add missing MODULE_DEVICE_TABLE()

Rakesh Kota (1):
      dt-bindings: power: reset: qcom-pon: Add new compatible PMM8654AU

Rob Herring (Arm) (2):
      power: supply: Match DT value types
      power: reset: syscon-reboot: Read "priority" as unsigned

Sang-Heon Jeon (1):
      power: supply: pm8916_lbc: remove conditional return with no effect

Sebastian Reichel (1):
      Merge tag 'ib-psy-array-helpers-for-v7.3-signed' into psy-next

Shivendra Pratap (1):
      power: reset: reboot-mode: Remove devres based allocations

Steffen Dirkwinkel (2):
      power: supply: leds: create triggers based on properties, not type
      power: supply: hold extensions_sem when creating LED triggers

Tingguo Cheng (1):
      power: supply: qcom_battmgr: fix battery chemistry strncmp length

Vincent Cloutier (11):
      power: supply: Add registration init callback
      power: supply: max17042_battery: Separate MAX17055 initialization
      power: supply: max17042_battery: Use bool for init_complete
      power: supply: max17042_battery: Convert initialization to delayed work
      power: supply: max17042_battery: Propagate status register errors
      power: supply: max17042_battery: Retry failed MAX17055 initialization
      power: supply: max17042_battery: Program MAX17055 EZ Config values
      power: supply: max17042_battery: Follow MAX17055 POR sequence
      power: supply: max17042_battery: Initialize MAX17055 from battery info
      power: supply: max17042_battery: Honor MAX17055 charge voltage
      dt-bindings: power: supply: max17042: Allow generic power-supply properties

Waqar Hameed (5):
      power: supply: rt9471: Remove superfluous unpacking of propval
      power: supply: bq24190: Remove unused watchdog struct field
      power: supply: bq24190: Disable watchdog with bq24190_write_mask()
      dt-bindings: power: supply: Add TI BQ25630 charger
      power: supply: Add driver for TI BQ25630 charger

Xu Rao (1):
      power: supply: pf1550: enable charging when battery profile exists

 Documentation/ABI/testing/sysfs-class-power        |    2 +-
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |   20 +-
 .../bindings/power/supply/maxim,max17042.yaml      |    4 +-
 .../bindings/power/supply/maxim,max8903.yaml       |   53 +
 .../bindings/power/supply/sgmicro,sgm41542.yaml    |   96 ++
 .../bindings/power/supply/ti,bq25630.yaml          |   55 +
 MAINTAINERS                                        |    6 +
 drivers/power/reset/Kconfig                        |   12 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/mcf-rcm-reset.c                |  126 +++
 drivers/power/reset/piix4-poweroff.c               |    1 +
 drivers/power/reset/pwr-mlxbf.c                    |    2 -
 drivers/power/reset/reboot-mode.c                  |   30 +-
 drivers/power/reset/syscon-reboot.c                |    4 +-
 drivers/power/supply/88pm860x_battery.c            |   10 +-
 drivers/power/supply/88pm860x_charger.c            |    5 +-
 drivers/power/supply/Kconfig                       |   16 +
 drivers/power/supply/Makefile                      |    2 +
 drivers/power/supply/ab8500_btemp.c                |    5 +-
 drivers/power/supply/ab8500_charger.c              |    5 +-
 drivers/power/supply/ab8500_fg.c                   |   32 +-
 drivers/power/supply/act8945a_charger.c            |    4 +-
 drivers/power/supply/axp20x_ac_power.c             |    5 +-
 drivers/power/supply/axp20x_usb_power.c            |    5 +-
 drivers/power/supply/axp288_charger.c              |    3 +-
 drivers/power/supply/axp288_fuel_gauge.c           |    2 +-
 drivers/power/supply/bd71828-power.c               |   20 +-
 drivers/power/supply/bd99954-charger.h             |   23 +-
 drivers/power/supply/bq24190_charger.c             |   18 +-
 drivers/power/supply/bq24257_charger.c             |   20 +-
 drivers/power/supply/bq24735-charger.c             |    6 +-
 drivers/power/supply/bq25630_charger.c             | 1075 +++++++++++++++++++
 drivers/power/supply/bq256xx_charger.c             |   41 +-
 drivers/power/supply/bq257xx_charger.c             |  530 ++++++++-
 drivers/power/supply/bq25890_charger.c             |   12 +
 drivers/power/supply/bq27xxx_battery.c             |    6 +-
 drivers/power/supply/charger-manager.c             |   54 +-
 drivers/power/supply/cpcap-battery.c               |    6 +-
 drivers/power/supply/cpcap-charger.c               |    6 +-
 drivers/power/supply/cros_peripheral_charger.c     |   13 +-
 drivers/power/supply/cros_usbpd-charger.c          |   17 +-
 drivers/power/supply/cw2015_battery.c              |    1 +
 drivers/power/supply/da9150-fg.c                   |    4 +-
 drivers/power/supply/generic-adc-battery.c         |    2 +-
 drivers/power/supply/isp1704_charger.c             |    1 +
 drivers/power/supply/lp8727_charger.c              |    4 +-
 drivers/power/supply/lp8788-charger.c              |    2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |    2 +-
 drivers/power/supply/max14656_charger_detector.c   |    4 +-
 drivers/power/supply/max17040_battery.c            |   32 +-
 drivers/power/supply/max17042_battery.c            |  375 ++++++-
 drivers/power/supply/max77759_charger.c            |    4 +-
 drivers/power/supply/max8903_charger.c             |  430 +++++++-
 drivers/power/supply/max8971_charger.c             |    2 +-
 drivers/power/supply/mp2629_charger.c              |    4 +-
 drivers/power/supply/mt6360_charger.c              |    3 +-
 drivers/power/supply/mt6370-charger.c              |    4 +-
 drivers/power/supply/pf1550-charger.c              |    5 +-
 drivers/power/supply/pm8916_lbc.c                  |    6 +-
 drivers/power/supply/power_supply_core.c           |  169 ++-
 drivers/power/supply/power_supply_leds.c           |   88 +-
 drivers/power/supply/power_supply_sysfs.c          |    4 +
 drivers/power/supply/qcom_battmgr.c                |   17 +-
 drivers/power/supply/qcom_smbb.c                   |    5 +-
 drivers/power/supply/qcom_smbx.c                   |    3 +-
 drivers/power/supply/rk817_charger.c               |   12 +-
 drivers/power/supply/rn5t618_power.c               |    5 +-
 drivers/power/supply/rt9455_charger.c              |   25 +-
 drivers/power/supply/rt9467-charger.c              |    3 +-
 drivers/power/supply/rt9471.c                      |   52 +-
 drivers/power/supply/sbs-battery.c                 |   15 +-
 drivers/power/supply/sbs-charger.c                 |    2 +-
 drivers/power/supply/sc2731_charger.c              |    2 +
 drivers/power/supply/sc27xx_fuel_gauge.c           |    8 +-
 drivers/power/supply/sgm41542_charger.c            | 1127 ++++++++++++++++++++
 drivers/power/supply/surface-rt-ec.c               |    2 +-
 drivers/power/supply/tps65090-charger.c            |    6 +-
 drivers/power/supply/tps65217_charger.c            |    6 +-
 drivers/power/supply/twl4030_charger.c             |   22 +-
 drivers/power/supply/twl6030_charger.c             |    4 +-
 drivers/power/supply/ucs1002_power.c               |   16 +-
 include/linux/mfd/bq257xx.h                        |   14 +
 include/linux/power/max17042_battery.h             |    2 +
 include/linux/power_supply.h                       |   36 +-
 tools/testing/selftests/power_supply/helpers.sh    |    8 +-
 .../power_supply/test_power_supply_properties.sh   |    3 +-
 86 files changed, 4448 insertions(+), 446 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
 create mode 100644 drivers/power/reset/mcf-rcm-reset.c
 create mode 100644 drivers/power/supply/bq25630_charger.c
 create mode 100644 drivers/power/supply/sgm41542_charger.c

--s7atiawyd7e5yl26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqIT3EACgkQ2O7X88g7
+pplUQ//WD+eV6VDAYrHIfOVCbZTNMXGWl4fdN0fKIwkKQbQ9pkXyixnWIur0IF5
qpW/Z/ACLij9+pezGwYk47fLmPFrT7k+y7gGob0Nn+FOceLtt594KrP34q6RSwin
I39CiZSPBq9NPAJtB1XOH6WP/fMU2DQY2UjazZTj1fK+m07QGkgMvR4IslIN76yY
4EKZOLfTlqdbC7sRI9p2M+HshKhIq5eZC6OoJ0iDBDIpcwJ3LRhkJgYcJigW98og
y8Aeqp/0x5FLnpdQCNa9Q0sruYUZHJqMbORmDkHtS2+SuRrk2ppFwSy+22xB4d8H
Dr3DKvrVaSYCFwaEDdcZhDEDZascrPB5sA0eVNZ87UoIq0uYc9E1NLWaxcC4SDjZ
yiqE5UmgRIS5RYx+Pk9jS7NMDtPCHrnHr0ymF7brf72JNkiPHBwlCTzOEYfKqrVp
rtrGmAMOurnwuGnKiSpDl1jEwOeKr1HPelPlXXc7v3aMFwIXY/0TS2bnIENjzK2c
kvIia9cUk1W2v47MZlIN3szn9h8Iq94AGLoAVSeZVeFEoB/VKf1ClXLY3dLuurdJ
k2oEYKT2t60Gmj0xC+OHm/LjI45oTFTatx1WWqvZ8mYA2v5YcA8Llol3Ir6HSUzG
KxSG+I/JPes+j/CDHybUVTiqciV8oYWaW1u/1gHoXr/mlRV5w1E=
=BQbx
-----END PGP SIGNATURE-----

--s7atiawyd7e5yl26--
