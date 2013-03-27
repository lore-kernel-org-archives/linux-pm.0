From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 15/15] ARM: shmobile: cpuidle: use init/exit common
 routine
Date: Wed, 27 Mar 2013 23:10:06 +0900
Message-ID: <20130327141006.GH4324@verge.net.au>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-16-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48438 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3C0OKI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 10:10:08 -0400
Content-Disposition: inline
In-Reply-To: <1364234140-514-16-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

On Mon, Mar 25, 2013 at 06:55:40PM +0100, Daniel Lezcano wrote:
> Remove the duplicate code and use the arm cpuidle driver's common code
> for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/cpuidle.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
> index c872ae8..9744d88 100644
> --- a/arch/arm/mach-shmobile/cpuidle.c
> +++ b/arch/arm/mach-shmobile/cpuidle.c
> @@ -16,7 +16,6 @@
>  #include <asm/cpuidle.h>
>  #include <asm/io.h>
>  
> -static struct cpuidle_device shmobile_cpuidle_dev;
>  static struct cpuidle_driver shmobile_cpuidle_default_driver = {
>  	.name			= "shmobile_cpuidle",
>  	.owner			= THIS_MODULE,
> @@ -35,12 +34,5 @@ void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
>  
>  int __init shmobile_cpuidle_init(void)
>  {
> -	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
> -
> -	cpuidle_register_driver(cpuidle_drv);
> -
> -	dev->state_count = cpuidle_drv->state_count;
> -	cpuidle_register_device(dev);
> -
> -	return 0;
> +	return arm_cpuidle_init(cpuidle_drv);
>  }
> -- 
> 1.7.9.5
> 
