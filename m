From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 5/8] ARM64: cpuidle: Remove arm64 reference
Date: Sat, 21 Mar 2015 20:21:33 +0000
Message-ID: <20150321202133.GC22354@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42857 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbCUUV1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Mar 2015 16:21:27 -0400
Content-Disposition: inline
In-Reply-To: <1426851841-2072-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On Fri, Mar 20, 2015 at 11:43:58AM +0000, Daniel Lezcano wrote:
> In the next patch, this driver will be common across ARM/ARM64. Remove all refs
> to ARM64 as it will be shared with ARM32.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Rob Herring <robherring2@gmail.com>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  drivers/cpuidle/cpuidle-arm64.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 6ef291c7..1c94b88 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -1,5 +1,5 @@
>  /*
> - * ARM64 generic CPU idle driver.
> + * ARM/ARM64 generic CPU idle driver.
>   *
>   * Copyright (C) 2014 ARM Ltd.
>   * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> @@ -9,7 +9,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#define pr_fmt(fmt) "CPUidle arm64: " fmt
> +#define pr_fmt(fmt) "CPUidle arm: " fmt
>  
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
> @@ -23,7 +23,7 @@
>  #include "dt_idle_states.h"
>  
>  /*
> - * arm64_enter_idle_state - Programs CPU to enter the specified state
> + * arm_enter_idle_state - Programs CPU to enter the specified state
>   *
>   * dev: cpuidle device
>   * drv: cpuidle driver
> @@ -32,8 +32,8 @@
>   * Called from the CPUidle framework to program the device to the
>   * specified target state selected by the governor.
>   */
> -static int arm64_enter_idle_state(struct cpuidle_device *dev,
> -				  struct cpuidle_driver *drv, int idx)
> +static int arm_enter_idle_state(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int idx)
>  {
>  	int ret;
>  
> @@ -57,8 +57,8 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
>  	return ret ? -1 : idx;
>  }
>  
> -static struct cpuidle_driver arm64_idle_driver = {
> -	.name = "arm64_idle",
> +static struct cpuidle_driver arm_idle_driver = {
> +	.name = "arm_idle",
>  	.owner = THIS_MODULE,
>  	/*
>  	 * State at index 0 is standby wfi and considered standard
> @@ -68,32 +68,32 @@ static struct cpuidle_driver arm64_idle_driver = {
>  	 * handler for idle state index 0.
>  	 */
>  	.states[0] = {
> -		.enter                  = arm64_enter_idle_state,
> +		.enter                  = arm_enter_idle_state,
>  		.exit_latency           = 1,
>  		.target_residency       = 1,
>  		.power_usage		= UINT_MAX,
>  		.name                   = "WFI",
> -		.desc                   = "ARM64 WFI",
> +		.desc                   = "ARM WFI",
>  	}
>  };
>  
> -static const struct of_device_id arm64_idle_state_match[] __initconst = {
> +static const struct of_device_id arm_idle_state_match[] __initconst = {
>  	{ .compatible = "arm,idle-state",
> -	  .data = arm64_enter_idle_state },
> +	  .data = arm_enter_idle_state },
>  	{ },
>  };
>  
>  /*
> - * arm64_idle_init
> + * arm_idle_init
>   *
> - * Registers the arm64 specific cpuidle driver with the cpuidle
> + * Registers the arm specific cpuidle driver with the cpuidle
>   * framework. It relies on core code to parse the idle states
>   * and initialize them using driver data structures accordingly.
>   */
> -static int __init arm64_idle_init(void)
> +static int __init arm_idle_init(void)
>  {
>  	int cpu, ret;
> -	struct cpuidle_driver *drv = &arm64_idle_driver;
> +	struct cpuidle_driver *drv = &arm_idle_driver;
>  
>  	/*
>  	 * Initialize idle states data, starting at index 1.
> @@ -101,7 +101,7 @@ static int __init arm64_idle_init(void)
>  	 * let the driver initialization fail accordingly since there is no
>  	 * reason to initialize the idle driver if only wfi is supported.
>  	 */
> -	ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
> +	ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>  	if (ret <= 0)
>  		return ret ? : -ENODEV;
>  
> @@ -119,4 +119,4 @@ static int __init arm64_idle_init(void)
>  
>  	return cpuidle_register(drv, NULL);
>  }
> -device_initcall(arm64_idle_init);
> +device_initcall(arm_idle_init);
> -- 
> 1.9.1
> 
> 
