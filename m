From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Mon, 28 Mar 2016 14:02:30 +0200
Message-ID: <56F91D56.4020007@arm.com>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-am1on0063.outbound.protection.outlook.com ([157.56.112.63]:41083
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751969AbcC1Ne4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Mar 2016 09:34:56 -0400
In-Reply-To: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Steve,

these patches fall into the bucket of 'optimization of updating the 
value only if the root cfs_rq util has changed' as discussed in '[PATCH 
5/8] sched/cpufreq: pass sched class into cpufreq_update_util' of Mike 
T's current series '[PATCH 0/8] schedutil enhancements', right?

I wonder if it makes sense to apply them before a proper 'capacity vote 
aggregation from CFS/RT/DL' has been agreed upon?

Otherwise I agree with the changes in your 3 patches (inc. "[RFC PATCH] 
sched/fair: call cpufreq hook in additional paths") to only invoke 
cpufreq_update_util() if &rq->cfs.avg.util_avg has really changed.


On 03/22/2016 01:21 AM, Steve Muckle wrote:
> The cpufreq hook should be called whenever the root cfs_rq
> utilization changes so update_cfs_rq_load_avg() is a better
> place for it. The current location is not invoked in the
> enqueue_entity() or update_blocked_averages() paths.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>   kernel/sched/fair.c | 50 ++++++++++++++++++++++++++------------------------
>   1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 46d64e4ccfde..d418deb04049 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2825,7 +2825,9 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
>   static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   {
>   	struct sched_avg *sa = &cfs_rq->avg;
> +	struct rq *rq = rq_of(cfs_rq);
>   	int decayed, removed = 0;
> +	int cpu = cpu_of(rq);
>
>   	if (atomic_long_read(&cfs_rq->removed_load_avg)) {
>   		s64 r = atomic_long_xchg(&cfs_rq->removed_load_avg, 0);
> @@ -2840,7 +2842,7 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   		sa->util_sum = max_t(s32, sa->util_sum - r * LOAD_AVG_MAX, 0);
>   	}
>
> -	decayed = __update_load_avg(now, cpu_of(rq_of(cfs_rq)), sa,
> +	decayed = __update_load_avg(now, cpu, sa,
>   		scale_load_down(cfs_rq->load.weight), cfs_rq->curr != NULL, cfs_rq);

Why did you change these 3 lines above? You reverted this back in "[RFC 
PATCH] sched/fair: call cpufreq hook in additional paths".

[...]
