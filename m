From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: armada-37xx: driver relies on cpufreq-dt
Date: Tue, 24 Apr 2018 16:01:43 +0530
Message-ID: <20180424103143.v2u4hl3vilws3jh2@vireshk-i7>
References: <20180424102738.22967-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424102738.22967-1-miquel.raynal@bootlin.com>
Sender: stable-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-04-18, 12:27, Miquel Raynal wrote:
> Armada-37xx driver registers a cpufreq-dt driver. Not having
> CONFIG_CPUFREQ_DT selected leads to a silent abort during the probe.
> Prevent that situation by having the former depending on the latter.
> 
> Fixes: 92ce45fb875d7 ("cpufreq: Add DVFS support for Armada 37xx")
> Cc: stable@vger.kernel.org

Shouldn't this have been:

Cc: stable@vger.kernel.org # 4.16

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes since v1
> ================
>  * Changed 'select' by 'depends on'
>  * Added Fixes + Cc: stable tags
> 
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 7f56fe5183f2..2c64ee68ea8b 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -20,7 +20,7 @@ config ACPI_CPPC_CPUFREQ
>  
>  config ARM_ARMADA_37XX_CPUFREQ
>  	tristate "Armada 37xx CPUFreq support"
> -	depends on ARCH_MVEBU
> +	depends on ARCH_MVEBU && CPUFREQ_DT
>  	help
>  	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
>  	  The Armada 37xx PMU supports 4 frequency and VDD levels.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
