From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC patch 1/2] ARM: at91: cpuidle: encapsulate the standby code
Date: Mon, 15 Apr 2013 15:54:38 +0200
Message-ID: <516C069E.2040205@atmel.com>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org> <1366032598-23053-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:40861 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab3DONyi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2013 09:54:38 -0400
In-Reply-To: <1366032598-23053-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

Hi Daniel,

On 04/15/2013 03:29 PM, Daniel Lezcano :
> In order to split the pm code from the cpuidle driver, add an ops for the
> standby function which will be initialized by the pm init functions directly,
> thus no need of the SoC specific headers.
> 
> Cleanup also the headers included in this file as they are no longer needed.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-at91/cpuidle.c |   19 ++++---------------
>  arch/arm/mach-at91/pm.c      |    8 +++++++-
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index 48f1228..b2bec92 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -13,32 +13,21 @@
>   * #2 wait-for-interrupt and RAM self refresh
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/platform_device.h>
>  #include <linux/cpuidle.h>
> -#include <linux/io.h>
> -#include <linux/export.h>
> -#include <asm/proc-fns.h>
>  #include <asm/cpuidle.h>
> -#include <mach/cpu.h>
> -
> -#include "pm.h"
>  
>  #define AT91_MAX_STATES	2
>  
> +extern void (*at91_standby_ops)(void);
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
> -	else
> -		at91sam9_standby();
> -
> +	at91_standby_ops();
>  	return index;
>  }
>  
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 73f1f25..f456e86 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -39,6 +39,8 @@
>  #include "at91_rstc.h"
>  #include "at91_shdwc.h"
>  
> +void (*at91_standby_ops)(void);

Is this a common pattern to have such a floating function pointer in the
pm code?

> +
>  static void __init show_reset_status(void)
>  {
>  	static char reset[] __initdata = "reset";
> @@ -321,8 +323,12 @@ static int __init at91_pm_init(void)
>  	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
>  
>  	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
> -	if (cpu_is_at91rm9200())
> +	if (cpu_is_at91rm9200()) {
>  		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
> +		at91_standby_ops = at91rm9200_standby;
> +	} else if (cpu_is_at91sam9g45())

CodingStyle: ending "{" is missing.

> +		at91_standby_ops= at91sam9g45_standby;

CodingStyle: " " is missing

> +	else at91_standby_ops = at91sam9_standby;

CodingStyle: not on the same line + "{}" missing

>  
>  	suspend_set_ops(&at91_pm_ops);

I am in favor for the move. But please rewrite a new series.

Bye,
-- 
Nicolas Ferre
