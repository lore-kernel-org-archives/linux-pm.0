From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to drivers/cpuidle
 directory
Date: Mon, 15 Apr 2013 16:14:08 +0200
Message-ID: <516C0B30.501@atmel.com>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org> <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:9251 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab3DOOOJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2013 10:14:09 -0400
In-Reply-To: <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, plagnioj@jcrosoft.com
Cc: linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 04/15/2013 03:29 PM, Daniel Lezcano :
> We don't have any dependency with the SoC specific code.
> 
> Move the driver to the drivers/cpuidle directory.
> 
> Add Nicolas Ferre as author of the driver, so it will be in copy of the emails.

Unfortunately, I am not the author of this driver. It is the work of
Albin Tonnerre <albin.tonnerre@free-electrons.com>. So, for sure, I (and
Jean-Christohpe) can babysit this code but I cannot be awarded for it...

You can certainly add to the header of this file:
Maintained by the AT91 crew: Nicolas Ferre, Jean-Christophe
Plagniol-Villard (together with email addresses).



> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-at91/Makefile  |    1 -
>  arch/arm/mach-at91/cpuidle.c |   55 ----------------------------------------
>  drivers/cpuidle/Makefile     |    1 +
>  drivers/cpuidle/at91.c       |   57 ++++++++++++++++++++++++++++++++++++++++++

No, sorry this file name is not appropriate: I prefer cpuidle-at91.c

>  4 files changed, 58 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/cpuidle.c
>  create mode 100644 drivers/cpuidle/at91.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 39218ca..3c7fca1 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -99,7 +99,6 @@ obj-y				+= leds.o
>  # Power Management
>  obj-$(CONFIG_PM)		+= pm.o
>  obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
> -obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
>  
>  ifeq ($(CONFIG_PM_DEBUG),y)
>  CFLAGS_pm.o += -DDEBUG
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> deleted file mode 100644
> index b2bec92..0000000
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ /dev/null
> @@ -1,55 +0,0 @@
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
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/cpuidle.h>
> -#include <asm/cpuidle.h>
> -
> -#define AT91_MAX_STATES	2
> -
> -extern void (*at91_standby_ops)(void);
> -
> -/* Actual code that puts the SoC in different idle states */
> -static int at91_enter_idle(struct cpuidle_device *dev,
> -			struct cpuidle_driver *drv,
> -			       int index)
> -{
> -	at91_standby_ops();
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
> -		.target_residency	= 100000,
> -		.flags			= CPUIDLE_FLAG_TIME_VALID,
> -		.name			= "RAM_SR",
> -		.desc			= "WFI and DDR Self Refresh",
> -	},
> -	.state_count = AT91_MAX_STATES,
> -};
> -
> -/* Initialize CPU idle by registering the idle states */
> -static int __init at91_init_cpuidle(void)
> -{
> -	return cpuidle_register(&at91_idle_driver, NULL);
> -}
> -
> -device_initcall(at91_init_cpuidle);
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0d8bd55..ba4e977 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  
>  obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
> +obj-$(CONFIG_ARCH_AT91) += at91.o
> diff --git a/drivers/cpuidle/at91.c b/drivers/cpuidle/at91.c
> new file mode 100644
> index 0000000..2bc745b
> --- /dev/null
> +++ b/drivers/cpuidle/at91.c
> @@ -0,0 +1,57 @@
> +/*
> + * based on arch/arm/mach-kirkwood/cpuidle.c
> + *
> + * CPU idle support for AT91 SoC
> + *
> + * Author: Nicolas Ferre <nicolas.ferre@atmel.com>
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
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/cpuidle.h>
> +#include <asm/cpuidle.h>
> +
> +#define AT91_MAX_STATES	2
> +
> +extern void (*at91_standby_ops)(void);
> +
> +/* Actual code that puts the SoC in different idle states */
> +static int at91_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	at91_standby_ops();
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
> +		.target_residency	= 100000,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
> +		.name			= "RAM_SR",
> +		.desc			= "WFI and DDR Self Refresh",
> +	},
> +	.state_count = AT91_MAX_STATES,
> +};
> +
> +/* Initialize CPU idle by registering the idle states */
> +static int __init at91_init_cpuidle(void)
> +{
> +	return cpuidle_register(&at91_idle_driver, NULL);
> +}
> +
> +device_initcall(at91_init_cpuidle);
> 


-- 
Nicolas Ferre
