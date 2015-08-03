From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4x12
Date: Mon, 3 Aug 2015 15:59:26 +0530
Message-ID: <20150803102926.GA21529@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
 <20150801111721.GI899@linux>
 <5201904.0cZWHobiJs@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32949 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbHCK3b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 06:29:31 -0400
Received: by pdbnt7 with SMTP id nt7so72355852pdb.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2015 03:29:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5201904.0cZWHobiJs@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On 03-08-15, 12:17, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Saturday, August 01, 2015 04:47:21 PM Viresh Kumar wrote:
> > On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> > > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > > index 659879a..bf6d596 100644
> > > --- a/drivers/cpufreq/Kconfig
> > > +++ b/drivers/cpufreq/Kconfig
> > > @@ -191,6 +191,7 @@ config CPUFREQ_DT
> > >  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
> > >  	depends on !CPU_THERMAL || THERMAL
> > >  	select PM_OPP
> > > +	select EXYNOS_THERMAL if ARCH_EXYNOS
> > >  	help
> > >  	  This adds a generic DT based cpufreq driver for frequency management.
> > >  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> > 
> > No, we shouldn't pollute generic Kconfig options with platform specific stuff.
> 
> The old code depended on this.  You couldn't enable boost support
> without enabling thermal support (ARM_EXYNOS_CPU_FREQ_BOOST_SW
> config option selected EXYNOS_THERMAL).
> 
> > Why don't you enable thermal in your .config?
> 
> It is enabled in exynos_defconfig but without the above change it
> can disabled manually which is something that we don't want.

You are not getting it. I am not asking you to not select thermal, but
to select it from within your architecture Kconfig option if you want.

Over that, thermal is really an option, not a dependency. So, if
someone manually disables it, its his problem not yours :)

-- 
viresh
