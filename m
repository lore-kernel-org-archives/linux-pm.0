From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency selection
Date: Tue, 25 Aug 2015 11:45:47 +0100
Message-ID: <55DC475B.2080502@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com> <20150815130545.GI10304@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:44573 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754122AbbHYKpB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 06:45:01 -0400
In-Reply-To: <20150815130545.GI10304@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Peter,

On 15/08/15 14:05, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:21PM +0100, Morten Rasmussen wrote:
>> +void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>> +{
>> +	unsigned int freq_new, cpu_tmp;
>> +	struct cpufreq_policy *policy;
>> +	struct gov_data *gd;
>> +	unsigned long capacity_max = 0;
>> +
>> +	/* update per-cpu capacity request */
>> +	__this_cpu_write(pcpu_capacity, capacity);
>> +
>> +	policy = cpufreq_cpu_get(cpu);
>> +	if (IS_ERR_OR_NULL(policy)) {
>> +		return;
>> +	}
>> +
>> +	if (!policy->governor_data)
>> +		goto out;
>> +
>> +	gd = policy->governor_data;
>> +
>> +	/* bail early if we are throttled */
>> +	if (ktime_before(ktime_get(), gd->throttle))
>> +		goto out;
> 
> Isn't this the wrong place to throttle? Suppose you're getting multiple
> new tasks placed on this CPU, the first one would trigger this callback
> and start increasing freq..
> 
> While we're still changing freq. (and therefore throttled), another task
> comes in which would again raise the freq.
> 
> With this scheme you loose the latter freq. change and will not
> re-evaluate.
> 

The way the policy is implemented, you should not have this problem.
For new tasks you actually jump to max freq, as new tasks util gets
initialized to 1024. For load balancing migrations we wait until
all the tasks are migrated and then we trigger an update.

> Any scheme that limits the callbacks to the actual hardware will have to
> buffer requests and once the hardware returns (be it through an
> interrupt or timeout) issue the latest request.
>

But, it is true that if the above events happened the other way around
(we trigger an update after load balancing and a new task arrives), we
may miss the opportunity to jump to max with the new task. In my mind
this is probably not a big deal, as we'll have a tick pretty soon that
will fix things anyway (saving us some complexity in the backend).

What you think?

Thanks,

- Juri

