From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [RFC PATCH v1 00/13] support ROHM BD70528 PMIC
Date: Tue, 22 Jan 2019 11:41:53 +0200
Message-ID: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

Patch series introducing support for ROHM BD70528 PMIC

Please note that patch 2 breaks compilation without patches 3 and 4

ROHM BD70528 is a programmable Power Management IC for battery
powered 'ultra low power' systems like the pre-announced NXP
i.MX7 ULP. This patch series introduces support for the PMIC.

I send this a RFC now as I would like to receive comments from
Lee, Mark and Stephen regarding splitting the existing
include/linux/mfd/bd718x7.h into ROHM generic and chip specific
portions. Benefit is that for example the clk sub-driver does
not need to be aware of chip specific structure(s) (struct
bd718x7 and struct bd70528) as it only needs to derefernce the
generic struct rohm_regmap_dev. Thus same clk subdriver can
support both the bd718x7 and bd70528 as long as MFD driver
data has this generic structure in the beginning of allocated
data. But knowing the bd718x7 driver is already in upstream,
it might be good if this change went through single tree, right?

Another 'RFC' item is 'main register support' for regmap-irq.
This has been initially discussed with Mark in these mail threads

Option 1
https://lore.kernel.org/lkml/20181217185014.GH27909@sirena.org.uk/

Option 2
https://lore.kernel.org/lkml/20181218085803.GD2477@localhost.localdomain/

But I think it is Ok to show it to wider audience with this real
usage example.

RTC block of the bd70528 can support 'wake' irq which wakes PMIC
from standby state. Wake irq's can be armed to wake up system up
to 24 hours from arming. bd70528 can also generate alarm interrupts
which can be armed to occur years after triggering. The RTC driver
does always arm both the waker and alarm irqs and does not utilize
longer period of alarm interrupts. All the RTC timers are limited
to occur within the next 24 hours. Any suggestions on more elegant
timer support are welcome =)

GPIO portion of bd70528 driver adds I/O support for driving GPIO
pins or reading the state. The interrupt functionality is provided
by regmap-irq. Current GPIO driver is not aware of whether the pin(s)
are used for I/O or interrupts and it is up-to driver user to
ensure there is no misconfiguration or "double use".

Currently only MFD core, clk, RTC and regulator portions are
somehow tested. The RFC series also include initial gpio, power-supply
and watchdog patches in order to provide better overview on chip
and to collect initial feedback. Reset and ADC are not supported by
this series.

Patch 1:
	regmap-irq, 'main status register support'. See discussion
	https://lore.kernel.org/lkml/20181217185014.GH27909@sirena.org.uk/
Patch 2:
	split the bd718x7.h to generic and chip specific portions.
	(breaks compilation without patch 3 and 4)
Patch 3:
	adapt bd718x7.h changes to bd718x7 regulator driver
Patch 4:
	adapt bd718x7.h changes to bd718x7 clk driver
Patch 5:
	add MFD core support for bd70528
Patch 6:
	support bd70528 clk using bd718x7 clk driver
Patch 7:
	document DT bindings for BD70528
Patch 8:
	support bd70528 regulators
Patch 9:
	document regulator DT bindings for BD70528
Patch 10:
	support BD70528 GPIO block
Patch 11:
	support BD70528 RTC
Patch 12:
	support BD70528 battery charger
Patch 13:
	support BD70528 watchdog

This patch series is based on Mark's regulator/for-next branch

---

Matti Vaittinen (13):
  regmap: regmap-irq: Add main status register support
  mfd: bd718x7.h split to ROHM common and bd718x7 specific parts
  regulator: bd718x7 use chip specific and generic data structs
  clk: bd718x7: use chip specific and generic data structs
  mfd: bd70528: Support ROHM bd70528 PMIC - core
  clk: bd718x7: Support ROHM BD70528 clk block
  devicetree: bindings: Document first ROHM BD70528 bindings
  regulator: bd70528: Support ROHM BD70528 regulator block
  devicetree: bindings: ROHM bd70528 regulator bindings
  gpio: Initial support for ROHM bd70528 GPIO block
  rtc: bd70528: Initial support for ROHM bd70528 RTC
  power: supply: Initial support for ROHM BD70528 PMIC charger block
  watchdog: bd70528: Initial support for ROHM BD70528 watchdog block

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 ++++
 .../bindings/regulator/rohm,bd70528-regulator.txt  |  68 +++
 drivers/base/regmap/regmap-irq.c                   |  99 ++-
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  25 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 192 ++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd70528.c                         | 409 +++++++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 670 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd70528-regulator.c              | 290 +++++++++
 drivers/regulator/bd718x7-regulator.c              |  22 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 439 ++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd70528_wdt.c                     | 161 +++++
 include/linux/mfd/rohm-bd70528.h                   | 392 ++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 include/linux/regmap.h                             |  31 +
 29 files changed, 2998 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/regulator/bd70528-regulator.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 drivers/watchdog/bd70528_wdt.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
