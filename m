From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 12/12] cpuidle: cpuidle-cps: Enable use with MIPSr6
 CPUs.
Date: Thu, 8 Sep 2016 12:55:13 +0200
Message-ID: <f0e9df57-a19f-a94d-6cf8-60ea7c84a732@linaro.org>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
 <1473241520-14917-13-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1473241520-14917-13-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Matt Redfearn <matt.redfearn@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/09/2016 11:45, Matt Redfearn wrote:
> This patch enables the MIPS CPS driver for MIPSr6 CPUs.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> 

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v2: None
> 
>  drivers/cpuidle/Kconfig.mips  | 2 +-
>  drivers/cpuidle/cpuidle-cps.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
> index 4102be01d06a..512ee37b374b 100644
> --- a/drivers/cpuidle/Kconfig.mips
> +++ b/drivers/cpuidle/Kconfig.mips
> @@ -5,7 +5,7 @@ config MIPS_CPS_CPUIDLE
>  	bool "CPU Idle driver for MIPS CPS platforms"
>  	depends on CPU_IDLE && MIPS_CPS
>  	depends on SYS_SUPPORTS_MIPS_CPS
> -	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT || CPU_MIPSR6
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select MIPS_CPS_PM
>  	default y
> diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
> index 1adb6980b707..926ba9871c62 100644
> --- a/drivers/cpuidle/cpuidle-cps.c
> +++ b/drivers/cpuidle/cpuidle-cps.c
> @@ -163,7 +163,7 @@ static int __init cps_cpuidle_init(void)
>  		core = cpu_data[cpu].core;
>  		device = &per_cpu(cpuidle_dev, cpu);
>  		device->cpu = cpu;
> -#ifdef CONFIG_MIPS_MT
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>  		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
>  #endif
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
