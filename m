From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Kconfig.arm: Fix unmet direct dependencies
Date: Tue, 18 Feb 2014 13:57:54 +0100
Message-ID: <1490688.YGyTpvjYUy@vostro.rjw.lan>
References: <1392726951-8256-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64477 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754544AbaBRMnF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 07:43:05 -0500
In-Reply-To: <1392726951-8256-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: viresh.kumar@linaro.org, shawn.guo@linaro.org, mark.langsdorf@calxeda.com, linux-pm@vger.kernel.org, festevam@gmail.com

On Tuesday, February 18, 2014 09:35:51 AM Fabio Estevam wrote:
> Currently the following warning is generated when building multi_v7_defconfig:
> 
> $ make multi_v7_defconfig 
> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
> # configuration written to .config
> 
> Instead of forcing the selection of GENERIC_CPUFREQ_CPU0 and REGULATOR, change
> it to 'depends on' instead.

OK

Any objections here?

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Use 'depends on'
> 
>  drivers/cpufreq/Kconfig.arm | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 3129749..7c39e85 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -84,9 +84,9 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  config ARM_HIGHBANK_CPUFREQ
>  	tristate "Calxeda Highbank-based"
>  	depends on ARCH_HIGHBANK
> -	select GENERIC_CPUFREQ_CPU0
> +	depends on GENERIC_CPUFREQ_CPU0
> +	depends on REGULATOR
>  	select PM_OPP
> -	select REGULATOR
>  
>  	default m
>  	help
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
