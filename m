From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: Kconfig.arm: Fix unmet direct dependencies
Date: Wed, 19 Feb 2014 11:21:28 +0530
Message-ID: <CAKohpomvFKA0WUPShLkNnHXbX=QibB3oybXcXD=Qv+f4yQjBAQ@mail.gmail.com>
References: <1392731091-817-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:40582 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbaBSFv2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 00:51:28 -0500
Received: by mail-ob0-f182.google.com with SMTP id wm4so19764231obc.13
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2014 21:51:28 -0800 (PST)
In-Reply-To: <1392731091-817-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, festevam@gmail.com

On 18 February 2014 19:14, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> Currently the following warning is generated when building multi_v7_defconfig:
>
> $ make multi_v7_defconfig
> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
> # configuration written to .config
>
> Instead of forcing the selection of GENERIC_CPUFREQ_CPU0 let's depend on it.
>
> By depending on GENERIC_CPUFREQ_CPU0 we can remove the selection of PM_OPP
> and REGULATOR because we have:
>
> config GENERIC_CPUFREQ_CPU0
>         tristate "Generic CPU0 cpufreq driver"
>         depends on HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL
>         select PM_OPP
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v2:
> - Only keep the 'depends on GENERIC_CPUFREQ_CPU0' and remove the other
> selections
> Changes since v1:
> - Use 'depends on'
>
>  drivers/cpufreq/Kconfig.arm | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 3129749..c43e2c2 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -84,9 +84,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  config ARM_HIGHBANK_CPUFREQ
>         tristate "Calxeda Highbank-based"
>         depends on ARCH_HIGHBANK
> -       select GENERIC_CPUFREQ_CPU0
> -       select PM_OPP
> -       select REGULATOR
> +       depends on GENERIC_CPUFREQ_CPU0
>
>         default m
>         help

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
