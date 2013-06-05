From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: move ARCH_NEEDS_CPU_IDLE_COUPLED Kconfig option
Date: Wed, 05 Jun 2013 22:36:20 +0200
Message-ID: <2504003.GJXn0Z0NTJ@vostro.rjw.lan>
References: <1460854.rT4b7LefMM@wuerfel> <51AF3424.5060200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:58457 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757276Ab3FEU1Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Jun 2013 16:27:16 -0400
In-Reply-To: <51AF3424.5060200@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday, June 05, 2013 02:50:44 PM Daniel Lezcano wrote:
> On 06/05/2013 02:38 PM, Arnd Bergmann wrote:
> > There is no reason why ARCH_NEEDS_CPU_IDLE_COUPLED needs to be
> > hidden inside of "if CPU_IDLE", since it is a silent option.
> > Moving it outside lets platforms select this symbol unconditionally,
> > which avoid a warning from the ARM omap2plus_defconfig build:
> > 
> > warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects
> > 	ARCH_NEEDS_CPU_IDLE_COUPLED which has unmet direct
> > 	dependencies (CPU_IDLE)
> 
> IMHO, this option depends on CPU_IDLE and thus must be kept inside the
> CPU_IDLE menuconfig.
> 
> The warning raised here is because this option is selected by the arch
> Kconfig without checking if CPU_IDLE is set or not.
> 
> I am in favor to change the OMAP / TEGRA Kconfigs instead, in this way:

I prefer this one.

Thanks,
Rafael


> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f49cd51..831e89e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -83,7 +83,7 @@ config ARCH_OMAP4
>         depends on ARCH_OMAP2PLUS
>         depends on ARCH_MULTI_V7
>         select ARCH_HAS_OPP
> -       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> +       select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
>         select ARM_CPU_SUSPEND if PM
>         select ARM_ERRATA_720789
>         select ARM_GIC
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 84d72fc..04c6221 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -23,7 +23,7 @@ menu "NVIDIA Tegra options"
> 
>  config ARCH_TEGRA_2x_SOC
>         bool "Enable support for Tegra20 family"
> -       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> +       select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
>         select ARM_ERRATA_720789
>         select ARM_ERRATA_754327 if SMP
>         select ARM_ERRATA_764369 if SMP
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> 
> [ ... ]
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
