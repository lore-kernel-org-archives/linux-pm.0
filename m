From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 32/46] sched: Energy-aware wake-up task placement
Date: Sun, 20 Sep 2015 11:39:16 -0700
Message-ID: <55FEFD54.3010206@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
 <20150902171131.GA12510@leoy-linaro> <55FBE8AF.3050200@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55FBE8AF.3050200@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Leo Yan <leo.yan@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/18/2015 03:34 AM, Dietmar Eggemann wrote:
>> Here should consider scenario for two groups have same capacity?
>> This will benefit for the case LITTLE.LITTLE. So the code will be
>> looks like below:
>>
>> 	int target_sg_cpu = INT_MAX;
>>
>> 	if (capacity_of(max_cap_cpu) <= target_max_cap &&
>>             task_fits_capacity(p, max_cap_cpu)) {
>>
>>                 if ((capacity_of(max_cap_cpu) == target_max_cap) &&
>> 		    (target_sg_cpu < max_cap_cpu))
>> 		        continue;
>>
>> 		target_sg_cpu = max_cap_cpu;
>> 		sg_target = sg;
>> 		target_max_cap = capacity_of(max_cap_cpu);
>> 	}
>>
> 
> It's true that on your SMP system the target sched_group 'sg_target'
> depends only on 'task_cpu(p)' because this determines sched_domain 'sd'
> (and so the order of sched_groups for the iteration).
> 
> So the current do-while loop to select 'sg_target' for an SMP system
> makes little sense.
> 
> But why should we favour the first sched_group (cluster) (the one w/ the
> lower max_cap_cpu number) in this situation?

Running the originally proposed code on a system with two identical
clusters, it looks like we'll always end up doing an energy-aware search
in the task's prev_cpu cluster (sched_group). If you had small tasks
scattered across both clusters, energy_aware_wake_cpu() would not
consider condensing them on a single cluster. Leo was this the issue you
were seeing?

However I think there may be negative side effects with the proposed
policy above as well - won't this cause us to pack the first cluster
until it's 100% full (running at fmax) before using the second cluster?
That would also be bad for power.

thanks,
Steve
