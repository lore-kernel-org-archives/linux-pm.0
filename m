From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: scpi: add thermal dependency
Date: Wed, 14 Mar 2018 10:39:54 +0530
Message-ID: <20180314050954.GE15832@vireshk-i7>
References: <20180313114607.2061209-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180313114607.2061209-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13-03-18, 12:45, Arnd Bergmann wrote:
> A built-in scpi cpufreq driver cannot link against a modular
> thermal framework:
> 
> drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_ready':
> scpi-cpufreq.c:(.text+0x4c): undefined reference to `of_cpufreq_cooling_register'
> drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_exit':
> scpi-cpufreq.c:(.text+0x9c): undefined reference to `cpufreq_cooling_unregister'
> 
> This adds a Kconfig dependency that makes sure this configuration
> is not possible, while allowing all configurations that can work.
> Note that disabling CPU_THERMAL means we don't care about the
> THERMAL dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 9bbb5b39d18a..d9457d1e535c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -45,6 +45,7 @@ config ARM_DT_BL_CPUFREQ
>  config ARM_SCPI_CPUFREQ
>  	tristate "SCPI based CPUfreq driver"
>  	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
> +	depends on !CPU_THERMAL || THERMAL
>  	help
>  	  This adds the CPUfreq driver support for ARM platforms using SCPI
>  	  protocol for CPU power management.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
