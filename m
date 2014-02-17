From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Kconfig.arm: Do not select GENERIC_CPUFREQ_CPU0
Date: Mon, 17 Feb 2014 22:54:08 +0100
Message-ID: <8017605.Hn2oDKGgE8@vostro.rjw.lan>
References: <1392662127-31005-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64136 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754249AbaBQVjU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 16:39:20 -0500
In-Reply-To: <1392662127-31005-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>, viresh.kumar@linaro.org, Shawn Guo <shawn.guo@linaro.org>
Cc: festevam@gmail.com, linux-pm@vger.kernel.org

On Monday, February 17, 2014 03:35:27 PM Fabio Estevam wrote:
> Currently the following warnings are generated when building multi_v7_defconfig:
> 
> $ make multi_v7_defconfig 
> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
> # configuration written to .config
> 
> ARM_HIGHBANK_CPUFREQ can be built with GENERIC_CPUFREQ_CPU0=n, so remove this
> selection.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Viresh, Shawn, I need to know if this breaks anything.

> ---
>  drivers/cpufreq/Kconfig.arm | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 3129749..bdd3ff9 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -84,7 +84,6 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  config ARM_HIGHBANK_CPUFREQ
>  	tristate "Calxeda Highbank-based"
>  	depends on ARCH_HIGHBANK
> -	select GENERIC_CPUFREQ_CPU0
>  	select PM_OPP
>  	select REGULATOR
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
