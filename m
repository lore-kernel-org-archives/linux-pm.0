From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [RFC PATCH v3 00/10] support ROHM BD70528 PMIC
Date: Wed, 30 Jan 2019 11:05:07 +0200
Message-ID: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc: heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Patch series introducing support for ROHM BD70528 PMIC

Please note that patch 1 breaks compilation without patches 2 and 3

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

Changelog v3:
patches 1,2,3,4,5,6,7,8 and 10 are unchanged from v2
RTC fixups suggested by Guenter Roeck:
- create bd70528_set_time_locked function in order to simplify
  error handling and to make mutex lock/unlock path more obvious
- don't ignore errors on bd70528_set_time_locked
- simplify bd70528_read_alarm enabled condition setting
- add __packed to structs where members are mapped to HW registers
- remove unnecessary brackets from enable condition in set_wake
RTC: fixups suggested by Alessandro Belloni
- don't use deprecated devm_rtc_device_register
- add alarm_irq_enable callback
- add range_min and range_max
WDT:
- add regmap and mutex pointers to WDT data so that they can be accessed
  without dereferencing the parent data
- remove parent data pointer from WDT data
- embed struct watchdog_device into WDT data in order to avoid double
  allocation.
GPIO:
- remove unused header as pointed by Linus Walleij
POWER:
- do not copy the whole MFD data (especially the mutex to avoid
  all possibilities of accidentally using the copy of a mutex)

Changelog v2: Mainly feedback from Guenter Roeck:
- patches 1, 2, 3, 4, 5, 9 are unchanged.
- mfd: own mutex for each bd70528 instance - embed in struct bd70528
- watchdog: do not copy parent device data
- watchdog: fix deadlock caused by double locked mutex
- watchdog: set initial timeouts and WDT parent information
- watchdog: remove unnecessary ping function from ops
- watchdog: and the comment regarding it
- watchdog: allocate watchdog struct in order to allow multiple WDG
  instances
- rtc: bd70528 fix the order of mutex unlock and re-enabling RTC based
  timers
- rtc: fix the irq mask register address
- power: fix the irq mask register address
- regulator/regmap-irq: Drop the patches 1, 8 and 9 from original series
  as those were already applied by Mark 

Patch 1:
	split the bd718x7.h to generic and chip specific portions.
	(breaks compilation without patch 2 and 3)
Patch 2:
	adapt bd718x7.h changes to bd718x7 regulator driver
Patch 3:
	adapt bd718x7.h changes to bd718x7 clk driver
Patch 4:
	add MFD core support for bd70528
Patch 5:
	support bd70528 clk using bd718x7 clk driver
Patch 6:
	document DT bindings for BD70528
Patch 7:
	support BD70528 GPIO block
Patch 8:
	support BD70528 RTC
Patch 9:
	support BD70528 battery charger
Patch 10:
	support BD70528 watchdog

This patch series is based on Mark's regulator/for-next branch

---

Matti Vaittinen (10):
  mfd: bd718x7.h split to ROHM common and bd718x7 specific parts
  regulator: bd718x7 use chip specific and generic data structs
  clk: bd718x7: use chip specific and generic data structs
  mfd: bd70528: Support ROHM bd70528 PMIC - core
  clk: bd718x7: Support ROHM BD70528 clk block
  devicetree: bindings: Document first ROHM BD70528 bindings
  gpio: Initial support for ROHM bd70528 GPIO block
  rtc: bd70528: Initial support for ROHM bd70528 RTC
  power: supply: Initial support for ROHM BD70528 PMIC charger block
  watchdog: bd70528: Initial support for ROHM BD70528 watchdog block

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 ++++
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  25 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 191 ++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd70528.c                         | 410 +++++++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 676 +++++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c              |  22 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 502 +++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd70528_wdt.c                     | 187 ++++++
 include/linux/mfd/rohm-bd70528.h                   | 392 ++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 23 files changed, 2597 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 drivers/watchdog/bd70528_wdt.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
