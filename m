From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
Date: Thu, 28 May 2015 20:53:25 +0200
Message-ID: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

	Hi all,

This patch series adds Clock Domain support to the Clock Pulse Generator
(CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain, to
be used on shmobile SoCs without device power domains (R-Car Gen1 and
Gen2, RZ).  This allows to power-manage the module clocks of SoC devices
that are part of the CPG Clock Domain using Runtime PM, or for system
suspend/resume, similar to SoCs with device power domains (SH-Mobile and
R-Mobile).

SoC devices that are part of the CPG Clock Domain and can be
power-managed through an MSTP clock are tagged in DT with a proper
"power-domains" property. This applies to most on-SoC devices, which
have a one-to-one mapping from SoC device to DT device node.
Notable exceptions are "display" and "sound" device nodes, which
represent multiple SoC devices, each having their own MSTP clocks. Hence
drivers for such devices still have to manage their (multiple module)
clocks themselves.

The (MSTP) clock to use for power-management is found by scanning for
clocks that are compatible with "renesas,cpg-mstp-clocks".
Before, the "first" clock tied to each device (con_id NULL) was used,
being a bit ad-hoc. It was suggested to use the "fck" clock instead,
but this may conflict with DT bindings for devices we don't control
(e.g. GIC-400 plans to mandate "clk" for the clk-name of its single
clock). Looking for real MSTP clocks avoids this problem.

Logically, the CPG Clock Domain operates on the SoC CPG/MSTP block.
As there's no single device node in DT representing this block (there
are separate device nodes for the CPG and for the individual MSTP
clocks), I bound the logic to the CPG device node.
Perhaps this is something we should change for future SoCs?

Finally, the legacy default PM domain hack in drivers/sh/pm_runtime.c
is no longer needed when running an ARM multi-platform kernel on an
shmobile SoC with genpd support. Please note that this hack is still
needed for legacy (SH/ARM) platforms, and for the CONFIG_PM=n case.
Perhaps we should unconditionally enable PM when building shmobile
multi-platform kernels?

Compared to the legacy default PM domain hack, the CPG Clock Domain has
several advantages:
  - It only affects on-SoC devices, not all platform devices,
  - It only affects the on-SoC devices we want, as specified in DT,
  - Allmost all module clocks of all on-SoC devices (barring devices
    needed for wake-up) are now gated during s2ram, saving more power.

By adding a small quirk to the CPG Clock Domain code, its functions to
attach/detach devices to a PM Domain can be reused by the pm-rmobile
driver, reducing code duplication.

Here's a list of all devices in the CPG Clock Domain on r8a7791:

root@koelsch:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
cpg_clocks                      on               
    /devices/platform/e61c0000.interrupt-controller     active
    /devices/platform/e60b0000.i2c                      suspended
    /devices/platform/ffca0000.timer                    suspended
    /devices/platform/e6590100.usb-phy                  unsupported
    /devices/platform/e6050000.gpio                     active
    /devices/platform/e6051000.gpio                     active
    /devices/platform/e6052000.gpio                     active
    /devices/platform/e6053000.gpio                     active
    /devices/platform/e6054000.gpio                     active
    /devices/platform/e6055000.gpio                     active
    /devices/platform/e6055400.gpio                     active
    /devices/platform/e6055800.gpio                     active
    /devices/platform/ee090000.pci                      active
    /devices/platform/ee0d0000.pci                      active
    /devices/platform/fe000000.pcie                     unsupported
    /devices/platform/e6700000.dma-controller           active
    /devices/platform/e6720000.dma-controller           active
    /devices/platform/ec700000.dma-controller           active
    /devices/platform/ec720000.dma-controller           suspended
    /devices/platform/e65a0000.dma-controller           suspended
    /devices/platform/e65b0000.dma-controller           suspended
    /devices/platform/e6e60000.serial                   active
    /devices/platform/e6e68000.serial                   active
    /devices/platform/ee300000.sata                     unsupported
    /devices/platform/e6b10000.spi                      suspended
    /devices/platform/e6e20000.spi                      suspended
    /devices/platform/ee700000.ethernet                 active
    /devices/platform/e6530000.i2c                      suspended
    /devices/platform/e6ef1000.video                    suspended
    /devices/platform/e61f0000.thermal                  active
    /devices/platform/ee100000.sd                       active
    /devices/platform/ee140000.sd                       active
    /devices/platform/ee160000.sd                       active
root@koelsch:~# 

