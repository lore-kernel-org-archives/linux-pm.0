From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 00/17] PM / wakeup : remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:46:56 +0100
Message-ID: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53967 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476AbbIUPsC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Sep 2015 11:48:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi,

As discussed in under the topic "Wakeup sources configuration and
management" in LPC PM microconference @ Seattle[1], this is the first
set of changes to remove the mis/ab-use of IRQF_NO_SUSPEND for wakeup
IRQ configuration. This list is not complete, there are few more usages
that can be removed.

Regards,
Sudeep

[1] http://www.linuxplumbersconf.org/2015/ocw//system/presentations/3051/original/wakeup_config.pdf

Sudeep Holla (17):
  rtc: pl031: remove misuse of IRQF_NO_SUSPEND flag
  rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag
  input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
  powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of redundant
    mpic_irq_set_wake
  platform: x86: remove misuse of IRQF_NO_SUSPEND flag
  rtc: ds1343: remove misuse of IRQF_NO_SUSPEND flag
  input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
  hwmon: abx500: drop the use of IRQF_NO_SUSPEND
  MIPS: ttyFDC: replace IRQF_NO_SUSPEND with IRQF_COND_SUSPEND
  tty/serial: st-asc: drop the use of IRQF_NO_SUSPEND
  pm: bf609: remove misuse of IRQF_NO_SUSPEND flag
  ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
  net: gianfar: remove misuse of IRQF_NO_SUSPEND flag
  media: st-rc: remove misuse of IRQF_NO_SUSPEND flag
  ir-hix5hd2: drop the use of IRQF_NO_SUSPEND
  pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
  mfd : ab8500/db8500: fix the abuse of IRQF_NO_SUSPEND

 arch/arm/mach-omap2/mux.c                 |  4 ++--
 arch/arm/mach-omap2/pm34xx.c              |  9 ++++-----
 arch/blackfin/mach-bf609/pm.c             | 13 +++++++------
 arch/powerpc/sysdev/mpic.c                | 23 ++++-------------------
 drivers/hwmon/abx500.c                    |  2 +-
 drivers/input/keyboard/tegra-kbc.c        |  2 +-
 drivers/media/rc/ir-hix5hd2.c             |  2 +-
 drivers/media/rc/st_rc.c                  | 14 +++++++++-----
 drivers/mfd/ab8500-core.c                 | 11 +++++++++--
 drivers/mfd/ab8500-debugfs.c              |  2 +-
 drivers/mfd/ab8500-gpadc.c                | 15 +++++++++++----
 drivers/mfd/db8500-prcmu.c                | 24 +++++++++++++++++-------
 drivers/mfd/qcom_rpm.c                    |  2 +-
 drivers/net/ethernet/freescale/gianfar.c  |  9 +++++----
 drivers/pinctrl/pinctrl-single.c          |  7 ++++---
 drivers/platform/x86/intel_mid_powerbtn.c | 10 ++++++++--
 drivers/power/ab8500_btemp.c              |  6 ++++--
 drivers/power/ab8500_charger.c            |  6 ++++--
 drivers/power/ab8500_fg.c                 |  9 ++++++---
 drivers/rtc/rtc-ab8500.c                  |  6 +++++-
 drivers/rtc/rtc-ds1343.c                  |  9 ++++++---
 drivers/rtc/rtc-pl031.c                   | 13 ++++++++-----
 drivers/thermal/db8500_thermal.c          |  5 ++---
 drivers/tty/mips_ejtag_fdc.c              |  4 ++--
 drivers/tty/serial/st-asc.c               |  2 +-
 drivers/tty/serial/stm32-usart.c          |  3 +--
 drivers/usb/phy/phy-ab8500-usb.c          | 10 ++++++----
 27 files changed, 130 insertions(+), 92 deletions(-)

-- 
1.9.1

