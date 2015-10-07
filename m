From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct
 on governor switch
Date: Wed, 07 Oct 2015 08:18:08 -0400
Message-ID: <56150D80.8040609@redhat.com>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1594304.lVcRDcB3yL@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 10/06/2015 07:06 PM, Rafael J. Wysocki wrote:
> On Wednesday, October 07, 2015 12:43:55 AM Rafael J. Wysocki wrote:
>> On Tuesday, October 06, 2015 05:49:07 PM Prarit Bhargava wrote:

<snip>

>>>
>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>> index 3af9dd7..bb24458 100644
>>> --- a/drivers/cpufreq/intel_pstate.c
>>> +++ b/drivers/cpufreq/intel_pstate.c
>>> @@ -986,6 +986,9 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>>  	if (!policy->cpuinfo.max_freq)
>>>  		return -ENODEV;
>>>  
>>> +	limits.min_sysfs_pct = 0;
>>> +	limits.max_sysfs_pct = 100;
>>> +
>>>  	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
>>>  	    policy->max >= policy->cpuinfo.max_freq) {
>>>  		limits.min_policy_pct = 100;
>>> @@ -1004,9 +1007,9 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>>  	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
>>>  
>>>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>>> -	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
>>> +	limits.min_perf_pct = limits.min_policy_pct;
>>>  	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
>>> -	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
>>> +	limits.max_perf_pct = limits.max_sysfs_pct;
> 
> On a second thought, isn't that always 100?  If so, doesn't it basically discard
> limits.max_policy_pct?

Wow :)  I think you're right and that definitely was an unintended consequence
of this patch.  I also see that I can clean up the intel_pstate_set_policy()
code a bit more.  I'll submit a 2-part v2.

P.
