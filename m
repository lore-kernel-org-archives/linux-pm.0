From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 8/8] ARM: cpuidle: Change function name to be
 consistent with x86
Date: Sat, 21 Mar 2015 20:09:38 +0000
Message-ID: <20150321200938.GA22354@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-9-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42816 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbbCUUJg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Mar 2015 16:09:36 -0400
Content-Disposition: inline
In-Reply-To: <1426851841-2072-9-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On Fri, Mar 20, 2015 at 11:44:01AM +0000, Daniel Lezcano wrote:
> Change the functions name:
>  arm_cpuidle_suspend => arm_idle
>  arm_cpuidle_init    => arm_idle_cpu_init
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I think you can drop this patch, unless we have a compelling reason
to have same names with x86, sorry for the churn.

Lorenzo

> ---
>  arch/arm/include/asm/cpuidle.h   | 4 ++--
>  arch/arm/kernel/cpuidle.c        | 4 ++--
>  arch/arm64/include/asm/cpuidle.h | 6 +++---
>  arch/arm64/kernel/cpuidle.c      | 2 +-
>  drivers/cpuidle/cpuidle-arm.c    | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> index 0f84249..5f547c0 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -44,8 +44,8 @@ struct of_cpuidle_method {
>  	__used __section(__cpuidle_method_of_table)			\
>  	= { .method = _method, .ops = _ops }
>  
> -extern int arm_cpuidle_suspend(int index);
> +extern int arm_idle(int index);
>  
> -extern int arm_cpuidle_init(int cpu);
> +extern int arm_idle_cpu_init(int cpu);
>  
>  #endif
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index 7b42a40..05a2c3e 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -29,7 +29,7 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> -int arm_cpuidle_suspend(int index)
> +int arm_idle(int index)
>  {
>  	int ret = -EOPNOTSUPP;
>  	int cpu = smp_processor_id();
> @@ -75,7 +75,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
>  	return 0;
>  }
>  
> -int __init arm_cpuidle_init(int cpu)
> +int __init arm_idle_cpu_init(int cpu)
>  {
>  	int ret = -EOPNOTSUPP;
>  	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
> index 141b2fc..e9c0dc4e 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -4,10 +4,10 @@
>  #include <asm/proc-fns.h>
>  
>  #ifdef CONFIG_CPU_IDLE
> -extern int arm_cpuidle_init(unsigned int cpu);
> +extern int arm_idle_cpu_init(unsigned int cpu);
>  extern int cpu_suspend(unsigned long arg);
>  #else
> -static inline int arm_cpuidle_init(unsigned int cpu)
> +static inline int arm_idle_cpu_init(unsigned int cpu)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -17,7 +17,7 @@ static inline int cpu_suspend(unsigned long arg)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -static inline int arm_cpuidle_suspend(int index)
> +static inline int arm_idle(int index)
>  {
>  	return cpu_suspend(index);
>  }
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index a78143a..b6b4fcf 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -15,7 +15,7 @@
>  #include <asm/cpuidle.h>
>  #include <asm/cpu_ops.h>
>  
> -int arm_cpuidle_init(unsigned int cpu)
> +int arm_idle_cpu_init(unsigned int cpu)
>  {
>  	int ret = -EOPNOTSUPP;
>  	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index e4a6eba..37c732d 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -50,7 +50,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>  		 * call the CPU ops suspend protocol with idle index as a
>  		 * parameter.
>  		 */
> -		arm_cpuidle_suspend(idx);
> +		arm_idle(idx);
>  
>  		cpu_pm_exit();
>  	}
> @@ -118,7 +118,7 @@ static int __init arm_idle_init(void)
>  	 * idle states suspend back-end specific data
>  	 */
>  	for_each_possible_cpu(cpu) {
> -		ret = arm_cpuidle_init(cpu);
> +		ret = arm_idle_cpu_init(cpu);
>  
>  		/* This cpu does not support any idle states */
>  		if (ret == -ENXIO)
> -- 
> 1.9.1
> 
> 
