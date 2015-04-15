From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Wed, 15 Apr 2015 14:18:31 +0200
Message-ID: <20150415121831.GU5029@twins.programming.kicks-ass.net>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
 <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35024 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbbDOMSm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 08:18:42 -0400
Content-Disposition: inline
In-Reply-To: <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, Ingo Molnar <mingo@redhat.com>

On Wed, Apr 15, 2015 at 12:00:24PM +0200, Daniel Lezcano wrote:
> The find_idlest_cpu is assuming the rq->idle_stamp information reflects when
> the cpu entered the idle state. This is wrong as the cpu may exit and enter
> the idle state several times without the rq->idle_stamp being updated.

Sure, but you forgot to tell us why it matters.

> We have two informations here:
> 
>  * rq->idle_stamp gives when the idle task has been scheduled
>  * idle->idle_stamp gives when the cpu entered the idle state

I'm not a native speaker, but I'm pretty sure 'information' is a word
without a plural, a google search suggests it to be a non-countable
noun.

> The patch fixes that by using the latter information and fallbacks to
> the rq's timestamp when the idle state is not accessible
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 46855d0..b44f1ad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4704,21 +4704,35 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
>  		if (idle_cpu(i)) {
>  			struct rq *rq = cpu_rq(i);
>  			struct cpuidle_state *idle = idle_get_state(rq);
> +
> +			if (idle) {
> +				if (idle->exit_latency < min_exit_latency) {
> +					/*
> +					 * We give priority to a CPU
> +					 * whose idle state has the
> +					 * smallest exit latency
> +					 * irrespective of any idle
> +					 * timestamp.
> +					 */
> +					min_exit_latency = idle->exit_latency;
> +					latest_idle_timestamp = idle->idle_stamp;
> +					shallowest_idle_cpu = i;
> +				} else if (idle->exit_latency == min_exit_latency &&
> +					   idle->idle_stamp > latest_idle_timestamp) {
> +					/*
> +					 * If the CPU is in the same
> +					 * idle state, choose the more
> +					 * recent one as it might have
> +					 * a warmer cache
> +					 */
> +					latest_idle_timestamp = idle->idle_stamp;
> +					shallowest_idle_cpu = i;
> +				}
> +			} else if (rq->idle_stamp > latest_idle_timestamp) {
>  				/*
> +				 * If no active idle state, then the
> +				 * most recent idled CPU might have a
> +				 * warmer cache
>  				 */
>  				latest_idle_timestamp = rq->idle_stamp;
>  				shallowest_idle_cpu = i;

Urgh, you made horrid code more horrible.

And all without reason.
