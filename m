From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Mon, 20 Feb 2017 21:33:23 +0100
Message-ID: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

This patch series adds support for using non-PMIC wake-up sources on the
Renesas R-Car Gen3 (H3 or M3-W) Salvator-X development boards.

Nothing in the PSCI specification requires the SoC to remain powered and
to support wake-up sources when suspended using SYSTEM_SUSPEND.
If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
power to the SoC, the only possibly wake-up sources are thus the ones
connected to the PMIC.

To allow other wake-up sources, this patch series documents and adds
support for an "arm,psci-system-suspend-is-power-down" DT property, so
Linux uses a different suspend method when other wake-up sources (e.g.
wake on LAN, UART or GPIO) are enabled.  Hence the user no longer has to
manually restrict "mem" suspend to "s2idle" or "shallow" states using:

    $ echo s2idle > /sys/power/mem_sleep # or "shallow"

Contents:
  - Patch 1 prevents the alarmtimer from showing up as a wake-up source
    when no wake-up capable RTC device is present in the system,
  - Patch 2 provides an API to check if any wake-up sources have been
    registered,
  - Patch 3 implements "shallow" suspend mode on systems using PSCI,
    in addition to the existing "s2idle" and "deep" suspend modes,
  - Patch 4 makes the system use "shallow" instead of "deep" suspend
    mode on systems where this is needed to support non-PMIC wake-up
    sources,
  - Patches 5 and 6 enable the above on Renesas R-Car H3 and M3-W
    systems.

Dependencies:
  - The three first patches are independent,
  - The fourth patch depends on the first three patches,
  - The DTS patches depend on acceptance of the DT bindings in patch 4.

This has been tested on both the Renesas R-Car H3 (quad A57*)
and M3-W (dual A57*) Salvator-X development boards
(*A53 cores are unused).

Power consumption:

		H3	M3-W
		--	----
  - idle:	9.2 W	7.6 W
  - s2idle:	8.6 W	6.3 W
  - shallow:	8.4 W	6.2 W	(secondary CPU cores off)
  - deep:	1.4 W	1.2 W	(PSCI_SYSTEM_SUSPEND)
  - shutdown:	7.7 W	5.6 W	(PSCI SYSTEM_OFF: needs improvement)
  - poweroff:	1.3 W	1.1 W	(fan running)

Thanks for your comments!

Geert Uytterhoeven (6):
  alarmtimer: Postpone wake-up source registration until really
    available
  PM / Wakeup: Add wakeup_source_available()
  drivers: firmware: psci: Implement shallow suspend mode
  drivers: firmware: psci: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
    power
  arm64: dts: r8a7795: Fix non-PMIC wake-up sources
  arm64: dts: r8a7796: Fix non-PMIC wake-up sources

 Documentation/devicetree/bindings/arm/psci.txt | 11 ++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi       |  1 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi       |  1 +
 drivers/base/power/wakeup.c                    |  8 ++++++
 drivers/firmware/psci.c                        | 39 ++++++++++++++++++++++++--
 include/linux/pm_wakeup.h                      |  3 ++
 kernel/time/alarmtimer.c                       |  9 +++++-
 7 files changed, 68 insertions(+), 4 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
