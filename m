From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.5
Date: Thu, 14 Jan 2016 13:36:08 +0100
Message-ID: <20160114123607.GA24407@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I have mostly fixes in the power-supply tree for the 4.5 kernel.
I should mention, that the top-most commit has not been in next,
but it's a fix changing only a single register offset.

-- Sebastian

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.5

for you to fetch changes up to 265b60497a57da56a4be7d5c72983ae89dc0765e:

  power: bq27xxx_battery: Fix bq27541 AveragePower register address (2016-01-14 01:03:18 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.4 series

 * uncouple CONFIG_POWER_RESET from CONFIG_POWER_SUPPLY
 * misc. fixes

---------------------------------------------------------------
Andrew F. Davis (1):
      power: bq27xxx_battery: Reorganize I2C into a module

Geliang Tang (1):
      power: generic-adc-battery: use to_delayed_work

H. Nikolaus Schaller (2):
      power: bq27xxx: fix reading for bq27000 and bq27010
      power: bq27xxx: fix register numbers of bq27500

Ivaylo Dimitrov (1):
      power: isp1704_charger: Fix isp1704_write() definition

Julia Lawall (2):
      power: ds2782_battery: constify ds278x_battery_ops structure
      power/reset: at91-reset: add missing of_node_put

Krzysztof Kozlowski (1):
      power: Fix unmet dependency on POWER_SUPPLY by POWER_RESET by uncoupling them

Liu Xiang (1):
      power: bq27xxx_battery: Fix bq27541 AveragePower register address

Markus Elfring (1):
      power: bq2415x_charger: Delete unnecessary checks before the function call "of_node_put"

NeilBrown (1):
      power: bq27xxx: don't fill system log by missing battery

Sasha Levin (1):
      power: test_power: correctly handle empty writes

Saurabh Sengar (1):
      power: max8903_charger: set IRQF_ONESHOT if no primary handler is specified

 drivers/Makefile                      |   2 +-
 drivers/power/Kconfig                 |  17 +-
 drivers/power/Makefile                |   1 +
 drivers/power/bq2415x_charger.c       |   6 +-
 drivers/power/bq27xxx_battery.c       | 348 ++++------------------------------
 drivers/power/bq27xxx_battery_i2c.c   | 150 +++++++++++++++
 drivers/power/ds2782_battery.c        |   4 +-
 drivers/power/generic-adc-battery.c   |   2 +-
 drivers/power/isp1704_charger.c       |   2 +-
 drivers/power/max8903_charger.c       |  24 +--
 drivers/power/reset/at91-reset.c      |   1 +
 drivers/power/test_power.c            |   2 +
 include/linux/power/bq27xxx_battery.h |  57 +++++-
 13 files changed, 264 insertions(+), 352 deletions(-)
 create mode 100644 drivers/power/bq27xxx_battery_i2c.c

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWl5Y3AAoJENju1/PIO/qaR78P/2iTN80NENIv/lL7Fv8DLtMt
PEB7zl4Pw7mB8lWX4QYOQRrta82xxNK1W0nxAMeFjDzXUKnWxK+9+cixIDEm8jOC
QoJQgp8m0QTtbSMLfCB1a6H6Lc2yshLtecdDxwbp+aP1Gav0/ODA8Bc9jOBAlTNA
AmD1YUJhuBCOhIxV+S6z+cw3Plq/rgNgbrZZvEbyJH9XsMtunyfmXdbGC0JOuA5R
oBGwwzzVHxoxtMRrQgXF2bgL6AcCK+n2AjpHlQ5kEhjC2cOApae2eQK/EuTEZILX
Z/xs9DqkhNH9szZaxiuNJXQatHqgUxxLeFys/XTs/l6LF/FsFJSxWUOkQN9oYF1r
kkM4tun24SIJ3Be4XAGpQ7q4Yi71BuQW6+IJu3jg2d6y8FeUGBwJFzaoShb/oe88
y9Cb/wq78SfGR99Tb+x4EF+5eNOgLfVR8gLk1tRTSvARVFvrKoWeRIeRQWEsTvrl
DbIFvWc0bFMEejXbtppWpB57xziRgFGPkanundPFaCEuCGnPS5cmhKZquXm6eon8
W2+tYasbBLTPX9iZVihc2iCmtmuRsPWeKUKdavLGSXdSIAPWZmLqnY3mBqyj52Dt
d6db3zi6vptsS89m3XW4/TLcQ4xL0ioQlMjV9tbqp4HTgplhXIG3o3IUpTExukSd
ufuK00wUMpUIVkCMcZtE
=P0YK
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
