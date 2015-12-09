From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Wed, 9 Dec 2015 07:46:17 +0530
Message-ID: <20151209021617.GQ3692@ubuntu>
References: <2194927.eV2s2QmZs0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34754 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbLICQV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 21:16:21 -0500
Received: by pacwq6 with SMTP id wq6so21330627pac.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 18:16:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2194927.eV2s2QmZs0@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>

On 08-12-15, 22:52, Arnd Bergmann wrote:
> This driver is the only one that calls regulator_sync_voltage(), but it
> can currently be built with CONFIG_REGULATOR disabled, producing
> this build error:
> 
> drivers/cpufreq/tegra124-cpufreq.c: In function 'tegra124_cpu_switch_to_pllx':
> drivers/cpufreq/tegra124-cpufreq.c:68:2: error: implicit declaration of function 'regulator_sync_voltage' [-Werror=implicit-function-declaration]
>   regulator_sync_voltage(priv->vdd_cpu_reg);
> 
> My first attempt was to implement a helper for this function
> for regulator_sync_voltage, but Mark Brown explained:
> 
>    We don't do this for *all* regulator API functions - there's some where
>    using them strongly suggests that there is actually a dependency on
>    the regulator API.  This does seem like it might be falling into the
>    specialist category [...]
>    Looking at the code I'm pretty unclear on what the authors think the
>    use of _sync_voltage() is doing in the first place so it may be even
>    better to just remove the call.  It seems to have been included in the
>    first commit so there's not changelog explaining things and there's
>    no comment either.  I'd *expect* it to be a noop as far as I can see.
> 
> This adds the dependency to make the driver always build successfully
> or not be enabled at all. Alternatively, we could investigate if the
> driver should stop calling regulator_sync_voltage instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 235a1ba73d92..b1f8a73e5a94 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -226,7 +226,7 @@ config ARM_TEGRA20_CPUFREQ
>  
>  config ARM_TEGRA124_CPUFREQ
>  	tristate "Tegra124 CPUFreq support"
> -	depends on ARCH_TEGRA && CPUFREQ_DT
> +	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
>  	default y
>  	help
>  	  This adds the CPUFreq driver support for Tegra124 SOCs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
