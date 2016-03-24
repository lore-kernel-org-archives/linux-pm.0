From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [PATCH 2/2] sched/fair: do not call cpufreq hook unless util
 changed
Date: Thu, 24 Mar 2016 16:47:21 -0700
Message-ID: <56F47C89.9070201@nvidia.com>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org> <1458606068-7476-2-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2777 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCXXsL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 19:48:11 -0400
In-Reply-To: <1458606068-7476-2-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, pboonstoppel@nvidia.com

Hi Steve,

On 03/21/2016 05:21 PM, Steve Muckle wrote:
> There's no reason to call the cpufreq hook if the root cfs_rq
> utilization has not been modified.
> 
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/fair.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d418deb04049..af58e826cffe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2826,20 +2826,21 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
>  	struct sched_avg *sa = &cfs_rq->avg;
>  	struct rq *rq = rq_of(cfs_rq);
> -	int decayed, removed = 0;
> +	int decayed, removed_load = 0, removed_util = 0;
>  	int cpu = cpu_of(rq);
>  
>  	if (atomic_long_read(&cfs_rq->removed_load_avg)) {
>  		s64 r = atomic_long_xchg(&cfs_rq->removed_load_avg, 0);
>  		sa->load_avg = max_t(long, sa->load_avg - r, 0);
>  		sa->load_sum = max_t(s64, sa->load_sum - r * LOAD_AVG_MAX, 0);
> -		removed = 1;
> +		removed_load = 1;
>  	}
>  
>  	if (atomic_long_read(&cfs_rq->removed_util_avg)) {
>  		long r = atomic_long_xchg(&cfs_rq->removed_util_avg, 0);
>  		sa->util_avg = max_t(long, sa->util_avg - r, 0);
>  		sa->util_sum = max_t(s32, sa->util_sum - r * LOAD_AVG_MAX, 0);
> +		removed_util = 1;
>  	}
>  
>  	decayed = __update_load_avg(now, cpu, sa,
> @@ -2850,7 +2851,8 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>  
> -	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
> +	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq &&
> +	    (decayed || removed_util)) {
>  		unsigned long max = rq->cpu_capacity_orig;

Should this filtering instead happen on the governor side?

Even if the CFS load itself didn't change, we could have switched from an
RT/DL thread to a CFS thread so util would have to be updated from ULONG_MAX
to whatever CFS needs right?

Also now that CFS enqueue calls cpufreq_update_util, RT/DL requests could
potentially get overridden.

-Sai
