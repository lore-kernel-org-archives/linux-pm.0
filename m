From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched: cpufreq: ignore SMT when determining max cpu
 capacity
Date: Wed, 24 Aug 2016 09:31:39 +0100
Message-ID: <20160824083138.GA3315@e105550-lin.cambridge.arm.com>
References: <1471639427-16006-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45223 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbcHXImg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Aug 2016 04:42:36 -0400
Content-Disposition: inline
In-Reply-To: <1471639427-16006-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

On Fri, Aug 19, 2016 at 01:43:47PM -0700, Steve Muckle wrote:
> PELT does not consider SMT when scaling its utilization values via
> arch_scale_cpu_capacity(). The value in rq->cpu_capacity_orig does
> take SMT into consideration though and therefore may be smaller than
> the utilization reported by PELT.
> 
> On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> util_avg scales up to 1024. This means that a 50% utilized CPU will show
> up in schedutil as ~86% busy.
> 
> Fix this by using the same CPU scaling value in schedutil as that which
> is used by PELT.
> 
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 60d985f4dc47..cb8a77b1ef1b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -147,7 +147,9 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
>  static void sugov_get_util(unsigned long *util, unsigned long *max)
>  {
>  	struct rq *rq = this_rq();
> -	unsigned long cfs_max = rq->cpu_capacity_orig;
> +	unsigned long cfs_max;
> +
> +	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());

Until we have figured out how to define utilization (and capacity)
better for SMT I think this is a better solution.

Morten
