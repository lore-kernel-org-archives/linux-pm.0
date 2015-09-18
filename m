From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv5 PATCH 32/46] sched: Energy-aware wake-up task placement
Date: Fri, 18 Sep 2015 11:34:23 +0100
Message-ID: <55FBE8AF.3050200@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
 <20150902171131.GA12510@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902171131.GA12510@leoy-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/09/15 18:11, Leo Yan wrote:
> On Tue, Jul 07, 2015 at 07:24:15PM +0100, Morten Rasmussen wrote:
>> Let available compute capacity and estimated energy impact select
>> wake-up target cpu when energy-aware scheduling is enabled and the
>> system in not over-utilized (above the tipping point).
>>
>> energy_aware_wake_cpu() attempts to find group of cpus with sufficient
>> compute capacity to accommodate the task and find a cpu with enough spare
>> capacity to handle the task within that group. Preference is given to
>> cpus with enough spare capacity at the current OPP. Finally, the energy
>> impact of the new target and the previous task cpu is compared to select
>> the wake-up target cpu.
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
>> ---
>>  kernel/sched/fair.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0f7dbda4..01f7337 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5427,6 +5427,86 @@ static int select_idle_sibling(struct task_struct *p, int target)
>>  	return target;
>>  }
>>  
>> +static int energy_aware_wake_cpu(struct task_struct *p, int target)
>> +{
>> +	struct sched_domain *sd;
>> +	struct sched_group *sg, *sg_target;
>> +	int target_max_cap = INT_MAX;
>> +	int target_cpu = task_cpu(p);
>> +	int i;
>> +
>> +	sd = rcu_dereference(per_cpu(sd_ea, task_cpu(p)));
>> +
>> +	if (!sd)
>> +		return target;
>> +
>> +	sg = sd->groups;
>> +	sg_target = sg;
>> +
>> +	/*
>> +	 * Find group with sufficient capacity. We only get here if no cpu is
>> +	 * overutilized. We may end up overutilizing a cpu by adding the task,
>> +	 * but that should not be any worse than select_idle_sibling().
>> +	 * load_balance() should sort it out later as we get above the tipping
>> +	 * point.
>> +	 */
>> +	do {
>> +		/* Assuming all cpus are the same in group */
>> +		int max_cap_cpu = group_first_cpu(sg);
>> +
>> +		/*
>> +		 * Assume smaller max capacity means more energy-efficient.
>> +		 * Ideally we should query the energy model for the right
>> +		 * answer but it easily ends up in an exhaustive search.
>> +		 */
>> +		if (capacity_of(max_cap_cpu) < target_max_cap &&
>> +		    task_fits_capacity(p, max_cap_cpu)) {
>> +			sg_target = sg;
>> +			target_max_cap = capacity_of(max_cap_cpu);
>> +		}
> 
> Here should consider scenario for two groups have same capacity?
> This will benefit for the case LITTLE.LITTLE. So the code will be
> looks like below:
> 
> 	int target_sg_cpu = INT_MAX;
> 
> 	if (capacity_of(max_cap_cpu) <= target_max_cap &&
>             task_fits_capacity(p, max_cap_cpu)) {
> 
>                 if ((capacity_of(max_cap_cpu) == target_max_cap) &&
> 		    (target_sg_cpu < max_cap_cpu))
> 		        continue;
> 
> 		target_sg_cpu = max_cap_cpu;
> 		sg_target = sg;
> 		target_max_cap = capacity_of(max_cap_cpu);
> 	}
> 

It's true that on your SMP system the target sched_group 'sg_target'
depends only on 'task_cpu(p)' because this determines sched_domain 'sd'
(and so the order of sched_groups for the iteration).

So the current do-while loop to select 'sg_target' for an SMP system
makes little sense.

But why should we favour the first sched_group (cluster) (the one w/ the
lower max_cap_cpu number) in this situation?

[...]
