From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/5] arm64: dts: renesas: Salvator-X/XS: Enable DDR Backup Mode
Date: Tue, 10 Oct 2017 17:26:13 +0200
Message-ID: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

The ROHM BD9571MWV PMIC on the Renesas Salvator-X/XS development boards
supports DDR Backup Power, which means that the DDR power rails can be
kept powered while the main SoC is powered down.

Currently performing a system suspend/resume cycle involves several
manual steps:
  1. Configure the PMIC for Backup Mode, using
     "i2cset -f -y 7 0x30 0x20 0x0f",
  2. Switch off SW23 (the ACC switch, which now changes role from power
     switch to wake-up switch) to prepare for suspend,
  3. Suspend to RAM, using "echo mem > /sys/power/state",
  4. Switch on SW23 to resume.

Especially the first step is cumbersome, as it relies on
  1. Intimate knowledge about the PMIC and actual board design,
  2. direct i2c access,
  3. having the i2cset utility available.
In addition, it has to be redone after system resume.

This patch series integrates Backup Mode configuration into the PMIC
driver, using a sysfs virtual file.  E.g. it can be enabled using:

    echo on > /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.3.auto/backup_mode

Backup Mode state is retained across suspend/resume cycles.

Which DDR rails are to be kept powered is board-specific, and controlled
using the optional "rohm,ddr-backup-power" property in the board DTS
file.

Note that the last patch depends on "[PATCH/RFC] arm64: dts: renesas:
salvator-common: Add BD9571 PMIC".

Thanks for your comments!

Geert Uytterhoeven (5):
  dt-bindings: mfd: bd9571mwv: Document rohm,ddr-backup-power
  mfd: bd9571mwv: Add DDR Backup Power register bit definitions
  mfd: bd9571mwv: Allow DDR Backup Power register access
  regulator: bd9571mwv: Add support for backup mode
  arm64: dts: renesas: salvator-common: Configure PMIC for DDR Backup
  Power

 .../devicetree/bindings/mfd/bd9571mwv.txt          |   7 ++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   1 +
 drivers/mfd/bd9571mwv.c                            |   2 +
 drivers/regulator/bd9571mwv-regulator.c            | 121 ++++++++++++++++++++-
 include/linux/mfd/bd9571mwv.h                      |   5 +
 5 files changed, 134 insertions(+), 2 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
