From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 19:10:38 +0100
Message-ID: <20130325181038.GA631@lunn.ch>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:58920 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333Ab3CYSMF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 14:12:05 -0400
Content-Disposition: inline
In-Reply-To: <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

On Mon, Mar 25, 2013 at 06:55:32PM +0100, Daniel Lezcano wrote:
> The init and exit routine for most of the drivers are the same,
> that is register the driver and register the device.
> 
> Provide a common function to do that in the cpuidle driver for ARM,
> so we can get rid of a lot of code duplication in the different SOC
> cpuidle drivers.

Hi Daniel

Please could you add a comment in the code about which piece is
specific to ARM, because its not obvious to me. Its not like there is
a reference to WFI for example. It looks like this code could go in
drivers/cpuidle/cpuidle.c

  Thanks
	Andrew

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/include/asm/cpuidle.h |    4 +++
>  arch/arm/kernel/cpuidle.c      |   57 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> index 7367787..83a38ac 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -4,6 +4,10 @@
>  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>  				    struct cpuidle_driver *drv, int index);
>  
> +extern int arm_cpuidle_init(struct cpuidle_driver *drv);
> +
> +extern void arm_cpuidle_exit(struct cpuidle_driver *drv);
> +
>  /* Common ARM WFI state */
>  #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
>  	.enter                  = arm_cpuidle_simple_enter,\
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index 89545f6..13cfe3e 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -9,13 +9,68 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> +#include <linux/module.h>
>  #include <linux/cpuidle.h>
>  #include <asm/proc-fns.h>
>  
> +static DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
> +
>  int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index)
> +			     struct cpuidle_driver *drv, int index)
>  {
>  	cpu_do_idle();
>  
>  	return index;
>  }
> +
> +int __init arm_cpuidle_init(struct cpuidle_driver *drv)
> +{
> +       int ret, cpu;
> +       struct cpuidle_device *device;
> +
> +       ret = cpuidle_register_driver(drv);
> +       if (ret) {
> +               printk(KERN_ERR "failed to register idle driver '%s'\n",
> +                       drv->name);
> +               return ret;
> +       }
> +
> +       for_each_online_cpu(cpu) {
> +
> +               device = &per_cpu(cpuidle_device, cpu);
> +               device->cpu = cpu;
> +               ret = cpuidle_register_device(device);
> +               if (ret) {
> +                       printk(KERN_ERR "Failed to register cpuidle "
> +                              "device for cpu%d\n", cpu);
> +                       goto out_unregister;
> +               }
> +       }
> +
> +out:
> +       return ret;
> +
> +out_unregister:
> +       for_each_online_cpu(cpu) {
> +               device = &per_cpu(cpuidle_device, cpu);
> +               cpuidle_unregister_device(device);
> +       }
> +
> +       cpuidle_unregister_driver(drv);
> +       goto out;
> +}
> +EXPORT_SYMBOL_GPL(arm_cpuidle_init);
> +
> +void __exit arm_cpuidle_exit(struct cpuidle_driver *drv)
> +{
> +	int cpu;
> +	struct cpuidle_device *device;
> +
> +	for_each_online_cpu(cpu) {
> +		device = &per_cpu(cpuidle_device, cpu);
> +		cpuidle_unregister_device(device);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +}
> +EXPORT_SYMBOL_GPL(arm_cpuidle_exit);
> -- 
> 1.7.9.5
> 
