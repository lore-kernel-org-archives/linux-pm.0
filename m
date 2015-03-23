From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V4] ARM: cpuidle: Register per cpuidle device
Date: Mon, 23 Mar 2015 22:58:28 +0000
Message-ID: <20150323225828.GC15435@e102568-lin.cambridge.arm.com>
References: <20150323162514.GE18904@red-moon>
 <1427129424-17175-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46949 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbbCWW6d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Mar 2015 18:58:33 -0400
Content-Disposition: inline
In-Reply-To: <1427129424-17175-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On Mon, Mar 23, 2015 at 04:50:24PM +0000, Daniel Lezcano wrote:
> On some platforms, the low level PM code may not be initialized correctly for
> a specific cpu. In this case, the EXNIO tells the cpuidle driver to not

"-ENXIO", but honestly these sentences should be rewritten, I understand
what you mean, but for someone who has not reviewed the code before
this log means precious little.

"If the cpuidle init cpu operation returns -ENXIO, therefore reporting HW
failure or misconfiguration, the CPUidle driver skips the respective
cpuidle device initialization because the associated platform back-end HW
is not operational".

> initialize the cpuidle device as the associated low level PM is not operational.
> 
> That prevents the system to crash and allows to handle the error gracefully.
> 
> For example, on Qcom's platform, each core has a SPM. The device associated
> with this SPM is initialized before the cpuidle framework. If there is an error
> in the initialization (eg. error in the DT), the system continues to boot but
> in degraded mode as some SPM may not be correctly initialized.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm.c | 46 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 1c94b88..a7a01ce 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/slab.h>
>  
>  #include <asm/cpuidle.h>
>  
> @@ -94,6 +95,7 @@ static int __init arm_idle_init(void)
>  {
>  	int cpu, ret;
>  	struct cpuidle_driver *drv = &arm_idle_driver;
> +	struct cpuidle_device *dev;
>  
>  	/*
>  	 * Initialize idle states data, starting at index 1.
> @@ -105,18 +107,58 @@ static int __init arm_idle_init(void)
>  	if (ret <= 0)
>  		return ret ? : -ENODEV;
>  
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		pr_err("Failed to register cpuidle driver\n");
> +		return ret;
> +	}
> +
>  	/*
>  	 * Call arch CPU operations in order to initialize
>  	 * idle states suspend back-end specific data
>  	 */
>  	for_each_possible_cpu(cpu) {
>  		ret = arm_cpuidle_init(cpu);
> +
> +		/* 
> +		 * Do not register the cpuidle device. This situation could
> +		 * happen when the low level PM was not able to initialize
> +		 * for any reaon.

s/reaon/reason. I disagree, it is not for *any* reason. Something like:

/*
 * Skip the cpuidle device initialization if the reported failure
 * is a HW misconfiguration/breakage (-ENXIO).
 */

arm_cpuidle_init() should be documented in this respect.

> +		 */
> +		if (ret == -ENXIO)
> +			continue;
> +
>  		if (ret) {
>  			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> -			return ret;
> +			goto out_fail;
> +		}
> +
> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +		if (!dev) {
> +			pr_err("Failed to allocate cpuidle device\n");
> +			goto out_fail;
> +		}
> +		dev->cpu = cpu;
> +
> +		ret = cpuidle_register_device(dev);
> +		if (ret) {
> +			pr_err("Failed to register cpuidle device for CPU %d\n",
> +			       cpu);
> +			kfree(dev);
> +			goto out_fail;
>  		}
>  	}
>  
> -	return cpuidle_register(drv, NULL);
> +	return 0;
> +out_fail:
> +	while (--cpu >= 0) {
> +		dev = per_cpu(cpuidle_devices, cpu);
> +		cpuidle_unregister_device(dev);
> +		kfree(dev);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +
> +	return ret;
>  }
>  device_initcall(arm_idle_init);

With the changes requested:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
