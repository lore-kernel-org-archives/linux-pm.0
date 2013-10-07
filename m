From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: offer TI thermal support only when ARCH_OMAP2PLUS
 is defined
Date: Mon, 07 Oct 2013 11:57:16 +0200
Message-ID: <5727785.7GtnvaVLcG@amdc1032>
References: <3702969.8rn3SOscJE@amdc1032> <524F0766.8070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <524F0766.8070302@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org


Hi,

On Friday, October 04, 2013 02:22:30 PM Eduardo Valentin wrote:
> On 04-10-2013 08:35, Bartlomiej Zolnierkiewicz wrote:
> > Menu for Texas Instruments thermal support is visible on all
> > platforms and TI_SOC_THERMAL + TI_THERMAL config options can
> > be selected also on EXYNOS platform (on which ARCH_HAS_BANDGAP
> > config option is selected by SoCs config options to fulfill
> > EXYNOS_THERMAL config option dependency). Thus the code which
> > is never used can be build. Fix it by making TI menu dependent
> > on ARCH_OMAP2PLUS config option.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/thermal/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 57e06a9..a709c63 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -193,6 +193,7 @@ config X86_PKG_TEMP_THERMAL
> >  	  notification methods.
> >  
> >  menu "Texas Instruments thermal drivers"
> > +depends on ARCH_OMAP2PLUS
> 
> No, this driver is not for ARCH_OMAP*, but for TI bandgap, with the
> option to offer thermal control. So, the HW supported is TI bandgap IP,
> not ARCH_OMAP*. It happens to be so that OMAP2PLUS all have a
> (different) version of this device.
> 
> However, DRA7 devices, for instance, also feature the bandgap IP
> (different version of those present in OMAP devices), and it is not
> ARCH_OMAP2PLUS.

Then you have wrong dependencies anyway since ARCH_BANDGAP is selected
currently only by ARCH_OMAP2PLUS and EXYNOS SoCs.

arch/arm/mach-omap2/Kconfig (next-20130927):

config ARCH_OMAP2PLUS
        bool
        select ARCH_HAS_BANDGAP
        select ARCH_HAS_CPUFREQ
        select ARCH_HAS_HOLES_MEMORYMODEL
        select ARCH_OMAP
        select ARCH_REQUIRE_GPIOLIB
        select CLKDEV_LOOKUP
        select CLKSRC_MMIO
        select GENERIC_CLOCKEVENTS
        select GENERIC_IRQ_CHIP
        select HAVE_CLK
        select OMAP_DM_TIMER
        select PINCTRL
        select PROC_DEVICETREE if PROC_FS
        select SOC_BUS
        select SPARSE_IRQ
        select TI_PRIV_EDMA
        select USE_OF
        help
          Systems based on OMAP2, OMAP3, OMAP4 or OMAP5

drivers/thermal/ti-soc-thermal/Kconfig (next-20130927):

config TI_SOC_THERMAL
        tristate "Texas Instruments SoCs temperature sensor driver"
        depends on THERMAL
        depends on ARCH_HAS_BANDGAP
        help
          If you say yes here you get support for the Texas Instruments
          OMAP4460+ on die bandgap temperature sensor support. The register
          set is part of system control module.

          This includes alert interrupts generation and also the TSHUT
          support.

> And because of that, the design of this driver is different. It is not
> expected to depend on an arch, but the arch code is expected to select
> ARCH_HAS_BANDGAP.

There should be additional dependencies beside ARCH_BANDGAP, i.e. on
EXYNOS platforms we currently also have dependency on PLAT_SAMSUNG
(should be ARCH_EXYNOS instead, my other patch fixes it).

> >  source "drivers/thermal/ti-soc-thermal/Kconfig"
> >  endmenu

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
