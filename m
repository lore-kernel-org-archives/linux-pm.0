From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 4/8] tick/nohz: keep tick on for a fast idle
Date: Mon, 16 Oct 2017 11:26:11 +0800
Message-ID: <5beefd1a-2792-c371-3bb8-8ee2a6574020@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-5-git-send-email-aubrey.li@intel.com>
 <4523111.uMcC96MW3N@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38445 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdJPD0O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Oct 2017 23:26:14 -0400
In-Reply-To: <4523111.uMcC96MW3N@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/14 8:51, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:30 AM CEST Aubrey Li wrote:
>> If the next idle is expected to be a fast idle, we should keep tick
>> on before going into idle
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> 
> This also can be merged with the previous patch (and the [2/8]) IMO.
> 

okay, will merge in the next version.

>> ---
>>  drivers/cpuidle/cpuidle.c | 14 ++++++++++++++
>>  include/linux/cpuidle.h   |  2 ++
>>  kernel/time/tick-sched.c  |  4 ++++
>>  3 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index ef6f7dd..6cb7e17 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -370,6 +370,20 @@ void cpuidle_predict(void)
>>  }
>>  
>>  /**
>> + * cpuidle_fast_idle - predict whether or not the coming idle is a fast idle
>> + * This function can be called in irq exit path, make it as soon as possible
>> + */
>> +bool cpuidle_fast_idle(void)
>> +{
>> +	struct cpuidle_device *dev = cpuidle_get_device();
>> +
>> +	if (!dev)
>> +		return false;
>> +
>> +	return dev->idle_stat.fast_idle;
> 
> return dev && dev->idle_stat.fast_idle;

Thanks!

>>  
>> @@ -916,6 +917,9 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>>  			return false;
>>  	}
>>  
>> +	if (cpuidle_fast_idle())
>> +		return false;
>> +
>>  	return true;
> 
> return !cpuidle_fast_idle();

And thanks!
> 
>>  }
>>  
>>
> 
> And IMO there is quite a bit too much marketing in the "fast_idle" name,
> as it seems all about avoiding to stop the tick if the predicted idle
> duration is short enough.
> 

okay, and what's your suggestion? :)
I'll try to move quiet_vmstat() into the normal idle branch if this patch series
are reasonable. Is fast_idle a good indication for it?

Thanks,
-Aubrey
