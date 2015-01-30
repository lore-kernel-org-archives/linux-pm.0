From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Fri, 30 Jan 2015 22:24:12 +0100
Message-ID: <5048920.rXbXJT1FvO@wuerfel>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de> <1642077.OrkdxhO2uI@wuerfel> <20150129222150.GA29837@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150129222150.GA29837@developer.amazonguestwifi.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 January 2015 18:21:51 Eduardo Valentin wrote:
> Hello Arnd and Viresh,
> 
> On Thu, Jan 29, 2015 at 01:42:32PM +0100, Arnd Bergmann wrote:
> > On Thursday 29 January 2015 15:40:15 Viresh Kumar wrote:
> > >  obj-$(CONFIG_ARCH_DAVINCI)             += davinci-cpufreq.o
> > >  obj-$(CONFIG_UX500_SOC_DB8500)         += dbx500-cpufreq.o
> > > -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       += exynos-cpufreq.o
> > > -obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
> > > -obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
> > > -obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> > > +obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos-cpufreq.o exynos4210-cpufreq.o
> > > +obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos-cpufreq.o exynos4x12-cpufreq.o
> > > +obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos-cpufreq.o exynos5250-cpufreq.o
> > > 
> > 
> > I'd have to try it, but this might fail if one of the three drivers
> > is built-in and another one is a module.
> > 
> > 	Arnd
> 
> Let me make one step back here. The original issue is, now this exynos
> cpufreq driver depends on of thermal; but of thermal can be built as
> module, while this cpufreq driver cannot. Original proposal is to allow
> module build in the exynos cpufreq driver.
> 
> On the original proposal, my concern is that the driver code does not
> have separated modules, but one single module platform driver,  which uses functions from
> other c files. On top of that, the patch originally allows four
> (independent) modules builds. Although the children drivers still
> selects the core part, we would still need to change the original patch
> to add module dependency too.
> 
> So, my proposal was to, in order to allow module builds on this cpufreq
> driver, we also need to properly construct the driver into a single
> module, instead of several modules. The issue with my patch was the fact
> that it was allowing platforms that do not use that driver, to select it
> by default. And eventually this may cause a unusable module being loaded
> into those systems.
> 
> Well, trying harder here in the same approach. The diff bellow is based
> on Arnd's original patch and on Viresh's amendment, except that the core
> part is now dependent on all the supported platforms, instead of
> ARCH_EXYNOS. This way, it wont load in platforms that are not supposed
> to be loaded. The user will be able to build the support for all
> platforms, or select which platforms he/she wants (as originally),
> except that now it can be a module, instead.
> 
> I believe now by default it will still keep the driver only on those
> configs that expect it to be on. And it won't compile/load on platforms
> that it is not supposed to. It brings closer a config that is dependent on this
> driver, so it looks better in the menuconfig.
> 
> Let me know if I missed something (feel free to amend to your patch):

Yes, I think your refined approach works and is better than my
original patch, thanks a lot for giving it more thought!

One tiny problem:

> @@ -90,6 +84,20 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  
>  	  If in doubt, say N.
>  
> +config ARM_EXYNOS5440_CPUFREQ
> +	bool "SAMSUNG EXYNOS5440"
> +	depends on SOC_EXYNOS5440
> +	depends on HAVE_CLK && OF
> +	select PM_OPP
> +	default y
> +	help
> +	  This adds the CPUFreq driver for Samsung EXYNOS5440
> +	  SoC. The nature of exynos5440 clock controller is
> +	  different than previous exynos controllers so not using
> +	  the common exynos framework.
> +
> +	  If in doubt, say N.

I believe this one also has to be tristate, for the same reason.

>  
> -#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
> +#if IS_ENABLED(CONFIG_ARM_EXYNOS4210_CPUFREQ)
>  extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
>  #else
>  static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
> @@ -61,7 +61,7 @@ static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
> +#if IS_ENABLED(CONFIG_ARM_EXYNOS4X12_CPUFREQ)
>  extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
>  #else
>  static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
> @@ -69,7 +69,7 @@ static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -#ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
> +#if IS_ENABLED(CONFIG_ARM_EXYNOS5250_CPUFREQ)
>  extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
>  #else
>  static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)

This change is ok, but not needed, because the three extra symbols are still
bool. I would leave that change out, but I also don't mind it.

With the change to make ARM_EXYNOS5440_CPUFREQ tristate:

Acked-by: Arnd Bergmann <arnd@arndb.de>
