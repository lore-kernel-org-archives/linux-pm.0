From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 0/9] Atmel System Timer cleanups
Date: Thu,  5 Mar 2015 16:49:45 +0100
Message-ID: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch set cleans up the system timer driver.

The main goal is to get rid of the mach/ headers dependency. At the same time,
it introduces proper probing and locking (using a regmap) for the watchdog
driver.

This is based on 4.0-rc1 and will have two merge conflicts with my cleanup #1 in
mach-at91/at91rm9200.c

Changes in v4:
 - Added MODULE_* metadata in at91rm9200-reset
 - Proper copyright in at91rm9200-reset
 - Use BIT() in atmel-st.h
 - changed MODULE_ALIAS in at91rm9200_wdt.c

Changes in v3:
 - stop using an mfd and get the syscon directly from the watchdog driver
 - introduce a proper reset driver to handle reset

Changes in v2:
 - cleaned up more includes in the watchdog driver
 - stop using if OF when selecting CLKSRC_OF
 - stop initializing .owner


Alexandre Belloni (9):
  ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
  mfd: syscon: Add atmel system timer registers definition
  watchdog: at91rm9200: use the system timer syscon
  power: reset: Add AT91RM9200 reset driver
  ARM: at91: at91rm9200: remove deprecated arm_pm_restart
  ARM: at91: time: move the system timer driver to drivers/clocksource
  clocksource: atmel-st: properly initialize driver
  clocksource: atmel-st: use syscon/regmap
  ARM: at91: remove useless include

 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/mach-at91/Makefile                        |   2 +-
 arch/arm/mach-at91/at91rm9200.c                    |  19 ----
 arch/arm/mach-at91/generic.h                       |   3 -
 arch/arm/mach-at91/include/mach/at91_st.h          |  61 ------------
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 .../clocksource/timer-atmel-st.c                   | 103 ++++++++-------------
 drivers/power/reset/Kconfig                        |   7 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91rm9200-reset.c             |  72 ++++++++++++++
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/at91rm9200_wdt.c                  |  23 +++--
 include/linux/mfd/syscon/atmel-st.h                |  49 ++++++++++
 15 files changed, 194 insertions(+), 157 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (77%)
 create mode 100644 drivers/power/reset/at91rm9200-reset.c
 create mode 100644 include/linux/mfd/syscon/atmel-st.h

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
