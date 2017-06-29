From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH/RFC v2 0/5] clk: renesas: rcar-gen3: Restore clocks
 during resume
Date: Thu, 29 Jun 2017 17:18:26 +0200
Message-ID: <20170629151826.GA18905@bigcity.dyn.berto.se>
References: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your hard work!

On 2017-06-29 15:25:15 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
> clock register state is lost.  Note that as the boot loader skips most
> initialization after resume, clock register state differs from the state
> encountered during normal system boot, too.
> 
> Hence after s2ram, some operations may fail because module clocks are
> disabled, while drivers expect them to be still enabled.  E.g. EtherAVB
> fails when Wake-on-LAN has been enabled using "ethtool -s eth0 wol g":
> 
>     ravb e6800000.ethernet eth0: failed to switch device to config mode
>     ravb e6800000.ethernet eth0: device will be stopped after h/w processes are done.
>     ravb e6800000.ethernet eth0: failed to switch device to config
>     PM: Device e6800000.ethernet failed to resume: error -110
> 
> In addition, some clocks that were disabled by clk_disable_unused() may
> have been re-enabled, wasting power.
> 
> This RFC is a second attempt to fix this issue by restoring clock registers
> during system resume.
> 
> Note that while this fixes EtherAVB operation after resume from s2ram,
> EtherAVB cannot be used as an actual wake-up source from s2ram, only
> from s2idle, due to PSCI limitations.
> 
> Changes compared to v1 (more details in the individual patches):
>   - Save module clock registers in suspend_noirq instead of constantly
>     updating shadow registers,
>   - Restore all module clocks under our control, not just the ones we ever
>     changed,
>   - Also restore DIV6, SDHI, and R clocks, thus covering all supported
>     programmable core clocks on R-Car Gen3.
> 
> As clock register restore is only needed on R-Car Gen3 with PSCI, although
> harmless on other systems, perhaps the save/restore code should be
> protected by #ifdef CONFIG_ARM_PSCI_FW?
> 
> This series is against clk-next, with "clk: renesas: div6: Document fields
> used for parent selection" applied on top.
> 
> This has been tested on Salvator-X with R-Car H3 ES1.0 and M3-W ES1.0.
> On Salvator-XS with R-Car H3 ES2.0, EtherAVB restarts after system resume,
> but NFS fails with "server not responding", probably not due to a clock
> issue.

I tested this series using this setup:

- Base latest renesas-drivers, 710def1a48c7bc9d ("of_mdio: Fix broken 
  PHY IRQ in case of probe deferral"). This branch also includes the 
  RAVB WoL patches.

- Salvator-X H3 ES1.0

- The arm64 defconfig.

The test procedure I used:

    arm64 ~/shared/deep-sleep # cat sleep.sh
    #!/bin/bash

    ethtool -s eth0 wol g

    echo disabled > /sys/devices/platform/soc/e6800000.ethernet/power/wakeup

    echo 0 > /sys/module/printk/parameters/console_suspend

    i2cset -f -y 7 0x30 0x20 0x0F

    echo "Flip Switch"
    read -n 1

    echo mem > /sys/power/state

And for me the NFS root came up OK after flipping switch back. I wonder 
what is different in our test procedures. I would like to provide my 
tested-by tag but I first want to figure out why NFS (or maybe the whole 
net interface?) don't work for you after resume.

arm64 ~/shared/deep-sleep # ./sleep.sh
Flip Switch

[  720.992971] PM: Syncing filesystems ... done.
[  720.998841] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  721.007530] OOM killer disabled.
[  721.010763] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  721.600789] vsp1 fea38000.vsp: pipeline 0 stop timeout
[  722.112773] vsp1 fea30000.vsp: pipeline 0 stop timeout
[  722.624769] vsp1 fea28000.vsp: pipeline 0 stop timeout
[  723.136772] vsp1 fea20000.vsp: pipeline 0 stop timeout
[  723.147535] ohci-platform ee080000.usb: runtime PM trying to suspend device but active child
[  723.156051] phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend device but active child
[  723.167851] ohci-platform ee0c0000.usb: runtime PM trying to suspend device but active child
[  723.176313] ohci-platform ee0a0000.usb: runtime PM trying to suspend device but active child
[  723.184769] phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend device but active child
[  723.194001] phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend device but active child
[  723.203413] Disabling non-boot CPUs ...
[  723.229225] IRQ15 no longer affine to CPU1
[  723.229561] CPU1: shutdown
[  723.236412] psci: CPU1 killed.
[  723.277182] IRQ16 no longer affine to CPU2
[  723.277535] CPU2: shutdown
[  723.284367] psci: CPU2 killed.
[  723.329121] IRQ17 no longer affine to CPU3
[  723.329404] CPU3: shutdown
[  723.336229] psci: CPU3 killed.

