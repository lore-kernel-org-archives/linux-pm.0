From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 6/8] cpuidle: make fast idle threshold tunable
Date: Mon, 16 Oct 2017 14:00:45 +0800
Message-ID: <d039059f-5ff4-780e-5865-8361315896c5@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-7-git-send-email-aubrey.li@intel.com>
 <2242303.t20yq9Lc6j@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2242303.t20yq9Lc6j@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017/10/14 8:59, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:32 AM CEST Aubrey Li wrote:
>> Add a knob to make fast idle threshold tunable
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> 
> I first of all am not sure about the need to add a tunable for this at all
> in the first place.

Actually I think a fixed value(10) might be good enough but not quite sure
if there is a requirement to tune it for different scenario, for example even
if the predicted idle interval is 100x overhead, I still want a fast path for
a better benchmark score?

>> @@ -1229,6 +1230,17 @@ static struct ctl_table kern_table[] = {
>>  		.extra2		= &one,
>>  	},
>>  #endif
>> +#ifdef CONFIG_CPU_IDLE
>> +	{
>> +		.procname       = "fast_idle_ratio",
>> +		.data           = &sysctl_fast_idle_ratio,
>> +		.maxlen         = sizeof(int),
>> +		.mode           = 0644,
>> +		.proc_handler   = proc_dointvec_minmax,
>> +		.extra1         = &one,
>> +		.extra2         = &one_hundred,
>> +	},
>> +#endif
>>  	{ }
>>  };
>>  
> 
> And if there is a good enough reason to add it, shouldn't the tunable be
> there in the cpuidle framework?
> 
sure, if it makes sense, I'll move it into cpuidle/sysfs.c

Thanks,
-Aubrey
