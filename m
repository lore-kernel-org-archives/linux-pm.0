From: Parth Shah <parth@linux.ibm.com>
Subject: Re: [RFCv2 1/6] sched/core: Add manual jitter classification from
 cgroup interface
Date: Thu, 16 May 2019 21:42:35 +0530
Message-ID: <00950713-f386-a91e-d1e2-17db26e8e487@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-2-parth@linux.ibm.com>
 <20190515162924.GT2589@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515162924.GT2589@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org



On 5/15/19 9:59 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:17PM +0530, Parth Shah wrote:
> 
>> Subject: [RFCv2 1/6] sched/core: Add manual jitter classification from cgroup interface
> 
> How can this be v2 ?! I've never seen v1.
> 

Actually, I sent out v1 on linux-pm@vger.kernel.org mailing list. This patch set
is then refined and re-organized to get better comments from larger audience.
You can find v1 at https://lwn.net/Articles/783959/

>> Jitter tasks are usually of less important in terms of performance
>> and are short/bursty in characteristics. TurboSched uses this jitter
>> classification to pack jitters into the already running busy cores to
>> keep the total idle core count high.
>>
>> The patch describes the use of UCLAMP mechanism to classify tasks. Patrick
>> Bellasi came up with a mechanism to classify tasks from the userspace
>> https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/
> 
> The canonical form is:
> 
> 	https://lkml.kernel.org/r/$MSGID
> 

Thanks for pointing out. I will use the above form from next time onwards

>> This UCLAMP mechanism can be useful in classifying tasks as jitter. Jitters
>> can be classified for the cgroup by keeping util.max of the tasks as the
>> least(=0). This also provides benefit of giving the least frequency to
>> those jitter tasks, which is useful if all jitters are packed onto a
>> separate core.
>>
>> Use Case with UCLAMP
>> ===================
>> To create a cgroup with all the tasks classified as jitters;
>>
>> ```
>> mkdir -p /sys/fs/cgroup/cpu/jitter
>> echo 0 > /proc/sys/kernel/sched_uclamp_util_min;
>> echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.min;
>> echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.max;
>> i=8;
>> ./turbo_bench -t 30 -h $i -n $i &
>> ./turbo_bench -t 30 -h 0 -n $i &
>> echo $! > /sys/fs/cgroup/cpu/jitter/cgroup.procs;
>> ```
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  kernel/sched/core.c  | 9 +++++++++
>>  kernel/sched/sched.h | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index d42c0f5eefa9..77aa4aee4478 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7192,6 +7192,15 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>>  	tg->uclamp_req[UCLAMP_MAX].value = max_value;
>>  	tg->uclamp_req[UCLAMP_MAX].bucket_id = uclamp_bucket_id(max_value);
>>  
>> +	/*
>> +	 * Classify the tasks belonging to the last bucket of MAX UCLAMP as
>> +	 * jitters
>> +	 */
>> +	if (uclamp_bucket_id(max_value) == 0)
>> +		tg->turbo_sched_enabled = 1;
>> +	else if (tg->turbo_sched_enabled)
>> +		tg->turbo_sched_enabled = 0;
>> +
>>  	/* Update effective clamps to track the most restrictive value */
>>  	cpu_util_update_eff(css, UCLAMP_MAX);
>>  
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index b4019012d84b..e75ffaf3ff34 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -407,6 +407,7 @@ struct task_group {
>>  	struct uclamp_se	uclamp[UCLAMP_CNT];
>>  #endif
>>  
>> +	bool			turbo_sched_enabled;
>>  };
> 
> Your simple patch has 3 problems:
> 
>  - it limits itself; for no apparent reason; to the cgroup interface.

Maybe I can add other interfaces like syscall to allow per-entity classification.

> 
>  - it is inconsistent in the terminology; pick either jitter or
>    turbo-sched, and I think the latter is a horrid name, it wants to be
>    'pack' or something similar. Also, jitter really doesn't make sense
>    given the classification.
> 

Yes, I will be happy to re-name any variables/function to enhance readability.

>  - you use '_Bool' in a composite type.
> 

Maybe I can switch to int.


Thanks,
Parth
