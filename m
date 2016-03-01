From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: allow building as a module
Date: Tue, 1 Mar 2016 16:04:38 +0100
Message-ID: <56D5AF86.7000809@gmail.com>
References: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
 <1456761867-1742824-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456761867-1742824-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 29/02/16 17:04, Arnd Bergmann wrote:
> The MT8173 cpufreq driver can currently only be built-in, but
> it has a Kconfig dependency on the thermal core. THERMAL
> can be a loadable module, which in turn makes this driver
> impossible to build.
>
> It is nicer to make the cpufreq driver a module as well, so
> this patch turns the option in to a 'tristate' and adapts
> the dependency accordingly.
>
> The driver has no module_exit() function, so it will continue
> to not support unloading, but it can be built as a module
> and loaded at runtime now.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5269e7067cd6 ("cpufreq: Add ARM_MT8173_CPUFREQ dependency on THERMAL")
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   drivers/cpufreq/Kconfig.arm      | 4 ++--
>   drivers/cpufreq/mt8173-cpufreq.c | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0031069b64c9..14b1f9393b05 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -84,10 +84,10 @@ config ARM_KIRKWOOD_CPUFREQ
>   	  SoCs.
>
>   config ARM_MT8173_CPUFREQ
> -	bool "Mediatek MT8173 CPUFreq support"
> +	tristate "Mediatek MT8173 CPUFreq support"
>   	depends on ARCH_MEDIATEK && REGULATOR
>   	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
> -	depends on !CPU_THERMAL || THERMAL=y
> +	depends on !CPU_THERMAL || THERMAL
>   	select PM_OPP
>   	help
>   	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 1efba340456d..2058e6d292ce 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -17,6 +17,7 @@
>   #include <linux/cpu_cooling.h>
>   #include <linux/cpufreq.h>
>   #include <linux/cpumask.h>
> +#include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>
