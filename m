From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 4/8] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
Date: Sat, 21 Mar 2015 20:24:46 +0000
Message-ID: <20150321202446.GD22354@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42872 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbbCUUYl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Mar 2015 16:24:41 -0400
Content-Disposition: inline
In-Reply-To: <1426851841-2072-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On Fri, Mar 20, 2015 at 11:43:57AM +0000, Daniel Lezcano wrote:
> With this change the cpuidle-arm64.c file calls the same function name
> for both ARM and ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Rob Herring <robherring2@gmail.com>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  arch/arm64/include/asm/cpuidle.h | 4 ++--
>  arch/arm64/kernel/cpuidle.c      | 2 +-
>  drivers/cpuidle/cpuidle-arm64.c  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
> index 460a38b..141b2fc 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -4,10 +4,10 @@
>  #include <asm/proc-fns.h>
>  
>  #ifdef CONFIG_CPU_IDLE
> -extern int cpu_init_idle(unsigned int cpu);
> +extern int arm_cpuidle_init(unsigned int cpu);
>  extern int cpu_suspend(unsigned long arg);
>  #else
> -static inline int cpu_init_idle(unsigned int cpu)
> +static inline int arm_cpuidle_init(unsigned int cpu)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index 5c08966..a78143a 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -15,7 +15,7 @@
>  #include <asm/cpuidle.h>
>  #include <asm/cpu_ops.h>
>  
> -int cpu_init_idle(unsigned int cpu)
> +int arm_cpuidle_init(unsigned int cpu)
>  {
>  	int ret = -EOPNOTSUPP;
>  	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 0cea244..6ef291c7 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -110,7 +110,7 @@ static int __init arm64_idle_init(void)
>  	 * idle states suspend back-end specific data
>  	 */
>  	for_each_possible_cpu(cpu) {
> -		ret = cpu_init_idle(cpu);
> +		ret = arm_cpuidle_init(cpu);
>  		if (ret) {
>  			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>  			return ret;
> -- 
> 1.9.1
> 
> 
