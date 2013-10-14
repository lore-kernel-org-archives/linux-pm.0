From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH V2 1/2] ARM: at91: cpuidle: convert to platform driver
Date: Tue, 15 Oct 2013 01:25:39 +0200
Message-ID: <20131014232539.GM11420@ns203013.ovh.net>
References: <1381781721-11866-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1381781721-11866-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: thomas.petazzoni@free-electrons.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, nicolas.ferre@atmel.com, b.zolnierkie@samsung.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 22:15 Mon 14 Oct     , Daniel Lezcano wrote:
> Using the platform driver model is a good way to separate the cpuidle specific
> code from the low level pm code. It allows to remove the dependency between
> these two components.
> 
> The platform_device is located in the pm code and a 'set' function has been
> added to set the standby function from the AT91_SOC_START initialization
> function. Each SoC with a cpuidle driver will set the standby function in the
> platform_data field at init time. Then pm code will register the cpuidle
> platform device.
> 
> The cpuidle driver will register the platform_driver and use the device's
> platform_data as a standby callback in the idle path.

I've an issue while re-reading the pm code

we use the xx_standby for 2 drivers cpuidle and suspend/resume

with all the cpu_is_xxxx

so you need to do one more step in this series
by cleaning up the PM_SUSPEND_STANDBY to as you put a function pointer with
the correct one in pm.c

otherwise looks good

