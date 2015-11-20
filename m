From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq, intel_pstate, Fix limits->max_policy_pct
 rounding error
Date: Fri, 20 Nov 2015 18:47:29 -0500
Message-ID: <564FB111.5050403@redhat.com>
References: <1448022757-7856-1-git-send-email-prarit@redhat.com>	 <1448022757-7856-2-git-send-email-prarit@redhat.com>	 <20151120131833.GD3957@ubuntu> <564F37C8.60307@redhat.com>	 <20151120151944.GE3957@ubuntu> <564F3FBA.6030806@redhat.com> <1448049757.4914.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448049757.4914.3.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "kristen@linux.intel.com" <kristen@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Yates, Alexandra" <alexandra.yates@intel.com>
List-Id: linux-pm@vger.kernel.org



On 11/20/2015 03:02 PM, Pandruvada, Srinivas wrote:
> On Fri, 2015-11-20 at 10:43 -0500, Prarit Bhargava wrote:
>>
>> On 11/20/2015 10:19 AM, Viresh Kumar wrote:
>>> On 20-11-15, 10:10, Prarit Bhargava wrote:
>>>>>>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
>>>>>
>>>>> And put this after the later one ?
>>>>>
>>>>>> +	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
>>>>>> +					      policy->cpuinfo.max_freq);
>>>>>>  
>>>>>>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>>>>>>  	limits->min_perf_pct = max(limits->min_policy_pct,
>>>>>
>>>>> Sure you tested it  ? :)
>>>>
>>>> Oops -- and yeah, tested.  It works because I rewrite the value of
>>>> max_policy_pct :).  I'll repost shortly.
>>>
>>> But we aren't doing below anymore, doesn't this change the
>>> calculations at all?
>>>
>>>   	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
>>
>> The clamp only confines the max_policy between 0 and 100.  AFAIK it doesn't make
>> any change tothe value of limits->max_policy_pct unless it was outside of that
>> range.
>>
>> P.
>>>
> 
> With the changes below (as suggested above), I did tests. Except two
> cases, it did correct. Those two are in turbo range, so I am OK with
> that. 
> 
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index b78abe9..c3bcca4 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1111,9 +1111,9 @@ static int intel_pstate_set_policy(struct
> cpufreq_policy *policy)
>  	limits = &powersave_limits;
>  	limits->min_policy_pct = (policy->min * 100) /
> policy->cpuinfo.max_freq;
>  	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 ,
> 100);
> -	limits->max_policy_pct = (policy->max * 100) /
> policy->cpuinfo.max_freq;
> +	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
> +                                             policy->cpuinfo.max_freq);
>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 ,
> 100);
> -
>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>  	limits->min_perf_pct = max(limits->min_policy_pct,
>  				   limits->min_sysfs_pct);
> @@ -1131,7 +1131,7 @@ static int intel_pstate_set_policy(struct
> cpufreq_policy *policy)
>  				  int_tofp(100));
>  	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
>  				  int_tofp(100));
> -
> +	limits->max_perf = round_up(limits->max_perf, 8);
>  	if (hwp_active)
>  		intel_pstate_hwp_set();
> 
> 
> 3300 : OK
> 3200 : 1 less
> 3100 : 1 less
> 3000 : 1 less

The -1 difference here is not unexpected given the other probable rounding
errors in the frequency code.  I have a feeling that no one really has done an
in depth review to find the errors.  I'm not going to because I'm pretty sure
I/we can convince users that 3200 == 3199.98 ;).  FWIW, I've also wondered if
the difference between the marketing frequency and the TSC frequency (which in
theory equals the marketing frequency) can cause this sort of error.

OOC did you try loading the system down (with a kernel build) and switching
between frequencies?  That's a good way to see the effect of the turbo states.
I would expect that the turbo state hits a maximum of about 75% of the max turbo
state value (based on experiment) so the differences should be larger at the
high end.

P.
