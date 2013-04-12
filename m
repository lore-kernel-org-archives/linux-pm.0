From: Simon Horman <horms@verge.net.au>
Subject: Re: [V2 patch 01/19] ARM: shmobile: cpuidle: remove
 shmobile_enter_wfi function
Date: Fri, 12 Apr 2013 09:44:25 +0900
Message-ID: <20130412004425.GD24461@verge.net.au>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
 <1365712969-7541-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42158 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab3DLAo2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 20:44:28 -0400
Content-Disposition: inline
In-Reply-To: <1365712969-7541-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Thu, Apr 11, 2013 at 10:42:31PM +0200, Daniel Lezcano wrote:
> Remove the shmobile_enter_wfi function which is the same as the
> common WFI enter function from the arm cpuidle driver defined
> with the ARM_CPUIDLE_WFI_STATE macro.

Should this patch also make shmobile_enter_wfi static in
arch/arm/mach-shmobile/cpuidle.c ?

Also, I have a slight preference for the patch to be split into two.
1. A patch to remove usage of shmobile_enter_wfi from the sh7372 SoC.
2. A patch to remove shmobile_enter_wfi. from common.h
   (and make it static?).

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-shmobile/include/mach/common.h |    3 ---
>  arch/arm/mach-shmobile/pm-sh7372.c           |    1 -
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index e48606d..362f9b2 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -13,9 +13,6 @@ extern int shmobile_clk_init(void);
>  extern void shmobile_handle_irq_intc(struct pt_regs *);
>  extern struct platform_suspend_ops shmobile_suspend_ops;
>  struct cpuidle_driver;
> -struct cpuidle_device;
> -extern int shmobile_enter_wfi(struct cpuidle_device *dev,
> -			      struct cpuidle_driver *drv, int index);
>  extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
>  
>  extern void sh7372_init_irq(void);
> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> index f6b14ca..fbef7b9 100644
> --- a/arch/arm/mach-shmobile/pm-sh7372.c
> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -414,7 +414,6 @@ static struct cpuidle_driver sh7372_cpuidle_driver = {
>  	.state_count		= 5,
>  	.safe_state_index	= 0, /* C1 */
>  	.states[0] = ARM_CPUIDLE_WFI_STATE,
> -	.states[0].enter = shmobile_enter_wfi,
>  	.states[1] = {
>  		.name = "C2",
>  		.desc = "Core Standby Mode",
> -- 
> 1.7.9.5
> 
