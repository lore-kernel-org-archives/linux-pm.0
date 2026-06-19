Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F73845CD;
	Fri, 19 Jun 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873047; cv=none; b=Z9DPwD+yMGlx5Wfklg71fD28TINV2o6hryRDt9BiYysWb6gZBZnhg8iIN9tGBs7yASxEoSxFRIAS7Rbr1tMoBcIMZ+CRlQtKrk40vDBTNmEZL+QXonLbt47eBhSG5XOZUpegs2yJy7YoiXtCPXR+bsnZr+Oncsgd8MLs/COykcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873047; c=relaxed/simple;
	bh=mXL/xXZnRAQBi+iQsPmzOpU/Y8oNGKaS3lGh8AojZws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cZ6mVeWM1OM6+FgujeWqLUrzlxhbpnd4lJNpkpCmrnBHwntm+42pkEKZbsfik6bg7ea8O3h9Sbq5lTobfaP/KZRuUtwegEAiJLdI4uJ4EvWniFJtlbyCgbDxnnnovo2YeJp1DJ6sgb35pZqwUtQJuRjKRyC8TV1dJjGMNsihLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/rD8YcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/rD8YcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559171F000E9;
	Fri, 19 Jun 2026 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781873045;
	bh=pRlt42eYsNb65U+x2Cfqw56C+Z3g+uA00NlknT2pnyA=;
	h=Date:From:To:Cc:Subject;
	b=T/rD8YcA5Er8sGeGsYDJNpkEFk2j7aP2S59d0PQFrvlZvub/nWxcHCnYao2oNKDyL
	 S8IWgG2ir4bZ6vPd9fXr6BD/aOl4RMVKdhlhCJnnUQO19DECXT1+xhZzS9IDbrM4uV
	 j0//07npVI9tBfRhZAm5v4V0gp/nr8a/p/79C3cRFaPJpv736ZZ9QgUXX89ZzRc63N
	 zrJXiGUTRkW8qQF/0i19YPY8nfWanluL5MVeSU+7Y++HBDqWjgZBDC7IUozO+HsAx7
	 rhzalJYLQRZOAXPic0Bk2+Jco2kA/X6sWU41pjSs4nAc8sz33BXkjWCRd2q+MwfmJ+
	 L6BY17j1uOmRg==
Received: by venus (Postfix, from userid 1000)
	id 1B5F21810FF; Fri, 19 Jun 2026 14:44:03 +0200 (CEST)
Date: Fri, 19 Jun 2026 14:44:03 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.2
Message-ID: <ajU34j9bIpuC_JkI@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2l6kdjzkvxtfdkke"
Content-Disposition: inline


--2l6kdjzkvxtfdkke
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 7.2
MIME-Version: 1.0

Hi Linus,

Nothing special from the power-supply tree (no changes outside the
tree, no merge conflicts in linux-next, no core changes). Please
find the details below:

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v7.2

for you to fetch changes up to a888754e51e915731c8974c4d6d62709facb35d3:

  Documentation: ABI: sysfs-class-reboot-mode-reboot_modes: fix doc warning=
s (2026-06-13 00:01:26 +0200)

----------------------------------------------------------------
power supply and reset changes for the 7.2 series

 * power-supply drivers
  - surface-rt-ec: new EC driver providing battery info for Microsoft Surfa=
ce RT
  - s2m-charger: new driver for battery charger in Samsung S2M PMICs
  - max17042: rework driver
  - bd71828: sysfs for auto input current limitation
  - use named fields for struct platform_device_id and of_device_id entries
  - misc. small cleanups and fixes
 * reset drivers
  - use named fields for struct platform_device_id and of_device_id entries
  - misc. small cleanups and fixes

----------------------------------------------------------------
Alexey Charkov (4):
      power: supply: bq257xx: Fix VSYSMIN clamping logic
      power: supply: bq257xx: Make the default current limit a per-chip att=
ribute
      power: supply: bq257xx: Consistently use indirect get/set helpers
      power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' s=
tates

Andreas Kemnade (1):
      power: supply: bd71828: sysfs for auto input current limitation

Costa Shulyupin (1):
      power: supply: Remove unused jz4740-battery.h

Johan Hovold (1):
      power: supply: max17042: fix OF node reference imbalance

Jonas Schw=F6bel (1):
      power: supply: Add support for Surface RT battery and charger

