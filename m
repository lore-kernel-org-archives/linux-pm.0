From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH] Revert "cpufreq: pcc-cpufreq: update default value of
 cpuinfo_transition_latency"
Date: Fri, 22 Jul 2016 17:16:33 -0400
Message-ID: <57928D31.5050602@hpe.com>
References: <20160722151411.GB11711@suselix.suse.de> <20160722153656.GR3122@ubuntu> <ead100e9-e2a0-3733-9537-ec47dc38e75c@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ead100e9-e2a0-3733-9537-ec47dc38e75c@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andreas Herrmann <aherrmann@suse.com>
Cc: Jacob Tanenbaum <jtanenba@redhat.com>, stable@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/22/2016 03:25 PM, Linda Knippers wrote:
> 
> 
> On 7/22/2016 11:36 AM, Viresh Kumar wrote:
>> On 22-07-16, 17:14, Andreas Herrmann wrote:
>>> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
>>> index a7ecb9a..3f0ce2a 100644
>>> --- a/drivers/cpufreq/pcc-cpufreq.c
>>> +++ b/drivers/cpufreq/pcc-cpufreq.c
>>> @@ -555,8 +555,6 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>  	policy->min = policy->cpuinfo.min_freq =
>>>  		ioread32(&pcch_hdr->minimum_frequency) * 1000;
>>>  
>>> -	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
>>> -
>>>  	pr_debug("init: policy->max is %d, policy->min is %d\n",
>>>  		policy->max, policy->min);
>>>  out:
>>
>> Hi Rafael,
>>
>> I am very confused on this, can you help me understand ?
>>
>> - CPUFREQ_ETERNAL = -1
>> - unsigned int transition_latency = CPUFREQ_ETERNAL, will set it to UINT_MAX.
>> - Many drivers do it today
>>
>> cpufreq.c
>>
>> 	if (policy->governor->max_transition_latency &&
>> 	    policy->cpuinfo.transition_latency >
>> 	    policy->governor->max_transition_latency) {
>>
>> - And this check will always fail, unless max_transition_latency is zero.
>>
>> What am I missing ?
> 
> I don't know what's missing but I can reproduce the problem.

I added a debug message to show the transition latency values.

[   36.113829] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to
performance governor
[   36.164688] cpufreq: cpufreq_governor: max_transition_latency 0x10000000, transition_latency
0x4294967295

max_transition latency for ondemand seems to come from
#define TRANSITION_LATENCY_LIMIT                (10 * 1000 * 1000)

How does this work for any driver?

-- ljk
> 
> -- ljk
> 
