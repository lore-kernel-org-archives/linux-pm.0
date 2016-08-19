From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Fri, 19 Aug 2016 16:00:57 +0100
Message-ID: <02391a39-b785-6056-49c4-c0ff34b3b780@arm.com>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36819 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754348AbcHSPBB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 11:01:01 -0400
In-Reply-To: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

Hi Steve,

On 19/08/16 02:55, Steve Muckle wrote:
> PELT scales its util_sum and util_avg values via
> arch_scale_cpu_capacity(). If that function is passed the CPU's sched
> domain then it will reduce the scaling capacity if SD_SHARE_CPUCAPACITY
> is set. PELT does not pass in the sd however. The other caller of
> arch_scale_cpu_capacity, update_cpu_capacity(), does. This means
> util_sum and util_avg scale beyond the CPU capacity on SMT.
> 
> On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> util_avg scales up to 1024.
> 
> Fix this by passing in the sd in __update_load_avg() as well.
> 
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 61d485421bed..95d34b337152 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2731,7 +2731,7 @@ __update_load_avg(u64 now, int cpu, struct sched_avg *sa,
>  	sa->last_update_time = now;
>  
>  	scale_freq = arch_scale_freq_capacity(NULL, cpu);
> -	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> +	scale_cpu = arch_scale_cpu_capacity(cpu_rq(cpu)->sd, cpu);

Wouldn't you have to subscribe to this rcu pointer rq->sd w/ something
like 'rcu_dereference(cpu_rq(cpu)->sd)'?

IMHO, __update_load_avg() is called outside existing RCU read-side
critical sections as well so there would be a pair of
rcu_read_lock()/rcu_read_unlock() required in this case.

>  
>  	/* delta_w is the amount already accumulated against our next period */
>  	delta_w = sa->period_contrib;
> 