Best Regards,
J.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-at91/at91rm9200.c  |    3 +++
>  arch/arm/mach-at91/at91sam9260.c |    3 +++
>  arch/arm/mach-at91/at91sam9261.c |    3 +++
>  arch/arm/mach-at91/at91sam9263.c |    3 +++
>  arch/arm/mach-at91/at91sam9g45.c |    3 +++
>  arch/arm/mach-at91/at91sam9rl.c  |    3 +++
>  arch/arm/mach-at91/cpuidle.c     |   29 +++++++++++++++--------------
>  arch/arm/mach-at91/pm.c          |   12 ++++++++++++
>  arch/arm/mach-at91/pm.h          |    4 ++++
>  9 files changed, 49 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 4aad93d..0d234f2 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -27,6 +27,7 @@
>  #include "generic.h"
>  #include "clock.h"
>  #include "sam9_smc.h"
> +#include "pm.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -337,6 +338,8 @@ static void __init at91rm9200_initialize(void)
>  	/* Initialize GPIO subsystem */
>  	at91_gpio_init(at91rm9200_gpio,
>  		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
> +
> +	at91_pm_set_standby(at91rm9200_standby);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index 5de6074..ffe9ce7 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -28,6 +28,7 @@
>  #include "generic.h"
>  #include "clock.h"
>  #include "sam9_smc.h"
> +#include "pm.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -351,6 +352,8 @@ static void __init at91sam9260_initialize(void)
>  
>  	/* Register GPIO subsystem */
>  	at91_gpio_init(at91sam9260_gpio, 3);
> +
> +	at91_pm_set_standby(at91sam9_standby);
>  }
>  
>  /* --------------------------------------------------------------------
> diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> index 0e07932..1edbb6f 100644
> --- a/arch/arm/mach-at91/at91sam9261.c
> +++ b/arch/arm/mach-at91/at91sam9261.c
> @@ -27,6 +27,7 @@
>  #include "generic.h"
>  #include "clock.h"
>  #include "sam9_smc.h"
> +#include "pm.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -293,6 +294,8 @@ static void __init at91sam9261_initialize(void)
>  
>  	/* Register GPIO subsystem */
>  	at91_gpio_init(at91sam9261_gpio, 3);
> +
> +	at91_pm_set_sandby(at91sam9_standby);
>  }
>  
>  /* --------------------------------------------------------------------
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index 6ce7d18..8c81c89 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -26,6 +26,7 @@
>  #include "generic.h"
>  #include "clock.h"
>  #include "sam9_smc.h"
> +#include "pm.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -330,6 +331,8 @@ static void __init at91sam9263_initialize(void)
>  
>  	/* Register GPIO subsystem */
>  	at91_gpio_init(at91sam9263_gpio, 5);
> +
> +	at91_pm_set_standby(at91sam9263_standby);
>  }
>  
>  /* --------------------------------------------------------------------
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index 474ee04..8460f52 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -26,6 +26,7 @@
>  #include "generic.h"
>  #include "clock.h"
>  #include "sam9_smc.h"
> +#include "pm.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -379,6 +380,8 @@ static void __init at91sam9g45_initialize(void)
>  
>  	/* Register GPIO subsystem */
>  	at91_gpio_init(at91sam9g45_gpio, 5);
> +
> +	at91_pm_set_standby(at91sam9g45_standby);
>  }
>  
>  /* --------------------------------------------------------------------
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index d4ec0d9..c7986e4 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -27,6 +27,7 @@
>  #include "generic.h"
>  #include "clock.h"
>  #include "sam9_smc.h"
> +#include "pm.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -296,6 +297,8 @@ static void __init at91sam9rl_initialize(void)
>  
>  	/* Register GPIO subsystem */
>  	at91_gpio_init(at91sam9rl_gpio, 4);
> +
> +	at91_pm_set_standby(at91sam9_standby);
>  }
>  
>  /* --------------------------------------------------------------------
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index 4ec6a6d..a077437 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -21,26 +21,17 @@
>  #include <linux/export.h>
>  #include <asm/proc-fns.h>
>  #include <asm/cpuidle.h>
> -#include <mach/cpu.h>
> -
> -#include "pm.h"
>  
>  #define AT91_MAX_STATES	2
>  
> +static void (*at91_standby)(void);
> +
>  /* Actual code that puts the SoC in different idle states */
>  static int at91_enter_idle(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			       int index)
>  {
> -	if (cpu_is_at91rm9200())
> -		at91rm9200_standby();
> -	else if (cpu_is_at91sam9g45())
> -		at91sam9g45_standby();
> -	else if (cpu_is_at91sam9263())
> -		at91sam9263_standby();
> -	else
> -		at91sam9_standby();
> -
> +	at91_standby();
>  	return index;
>  }
>  
> @@ -60,9 +51,19 @@ static struct cpuidle_driver at91_idle_driver = {
>  };
>  
>  /* Initialize CPU idle by registering the idle states */
> -static int __init at91_init_cpuidle(void)
> +static int at91_cpuidle_probe(struct platform_device *dev)
>  {
> +	at91_standby = (void *)(dev->dev.platform_data);
> +	
>  	return cpuidle_register(&at91_idle_driver, NULL);
>  }
>  
> -device_initcall(at91_init_cpuidle);
> +static struct platform_driver at91_cpuidle_driver = {
> +	.driver = {
> +		.name = "cpuidle-at91",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = at91_cpuidle_probe,
> +};
> +
> +module_platform_driver(at91_cpuidle_driver);
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 15afb5d..f753ace 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -314,6 +314,15 @@ static const struct platform_suspend_ops at91_pm_ops = {
>  	.end	= at91_pm_end,
>  };
>  
> +static struct platform_device at91_cpuidle_device = {
> +	.name = "cpuidle-at91",
> +};
> +
> +void at91_pm_set_standby(void (*at91_standby)(void))
> +{
> +	at91_cpuidle_device.dev.platform_data = at91_standby;	
> +}
> +
>  static int __init at91_pm_init(void)
>  {
>  #ifdef CONFIG_AT91_SLOW_CLOCK
> @@ -325,6 +334,9 @@ static int __init at91_pm_init(void)
>  	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
>  	if (cpu_is_at91rm9200())
>  		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
> +	
> +	if (at91_cpuidle_device.dev.platform_data)
> +		platform_device_register(&at91_cpuidle_device);
>  
>  	suspend_set_ops(&at91_pm_ops);
>  
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index 2f5908f..76dd1a7 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -11,9 +11,13 @@
>  #ifndef __ARCH_ARM_MACH_AT91_PM
>  #define __ARCH_ARM_MACH_AT91_PM
>  
> +#include <asm/proc-fns.h>
> +
>  #include <mach/at91_ramc.h>
>  #include <mach/at91rm9200_sdramc.h>
>  
> +extern void at91_pm_set_standby(void (*at91_standby)(void));
> +
>  /*
>   * The AT91RM9200 goes into self-refresh mode with this command, and will
>   * terminate self-refresh automatically on the next SDRAM access.
> -- 
> 1.7.9.5
> 