Patch overview:
  - Patch 1 adds the core CPG Clock Domain code to the CPG MSTP driver,
  - Patches 2-5 adds CPG Clock Domain driver support for all Renesas
    SoCs that have MSTP clocks, but no device power domains, and
    updates the DT binding documentation accordingly,
  - Patches 6-11 add CPG Clock Domains to the dtsi files,
  - Patch 12 disables the legacy default PM domain hack on all ARM
    multi-platform builds with genpd support, now it's no longer needed
    nor wanted,
  - Patch 13 adds a quirk for r8a73a4 and sh73a0, where the Bus State
    Controller is not power-managed by an MSTP clock, but by a plain
    CPG clock,
  - Patch 14 makes the R-Mobile PM Domain driver use the CPG Clock
    Domain attach/detach helpers, as they're more future-proof, and to
    reduce code duplication.

Changes compared to v1
("[PATCH/RFC 0/5] ARM: shmobile: rcar-gen2: Add CPG Clock Domain",
https://www.marc.info/?l=linux-pm&m=142670805530085&w=3):
  - Add Acked-by and Reviewed-by.
  - Move core CPG Clock Domain code from the R-Car Gen2 driver to the
    CPG MSTP Clocks driver, as it's generic, and can be used on other
    Renesas SoCs that have a CPG/MSTP block,
  - Scan for an MSTP clock instead of using the first clock tied to the
    device (con_id NULL),
  - Add support for R-Car Gen1 and RZ, in addition to R-Car Gen2,
    allowing to drop the legacy default PM domain hack completely in
    multi-platform builds,
  - Reuse the CPG Clock Domain attach/detach helpers for pm-rmobile.
More detailed change logs are available in the individual patches.

Dependencies:
  - This series is against next-20150528,
  - As usual when involving clocks and/or PM Domains, there are stringent
    dependencies between the (subsets of) patches:
      - Patches 2-5 depend on patch 1,
      - Patches 6-11 depend on patches 2-5,
      - Patch 12 depends on patches 6-11,
      - Patch 13 depends on patch 1 only,
      - Patch 14 depends on patch 13.

All of this was tested on:
  - r8a73a4/ape6evm (multiplatform),
  - r8a7740/armadillo (both legacy and multiplatform),
  - r8a7791/koelsch (multiplatform, with and without CONFIG_PM),
  - sh73a0/kzm9g (both legacy and multiplatform).

Testing on other shmobile platforms (esp. R-Car Gen1 and RZ) would be
appreciated.

Thanks!

Geert Uytterhoeven (14):
    clk: shmobile: Add CPG Clock Domain support
  * clk: shmobile: r8a7778: Add CPG Clock Domain support
  * clk: shmobile: r8a7779: Add CPG Clock Domain support
    clk: shmobile: rcar-gen2: Add CPG Clock Domain support
  * clk: shmobile: rz: Add CPG Clock Domain support
  * ARM: shmobile: r7s72100 dtsi: Add CPG Clock Domain
  * ARM: shmobile: r8a7778 dtsi: Add CPG Clock Domain
  * ARM: shmobile: r8a7779 dtsi: Add CPG Clock Domain
    ARM: shmobile: r8a7790 dtsi: Add CPG Clock Domain
    ARM: shmobile: r8a7791 dtsi: Add CPG Clock Domain
    ARM: shmobile: r8a7794 dtsi: Add CPG Clock Domain
    drivers: sh: Stop using pm_runtime.c for multi-platform shmobile with
      genpd
  * clk: shmobile: mstp: Consider "zb_clk" suitable for power management
  * ARM: shmobile: R-Mobile: Use CPG Clock Domain attach/detach helpers

  (* = NEW)

 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 29 ++++++-
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 30 +++++++-
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++-
 .../bindings/clock/renesas,rz-cpg-clocks.txt       | 29 ++++++-
 arch/arm/boot/dts/r7s72100.dtsi                    | 19 +++++
 arch/arm/boot/dts/r8a7778.dtsi                     | 22 ++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 23 ++++++
 arch/arm/boot/dts/r8a7790.dtsi                     | 78 +++++++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi                     | 81 +++++++++++++++++--
 arch/arm/boot/dts/r8a7794.dtsi                     | 28 +++++++
 arch/arm/mach-shmobile/Kconfig                     |  2 +
 arch/arm/mach-shmobile/pm-rmobile.c                |  6 ++
 drivers/clk/shmobile/clk-mstp.c                    | 90 ++++++++++++++++++++++
 drivers/clk/shmobile/clk-r8a7778.c                 |  2 +
 drivers/clk/shmobile/clk-r8a7779.c                 |  2 +
 drivers/clk/shmobile/clk-rcar-gen2.c               |  4 +
 drivers/clk/shmobile/clk-rz.c                      |  3 +
 drivers/sh/Makefile                                |  4 +
 drivers/sh/pm_runtime.c                            | 18 -----
 include/linux/clk/shmobile.h                       | 12 +++
 20 files changed, 468 insertions(+), 40 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
