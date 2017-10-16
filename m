From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/8] cpuidle: record the overhead of idle entry
Date: Mon, 16 Oct 2017 11:11:57 +0800
Message-ID: <6f17f378-defc-c668-de00-250da5c41b87@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-3-git-send-email-aubrey.li@intel.com>
 <2672521.fEEa1b19Vu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2672521.fEEa1b19Vu@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017/10/14 8:35, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:28 AM CEST Aubrey Li wrote:
>> Record the overhead of idle entry in micro-second
>>
> 
> What is this needed for?

We need to figure out how long of a idle is a short idle and recording
the overhead is for this purpose. The short idle threshold is based
on this overhead.

> 
>> +void cpuidle_entry_end(void)
>> +{
>> +	struct cpuidle_device *dev = cpuidle_get_device();
>> +	u64 overhead;
>> +	s64 diff;
>> +
>> +	if (dev) {
>> +		dev->idle_stat.entry_end = local_clock();
>> +		overhead = div_u64(dev->idle_stat.entry_end -
>> +				dev->idle_stat.entry_start, NSEC_PER_USEC);
> 
> Is the conversion really necessary?
> 
> If so, then why?

We can choose nano-second and micro-second. Given that workload results
in the short idle pattern, I think micro-second is good enough for the
real workload.

Another reason is that prediction from idle governor is micro-second, so
I convert it for comparing purpose.
> 
> And if there is a good reason, what about using right shift to do
> an approximate conversion to avoid the extra division here?

Sure >> 10 works for me as I don't think here precision is a big deal.

> 
>> +		diff = overhead - dev->idle_stat.overhead;
>> +		dev->idle_stat.overhead += diff >> 3;
> 
> Can you please explain what happens in the two lines above?

Online average computing algorithm, stolen from update_avg() @ kernel/sched/core.c.
> 
>> +		/*
>> +		 * limit overhead to 1us
>> +		 */
>> +		if (dev->idle_stat.overhead == 0)
>> +			dev->idle_stat.overhead = 1;
>> +	}
>> +}
>> +
>>  /**
>>   * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
>>   */
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index fc1e5d7..cad9b71 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -72,6 +72,15 @@ struct cpuidle_device_kobj;
>>  struct cpuidle_state_kobj;
>>  struct cpuidle_driver_kobj;
>>  
>> +struct cpuidle_stat {
>> +	u64			entry_start;	/* nanosecond */
>> +	u64			entry_end;	/* nanosecond */
>> +	u64			overhead;	/* nanosecond */
>> +	unsigned int		predicted_us;	/* microsecond */
>> +	bool			predicted;	/* ever predicted? */
>> +	bool			fast_idle;	/* fast idle? */
> 
> Some of the fields here are never used in the code after this patch.
> 
> Also it would be good to add a comment describing the meaning of the
> fields.
> 
okay, will add in the next version.

Thanks,
-Aubrey
