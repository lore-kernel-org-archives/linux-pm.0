From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v3 06/10] sched: Add over-utilization/tipping point
 indicator
Date: Tue, 19 Jun 2018 12:26:35 +0200
Message-ID: <bdfd313d-1b31-0672-0a23-285087206b06@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-7-quentin.perret@arm.com>
 <20180619070103.GB9208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619070103.GB9208@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>, Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/19/2018 09:01 AM, Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:01PM +0100, Quentin Perret wrote:

[...]

>> @@ -8152,6 +8176,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		if (nr_running > 1)
>>   			*overload = true;
>>   
>> +		if (cpu_overutilized(i))
>> +			*overutilized = 1;
>> +
> 
> There is no need to check if every CPU is overutilized or not once
> *overutilized is marked as true, right?

True, so you want to check *overutilized before calling 
cpu_overutilized() to save a little bit on compute?

[...]

>> @@ -8586,6 +8621,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>   	 * this level.
>>   	 */
>>   	update_sd_lb_stats(env, &sds);
>> +
>> +	if (sched_energy_enabled() && !READ_ONCE(env->dst_rq->rd->overutilized))
>> +		goto out_balanced;
>> +
> 
> Is there any reason for sending no-hz idle kicks but bailing out here when
> system is not overutilized?

Even if a system is not-overutilized, we want to update stale cpu 
blocked load and utilization so NOHZ_STATS_KICK have to get through.

So calling find_busiest_group() -> update_sd_lb_stats() -> 
update_sg_lb_stats() to possibly execute update_nohz_stats() is IMHO the 
right thing to do.
