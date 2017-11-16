From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add Loongson machine dependencies
Date: Thu, 16 Nov 2017 08:11:15 +0530
Message-ID: <20171116024115.GP3257@vireshk-i7>
References: <20171115211755.25102-1-james.hogan@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:52008 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdKPClS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 21:41:18 -0500
Received: by mail-pg0-f66.google.com with SMTP id p9so19480616pgc.8
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 18:41:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171115211755.25102-1-james.hogan@mips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Hogan <james.hogan@mips.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>, James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

On 15-11-17, 21:17, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> The MIPS loongson cpufreq drivers don't build unless configured for the
> correct machine type, due to dependency on machine specific architecture
> headers and symbols in machine specific platform code.
> 
> More specifically loongson1-cpufreq.c uses RST_CPU_EN and RST_CPU,
> neither of which is defined in asm/mach-loongson32/regs-clk.h unless
> CONFIG_LOONGSON1_LS1B=y, and loongson2_cpufreq.c references
> loongson2_clockmod_table[], which is only defined in
> arch/mips/loongson64/lemote-2f/clock.c, i.e. when
> CONFIG_LEMOTE_MACH2F=y.
> 
> Add these dependencies to Kconfig to avoid randconfig / allyesconfig
> build failures (e.g. when based on BMIPS which also has a cpufreq
> driver).
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/cpufreq/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4ebae43118ef..d8addbce40bc 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -275,6 +275,7 @@ config BMIPS_CPUFREQ
>  
>  config LOONGSON2_CPUFREQ
>  	tristate "Loongson2 CPUFreq Driver"
> +	depends on LEMOTE_MACH2F
>  	help
>  	  This option adds a CPUFreq driver for loongson processors which
>  	  support software configurable cpu frequency.
> @@ -287,6 +288,7 @@ config LOONGSON2_CPUFREQ
>  
>  config LOONGSON1_CPUFREQ
>  	tristate "Loongson1 CPUFreq Driver"
> +	depends on LOONGSON1_LS1B
>  	help
>  	  This option adds a CPUFreq driver for loongson1 processors which
>  	  support software configurable cpu frequency.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
