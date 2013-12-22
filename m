From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: Make ARM big.LITTLE switcher depend on ARM
Date: Sun, 22 Dec 2013 02:06:04 +0100
Message-ID: <2576518.J5IDx9W8BG@vostro.rjw.lan>
References: <1386799947-6041-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1386799947-6041-1-git-send-email-broonie@kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 11, 2013 10:12:26 PM Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The patch currently under review to enable ARM cpufreq drivers for ARM64
> which is useful due to the large amount of shared IP between ARM and ARM64
> SoCs. However the big.LITTLE switcher relies on an architecture interface
> to build which is not present on ARM64. Add a dependency until that is
> resolved.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Both [1-2/2] queued up for 3.14, thanks!

> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index ce52ed949249..0a141109fd29 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -4,7 +4,7 @@
>  
>  config ARM_BIG_LITTLE_CPUFREQ
>  	tristate "Generic ARM big LITTLE CPUfreq driver"
> -	depends on ARM_CPU_TOPOLOGY && PM_OPP && HAVE_CLK
> +	depends on ARM && ARM_CPU_TOPOLOGY && PM_OPP && HAVE_CLK
>  	help
>  	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
