From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 45/46] sched/cpufreq_sched: modify pcpu_capacity
 handling
Date: Sun, 16 Aug 2015 22:35:12 +0200
Message-ID: <20150816203512.GK10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-46-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55472 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbbHPWBq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Aug 2015 18:01:46 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-46-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:28PM +0100, Morten Rasmussen wrote:
> From: Juri Lelli <juri.lelli@arm.com>
> 
> Use the cpu argument of cpufreq_sched_set_cap() to handle per_cpu writes,
> as the thing can be called remotely (e.g., from load balacing code).
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  kernel/sched/cpufreq_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
> index 06ff183..b81ac779 100644
> --- a/kernel/sched/cpufreq_sched.c
> +++ b/kernel/sched/cpufreq_sched.c
> @@ -151,7 +151,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>  	unsigned long capacity_max = 0;
>  
>  	/* update per-cpu capacity request */
> -	__this_cpu_write(pcpu_capacity, capacity);
> +	per_cpu(pcpu_capacity, cpu) = capacity;
>  
>  	policy = cpufreq_cpu_get(cpu);
>  	if (IS_ERR_OR_NULL(policy)) {

Uhm,.. this function seems to hard assume its called for the local CPU.
It will only use the irq_queue_work_on() if the cpufreq thing requires
the thread, otherwise it will call the method directly on the calling
cpu.
