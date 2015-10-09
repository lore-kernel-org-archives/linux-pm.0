From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 43/46] sched/{fair,cpufreq_sched}: add
 reset_capacity interface
Date: Fri, 9 Oct 2015 10:14:08 +0100
Message-ID: <56178560.8060502@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-44-git-send-email-morten.rasmussen@arm.com>
 <5616D4D9.6060609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:28705 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772AbbJIJON convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 9 Oct 2015 05:14:13 -0400
In-Reply-To: <5616D4D9.6060609@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Steve,

On 08/10/15 21:40, Steve Muckle wrote:
> Hi Juri,
> 
> On 07/07/2015 11:24 AM, Morten Rasmussen wrote:
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> When a CPU is going idle it is pointless to ask for an OPP update as we
>> would wake up another task only to ask for the same capacity we are already
>> running at (utilization gets moved to blocked_utilization).  We thus add
>> cpufreq_sched_reset_capacity() interface to just reset our current capacity
>> request without triggering any real update.  At wakeup we will use the
>> decayed utilization to select an appropriate OPP.
> ...
>> +void cpufreq_sched_reset_cap(int cpu)
>> +{
>> +	per_cpu(pcpu_capacity, cpu) = 0;
>> +}
>> +
> ...
>> @@ -4427,9 +4427,13 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>  		if (sched_energy_freq() && task_sleep) {
>>  			unsigned long req_cap = get_cpu_usage(cpu_of(rq));
>>  
>> -			req_cap = req_cap * capacity_margin
>> -					>> SCHED_CAPACITY_SHIFT;
>> -			cpufreq_sched_set_cap(cpu_of(rq), req_cap);
>> +			if (rq->cfs.nr_running) {
>> +				req_cap = req_cap * capacity_margin
>> +						>> SCHED_CAPACITY_SHIFT;
>> +				cpufreq_sched_set_cap(cpu_of(rq), req_cap);
>> +			} else {
>> +				cpufreq_sched_reset_cap(cpu_of(rq));
>> +			}
>>  		}
> 
> Though I understand the initial stated motivation here (avoiding a
> redundant capacity request upon idle entry), releasing the CPU's
> capacity request altogether on idle seems like it could be a contentious
> policy decision.
> 
> An example to illustrate my concern:
> - 2 CPU single frequency domain topology
> - task A is a small frequently-running task on CPU0
> - task B is a heavier intermittent task running on CPU1
> 
> Task B is driving the frequency of the cluster high, but whenever it
> sleeps CPU1 becomes idle and the capacity request is dropped. If there's
> any activity on CPU0 that causes cpufreq_sched_set_cap() to be called
> (which is likely, given task A runs often) the cluster frequency will be
> lowered. Task B's performance will be impacted when it wakes up because
> initially the OPP will be insufficient. Power may or may not be

With the current implementation you are right: B's util will be decayed
and it will have to build it up again, loosing in performance. What
about we try to change this as discussed at Connect? At enqueue time we
use pre-decayed B's util, so that it will generate an OPP transition
at the required capacity on wakeup.

> impacted, depending on the characteristics of the workload and system,
> and whether energy is saved with the additional frequency scaling.
> 
> The decision of when a CPU's vote should be decayed or removed is more
> policy where I believe there's no single right answer and in the past,
> has been solved with tunables. The interactive governor's slack timer
> controls how long it will allow an idle CPU to request a frequency > fmin.
> 

Mmm, IMHO there is still a bit of space for trying to make the current
implementation better, before we give up and go to add a tunable :-).

> If the utilization of a long-idle CPU could be decayed by a different
> CPU in the system, perhaps it could take care of updating that CPU's vote?
> 

Yeah, that's exactly what we thought of as well. Actually we also tried
to do some sort of "fake" pre-decaying based on information coming from
set timers, but it didn't quite fix the issue. Decaying someone else's
stuff implies taking locks, I fear, and that is not good. However, I
agree that finding a clean way of properly update util of idle cpus
would be a better solution.

Thanks,

- Juri

