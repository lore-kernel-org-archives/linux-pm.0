From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
Date: Mon, 03 Aug 2015 12:31:32 +0200
Message-ID: <59949991.607t9GcIyz@amdc1976>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
 <55BC78BE.5020102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58323 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbHCKc0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 06:32:26 -0400
In-reply-to: <55BC78BE.5020102@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>


[ added Zhang & Eduardo to Cc: ]

Hi,

On Saturday, August 01, 2015 04:43:58 PM Krzysztof Kozlowski wrote:
> W dniu 01.08.2015 o 03:49, Bartlomiej Zolnierkiewicz pisze:
> > The new CPU clock type allows the use of generic CPUfreq driver.
> > Switch Exynos4x12 to using generic cpufreq driver.
> > 
> > Also make CPUFREQ_DT config option select Exynos thermal driver
> > if Exynos platform support is enabled.
> 
> Why? I think this wasn't in your previous patch.

Previous patch kept ARM_EXYNOS_CPU_FREQ_BOOST_SW config option
which selected EXYNOS_THERMAL.  After recent changes (boost
support enabled in the cpufreq-dt driver when there are turbo
OPPs in board's dts file) ARM_EXYNOS_CPU_FREQ_BOOST_SW config
option become redundant and was removed.  However we still
would like to allow enabling boost support only if thermal
support is also enabled for Exynos platforms.

[ There may be a better way to do this in the future (runtime
  checking for thermal support being enabled) but currently
  there seems to be no thermal infrastructure to allow this. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> Krzysztof
> 
> 
> > 
> > Please also note that the switch to use the generic cpufreq-dt
> > driver fixes the minor issue present with the old code (support
> > for 'boost' mode in the exynos-cpufreq driver was enabled for
> > all supported SoCs even though 'boost' frequency was provided
> > only for Exynos4x12 ones).
> > 
> > Cc: Tomasz Figa <tomasz.figa@gmail.com>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/mach-exynos/exynos.c | 2 ++
> >  drivers/cpufreq/Kconfig       | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> > index 77ac021..1c47aee 100644
> > --- a/arch/arm/mach-exynos/exynos.c
> > +++ b/arch/arm/mach-exynos/exynos.c
> > @@ -227,6 +227,8 @@ static void __init exynos_init_irq(void)
> >  static const struct of_device_id exynos_cpufreq_matches[] = {
> >  	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
> >  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> > +	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
> > +	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
> >  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> >  	{ /* sentinel */ }
> >  };
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 659879a..bf6d596 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -191,6 +191,7 @@ config CPUFREQ_DT
> >  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
> >  	depends on !CPU_THERMAL || THERMAL
> >  	select PM_OPP
> > +	select EXYNOS_THERMAL if ARCH_EXYNOS
> >  	help
> >  	  This adds a generic DT based cpufreq driver for frequency management.
> >  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)

