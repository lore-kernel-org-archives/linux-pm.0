From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Wed, 9 Dec 2015 12:03:27 +0000
Message-ID: <5668188F.2080202@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9118 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbLIMDe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 07:03:34 -0500
In-Reply-To: <2194927.eV2s2QmZs0@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>

Hi Arnd,

On 08/12/15 21:52, Arnd Bergmann wrote:
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

In this sequence we are switching from the DFLL clock source (which
directly controls the voltage) back to a PLL (which does not control the
voltage directly). What we want to do is to restore the voltage back to
the voltage it was operating at before we switched to the DFLL clock
(which could have changed it).

I am not familiar with regulator_sync_voltage() but from the comment it
does say that it will re-apply the last voltage that was configured for
the regulator. So I can see what they were doing. The question I have
is, if the consumer has not explicitly called regulator_set_voltage()
then what does regulator_sync_voltage() do? I am wondering if we should
have been doing a regulator_get_voltage() during the probe and a
regulator_set_voltage() when switching back?

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

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
