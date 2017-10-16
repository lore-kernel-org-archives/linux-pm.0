From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/8] cpuidle: add a new predict interface
Date: Mon, 16 Oct 2017 16:04:15 +0800
Message-ID: <70eb3c82-a486-e1dd-05ce-d968b857e86b@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-4-git-send-email-aubrey.li@intel.com>
 <2353480.vFnqZDvmsB@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56079 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdJPIER (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Oct 2017 04:04:17 -0400
In-Reply-To: <2353480.vFnqZDvmsB@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/14 8:45, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:29 AM CEST Aubrey Li wrote:
>> For the governor has predict functionality, add a new predict
>> interface in cpuidle framework to call and use it.
> 
> Care to describe how it is intended to work?
> 
> Also this patch uses data structures introduced in the previous one
> (and the previous one didn't use them), so maybe merge the two?

okay, will refine in the next version.

> 
>> ---
>>  drivers/cpuidle/cpuidle.c        | 34 ++++++++++++++++++++++++++++++++++
>>  drivers/cpuidle/governors/menu.c |  7 +++++++
>>  include/linux/cpuidle.h          |  3 +++
>>  kernel/sched/idle.c              |  1 +
>>  4 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 4066308..ef6f7dd 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -336,6 +336,40 @@ void cpuidle_entry_end(void)
>>  }
>>  
>>  /**
>> + * cpuidle_predict - predict whether the coming idle is a fast idle or not
>> + */
>> +void cpuidle_predict(void)
>> +{
>> +	struct cpuidle_device *dev = cpuidle_get_device();
>> +	unsigned int overhead_threshold;
>> +
>> +	if (!dev)
>> +		return;
>> +
>> +	overhead_threshold = dev->idle_stat.overhead;
>> +
>> +	if (cpuidle_curr_governor->predict) {
>> +		dev->idle_stat.predicted_us = cpuidle_curr_governor->predict();
>> +		/*
>> +		 * notify idle governor to avoid reduplicative
>> +		 * prediction computation
>> +		 */
> 
> This comment is hard to understand.
> 
> What does it mean, really?
> 

predict() does a lot of computation. If it's called in cpuidle_predict(),
we don't want it to be called in menu governor again. So here I use a flag to
tell menu governor if predict computation is already done for the coming idle
this time.

>> +		dev->idle_stat.predicted = true;
>> +		if (dev->idle_stat.predicted_us < overhead_threshold) {
>> +			/*
>> +			 * notify tick subsystem to keep ticking
>> +			 * for the coming idle
>> +			 */
>> +			dev->idle_stat.fast_idle = true;
>> +		} else
>> +			dev->idle_stat.fast_idle = false;
> 
> What about
> 
> 		dev->idle_stat.fast_idle = dev->idle_stat.predicted_us < overhead_threshold;

Ack

> 
> Also why don't you use dev->idle_stat.overhead directly here?

Yeah, I should merge a few patches, because dev->idle_stat.overhead is referenced many times,
for irq timings, for scheduler idle statistics and for idle governor.

> 
> And what is the basic idea here?  Why do we compare the predicted
> idle duration with the entry/exit overhead from the previous cycle
> (if I understood this correctly, that is)?

entry/exit overhead is an average here, and the variance should not be big.

> 
>> +	} else {
>> +		dev->idle_stat.predicted = false;
>> +		dev->idle_stat.fast_idle = false;
>> +	}
>> +}
>> +
>> +/**
>>   * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
>>   */
>>  void cpuidle_install_idle_handler(void)
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index 6bed197..90b2a10 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -344,6 +344,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>  	if (unlikely(latency_req == 0))
>>  		return 0;
>>  
>> +	/*don't predict again if idle framework already did it */
>> +	if (!dev->idle_stat.predicted)
>> +		menu_predict();
>> +	else
>> +		dev->idle_stat.predicted = false;
> 
> We provide the callback which is going to be used by the core if present,
> so why would the core not use it after all?

There is a case that in the loop

while (!need_resched()) {
	cpuidle_idle_call()
}

The CPU receives a timer interrupt and wake up and find nothing to be scheduled
and back to call menu then mwait to sleep again.

Under this case, cpuidle_predict() is not reached but the idle data for the 
prediction needs to be updated.

Thanks,
-Aubrey
