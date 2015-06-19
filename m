From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle: powernv/pseries: Auto-promotion of snooze
 to deeper idle state
Date: Fri, 19 Jun 2015 11:07:10 +0530
Message-ID: <5583AA86.9010203@linux.vnet.ibm.com>
References: <1434626591-14509-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:44185 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbFSFhS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 01:37:18 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 19 Jun 2015 01:37:17 -0400
In-Reply-To: <1434626591-14509-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 06/18/2015 04:53 PM, Shilpasri G Bhat wrote:
> The idle cpus which stay in snooze for a long period can degrade the
> perfomance of the sibling cpus. If the cpu stays in snooze for more
> than target residency of the next available idle state, then exit from
> snooze. This gives a chance to the cpuidle governor to re-evaluate the
> last idle state of the cpu to promote it to deeper idle states.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

> Changes from v1:
> -Modified commit message
> 
>  drivers/cpuidle/cpuidle-powernv.c | 12 ++++++++++++
>  drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 5937207..1e3ef5e 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -29,18 +29,25 @@ struct cpuidle_driver powernv_idle_driver = {
>  
>  static int max_idle_state;
>  static struct cpuidle_state *cpuidle_state_table;
> +static u64 snooze_timeout;
> +static bool snooze_timeout_en;
>  
>  static int snooze_loop(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			int index)
>  {
> +	u64 snooze_exit_time;
> +
>  	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
>  
> +	snooze_exit_time = get_tb() + snooze_timeout;
>  	ppc64_runlatch_off();
>  	while (!need_resched()) {
>  		HMT_low();
>  		HMT_very_low();
> +		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +			break;
>  	}
>  
>  	HMT_medium();
> @@ -252,6 +259,11 @@ static int powernv_idle_probe(void)
>  		cpuidle_state_table = powernv_states;
>  		/* Device tree can indicate more idle states */
>  		max_idle_state = powernv_add_idle_states();
> +		if (max_idle_state > 1) {
> +			snooze_timeout_en = true;
> +			snooze_timeout = powernv_states[1].target_residency *
> +					 tb_ticks_per_usec;
> +		}
>   	} else
>   		return -ENODEV;
>  
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index bb9e2b6..07135e0 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -27,6 +27,8 @@ struct cpuidle_driver pseries_idle_driver = {
>  
>  static int max_idle_state;
>  static struct cpuidle_state *cpuidle_state_table;
> +static u64 snooze_timeout;
> +static bool snooze_timeout_en;
>  
>  static inline void idle_loop_prolog(unsigned long *in_purr)
>  {
> @@ -58,14 +60,18 @@ static int snooze_loop(struct cpuidle_device *dev,
>  			int index)
>  {
>  	unsigned long in_purr;
> +	u64 snooze_exit_time;
>  
>  	idle_loop_prolog(&in_purr);
>  	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
> +	snooze_exit_time = get_tb() + snooze_timeout;
>  
>  	while (!need_resched()) {
>  		HMT_low();
>  		HMT_very_low();
> +		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +			break;
>  	}
>  
>  	HMT_medium();
> @@ -244,6 +250,11 @@ static int pseries_idle_probe(void)
>  	} else
>  		return -ENODEV;
>  
> +	if (max_idle_state > 1) {
> +		snooze_timeout_en = true;
> +		snooze_timeout = cpuidle_state_table[1].target_residency *
> +				 tb_ticks_per_usec;
> +	}
>  	return 0;
>  }
>  
> 

