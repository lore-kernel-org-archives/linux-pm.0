From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] cpuidle: reduce unnecessary loop in c-state selection
Date: Thu, 16 Jan 2014 16:53:17 +0100
Message-ID: <13647359.XRIaiKjIK6@vostro.rjw.lan>
References: <1389876316-27161-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54047 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751991AbaAPPjR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2014 10:39:17 -0500
In-Reply-To: <1389876316-27161-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Alex Shi <alex.shi@linaro.org>, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org

Hi Len, what do you think?

On Thursday, January 16, 2014 08:45:16 PM Alex Shi wrote:
> All deeper c-state have the longer target_residency and exit_latency
> So, if the one can not meet our prediction, neither any later.
> So, just break out the for loop to save few checking instructions.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index cf7f2f0..48ed3fb 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -352,11 +352,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  		if (s->disabled || su->disable)
>  			continue;
>  		if (s->target_residency > data->predicted_us)
> -			continue;
> +			break;
>  		if (s->exit_latency > latency_req)
> -			continue;
> +			break;
>  		if (s->exit_latency * multiplier > data->predicted_us)
> -			continue;
> +			break;
>  
>  		data->last_state_idx = i;
>  		data->exit_us = s->exit_latency;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
