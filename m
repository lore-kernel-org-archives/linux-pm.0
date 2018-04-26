From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2][for 4.17-rc3] cpufreq / CPPC: Set platform specific
 transition_delay_us
Date: Thu, 26 Apr 2018 09:29:29 -0600
Message-ID: <d65edca1-616d-7766-5aca-b8942bc971b1@codeaurora.org>
References: <1524673572-27941-1-git-send-email-pprakash@codeaurora.org>
 <20180426052525.snsw3hzflabvfer3@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180426052525.snsw3hzflabvfer3@vireshk-i7>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, "4.14+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 4/25/2018 11:25 PM, Viresh Kumar wrote:
> On 25-04-18, 10:26, Prashanth Prakash wrote:
>> Add support to specify platform specific transition_delay_us instead
>> of using the transition delay derived from PCC.
>>
>> With commit "3d41386d556d: cpufreq: CPPC: Use transition_delay_us
>> depending transition_latency" we are setting transition_delay_us
>> directly and not applying the LATENCY_MULTIPLIER. With this on Qualcomm
>> Centriq we can end up with a very high rate of frequency change requests
>> when using schedutil governor (default rate_limit_us=10 compared to an
>> earlier value of 10000).
>>
>> The PCC subspace describes the rate at which the platform can accept
>> commands on the CPPC's PCC channel. This includes read and write
>> command on the PCC channel that can be used for reasons other than
>> frequency transitions. Moreover the same PCC subspace can be used by
>> multiple freq domains and deriving transition_delay_us from it as we do
>> now can be sub-optimal.
>>
>> Moreover if a platform does not use PCC for desired_perf register then
>> there is no way to compute the transition latency or the delay_us.
>>
>> CPPC does not have a standard defined mechanism to get the transition
>> rate or the latency at the moment.
>>
>> Given the above limitations, it is simpler to have a platform specific
>> transition_delay_us and rely on PCC derived value only if a platform
>> specific value is not available.
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: 4.14+ <stable@vger.kernel.org>
>> Fixes: 3d41386d556d ("cpufreq: CPPC: Use transition_delay_us depending
>> transition_latency)
>> ---
>> v2:
>> * Return final delay_us from cppc_cpufreq_get_transition_delay_us (Viresh)
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 43 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index bc5fc16..b1e32ad 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -126,6 +126,46 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>  				cpu->perf_caps.lowest_perf, cpu_num, ret);
>>  }
>>  
>> +/*
>> + * The PCC subspace describes the rate at which platform can accept commands
>> + * on the shared PCC channel (including READs which do not count towards freq
>> + * trasition requests), so ideally we need to use the PCC values as a fallback
>> + * if we don't have a platform specific transition_delay_us
>> + */
>> +#if defined(CONFIG_ARM64)
> You can use #ifdef here instead.
I will update.
>
>> +#include <asm/cputype.h>
>> +
>> +static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
>> +{
>> +	unsigned long implementor = read_cpuid_implementor();
>> +	unsigned long part_num = read_cpuid_part_number();
>> +	unsigned int delay_us = 0;
>> +
>> +	switch (implementor) {
>> +	case ARM_CPU_IMP_QCOM:
>> +		switch (part_num) {
>> +		case QCOM_CPU_PART_FALKOR_V1:
>> +		case QCOM_CPU_PART_FALKOR:
>> +			delay_us = 10000;
>> +			break;
>> +		}
>> +		break;
> What about adding a default: case here and moving the below code into that ?
Agree, it will much cleaner.. I will update.
>
>> +	}
>> +
>> +	if (!delay_us)
>> +		delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>> +
>> +	return delay_us;
>> +}
>> +
>> +#else
>> +
>> +static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
>> +{
>> +	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>> +}
>> +#endif
>> +
>>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>  {
>>  	struct cppc_cpudata *cpu;
>> @@ -162,8 +202,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>  		cpu->perf_caps.highest_perf;
>>  	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
>>  
>> -	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
>> -		NSEC_PER_USEC;
>> +	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
>>  	policy->shared_type = cpu->shared_type;
>>  
>>  	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
>> -- 
>> Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
>> Qualcomm Technologies, Inc. is a member of the
>> Code Aurora Forum, a Linux Foundation Collaborative Project.