Kaustabh Chakraborty (1):
      power: supply: add support for Samsung S2M series PMIC charger device

Krzysztof Kozlowski (1):
      power: supply: cros_charge-control: Move MODULE_DEVICE_TABLE next to =
the table itself

Lucas Tsai (1):
      power: supply: core: fix supplied_from allocations

Ma Ke (1):
      power: supply: cpcap-battery: Fix missing nvmem_device_put() causing =
reference leak

Md Shofiqul Islam (1):
      power: supply: ab8500_fg: Fix typos in comments

Nathan Chancellor (1):
      power: supply: max17042_battery: Use modern PM ops to clear up warning

Otto Pfl=FCger (1):
      power: reset: sc27xx: Add platform_device_id table

Randy Dunlap (1):
      Documentation: ABI: sysfs-class-reboot-mode-reboot_modes: fix doc war=
nings

Rosen Penev (1):
      power: reset: st-poweroff: Use of_device_get_match_data()

Sebastian Krzyszkowiak (3):
      power: supply: max17042_battery: Put LSB units into defines
      power: supply: max17042_battery: Use Current register in get_status
      power: supply: max17042_battery: use ModelCfg refresh on max17055

Svyatoslav Ryhel (1):
      dt-bindings: embedded-controller: Document Surface RT EC

Uwe Kleine-K=F6nig (The Capable Hub) (6):
      power: Drop unused assignment of platform_device_id driver data
      power: supply: max14577: Drop driver data in of and platform device i=
d arrays
      power: Use named initializers for platform_device_id arrays
      power: supply: mt6360_charger: Use of match table unconditionally
      power: Unify code style for platform_device_id arrays
      power: supply: Use named initializers for arrays of i2c_device_data

Vincent Cloutier (3):
      power: supply: max17042_battery: Route MAX17055 SOC alerts through dS=
OCi
      power: supply: max17042_battery: Keep only critical alerts during sus=
pend
      power: supply: max17042_battery: Remove unused platform-data plumbing

Vladimir Oltean (1):
      power: supply: cpcap-charger: include missing <linux/property.h>

WenTao Liang (1):
      power: supply: charger-manager: fix refcount leak in is_full_charged()

Wentao Liang (1):
      power: reset: linkstation-poweroff: fix use-after-free in the linksta=
tion_poweroff_init()

 .../ABI/testing/sysfs-class-power-bd71828          |  12 +
 .../testing/sysfs-class-reboot-mode-reboot_modes   |  13 +-
 .../microsoft,surface-rt-ec.yaml                   |  63 ++++
 drivers/power/reset/linkstation-poweroff.c         |   2 +-
 drivers/power/reset/qemu-virt-ctrl.c               |   2 +-
 drivers/power/reset/sc27xx-poweroff.c              |   8 +
 drivers/power/reset/spacemit-p1-reboot.c           |   4 +-
 drivers/power/reset/st-poweroff.c                  |   8 +-
 drivers/power/reset/tps65086-restart.c             |   2 +-
 drivers/power/supply/Kconfig                       |  21 ++
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/ab8500_fg.c                   |   2 +-
 drivers/power/supply/adp5061.c                     |   2 +-
 drivers/power/supply/axp288_charger.c              |   2 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   2 +-
 drivers/power/supply/bd71828-power.c               |  77 +++-
 drivers/power/supply/bq2415x_charger.c             |  28 +-
 drivers/power/supply/bq24190_charger.c             |  16 +-
 drivers/power/supply/bq24257_charger.c             |   8 +-
 drivers/power/supply/bq24735-charger.c             |   4 +-
 drivers/power/supply/bq2515x_charger.c             |   6 +-
 drivers/power/supply/bq256xx_charger.c             |  16 +-
 drivers/power/supply/bq257xx_charger.c             |  52 ++-
 drivers/power/supply/bq25890_charger.c             |  10 +-
 drivers/power/supply/bq25980_charger.c             |   8 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  64 ++--
 drivers/power/supply/charger-manager.c             |  10 +-
 drivers/power/supply/cpcap-battery.c               |  11 +-
 drivers/power/supply/cpcap-charger.c               |   1 +
 drivers/power/supply/cros_charge-control.c         |   6 +-
 drivers/power/supply/cros_peripheral_charger.c     |   4 +-
 drivers/power/supply/cros_usbpd-charger.c          |   4 +-
 drivers/power/supply/cw2015_battery.c              |   2 +-
 drivers/power/supply/ds2782_battery.c              |   6 +-
 drivers/power/supply/lp8727_charger.c              |   2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |  10 +-
 drivers/power/supply/ltc4162-l-charger.c           |   8 +-
 drivers/power/supply/macsmc-power.c                |   2 +-
 drivers/power/supply/max14577_charger.c            |  12 +-
 drivers/power/supply/max14656_charger_detector.c   |   4 +-
 drivers/power/supply/max17040_battery.c            |  18 +-
 drivers/power/supply/max17042_battery.c            | 402 +++++++++++------=
