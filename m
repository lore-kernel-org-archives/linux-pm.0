From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] cpufreq: merge maple cpufreq driver to pmac64
Date: Mon, 23 Sep 2013 19:20:49 +0200
Message-ID: <14395146.Bt0Um0VYXe@amdc1032>
References: <1379071806-17453-1-git-send-email-dmitry_eremin@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1379071806-17453-1-git-send-email-dmitry_eremin@mentor.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-pm@vger.kernel.org


Hi,

On Friday, September 13, 2013 03:30:06 PM Dmitry Eremin-Solenikov wrote:
> Maple boards use the same frequency changing mechanism, as do newer
> PowerMacs (write to SCOM). Thus maple-cpufreq.c is a reduced version
> of pmac64 driver. Merge it back to pmac64-cpufreq.c
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> ---
>  drivers/cpufreq/Kconfig.powerpc  |  10 +-
>  drivers/cpufreq/Makefile         |   1 -
>  drivers/cpufreq/maple-cpufreq.c  | 308 ---------------------------------------
>  drivers/cpufreq/pmac64-cpufreq.c |  58 +++++---
>  4 files changed, 40 insertions(+), 337 deletions(-)
>  delete mode 100644 drivers/cpufreq/maple-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index 25ca9db..2a802bd 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -17,14 +17,6 @@ config CPU_FREQ_CBE_PMI
>  	  frequencies. Using PMI, the processor will not only be able to run at
>  	  lower speed, but also at lower core voltage.
>  
> -config CPU_FREQ_MAPLE
> -	bool "Support for Maple 970FX Evaluation Board"
> -	depends on PPC_MAPLE
> -	select CPU_FREQ_TABLE
> -	help
> -	  This adds support for frequency switching on Maple 970FX
> -	  Evaluation Board and compatible boards (IBM JS2x blades).
> -
>  config PPC_CORENET_CPUFREQ
>  	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
>  	depends on PPC_E500MC && OF && COMMON_CLK
> @@ -46,7 +38,7 @@ config CPU_FREQ_PMAC
>  
>  config CPU_FREQ_PMAC64
>  	bool "Support for some Apple G5s"
> -	depends on PPC_PMAC && PPC64
> +	depends on (PPC_PMAC || PPC_MAPLE) && PPC64
>  	select CPU_FREQ_TABLE
>  	help
>  	  This adds support for frequency switching on Apple iMac G5,

minor nit:

Shouldn't the help entry be updated to reflect that this driver now also
supports Maple 970FX board & friends (can be done in incremental patch if
the original one is merged already)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

