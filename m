From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 09/15] ARM: at91: cpuidle: use init/exit common routine
Date: Tue, 26 Mar 2013 09:48:48 +0100
Message-ID: <515160F0.8030002@atmel.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-10-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:2119 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab3CZIs5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 04:48:57 -0400
In-Reply-To: <1364234140-514-10-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

On 03/25/2013 06:55 PM, Daniel Lezcano :
> Remove the duplicate code and use the arm cpuidle driver's common code
> for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

No objection for at91:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  arch/arm/mach-at91/cpuidle.c |   17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index 0c63815..0aa2c0f 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -27,8 +27,6 @@
>  
>  #define AT91_MAX_STATES	2
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
> -
>  /* Actual code that puts the SoC in different idle states */
>  static int at91_enter_idle(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
> @@ -61,20 +59,9 @@ static struct cpuidle_driver at91_idle_driver = {
>  };
>  
>  /* Initialize CPU idle by registering the idle states */
> -static int at91_init_cpuidle(void)
> +static int __init at91_init_cpuidle(void)
>  {
> -	struct cpuidle_device *device;
> -
> -	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
> -	device->state_count = AT91_MAX_STATES;
> -
> -	cpuidle_register_driver(&at91_idle_driver);
> -
> -	if (cpuidle_register_device(device)) {
> -		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
> -		return -EIO;
> -	}
> -	return 0;
> +	return arm_cpuidle_init(&at91_idle_driver);
>  }
>  
>  device_initcall(at91_init_cpuidle);
> 


-- 
Nicolas Ferre