----
 drivers/power/supply/max77693_charger.c            |   2 +-
 drivers/power/supply/max77759_charger.c            |   2 +-
 drivers/power/supply/max77976_charger.c            |   2 +-
 drivers/power/supply/max8971_charger.c             |   2 +-
 drivers/power/supply/max8997_charger.c             |   2 +-
 drivers/power/supply/max8998_charger.c             |   2 +-
 drivers/power/supply/mm8013.c                      |   4 +-
 drivers/power/supply/mt6360_charger.c              |   6 +-
 drivers/power/supply/pf1550-charger.c              |   2 +-
 drivers/power/supply/power_supply_core.c           |  11 +-
 drivers/power/supply/rt5033_battery.c              |   2 +-
 drivers/power/supply/rt5033_charger.c              |   2 +-
 drivers/power/supply/rt9455_charger.c              |   2 +-
 drivers/power/supply/s2m-charger.c                 | 313 ++++++++++++++++
 drivers/power/supply/sbs-battery.c                 |   8 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/power/supply/sbs-manager.c                 |   4 +-
 drivers/power/supply/smb347-charger.c              |  10 +-
 drivers/power/supply/stc3117_fuel_gauge.c          |   2 +-
 drivers/power/supply/surface-rt-ec.c               | 389 +++++++++++++++++=
+++
 drivers/power/supply/ug3105_battery.c              |   2 +-
 include/linux/power/jz4740-battery.h               |  15 -
 include/linux/power/max17042_battery.h             |  32 +-
 65 files changed, 1323 insertions(+), 431 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-bd71828
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/m=
icrosoft,surface-rt-ec.yaml
 create mode 100644 drivers/power/supply/s2m-charger.c
 create mode 100644 drivers/power/supply/surface-rt-ec.c
 delete mode 100644 include/linux/power/jz4740-battery.h

--2l6kdjzkvxtfdkke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmo1OY8ACgkQ2O7X88g7
+ppINw/4rwSt3y3TYIupeLQdc9pFUmyVWkU0LCRPQij+TcJNIaj3w9BkSq24UGBF
P5R2E5kd5ktFsvVis00Y5w3nAGfEghBLeBwnJFw//ypsgx98bAqe+Ry4c185s4JC
Bn2/nvXF4bTwhJG6gFa1S0YwzEJQ423UrP9OS7pxBoVbBWYaGJuAK0kuPIUypreZ
o9woZhBEqHIVdIoms1enSu6ndzezv4YzOarF1HarjngSiixKs8w/FMAwcWC3PFtU
79UdzvwY3gJTHWjHGP8KVlTvkXz6VZSPKQ2SfbBWB3nX4P0omYpHzJXv/GFivx5J
1rzJ4Vbmj8KdQCEHMoTevBTrGH1ZTI7y4hyHEiu5zYEq3OJ0rN/eANJaLSDHq4/+
S9vdg6s0lIku23Y+64S92UuumqZbVt35E0PvdP9UoqIM4YnVm5wKycYkhduWBbgs
b6IyLC17ESKT9IFTMj6jWh0R6HjCecIvgnzUBmgV+9idSFYAdAXKYn26uproWvce
PgR6lKj/H+OPPF4/8iaoplMOheXyT+OrBjomb3JN10kjZN7rz5rkuhewK0XmNIZQ
msojXcAKiWNY/ziCKnip65vS5ayhieblTU+Fwmzcd6WrKqlRMR+JmNonhAnjapqf
m0N4z9J3ToSlnEkq2i9pm0iJJQc8g3C6srCYsHxceWDbiHNzlw==
=HeNg
-----END PGP SIGNATURE-----

--2l6kdjzkvxtfdkke--
