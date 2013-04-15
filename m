From: Simon Horman <horms@verge.net.au>
Subject: Re: [V3 patch 01/19] ARM: shmobile: cpuidle: remove
 shmobile_enter_wfi function
Date: Mon, 15 Apr 2013 12:56:08 +0900
Message-ID: <20130415035608.GB3070@verge.net.au>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50028 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab3DOD4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2013 23:56:11 -0400
Content-Disposition: inline
In-Reply-To: <1365770165-27096-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Fri, Apr 12, 2013 at 02:35:47PM +0200, Daniel Lezcano wrote:
> Remove the shmobile_enter_wfi function which is the same as the
> common WFI enter function from the arm cpuidle driver defined
> with the ARM_CPUIDLE_WFI_STATE macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/pm-sh7372.c |    1 -
>  1 file changed, 1 deletion(-)
> 
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
