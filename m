Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA52C21D0;
	Fri, 17 Apr 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440488; cv=none; b=WZYDMt/Ae7VGmZn3OIIqrY1fkcrbXjWlwBtWB76hBMy3kv/NRGgXujLHkFJG1lHA7lVyxzjUBSUYd9z8MJjWR+SUIRege17DI+DSlakfEoqdhO1Igf/FyfNR1Po+YxzwYNZBtRlcqLGWNOo4vTjUu5ztqzMX2tSNAQJAVku2CkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440488; c=relaxed/simple;
	bh=0n8/YUL4yu8NdIhMcnmJqQjiuaM8Rj321HxdShp38oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pWIYM/AZEc+ryZOLmoCRrfv6QfrKWuGfcAJdfVOmTtCd5p40gcTEGlq+KEQyFzg2qxO45txx1/31bxkG4deN8c1czRiYLpBG+cB61nRXsiw2PPuagSQ4LHqtxXUXT7o5paFu2nEcKAtHb1GzA4y1gieUw2w134gXUS6J/2giHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA01KBlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA01KBlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E14C19425;
	Fri, 17 Apr 2026 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776440487;
	bh=0n8/YUL4yu8NdIhMcnmJqQjiuaM8Rj321HxdShp38oo=;
	h=Date:From:To:Cc:Subject:From;
	b=dA01KBlDN8eiOSILxs7ZoSwE57VeDkKGz5zEIWc4i2smBYDomvgBsdAzGENaJCE/Q
	 dAJDYbakSCy96pivmHw3eHZ7SMNvV9H0FhOnUX7ax9ojcQW/qLX+bq3EK+5t6VxQqE
	 smCLfpzBf9NBwTdjhZM3OR/RTde9hh6GFIXad23T9tEhK7qd7oXWppd2dL0xS/BgKj
	 8i3TkNInOsYql7sC5s5fdvHKxZsGspf/VTVw12FZ+V7vzxS5JyttFWAjO2u7Ul7SsF
	 boA0cxGAJJdNZPgZrYyqYLBEENJEzWQhcim5dvoUFH1SOBcM0YsG9OAGtfmebdyQi0
	 wAmgTURz0OlmQ==
Received: by venus (Postfix, from userid 1000)
	id 7A42C180269; Fri, 17 Apr 2026 17:41:25 +0200 (CEST)
Date: Fri, 17 Apr 2026 17:41:25 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.1
Message-ID: <aeJTAaRJ6lh1wBZr@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ciwqdomctq3b7icj"
Content-Disposition: inline


--ciwqdomctq3b7icj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 7.1
MIME-Version: 1.0

Hi Linus,

just as a heads up, Mark Brown reported a merge conflict in
drivers/power/supply/Makefile with the usb tree, which picked
up a new driver (max77759_charger) due to dependencies. The
conflict is trivial to solve:

https://lore.kernel.org/all/ac0aJ6jpCcSaemt7@sirena.org.uk/

Greetings,

-- Sebastian

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v7.1

for you to fetch changes up to 98d68b74ebb9d5f145960ff7d96ce8e7a39fb965:

  power: supply: qcom_smbx: allow disabling charging (2026-04-03 00:40:54 +=
0200)

----------------------------------------------------------------
power supply and reset changes for the 7.1 series

 * power-supply drivers
  - S2MU005: new battery fuel gauge driver
  - macsmc-power: new driver for Apple Silicon
  - qcom_battmgr: Add support for Glymur and Kaanapali
  - max17042: add support for max77759
  - qcom_smbx: allow disabling charging
  - bd71828: add input current limit support
  - multiple drivers: use new device managed workqueue allocation
    function
  - misc. small cleanups and fixes
 * reset core
  - Expose sysfs for registered reboot_modes
 * reset drivers
  - misc. small cleanups and fixes

----------------------------------------------------------------
Andreas Kemnade (1):
      power: supply: bd71828: add input current limit property

Andrew Davis (1):
      power: reset: keystone: Use register_sys_off_handler(SYS_OFF_MODE_RES=
TART)

Andr=E9 Draszik (11):
      dt-bindings: power: supply: max17042: add support for max77759
      dt-bindings: power: supply: max17042: support shunt-resistor-micro-oh=
ms
      dt-bindings: power: supply: max17042: drop formatting specifier |
      power: supply: max17042: fix a comment typo (then -> than)
      power: supply: max17042: use dev_err_probe() where appropriate
      power: supply: max17042: avoid overflow when determining health
      power: supply: max17042: time to empty is meaningless when charging
      power: supply: max17042: support standard shunt-resistor-micro-ohms D=
T property
      power: supply: max17042: initial support for Maxim MAX77759
      power: supply: max17042: consider task period (max77759)
      power: supply: max17042: report time to full (max17055 & max77759)

Anjelique Melendez (1):
      power: supply: qcom_battmgr: Add support for Glymur and Kaanapali

Arnd Bergmann (1):
      power: reset: reboot-mode: fix -Wformat-security warning

Bartosz Golaszewski (1):
      power: reset: drop unneeded dependencies on OF_GPIO

Casey Connolly (1):
      power: supply: qcom_smbx: allow disabling charging

Dmitry Torokhov (1):
      power: supply: sbs-manager: normalize return value of gpio_get

Hector Martin (1):
      power: supply: Add macsmc-power driver for Apple Silicon

Jaime Saguillo Revilla (1):
      power: supply: cpcap-battery: fix typo in config name

Kaustabh Chakraborty (1):
      dt-bindings: power: supply: document Samsung S2MU005 battery fuel gau=
