From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
Date: Wed, 22 Jul 2015 15:00:37 +0200
Message-ID: <CAPDyKFp=zoo1OY9K-dYh9e2OV-OFVp36MbXX83vT19uFWB+0Yg@mail.gmail.com>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 July 2015 at 17:57, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>         Hi all,
>
> This patch series adds Clock Domain support to the Clock Pulse Generator
> (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain, to
> be used on shmobile SoCs without device power domains (R-Car Gen1 and
> Gen2, RZ).  This allows to power-manage the module clocks of SoC devices
> that are part of the CPG/MSTP Clock Domain using Runtime PM, or for
> system suspend/resume, similar to SoCs with device power domains
> (SH-Mobile and R-Mobile).
>
> SoC devices that are part of the CPG/MSTP Clock Domain and can be
> power-managed through an MSTP clock are tagged in DT with a proper
> "power-domains" property, also serving as a visual clue. This applies to
> most on-SoC devices, which have a one-to-one mapping from SoC device to
> DT device node.  Notable exceptions are "display" and "sound" device
> nodes, which represent multiple SoC devices, each having their own MSTP
> clocks. Hence drivers for such devices still have to manage their
> (multiple module) clocks themselves.
>
> The (MSTP) clock to use for power-management is found by scanning for
> clocks that are compatible with "renesas,cpg-mstp-clocks".
> In V1, the "first" clock tied to each device (con_id NULL) was used,
> being a bit ad-hoc. It was suggested to use the "fck" clock instead,
> but this may conflict with DT bindings for devices we don't control
> (e.g. GIC-400 plans to mandate "clk" for the clk-name of its single
> clock). Looking for real MSTP clocks avoids this problem.
>
> Logically, the CPG/MSTP Clock Domain operates on the SoC CPG/MSTP block.
> As there's no single device node in DT representing this block (there
> are separate device nodes for the CPG and for the individual MSTP
> clocks), I bound the logic to the CPG device node.  Perhaps this is
> something we should change for future SoCs?
>
> Finally, the legacy default PM domain hack in drivers/sh/pm_runtime.c
> is no longer needed when running an ARM multi-platform kernel on an
> shmobile SoC with genpd support. Please note that this hack is still
> needed for legacy (SH/ARM) platforms, and for the CONFIG_PM=n case.
> Perhaps we should unconditionally enable PM when building shmobile
> multi-platform kernels?
>
> Compared to the legacy default PM domain hack, the CPG/MSTP Clock Domain
> has several advantages:
>   - It only affects on-SoC devices, not all platform devices,
>   - It only affects the on-SoC devices we want, as specified in DT,
>   - Allmost all module clocks of all on-SoC devices (barring devices
>     needed for wake-up) are now gated during s2ram, saving more power.
>
> By adding a small quirk to the CPG/MSTP Clock Domain code, its functions
> to attach/detach devices to a PM Domain can be reused by the pm-rmobile
> driver, reducing code duplication.
>
> Here's a list of all devices in the CPG/MSTP Clock Domain on r8a7791:
>
> root@koelsch:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
>            /device                                      runtime status
> ----------------------------------------------------------------------
> cpg_clocks                      on
>     /devices/platform/e61c0000.interrupt-controller     active
>     /devices/platform/e60b0000.i2c                      suspended
>     /devices/platform/ffca0000.timer                    suspended
>     /devices/platform/e6590100.usb-phy                  unsupported
>     /devices/platform/e6050000.gpio                     active
>     /devices/platform/e6051000.gpio                     active
>     /devices/platform/e6052000.gpio                     active
>     /devices/platform/e6053000.gpio                     active
>     /devices/platform/e6054000.gpio                     active
>     /devices/platform/e6055000.gpio                     active
>     /devices/platform/e6055400.gpio                     active
>     /devices/platform/e6055800.gpio                     active
>     /devices/platform/ee090000.pci                      active
>     /devices/platform/ee0d0000.pci                      active
>     /devices/platform/fe000000.pcie                     unsupported
>     /devices/platform/e6700000.dma-controller           active
>     /devices/platform/e6720000.dma-controller           active
>     /devices/platform/ec700000.dma-controller           active
>     /devices/platform/ec720000.dma-controller           suspended
>     /devices/platform/e65a0000.dma-controller           suspended
>     /devices/platform/e65b0000.dma-controller           suspended
>     /devices/platform/e6e60000.serial                   active
>     /devices/platform/e6e68000.serial                   active
>     /devices/platform/ee300000.sata                     unsupported
>     /devices/platform/e6b10000.spi                      suspended
>     /devices/platform/e6e20000.spi                      suspended
>     /devices/platform/ee700000.ethernet                 active
>     /devices/platform/e6530000.i2c                      suspended
>     /devices/platform/e6ef1000.video                    suspended
>     /devices/platform/e61f0000.thermal                  active
>     /devices/platform/ee100000.sd                       active
>     /devices/platform/ee140000.sd                       active
>     /devices/platform/ee160000.sd                       active
> root@koelsch:~#
>
> Patch overview:
>   - Patch 1 adds the core CPG/MSTP Clock Domain code to the CPG MSTP
>     driver,
>   - Patches 2-5 adds CPG/MSTP Clock Domain driver support for all
>     Renesas SoCs that have MSTP clocks, but no device power domains, and
>     updates the DT binding documentation accordingly,
>   - Patches 6-12 add CPG/MSTP Clock Domains to the dtsi files,
>   - Patches 13 and 14 disable the legacy default PM domain hack on all
>     ARM multi-platform builds with genpd support, now it's no longer
>     needed nor wanted,
>   - Patch 15 adds a quirk for r8a73a4 and sh73a0, where the Bus State
>     Controller is not power-managed by an MSTP clock, but by a plain
>     CPG clock,
>   - Patch 16 makes the R-Mobile PM Domain driver use the CPG/MSTP Clock
>     Domain attach/detach helpers, as they're more future-proof, and to
>     reduce code duplication.
>
> Changes compared to v2 ("[PATCH v2 00/14] ARM: shmobile: Add CPG Clock
> Domains", https://lkml.org/lkml/2015/5/28/590):
>   - Add Acked-by,
>   - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",
>   - Drop bogus addition of #includes to clk-rcar-gen2.c,
>   - Call pm_clk_destroy() from cpg_mstp_detach_dev() only if
>     cpg_mstp_attach_dev() actually added a clock,
>   - Add "power-domains" property to recently introduced Ethernet AVB
>     device node,
>   - Add CPG/MSTP Clock Domain to recently introduced r8a7793 SoC,
>   - The legacy default PM Domain runtime check must stay for the ARM
>     multiplatform CONFIG_PM=n case, to prevent the code from running on
>     non-shmobile machines,
>   - Provide backwards-compatibility with old DTs (mainly for R-Car
>     Gen2),
>   - Extract EMMA Mobile EV2 removal into a separate patch,
>   - Replace explicit platform checks in the legacy default PM Domain
>     code by a check for the presence of MSTP clocks,
>   - Drop references to legacy r8a7740/sh73a0, which are gone.
>
> Changes compared to v1 ("[PATCH/RFC 0/5] ARM: shmobile: rcar-gen2: Add
> CPG Clock Domain",
> https://www.marc.info/?l=linux-pm&m=142670805530085&w=3):
>   - Add Acked-by and Reviewed-by.
>   - Move core CPG Clock Domain code from the R-Car Gen2 driver to the
>     CPG MSTP Clocks driver, as it's generic, and can be used on other
>     Renesas SoCs that have a CPG/MSTP block,
>   - Scan for an MSTP clock instead of using the first clock tied to the
>     device (con_id NULL),
>   - Add support for R-Car Gen1 and RZ, in addition to R-Car Gen2,
>     allowing to drop the legacy default PM domain hack completely in
>     multi-platform builds,
>   - Reuse the CPG Clock Domain attach/detach helpers for pm-rmobile.
> More detailed change logs are available in the individual patches.
>
> Dependencies:
>   - This series is against renesas-drivers-2015-06-29-v4.1, i.e. it
>     depends on the removal of legacy r8a7740/sh73a0 support,
>   - As usual when involving clocks and/or PM Domains, there are stringent
>     dependencies between the (subsets of) patches:
>       - Patches 2-5 depend on patch 1,
>       - Patches 6-12 depend on patches 2-5,
>       - Patch 14 depends on patches 6-13,
>       - Patch 15 depends on patch 1 only,
>       - Patch 16 depends on patch 15.
>
> All of this was tested on:
>   - r8a73a4/ape6evm,
>   - r8a7740/armadillo,
>   - r8a7791/koelsch (with and without CONFIG_PM),
>   - sh73a0/kzm9g.
>
> Testing on other shmobile platforms (esp. R-Car Gen1 and RZ) would be
> appreciated.
>
> I think this series goes best in through Simon's shmobile tree.
>
> Thanks for applying!
>
> Geert Uytterhoeven (16):
>   [1] clk: shmobile: Add CPG/MSTP Clock Domain support
>   [2] clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
>   [3] clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
>   [4] clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain support
>   [5] clk: shmobile: rz: Add CPG/MSTP Clock Domain support
>   [6] ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
>   [7] ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
>   [8] ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
>   [9] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
>   [10] ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
>   [11] ARM: shmobile: r8a7793 dtsi: Add CPG/MSTP Clock Domain
>   [12] ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain
>   [13] drivers: sh: Disable legacy default PM Domain on emev2
>   [14] drivers: sh: Disable PM runtime for multi-platform ARM with genpd
>   [15] clk: shmobile: mstp: Consider "zb_clk" suitable for power management
>   [16] ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach
>     helpers
>
>  .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 29 ++++++-
>  .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 30 +++++++-
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++-
>  .../bindings/clock/renesas,rz-cpg-clocks.txt       | 29 ++++++-
>  arch/arm/boot/dts/r7s72100.dtsi                    | 19 +++++
>  arch/arm/boot/dts/r8a7778.dtsi                     | 22 ++++++
>  arch/arm/boot/dts/r8a7779.dtsi                     | 23 ++++++
>  arch/arm/boot/dts/r8a7790.dtsi                     | 79 +++++++++++++++++--
>  arch/arm/boot/dts/r8a7791.dtsi                     | 81 +++++++++++++++++--
>  arch/arm/boot/dts/r8a7793.dtsi                     |  7 ++
>  arch/arm/boot/dts/r8a7794.dtsi                     | 28 +++++++
>  arch/arm/mach-shmobile/Kconfig                     |  2 +
>  arch/arm/mach-shmobile/pm-rmobile.c                | 35 +--------
>  drivers/clk/shmobile/clk-mstp.c                    | 90 ++++++++++++++++++++++
>  drivers/clk/shmobile/clk-r8a7778.c                 |  2 +
>  drivers/clk/shmobile/clk-r8a7779.c                 |  2 +
>  drivers/clk/shmobile/clk-rcar-gen2.c               |  2 +
>  drivers/clk/shmobile/clk-rz.c                      |  3 +
>  drivers/sh/pm_runtime.c                            | 19 ++---
>  include/linux/clk/shmobile.h                       | 12 +++
>  20 files changed, 472 insertions(+), 68 deletions(-)
>
> --

Unless it's too late; for the series - feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
