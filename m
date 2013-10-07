From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: offer TI thermal support only when ARCH_OMAP2PLUS
 is defined
Date: Mon, 07 Oct 2013 12:51:18 +0200
Message-ID: <1777775.ZWYXb1l2UF@amdc1032>
References: <3702969.8rn3SOscJE@amdc1032> <524F086E.4020608@ti.com>
 <24683815.qjRRgfGo3Z@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50296 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab3JGKv2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2013 06:51:28 -0400
In-reply-to: <24683815.qjRRgfGo3Z@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>

On Monday, October 07, 2013 12:05:05 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, October 04, 2013 02:26:54 PM Eduardo Valentin wrote:
> > On 04-10-2013 14:22, Eduardo Valentin wrote:
> > > On 04-10-2013 08:35, Bartlomiej Zolnierkiewicz wrote:
> > >> Menu for Texas Instruments thermal support is visible on all
> > >> platforms and TI_SOC_THERMAL + TI_THERMAL config options can
> > >> be selected also on EXYNOS platform (on which ARCH_HAS_BANDGAP
> > >> config option is selected by SoCs config options to fulfill
> > >> EXYNOS_THERMAL config option dependency). Thus the code which
> > >> is never used can be build. Fix it by making TI menu dependent
> > >> on ARCH_OMAP2PLUS config option.
> > >>
> > 
> > 
> > Besides, you can always disable the driver if you are not interested in
> > compiling it.
> 
> You should not have TI-specific drivers visible without any TI dependencies.
> ARCH_BANDGAP dependency is not enough, ARCH_BANDGAP is also used by EXYNOS

s/ARCH_BANDGAP/ARCH_HAS_BANDGAP/ of course

> to indicate thermal support. Currently you can select TI thermal drivers on
> EXYNOS platforms without any other dependencies on TI. This is just wrong,
> it can result in unused code being build currently but can result in more
> severe problems in the future (build break).

Arnd, could you please give your opinion on the issue?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

 
> > >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > >> ---
> > >>  drivers/thermal/Kconfig | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > >> index 57e06a9..a709c63 100644
> > >> --- a/drivers/thermal/Kconfig
> > >> +++ b/drivers/thermal/Kconfig
> > >> @@ -193,6 +193,7 @@ config X86_PKG_TEMP_THERMAL
> > >>  	  notification methods.
> > >>  
> > >>  menu "Texas Instruments thermal drivers"
> > >> +depends on ARCH_OMAP2PLUS
> > > 
> > > No, this driver is not for ARCH_OMAP*, but for TI bandgap, with the
> > > option to offer thermal control. So, the HW supported is TI bandgap IP,
> > > not ARCH_OMAP*. It happens to be so that OMAP2PLUS all have a
> > > (different) version of this device.
> > > 
> > > However, DRA7 devices, for instance, also feature the bandgap IP
> > > (different version of those present in OMAP devices), and it is not
> > > ARCH_OMAP2PLUS.
> > > 
> > > And because of that, the design of this driver is different. It is not
> > > expected to depend on an arch, but the arch code is expected to select
> > > ARCH_HAS_BANDGAP.
> > > 
> > >>  source "drivers/thermal/ti-soc-thermal/Kconfig"
> > >>  endmenu
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

