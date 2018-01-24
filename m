From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH v3 2/3] sched/fair: use util_est in LB and WU paths
Date: Wed, 24 Jan 2018 17:03:42 +0530
Message-ID: <20180124113342.GD30677@codeaurora.org>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180123180847.4477-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Tue, Jan 23, 2018 at 06:08:46PM +0000, Patrick Bellasi wrote:
>  static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
>  {
> -	unsigned long util, capacity;
> +	long util, util_est;
>  
>  	/* Task has no contribution or is new */
>  	if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
> -		return cpu_util(cpu);
> +		return cpu_util_est(cpu);
>  
> -	capacity = capacity_orig_of(cpu);
> -	util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
> +	/* Discount task's blocked util from CPU's util */
> +	util = cpu_util(cpu) - task_util(p);
> +	util = max(util, 0L);
>  
> -	return (util >= capacity) ? capacity : util;
> +	if (!sched_feat(UTIL_EST))
> +		return util;

At first, It is not clear to me why you are not clamping the capacity to
CPU original capacity. It looks like it is not needed any more with
commit f453ae2200b0 ("sched/fair: Consider RT/IRQ pressure in
capacity_spare_wake()") inclusion. May be a separate patch to remove
the clamping part?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
