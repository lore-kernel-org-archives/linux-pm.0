From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
Date: Thu, 03 Oct 2013 14:59:46 +0200
Message-ID: <3239256.KJU9uDytC0@amdc1032>
References: <1380211567-2972-1-git-send-email-daniel.lezcano@linaro.org>
 <1380211567-2972-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58748 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab3JCM7x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 08:59:53 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MU3006V1G31LYB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 03 Oct 2013 21:59:50 +0900 (KST)
In-reply-to: <1380211567-2972-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org


Hi,

On Thursday, September 26, 2013 06:06:07 PM Daniel Lezcano wrote:
> As the cpuidle driver code has no more the dependency with the pm code, the
> 'standby' callback being passed as a parameter to the device's platform data,
> we can move the cpuidle driver in the drivers/cpuidle directory.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-at91/Makefile    |    1 -
>  arch/arm/mach-at91/cpuidle.c   |   69 ----------------------------------------
>  drivers/cpuidle/Kconfig.arm    |    6 ++++
>  drivers/cpuidle/Makefile       |    1 +
>  drivers/cpuidle/cpuidle-at91.c |   69 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 76 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/cpuidle.c
>  create mode 100644 drivers/cpuidle/cpuidle-at91.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 3b0a953..c1b7370 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -98,7 +98,6 @@ obj-y				+= leds.o
>  # Power Management
>  obj-$(CONFIG_PM)		+= pm.o
>  obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
> -obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
>  
>  ifeq ($(CONFIG_PM_DEBUG),y)
>  CFLAGS_pm.o += -DDEBUG
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> deleted file mode 100644
> index 6cdc76d..0000000
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/*
> - * based on arch/arm/mach-kirkwood/cpuidle.c
> - *
> - * CPU idle support for AT91 SoC
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - *
> - * The cpu idle uses wait-for-interrupt and RAM self refresh in order
> - * to implement two idle states -
> - * #1 wait-for-interrupt
> - * #2 wait-for-interrupt and RAM self refresh
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/cpuidle.h>
> -#include <linux/io.h>
> -#include <linux/export.h>
> -#include <asm/proc-fns.h>
> -#include <asm/cpuidle.h>
> -
> -#define AT91_MAX_STATES	2
> -
> -static void (*at91_standby)(void);
> -
> -/* Actual code that puts the SoC in different idle states */
> -static int at91_enter_idle(struct cpuidle_device *dev,
> -			struct cpuidle_driver *drv,
> -			       int index)
> -{
> -	at91_standby();
> -	return index;
> -}
> -
> -static struct cpuidle_driver at91_idle_driver = {
> -	.name			= "at91_idle",
> -	.owner			= THIS_MODULE,
> -	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> -	.states[1]		= {
> -		.enter			= at91_enter_idle,
> -		.exit_latency		= 10,
> -		.target_residency	= 10000,
> -		.flags			= CPUIDLE_FLAG_TIME_VALID,
> -		.name			= "RAM_SR",
> -		.desc			= "WFI and DDR Self Refresh",
> -	},
> -	.state_count = AT91_MAX_STATES,
> -};
> -
> -/* Initialize CPU idle by registering the idle states */
> -static int __init at91_cpuidle_probe(struct platform_device *dev)
> -{
> -	at91_standby = (void *)(dev->dev.platform_data);
> -	
> -	return cpuidle_register(&at91_idle_driver, NULL);
> -}
> -
> -static struct platform_driver at91_cpuidle_driver = {
> -	.driver = {
> -		.name = "cpuidle-at91",
> -		.owner = THIS_MODULE,
> -	},
> -	.probe = at91_cpuidle_probe,
> -};
> -
> -module_platform_driver(at91_cpuidle_driver);
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 8e36603..edecfc8 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -27,6 +27,12 @@ config ARM_U8500_CPUIDLE
>  	help
>  	  Select this to enable cpuidle for ST-E u8500 processors
>  
> +config ARM_AT91_CPUIDLE
> +        bool "Cpu Idle Driver for the AT91 processors"

whitespace damage, please replace spaces by tab

> +	depends on ARCH_AT91

I believe that it should be also "default y" here to preserve the old
behavior (the driver was always built-in for CONFIG_CPU_IDLE=y).

> +	help
> +	  Select this to enable cpuidle for AT91 processors
> +
>  config CPU_IDLE_BIG_LITTLE
>  	bool "Support for ARM big.LITTLE processors"
>  	depends on ARCH_VEXPRESS_TC2_PM
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index cea5ef5..60c4ae5 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
>  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>  obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
> +obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>  obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+= cpuidle-big_little.o
> diff --git a/drivers/cpuidle/cpuidle-at91.c b/drivers/cpuidle/cpuidle-at91.c
> new file mode 100644
> index 0000000..6cdc76d
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-at91.c
> @@ -0,0 +1,69 @@
> +/*
> + * based on arch/arm/mach-kirkwood/cpuidle.c
> + *
> + * CPU idle support for AT91 SoC
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * The cpu idle uses wait-for-interrupt and RAM self refresh in order
> + * to implement two idle states -
> + * #1 wait-for-interrupt
> + * #2 wait-for-interrupt and RAM self refresh
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpuidle.h>
> +#include <linux/io.h>
> +#include <linux/export.h>
> +#include <asm/proc-fns.h>
> +#include <asm/cpuidle.h>
> +
> +#define AT91_MAX_STATES	2
> +
> +static void (*at91_standby)(void);
> +
> +/* Actual code that puts the SoC in different idle states */
> +static int at91_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	at91_standby();
> +	return index;
> +}
> +
> +static struct cpuidle_driver at91_idle_driver = {
> +	.name			= "at91_idle",
> +	.owner			= THIS_MODULE,
> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		= {
> +		.enter			= at91_enter_idle,
> +		.exit_latency		= 10,
> +		.target_residency	= 10000,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
> +		.name			= "RAM_SR",
> +		.desc			= "WFI and DDR Self Refresh",
> +	},
> +	.state_count = AT91_MAX_STATES,
> +};
> +
> +/* Initialize CPU idle by registering the idle states */
> +static int __init at91_cpuidle_probe(struct platform_device *dev)
> +{
> +	at91_standby = (void *)(dev->dev.platform_data);
> +	
> +	return cpuidle_register(&at91_idle_driver, NULL);
> +}
> +
> +static struct platform_driver at91_cpuidle_driver = {
> +	.driver = {
> +		.name = "cpuidle-at91",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = at91_cpuidle_probe,
> +};
> +
> +module_platform_driver(at91_cpuidle_driver);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

