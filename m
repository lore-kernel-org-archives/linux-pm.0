From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 00/11] soc: renesas: Add R-Car SYSC PM Domain Support
Date: Wed,  9 Mar 2016 20:18:36 +0100
Message-ID: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60903 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933979AbcCITSu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 14:18:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series introduces a DT-based driver for the R-Car System
Controller.

This is a dependency for the enablement of DU and VSP on R-Car H3, as
the VSPs are located in a PM Domain.

Changes compared to v2:
  - Add Reviewed-by,
  - Rename driver from pm-rcar to rcar-sysc,
  - Create PM Domains from hierarchy in C data instead of DT,
  - Add support for an "always-on" domain, which is currently used on
    R-Car H3 only (support can be added for other R-Car SoCs, preferably
    after their migration to CPG/MSSR),
  - Drop power area A3SH on R-Car H3, as it's no longer
    documented in the datasheet, and touching it seems to crash SYSC,
  - Hook up the CPG/MSSR Clock Domain attach/detach callbacks instead of
    using our own copies,
  - Initialize SYSCIER early, as SYSC needs the interrupt sources to be
    enabled to control power,
  - Mask all SYSC interrupt sources for the CPU,
  - Drop check for CONFIG_PM_GENERIC_DOMAINS, which is now always
    enabled on R-Car SoCs,
  - Use early_initcall() instead of core_initcall(),
  - Do not power up CPU power areas during initialization, as this is
    handled later (directly or indirectly) by the SMP code,
  - Extract bindings into its own series, "[PATCH v3 0/7] PM / Domains:
    Add DT bindings for the R-Car System Controller".


Changes compared to v1 (more details in the individual patches):
  - Moved pm-rcar from arch/arm/mach-shmobile/ to drivers/soc/renesas/,
  - Added R-Car H3 (r8a7795) support, incl. support for devices part of
    a SYSC PM domain and the CPG/MSSR clock domain,
  - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
  - Added fallback compatibility strings for R-Car Gen2 and Gen3.
  - Changed one-line summary prefix to match current arm-soc practices,
  - The L2 cache-controller patches have been extracted into a separate
    series ("[PATCH v3 0/7] ARM/arm64: dts: renesas: Add/complete L2
    cache-controller nodes"),
  - Minor fixes.


Dependencies:
  - renesas-devel-20160307-v4.5-rc7,
  - "[PATCH 0/4] clk: renesas: PM Domain Cleanups and Preparation".

This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
and r8a7795/salvator-x.

Thanks for your comments!

Geert Uytterhoeven (11):
  soc: renesas: Move pm-rcar to drivers/soc/renesas/rcar-sysc
  soc: renesas: rcar-sysc: Improve rcar_sysc_power() debug info
  soc: renesas: rcar-sysc: Add DT support for SYSC PM domains
  soc: renesas: rcar-sysc: Make rcar_sysc_power_is_off() static
  soc: renesas: rcar-sysc: Enable Clock Domain for r8a7795 I/O devices
  soc: renesas: rcar-sysc: Add support for R-Car H1 power areas
  soc: renesas: rcar-sysc: Add support for R-Car H2 power areas
  soc: renesas: rcar-sysc: Add support for R-Car M2-W power areas
  soc: renesas: rcar-sysc: Add support for R-Car M2-N power areas
  soc: renesas: rcar-sysc: Add support for R-Car E2 power areas
  soc: renesas: rcar-sysc: Add support for R-Car H3 power areas

 arch/arm/mach-shmobile/Kconfig                     |  11 +-
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/pm-r8a7779.c                |   3 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |   2 +-
 arch/arm/mach-shmobile/pm-rcar.c                   | 164 ---------
 arch/arm/mach-shmobile/smp-r8a7779.c               |   2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c               |   2 +-
 drivers/soc/Makefile                               |   3 +-
 drivers/soc/renesas/Makefile                       |   7 +
 drivers/soc/renesas/r8a7779-sysc.c                 |  31 ++
 drivers/soc/renesas/r8a7790-sysc.c                 |  45 +++
 drivers/soc/renesas/r8a7791-sysc.c                 |  32 ++
 drivers/soc/renesas/r8a7794-sysc.c                 |  32 ++
 drivers/soc/renesas/r8a7795-sysc.c                 |  56 +++
 drivers/soc/renesas/rcar-sysc.c                    | 394 +++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.h                    |  60 ++++
 .../linux/soc/renesas/rcar-sysc.h                  |   9 +-
 17 files changed, 673 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rcar.c
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/r8a7779-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7790-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7791-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7794-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7795-sysc.c
 create mode 100644 drivers/soc/renesas/rcar-sysc.c
 create mode 100644 drivers/soc/renesas/rcar-sysc.h
 rename arch/arm/mach-shmobile/pm-rcar.h => include/linux/soc/renesas/rcar-sysc.h (60%)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
