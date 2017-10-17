From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/8] cpuidle: record the overhead of idle entry
Date: Tue, 17 Oct 2017 15:04:11 +0800
Message-ID: <fd85c52f-98f2-e847-b534-30f7907ecf11@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <2672521.fEEa1b19Vu@aspire.rjw.lan>
 <6f17f378-defc-c668-de00-250da5c41b87@linux.intel.com>
 <10643458.iWc7GTROAz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34371 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932699AbdJQHEQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Oct 2017 03:04:16 -0400
In-Reply-To: <10643458.iWc7GTROAz@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Galbraith <efault@gmx.de>
Cc: Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/17 8:05, Rafael J. Wysocki wrote:
> On Monday, October 16, 2017 5:11:57 AM CEST Li, Aubrey wrote:
>> On 2017/10/14 8:35, Rafael J. Wysocki wrote:
>>> On Saturday, September 30, 2017 9:20:28 AM CEST Aubrey Li wrote:
>>>> Record the overhead of idle entry in micro-second
>>>>
>>>
>>> What is this needed for?
>>
>> We need to figure out how long of a idle is a short idle and recording
>> the overhead is for this purpose. The short idle threshold is based
>> on this overhead.
> 
> I don't really understand this statement.
> 
> Pretent I'm not familiar with this stuff and try to explain it to me. :-)
> 

Okay, let me try, :-)

Today what we did in idle loop as follows:

do_idle {
	idle_entry {
	- deferrable stuff like quiet_vmstat
	- turn off tick(without looking at historical/predicted idle interval)
	- rcu idle enter, c-state selection, etc
	}

	idle_call {
	- poll or halt or mwait
	}

	idle_exit {
	- rcu idle exit
	- restore the tick if tick is stopped before enter idle
	}
}

And we already measured idle_entry and idle_exit costs several micro-seconds,
say 10us.

Now if idle_call is 1000us, much larger than idle_entry and idle_exit, we can
ignore the time cost in idle_entry and idle_exit.

But for some workloads with short idle pattern, like netperf, the idle_call
is 2us, then idle_entry and idle_exit start to dominate. If we can reduce the
time in idle_entry and idle_exit, we then get better workload performance
significantly.

Modem high-speed network and low-latency I/O like Nvme disk has this requirement.
Mike's patch was made several years ago though I don't know the details. Here is
an article related to this.
https://cacm.acm.org/magazines/2017/4/215032-attack-of-the-killer-microseconds/fulltext

>>>
>>>> +void cpuidle_entry_end(void)
>>>> +{
>>>> +	struct cpuidle_device *dev = cpuidle_get_device();
>>>> +	u64 overhead;
>>>> +	s64 diff;
>>>> +
>>>> +	if (dev) {
>>>> +		dev->idle_stat.entry_end = local_clock();
>>>> +		overhead = div_u64(dev->idle_stat.entry_end -
>>>> +				dev->idle_stat.entry_start, NSEC_PER_USEC);
>>>
>>> Is the conversion really necessary?
>>>
>>> If so, then why?
>>
>> We can choose nano-second and micro-second. Given that workload results
>> in the short idle pattern, I think micro-second is good enough for the
>> real workload.
>>
>> Another reason is that prediction from idle governor is micro-second, so
>> I convert it for comparing purpose.
>>>
>>> And if there is a good reason, what about using right shift to do
>>> an approximate conversion to avoid the extra division here?
>>
>> Sure >> 10 works for me as I don't think here precision is a big deal.
>>
>>>
>>>> +		diff = overhead - dev->idle_stat.overhead;
>>>> +		dev->idle_stat.overhead += diff >> 3;
>>>
>>> Can you please explain what happens in the two lines above?
>>
>> Online average computing algorithm, stolen from update_avg() @ kernel/sched/core.c.
> 
> OK
> 
> Maybe care to add a comment to that effect?

Sure, I'll add in the next version.

Thanks,
-Aubrey