!! Flipping switch back here !!

NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA57) Rev.1.0.12
NOTICE:  BL2: PRR is R-Car H3 ES1.0
NOTICE:  BL2: Boot device is HyperFlash(160MHz)
NOTICE:  BL2: LCM state is CM
NOTICE:  BL2: AVS setting succeeded. DVFS_SetVID=0x52
NOTICE:  BL2: DDR1600(rev.0.20)[WARM_BOOT]..0
NOTICE:  BL2: DRAM Split is 4ch
NOTICE:  BL2: QoS is default setting(rev.0.33)
NOTICE:  BL2: v1.3(release):c040be5
NOTICE:  BL2: Built : 16:03:29, Jan 30 2017
NOTICE:  BL2: Normal boot
ÿ[  723.351187] Enabling non-boot CPUs ...dToRAM)
[  723.367103] Detected PIPT I-cache on CPU1
[  723.367163] CPU1: Booted secondary processor [411fd073]
[  723.367448]  cache: parent cpu1 should not be sleeping
[  723.381957] CPU1 is up
[  723.394114] Detected PIPT I-cache on CPU2
[  723.394134] CPU2: Booted secondary processor [411fd073]
[  723.394306]  cache: parent cpu2 should not be sleeping
[  723.408755] CPU2 is up
[  723.426652] Detected PIPT I-cache on CPU3
[  723.426673] CPU3: Booted secondary processor [411fd073]
[  723.426845]  cache: parent cpu3 should not be sleeping
[  723.441328] CPU3 is up
[  723.565306] usb usb2: root hub lost power or was reset
[  723.565325] usb usb1: root hub lost power or was reset
[  723.569644] usb usb5: root hub lost power or was reset
[  723.649254] ravb e6800000.ethernet eth0: limited PHY to 100Mbit/s
[  723.655345] Micrel KSZ9031 Gigabit PHY e6800000.ethernet-ffffffff:00: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=e6800000.ethernet-ffffffff:00, irq=236)
[  723.762737] usb usb3: root hub lost power or was reset
[  723.854727] usb usb4: root hub lost power or was reset
[  723.950730] usb usb6: root hub lost power or was reset
[  724.092718] ata1: link resume succeeded after 1 retries
[  724.153545] OOM killer enabled.
[  724.158915] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  724.158918] [drm] No driver support for vblank timestamp query.
[  724.172372] Restarting tasks ... done.
[  724.202297] ata1: SATA link down (SStatus 0 SControl 300)
[  725.265366] ravb e6800000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
arm64 ~/shared/deep-sleep #

I also know you reported an IRQ storm when resuming using WoL which I in 
over 1000 suspend/resume cycles never have been able to reproduce. Maybe 
my test environment or procedure is to kind and/or something is falling 
thru the cracks :-( Do you notice any difference in test procedure or 
console printouts?

> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (5):
>   [RFC] clk: renesas: cpg-mssr: Restore module clocks during resume
>   [RFC] clk: renesas: cpg-mssr: Add support to restore core clocks
>     during resume
>   [RFC] clk: renesas: div6: Restore clock state during resume
>   [RFC] clk: renesas: rcar-gen3: Restore SDHI clocks during resume
>   [RFC] clk: renesas: rcar-gen3: Restore R clock during resume
> 
>  drivers/clk/renesas/clk-div6.c         | 38 ++++++++++++++-
>  drivers/clk/renesas/clk-div6.h         |  3 +-
>  drivers/clk/renesas/rcar-gen2-cpg.c    |  7 ++-
>  drivers/clk/renesas/rcar-gen2-cpg.h    |  6 +--
>  drivers/clk/renesas/rcar-gen3-cpg.c    | 79 +++++++++++++++++++++++++-------
>  drivers/clk/renesas/rcar-gen3-cpg.h    |  3 +-
>  drivers/clk/renesas/renesas-cpg-mssr.c | 84 +++++++++++++++++++++++++++++++++-
>  drivers/clk/renesas/renesas-cpg-mssr.h |  3 +-
>  8 files changed, 193 insertions(+), 30 deletions(-)
> 
> -- 
> 2.7.4
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
Regards,
Niklas Söderlund
