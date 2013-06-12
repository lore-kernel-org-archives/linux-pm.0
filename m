From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH 05/11] cpufreq: highbank: remove select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 12:04:49 -0500
Message-ID: <51B8AA31.30501@calxeda.com>
References: <cover.1371022830.git.viresh.kumar@linaro.org> <7e4ee3926630a243a8e69835011cf9c6c4673eb9.1371022830.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e4ee3926630a243a8e69835011cf9c6c4673eb9.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robin.randhawa@arm.com" <robin.randhawa@arm.com>, "Steve.Bannister@arm.com" <Steve.Bannister@arm.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>, "arvind.chauhan@arm.com" <arvind.chauhan@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On 06/12/2013 03:15 AM, Viresh Kumar wrote:
> Highbank cpufreq driver doesn't use any APIs from freq_table.c and so must not
> select CPU_FREQ_TABLE.
> 
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for catching this.

Acked-by: Mark Langsdorf <mark.langsdorf@calxeda.com>

> ---
>  drivers/cpufreq/Kconfig.arm | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 9d7e209..891dd1c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -57,7 +57,6 @@ config ARM_EXYNOS5440_CPUFREQ
>  config ARM_HIGHBANK_CPUFREQ
>  	tristate "Calxeda Highbank-based"
>  	depends on ARCH_HIGHBANK
> -	select CPU_FREQ_TABLE
>  	select GENERIC_CPUFREQ_CPU0
>  	select PM_OPP
>  	select REGULATOR
> 