ge

Khushal Chitturi (1):
      dt-bindings: power: reset: cortina,gemini-power-controller: convert t=
o DT schema

Krzysztof Kozlowski (10):
      power: supply: axp288_charger: Do not cancel work before initializing=
 it
      power: supply: axp288_charger: Simplify returns of dev_err_probe()
      power: supply: bq24190: Avoid rescheduling after cancelling work
      power: supply: twl4030_madc: Drop unused header includes
      workqueue: devres: Add device-managed allocate workqueue
      power: supply: cw2015: Free allocated workqueue
      power: supply: max77705: Drop duplicated IRQ error message
      power: supply: max77705: Free allocated workqueue and fix removal ord=
er
      power: supply: mt6370: Simplify with devm_alloc_ordered_workqueue()
      power: supply: ipaq_micro: Simplify with devm

Sebastian Reichel (1):
      Merge branch 'for-7.1-devm-alloc-wq'

Shivendra Pratap (2):
      Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
      power: reset: reboot-mode: Expose sysfs for registered reboot_modes

Svyatoslav Ryhel (2):
      dt-bindings: power: supply: cpcap-battery: document monitored-battery=
 property
      power: supply: cpcap-battery: pass static battery cell data from devi=
ce tree

Yassine Oudjana (1):
      power: supply: add support for S2MU005 battery fuel gauge device

 .../testing/sysfs-class-reboot-mode-reboot_modes   |  36 +
 .../reset/cortina,gemini-power-controller.yaml     |  42 +
 .../bindings/power/reset/gemini-poweroff.txt       |  17 -
 .../bindings/power/supply/cpcap-battery.yaml       |   1 +
 .../bindings/power/supply/maxim,max17042.yaml      |  21 +-
 .../power/supply/samsung,s2mu005-fuel-gauge.yaml   |  49 ++
 Documentation/driver-api/driver-model/devres.rst   |   4 +
 MAINTAINERS                                        |   1 +
 drivers/power/reset/Kconfig                        |   8 +-
 drivers/power/reset/keystone-reset.c               |  11 +-
 drivers/power/reset/reboot-mode.c                  | 151 +++-
 drivers/power/supply/Kconfig                       |  22 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/axp288_charger.c              |  71 +-
 drivers/power/supply/bd71828-power.c               |  62 ++
 drivers/power/supply/bq24190_charger.c             |   9 +-
 drivers/power/supply/cpcap-battery.c               |  31 +-
 drivers/power/supply/cw2015_battery.c              |   3 +-
 drivers/power/supply/ipaq_micro_battery.c          |  50 +-
 drivers/power/supply/macsmc-power.c                | 855 +++++++++++++++++=
++++
 drivers/power/supply/max17042_battery.c            | 130 +++-
 drivers/power/supply/max77705_charger.c            |  36 +-
 drivers/power/supply/mt6370-charger.c              |  13 +-
 drivers/power/supply/qcom_battmgr.c                |   2 +
 drivers/power/supply/qcom_smbx.c                   |   7 +
 drivers/power/supply/s2mu005-battery.c             | 307 ++++++++
 drivers/power/supply/sbs-manager.c                 |   2 +-
 drivers/power/supply/twl4030_madc_battery.c        |   2 -
 include/linux/power/max17042_battery.h             |  25 +-
 include/linux/workqueue.h                          |  22 +
 kernel/workqueue.c                                 |  28 +
 31 files changed, 1839 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-reboot-mode-reboo=
t_modes
 create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,g=
emini-power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-po=
weroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/samsung,=
s2mu005-fuel-gauge.yaml
 create mode 100644 drivers/power/supply/macsmc-power.c
 create mode 100644 drivers/power/supply/s2mu005-battery.c

--ciwqdomctq3b7icj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmniVKUACgkQ2O7X88g7
+ppBTw/+P//uFdD9VzFW7xGUZ5Ib7YH8TmvjibVChjy/faEq+4lNgx80N2Ob1CSr
0lAIC2kJcuUMHEbDJhkbkEWNDfkC59RXV23O0OT7MXzjXOxdI//ypxcyM6ZciS/f
gryXcE7UgqBiz+KxqRXaKWvBWAKQ3uo+BZQWMxgpr/ig8Jy3UY9lFmcjQmhbCzbg
2HJnpr2domRwm6J6o6GOH7Bqa1TJwHnj9iCNLKePZjxX1qMXRUqJUktJT2cHpgjH
XHg0XETRxHLu1F6htqe+CIfa5SiMkPT9/V1cKvNsBCULh0kiDYqSkqd/ES9nAirh
5kNRRK1ur4XfCXIfoeY1sWUX1VHi9/rpX5/PuaG6AGjNzHu2zn6Mj1oOjpbXhb0E
h/11cDar1gmkPNA9casoWtlW/2S3U8IRsehlW1dy3NGXIlaDCyzlLoX5NtLkLNbg
X49+Ad+yl0yO9i10KKdPURJSU8PHoR54oEdH/cRIC8k+s/R4Yr/XQhHPmYc9Eu66
ilLF57JsUixIXMB7eOqP/v4BLJsuSpWyJhtcXkJLG6AEEpG6gBw1DQrv9dPEVUqD
KyTHH+ikrR+nhwTPZ7AbD61MhcIOkJd8EgkfSYyaFOEzGW8z96GwTj7UttpLVYFk
nbfex34FpNKveEj88tM8HaxqLfffvh1LbRDh+45aZxCeEpGV300=
=IsQ5
-----END PGP SIGNATURE-----

--ciwqdomctq3b7icj--
