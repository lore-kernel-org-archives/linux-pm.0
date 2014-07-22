From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Wed, 23 Jul 2014 01:51:32 +0200
Message-ID: <1545810.J2fATbIVlt@vostro.rjw.lan>
References: <1406040192-632-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64930 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932115AbaGVXdI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jul 2014 19:33:08 -0400
In-Reply-To: <1406040192-632-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On Tuesday, July 22, 2014 03:43:12 PM Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since the OPP layer is a kernel library which has been converted to be
> directly selectable by its callers rather than user selectable and
> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
> has become redundant and can be removed. Do so.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Nishanth Menon <nm@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> 
> Raphael, IIRC you said that you'd applied this but it seems not to have
> appeared in -next.  There's a few more references crept in, I'll try to
> get them removed at source.

I've queued this up for 3.17, thanks!

>  Documentation/power/opp.txt    | 3 ---
>  arch/arm/mach-exynos/Kconfig   | 1 -
>  arch/arm/mach-highbank/Kconfig | 1 -
>  arch/arm/mach-imx/Kconfig      | 1 -
>  arch/arm/mach-omap2/Kconfig    | 1 -
>  arch/arm/mach-shmobile/Kconfig | 2 --
>  arch/arm/mach-vexpress/Kconfig | 1 -
>  arch/arm/mach-zynq/Kconfig     | 1 -
>  drivers/devfreq/Kconfig        | 1 -
>  kernel/power/Kconfig           | 3 ---
>  10 files changed, 15 deletions(-)
> 
> diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
> index a9adad828cdc..c6279c2be47c 100644
> --- a/Documentation/power/opp.txt
> +++ b/Documentation/power/opp.txt
> @@ -51,9 +51,6 @@ Typical usage of the OPP library is as follows:
>  SoC framework	-> modifies on required cases certain OPPs	-> OPP layer
>  		-> queries to search/retrieve information	->
>  
> -Architectures that provide a SoC framework for OPP should select ARCH_HAS_OPP
> -to make the OPP layer available.
> -
>  OPP layer expects each domain to be represented by a unique device pointer. SoC
>  framework registers a set of initial OPPs per device with the OPP layer. This
>  list is expected to be an optimally small number typically around 5 per device.
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 8f9b66c4ac78..f7889f6a1353 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -100,7 +100,6 @@ config SOC_EXYNOS5440
>  	default y
>  	depends on ARCH_EXYNOS5
>  	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
> -	select ARCH_HAS_OPP
>  	select HAVE_ARM_ARCH_TIMER
>  	select AUTO_ZRELADDR
>  	select MIGHT_HAVE_PCI
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index a5960e2ac090..31aa866c3317 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -2,7 +2,6 @@ config ARCH_HIGHBANK
>  	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
>  	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>  	select ARCH_HAS_HOLES_MEMORYMODEL
> -	select ARCH_HAS_OPP
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_ERRATA_764369 if SMP
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 2bc7b97861b4..9de84a215abd 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,6 +1,5 @@
>  menuconfig ARCH_MXC
>  	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> -	select ARCH_HAS_OPP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_CPU_SUSPEND if PM
>  	select CLKSRC_MMIO
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 1c1ed737f7ab..e7189dcc9309 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -15,7 +15,6 @@ config ARCH_OMAP3
>  	bool "TI OMAP3"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> -	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select OMAP_INTERCONNECT
>  	select PM_OPP if PM
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 384221d72d22..5814754c1240 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -92,7 +92,6 @@ config ARCH_R8A73A4
>  	select CPU_V7
>  	select SH_CLK_CPG
>  	select RENESAS_IRQC
> -	select ARCH_HAS_OPP
>  	select SYS_SUPPORTS_SH_CMT
>  	select SYS_SUPPORTS_SH_TMU
>  
> @@ -244,7 +243,6 @@ config MACH_KOELSCH
>  config MACH_KZM9G
>  	bool "KZM-A9-GT board"
>  	depends on ARCH_SH73A0
> -	select ARCH_HAS_OPP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select SND_SOC_AK4642 if SND_SIMPLE_CARD
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index d8b9330f896a..1af70329b88d 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -64,7 +64,6 @@ config ARCH_VEXPRESS_DCSCB
>  
>  config ARCH_VEXPRESS_SPC
>  	bool "Versatile Express Serial Power Controller (SPC)"
> -	select ARCH_HAS_OPP
>  	select PM_OPP
>  	help
>  	  The TC2 (A15x2 A7x3) versatile express core tile integrates a logic
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index 0c164f81e72d..aaa5162c1509 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -1,6 +1,5 @@
>  config ARCH_ZYNQ
>  	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
> -	select ARCH_HAS_OPP
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_GIC
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 49e74c1fc639..3dced0a9eae3 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -68,7 +68,6 @@ comment "DEVFREQ Drivers"
>  config ARM_EXYNOS4_BUS_DEVFREQ
>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
>  	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
> -	select ARCH_HAS_OPP
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_OPP
>  	help
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 9a83d780facd..e4e4121fa327 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -253,9 +253,6 @@ config APM_EMULATION
>  	  anything, try disabling/enabling this option (or disabling/enabling
>  	  APM in your BIOS).
>  
> -config ARCH_HAS_OPP
> -	bool
> -
>  config PM_OPP
>  	bool
>  	---help---
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
