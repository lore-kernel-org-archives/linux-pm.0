From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/14] pinctrl: sh-pfc: Add suspend/resume support
Date: Wed,  4 Oct 2017 11:06:59 +0200
Message-ID: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
pinctrl register state is lost.  Note that as the boot loader skips most
initialization after system resume, pinctrl register state differs from
the state encountered during normal system boot, too.

To fix this, save all GPIO and peripheral function select, module
select, drive strength control, bias, and other I/O control registers
during system suspend, and restore them during resume.

This series consists of 4 parts:
  - Patches 1-2 are cleanups,
  - Patches 3-9 introduce a generic way to describe bias (pull-up/down)
    registers, and converts the R-Car Gen3 and R-Car M1A bias support
    over,
  - Patches 10-13 introduce a generic way to describe various IOCTRL
    registers, and converts the R-Car Gen3 I/O voltage support over,
  - Patch 14 implements the actual suspend/resume code, using the
    generic bias and IOCTRL support introduced earlier.

To avoid overhead on platforms not needing it, the suspend/resume code
has a build time dependency on sleep and PSCI support, and a runtime
dependency on PSCI.

Due to the more compact description of bias registers, this series
actually decreases kernel size (by ca. 112 bytes for renesas_defconfig,
and ca. 60 bytes for shmobile_defconfig).

Thanks for your comments!

Geert Uytterhoeven (14):
  pinctrl: sh-pfc: Remove matching on plain sh-pfc platform device
  pinctrl: sh-pfc: Drop width parameter of sh_pfc_{read,write}_reg()
  pinctrl: sh-pfc: Add generic bias register description
  pinctrl: sh-pfc: Add sh_pfc_pin_to_bias_reg() helper
  pinctrl: sh-pfc: r8a7795-es1: Use generic bias register description
  pinctrl: sh-pfc: r8a7795: Use generic bias register description
  pinctrl: sh-pfc: r8a7796: Use generic bias register description
  pinctrl: sh-pfc: r8a7778: Use generic bias register description
  pinctrl: sh-pfc: Remove obsolete sh_pfc_pin_to_bias_info()
  pinctrl: sh-pfc: Add generic IOCTRL register description
  pinctrl: sh-pfc: r8a7795-es1: Use generic IOCTRL register description
  pinctrl: sh-pfc: r8a7795: Use generic IOCTRL register description
  pinctrl: sh-pfc: r8a7796: Use generic IOCTRL register description
  pinctrl: sh-pfc: Save/restore registers for PSCI system suspend

 drivers/pinctrl/sh-pfc/core.c            | 129 +++++++-
 drivers/pinctrl/sh-pfc/core.h            |  11 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 403 +++++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 511 ++++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 511 ++++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 511 ++++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pinctrl.c         |  12 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  24 +-
 8 files changed, 1170 insertions(+), 942 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
