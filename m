From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Wed, 27 May 2015 17:01:21 +0530
Message-ID: <5565AB09.8090802@linux.vnet.ibm.com>
References: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:33879 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbE0Lbb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 07:31:31 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Wed, 27 May 2015 05:31:31 -0600
In-Reply-To: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>

On 05/27/2015 07:06 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The CPUIDLE_DRIVER_STATE_START symbol is defined as 1 only if
> CONFIG_ARCH_HAS_CPU_RELAX is set, otherwise it is defined as 0.
> However, if CONFIG_ARCH_HAS_CPU_RELAX is set, the first (index 0)
> entry in the cpuidle driver's table of states is overwritten with
> the default "poll" entry by the core.  The "state" defined by the
> "poll" entry doesn't provide ->enter_dead and ->enter_freeze
> callbacks and its exit_latency is 0.
> 
> For this reason, it is not necessary to use CPUIDLE_DRIVER_STATE_START
> in cpuidle_play_dead() (->enter_dead is NULL, so the "poll state"
> will be skipped by the loop) and in find_deepest_state() (since
> exit_latency is 0, the "poll state" will become the default if the
> "s->exit_latency <= latency_req" check is replaced with
> "s->exit_latency < latency_req" which may only matter for drivers
> providing different states with the same exit_latency).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
<snip>

> 
> @@ -79,13 +79,13 @@ static int find_deepest_state(struct cpu
>  			      bool freeze)
>  {
>  	unsigned int latency_req = 0;
> -	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
> +	int i, ret = -ENXIO;
> 
> -	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> +	for (i = 0; i < drv->state_count; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
> 
> -		if (s->disabled || su->disable || s->exit_latency <= latency_req
> +		if (s->disabled || su->disable || s->exit_latency < latency_req

Prior to this patch,

For drivers on which CPUIDLE_DRIVER_STATE_START takes a value 0 and
whose first idle state has an exit_latency of 0, find_deepest_state()
would return -1 if it failed to find a deeper idle state.

But as an effect of this patch, find_deepest_state() returns 0 in the
above circumstance.

My concern is if these drivers do not intend to enter a polling state
during suspend, this will cause an issue, won't it? This also gets me
wondering if polling state is an acceptable idle state during suspend,
given that the drivers with ARCH_HAS_CPU_RELAX permit entry into it
during suspend today. I would expect the cpus to be in a hardware
defined idle state.

Regards
Preeti U Murthy

