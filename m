From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [RFC] cpuidle: menu: nearby timer use lightest state; allow
 state 0 to be disabled
Date: Tue, 6 Jun 2017 15:34:23 +0530
Message-ID: <20170606100423.GA19040@in.ibm.com>
References: <20170530162631.9073-1-npiggin@gmail.com>
 <20170605151906.GA2929@in.ibm.com>
 <20170606111555.2881763e@roar.ozlabs.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49775 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751329AbdFFKEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2017 06:04:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v569ifMu017628
        for <linux-pm@vger.kernel.org>; Tue, 6 Jun 2017 06:04:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2awph92pn9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2017 06:04:31 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 6 Jun 2017 06:04:29 -0400
Content-Disposition: inline
In-Reply-To: <20170606111555.2881763e@roar.ozlabs.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

On Tue, Jun 06, 2017 at 11:15:55AM +1000, Nicholas Piggin wrote:
> > 
> > Are you able to observe any functional difference with this patch ?
> 
> Yes for some tests, but it did have a bug where state0 was still
> being used despite other states being available. This patch really
> disables state0 (unless all states are disabled, then it falls back
> to 0 again).

Nice. I agree with this approach. We need to document that if the
lower states are disabled, then the menu governor selection logic
would promote to a higher cpuidle state even when the predicted
residency is small. So,folks who are worried about latency shouldn't
be disabling the lower states in the first place.

Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> 
> ---
>  drivers/cpuidle/governors/menu.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index b2330fd69e34..61b64c2b2cb8 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -286,6 +286,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	struct device *device = get_cpu_device(dev->cpu);
>  	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>  	int i;
> +	int first_idx;
> +	int idx;
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
>  	unsigned long nr_iowaiters, cpu_load;
> @@ -335,11 +337,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  		if (data->next_timer_us > polling_threshold &&
>  		    latency_req > s->exit_latency && !s->disabled &&
>  		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
> -			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> +			first_idx = CPUIDLE_DRIVER_STATE_START;
>  		else
> -			data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
> +			first_idx = CPUIDLE_DRIVER_STATE_START - 1;
>  	} else {
> -		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> +		first_idx = 0;
>  	}
> 
>  	/*
> @@ -359,20 +361,28 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
>  	 */
> -	for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
> +	idx = -1;
> +	for (i = first_idx; i < drv->state_count; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
> 
>  		if (s->disabled || su->disable)
>  			continue;
> +		if (idx == -1)
> +			idx = i; /* first enabled state */
>  		if (s->target_residency > data->predicted_us)
>  			break;
>  		if (s->exit_latency > latency_req)
>  			break;
> 
> -		data->last_state_idx = i;
> +		idx = i;
>  	}
> 
> +	if (idx == -1)
> +		idx = 0; /* No states enabled. Must use 0. */
> +
> +	data->last_state_idx = idx;
> +
>  	return data->last_state_idx;
>  }
> 
> -- 
> 
