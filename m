From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC 0/5] ARM: shmobile: rcar-gen2: Add CPG Clock Domain
Date: Fri, 20 Mar 2015 09:54:33 +0100
Message-ID: <CAPDyKFox=MoUX5tzxyVjLh+d61AFNsPR+LY0sP-VF+68Gs_rKw@mail.gmail.com>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18 March 2015 at 20:46, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>         Hi,
>
> This RFC patch series adds Clock Domain support to the R-Car Gen2 Clock
> Pulse Generator (CPG) driver using the generic PM Domain.  This allows
> to power-manage the module clocks of SoC devices that are part of the
> CPG Clock Domain using Runtime PM, or for system suspend/resume.
>
> SoC devices that are part of the CPG Clock Domain and can be
> power-managed through their primary clock are tagged in DT with a proper
> "power-domains" property. Drivers for devices with multiple clocks
> (notably du and rcar-sound) still have to manage their (multiple module)
> clocks themselves.
>
> Finally, the legacy default PM domain hack in drivers/sh/pm_runtime.c is
> disabled when running on an R-Car Gen2 SoC with genpd support.
>
> Compared to the legacy default PM domain hack, the CPG Clock Domain has
> several advantages:
>   - It only affects on-SoC devices, not all platform devices,
>   - It only affects the on-SoC devices we want, as specified in DT,
>   - Allmost all module clocks of all on-SoC devices (barring devices
>     needed for wake-up[*]) are now gated during s2ram, saving more
>     power.
>
> Here's a list of all devices in the CPG Clock Domain on r8a7791:
>
> root@koelsch:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
>            /device                                      runtime status
> ----------------------------------------------------------------------
> cpg_clocks                      on
>     /devices/platform/e61c0000.interrupt-controller     active
>     /devices/platform/e60b0000.i2c                      suspended
>     /devices/platform/ffca0000.timer                    suspended
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
> Logically, the CPG Clock Domain operates on the SoC CPG/MSTP block.
> As there's no single device node in DT representing this block (there
> are separate device nodes for the CPG and for the individual MSTP
> clocks), I bound the logic to the CPG device node.
> Perhaps this is something we should change for future SoCs?
>
> As usual when involving clocks and/or PM Domains, the DTS changes depend
> stricly on the driver change. The final patch must be applied last.
>
> The DTS changes also depend on the series "[PATCH 0/5] ARM: shmobile:
> Add INTC-SYS clock to device tree" I've just sent.
>
> This was tested on r8a7791/koelsch.
>
> Thanks for your comments!
>
> [*] GPIO wake-up requires "[PATCH 0/3] gpio: rcar: Fix wake up using
> gpio-keys with PM domain").
>
> Geert Uytterhoeven (5):
>   [RFC] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
>   [RFC] ARM: shmobile: r8a7790 dtsi: Add CPG Clock Domain
>   [RFC] ARM: shmobile: r8a7791 dtsi: Add CPG Clock Domain
>   [RFC] ARM: shmobile: r8a7794 dtsi: Add CPG Clock Domain
>   drivers: sh: Disable PM runtime for multi-platform R-Car Gen2 with
>     genpd
>
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++-
>  arch/arm/boot/dts/r8a7790.dtsi                     | 77 +++++++++++++++++++--
>  arch/arm/boot/dts/r8a7791.dtsi                     | 80 ++++++++++++++++++++--
>  arch/arm/boot/dts/r8a7794.dtsi                     | 29 ++++++++
>  arch/arm/mach-shmobile/Kconfig                     |  1 +
>  drivers/clk/shmobile/clk-rcar-gen2.c               | 63 +++++++++++++++++
>  drivers/sh/pm_runtime.c                            | 10 +--
>  7 files changed, 268 insertions(+), 18 deletions(-)

For the complete patchset.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> --
> 1.9.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
