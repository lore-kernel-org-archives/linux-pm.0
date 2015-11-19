From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] cpufreq, intel_pstate.c, Fix rounding errors
Date: Thu, 19 Nov 2015 14:07:37 -0500
Message-ID: <564E1DF9.1020809@redhat.com>
References: <1447862144-7188-1-git-send-email-prarit@redhat.com> <20151119044639.GD3737@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151119044639.GD3737@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 11/18/2015 11:46 PM, Viresh Kumar wrote:
> On 18-11-15, 10:55, Prarit Bhargava wrote:
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index 2e31d09..686f024 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1233,6 +1233,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>  	struct cpudata *cpu;
>>  	int i;
>>  #endif
>> +	int max_policy_calc;
>> +
>>  	pr_debug("intel_pstate: %s max %u policy->max %u\n", __func__,
>>  		 policy->cpuinfo.max_freq, policy->max);
>>  	if (!policy->cpuinfo.max_freq)
>> @@ -1249,7 +1251,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>  	limits = &powersave_limits;
>>  	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
>>  	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
>> -	limits->max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
>> +
>> +	max_policy_calc = (policy->max * 1000) / policy->cpuinfo.max_freq;
>> +	limits->max_policy_pct = DIV_ROUND_UP(max_policy_calc, 10);
>> +
> 
> Nice catch, but why can't we do this instead:
> 
> 	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100, policy->cpuinfo.max_freq);
> 

Ah, I got so deep into the code I didn't even think of simplifying the
calculation.  Thanks -- I'll do that instead.

>>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
>>  
>>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>> @@ -1269,6 +1274,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>  				  int_tofp(100));
>>  	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
>>  				  int_tofp(100));
>> +	limits->max_perf = round_up(limits->max_perf, 8);
> 
> Perhaps you should fix this in a separate patch.
> 

Okay, I submit these as a 2 part patchset.

P.
