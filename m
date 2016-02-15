From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 00/11] ARM/arm64: renesas: Add SYSC PM Domain DT Support
Date: Mon, 15 Feb 2016 22:16:49 +0100
Message-ID: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:37553 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcBOVRK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 16:17:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

The Renesas R-Car System Controller, as found in various Renesas R-Car
SoCs, provides power management for the CPU cores and various
coprocessors.

This RFC patch series adds DT support for the R-Car SYSC, using the
generic PM Domain. It supports R-Car H1, R-Car Gen2, and R-Car H3.

Patches:
  - Patch 1 adds the DT binding documentation (alternatives I considered
    below the "---"-line),
  - Patch 2 moves the existing pm-rcar driver to drivers/soc/renesas, so
    it can be shared by arm32 and arm64,
  - Patches 3-5 contain the driver implementation,
  - Patches 6-11 add the SYSC PM domains themselves to the various dtsi
    files.

Known issues:
  - This needs better integration with the PM code in pm-rcar-gen2, the
    SMP code in smp-r8a7790, and Magnus' DT APMU series,
  - CPG/MSSR clock domain handling should share more code with the
    renesas-cpg-mssr driver.

Changes compared to v2 (more details in the individual patches):
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

This series is against renesas-devel-20160215-v4.5-rc4, with series
"[PATCH v3 0/7] ARM/arm64: dts: renesas: Add/complete L2
cache-controller nodes" applied. It is not yet meant to be applied!
It's published as-is to ease development of drivers for devices residing
in a SYSC PM domain on R-Car H3 (e.g. VSP, FCP_V).

This was tested on r8a7779/marzen, r8a7791/koelsch, r8a7794/alt, and
r8a7795/salvator-x.

For your convenience, I've also pushed this series to
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#topic/rcar-sysc-pd-rfc-v2

Thanks for your comments!

Geert Uytterhoeven (11):
  PM / Domains: Add DT bindings for the R-Car System Controller
  soc: renesas: Move pm-rcar to drivers/soc/renesas/
  soc: renesas: Improve rcar_sysc_power() debug info
  soc: renesas: rcar: Add DT support for SYSC PM domains
  soc: renesas: rcar: Handle clock domain devices in SYSC PM domains
  ARM: dts: r8a7779: Add SYSC PM domains
  ARM: dts: r8a7790: Add SYSC PM domains
  ARM: dts: r8a7791: Add SYSC PM domains
  ARM: dts: r8a7793: Add SYSC PM domains
  ARM: dts: r8a7794: Add SYSC PM domains
  arm64: dts: r8a7795: Add SYSC PM domains

 .../bindings/power/renesas,sysc-rcar.txt           |  87 ++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  48 ++
 arch/arm/boot/dts/r8a7790.dtsi                     |  89 ++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  40 ++
 arch/arm/boot/dts/r8a7793.dtsi                     |  39 ++
 arch/arm/boot/dts/r8a7794.dtsi                     |  40 ++
 arch/arm/mach-shmobile/Kconfig                     |   8 +-
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/pm-r8a7779.c                |   3 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |   2 +-
 arch/arm/mach-shmobile/pm-rcar.c                   | 164 ------
 arch/arm/mach-shmobile/smp-r8a7779.c               |   2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c               |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 142 ++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   3 +-
 drivers/soc/renesas/Kconfig                        |   8 +
 drivers/soc/renesas/Makefile                       |   1 +
 drivers/soc/renesas/pm-rcar.c                      | 559 +++++++++++++++++++++
 .../linux/soc/renesas}/pm-rcar.h                   |   2 +
 20 files changed, 1065 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
 delete mode 100644 arch/arm/mach-shmobile/pm-rcar.c
 create mode 100644 drivers/soc/renesas/Kconfig
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/pm-rcar.c
 rename {arch/arm/mach-shmobile => include/linux/soc/renesas}/pm-rcar.h (93%)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
