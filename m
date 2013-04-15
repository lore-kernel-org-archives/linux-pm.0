From: Simon Horman <horms@verge.net.au>
Subject: Re: [V3 patch 02/19] ARM: shmobile: cpuidle: remove
 shmobile_enter_wfi prototype
Date: Mon, 15 Apr 2013 12:56:18 +0900
Message-ID: <20130415035618.GC3070@verge.net.au>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50067 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921Ab3DOD4U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2013 23:56:20 -0400
Content-Disposition: inline
In-Reply-To: <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Fri, Apr 12, 2013 at 02:35:48PM +0200, Daniel Lezcano wrote:
> Commit 688036b538974de32ce55be8b0e013b003992abc removed the function
> 'shmobile_enter_wfi' but we forgot to remove the definition in the header file.
> 
> Note this function is just an alias to 'cpu_do_idle()' wrapped into a cpuidle
> function callback prototype which already exists with the default WFI state
> and the arm_simple_enter function.
> 
> Remove the function prototype.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/include/mach/common.h |    3 ---
>  1 file changed, 3 deletions(-)
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
> -- 
> 1.7.9.5
> 
