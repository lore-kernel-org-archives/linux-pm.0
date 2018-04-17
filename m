From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
Date: Tue, 17 Apr 2018 19:39:21 +0200
Message-ID: <03a64b8b-9d13-5480-8882-75ecac3d6042@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <20180417142440.GB18509@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417142440.GB18509@leoy-ThinkPad-X240s>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 04/17/2018 04:25 PM, Leo Yan wrote:

>> @@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   		update_cfs_group(se);
>>   	}
>>   
>> -	if (!se)
>> +	if (!se) {
>>   		add_nr_running(rq, 1);
>> +		update_overutilized_status(rq);
>> +	}
> 
> Maybe this isn't a good question, why only update overutilized flag
> for enqueue flow but not for dequeue flow?

[...]

>> @@ -9955,6 +10009,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>   
>>   	if (static_branch_unlikely(&sched_numa_balancing))
>>   		task_tick_numa(rq, curr);
>> +
>> +	update_overutilized_status(rq);
> 
> Can sched tick clear overutilized flag if under tipping point?

No, only the load balancer for this particular sched domain level is 
able to clear the flag. We want to use the existing iteration over all 
cpus of the sched domain span to reset the flag.
