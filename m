From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Date: Thu, 18 Apr 2013 10:18:16 +0900
Message-ID: <20130418011816.GD4511@verge.net.au>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33356 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934477Ab3DRBSV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 21:18:21 -0400
Content-Disposition: inline
In-Reply-To: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lethal@linux-sh.org, rjw@sisk.pl, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
> The driver is a global static variable automatically initialized to zero.
> 
> Removing the useless initialization in the init function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

All four patches in this series seem reasonable to me.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Please let me know if I should take them through my renesas tree.

> ---
>  arch/sh/kernel/cpu/shmobile/cpuidle.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> index 0986f21..5b44af9 100644
> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -64,12 +64,6 @@ void sh_mobile_setup_cpuidle(void)
>  	struct cpuidle_state *state;
>  	int i;
>  
> -
> -	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
> -		drv->states[i].name[0] = '\0';
> -		drv->states[i].desc[0] = '\0';
> -	}
> -
>  	i = CPUIDLE_DRIVER_STATE_START;
>  
>  	state = &drv->states[i++];
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
