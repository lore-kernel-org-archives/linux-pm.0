From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Tue, 10 Jul 2018 11:12:08 +0530
Message-ID: <3bfc37e1-e82b-c09d-462f-bf4f79aec91f@caviumnetworks.com>
References: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
 <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hi Prakash,


On 07/09/2018 10:12 PM, Prakash, Prashanth wrote:
> 
> Hi George,
> 
> 
> On 7/9/2018 4:10 AM, George Cherian wrote:
>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>> feedback via set of performance counters. To determine the actual
>> performance level delivered over time, OSPM may read a set of
>> performance counters from the Reference Performance Counter Register
>> and the Delivered Performance Counter Register.
>>
>> OSPM calculates the delivered performance over a given time period by
>> taking a beginning and ending snapshot of both the reference and
>> delivered performance counters, and calculating:
>>
>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>
>> Implement the above and hook this to the cpufreq->get method.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index a9d3eec..61132e8 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        return ret;
>>   }
>>
>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>> +{
>> +     u64 delta_reference, delta_delivered;
>> +     u64 reference_perf, delivered_perf;
>> +
>> +     reference_perf = fb_ctrs_t0.reference_perf;
>> +
>> +     delta_reference = (u32)fb_ctrs_t1.reference -
>> +                             (u32)fb_ctrs_t0.reference;
>> +     delta_delivered = (u32)fb_ctrs_t1.delivered -
>> +                             (u32)fb_ctrs_t0.delivered;
> Why (u32)? These registers can be 64bits and that's why cppc_perf_fb_ctrs
> have 64b fields for reference and delivered counters.
> 
> Moreover, the integer math is incorrect. You can run into a scenario where
> t1.ref/del < t0.ref/del,  thus setting a negative number to u64! The likelihood
> of this is very high especially when you throw away the higher 32bits.
> 
Because of binary representation, unsigned subtraction will work even if
t1.ref/del < t0.ref/del. So essentially, the code should look like
this,

static inline u64 get_delta(u64 t1, u64 t0)
{
         if (t1 > t0 || t0 > ~(u32)0)
                 return t1 - t0;

         return (u32)t1 - (u32)t0;
}

As a further optimization, I used (u32) since that also works,
as long as the momentary delta at any point is not greater than 2 ^ 32.
I don't foresee any reason for any platform to increment the counters at
an interval greater than 2 ^ 32.

> To keep things simple, do something like below:
> 
> if (t1.reference <= t0.reference || t1.delivered <= t0.delivered) {
>       /* Atleast one of them should have overflowed */
>       return desired_perf;
> }
> else {
>       compute the delivered perf using the counters.
> }

No need to do like this as this is tested and found working across 
counter overruns in our platform.
> 
>> +
>> +     /* Check to avoid divide-by zero */
>> +     if (delta_reference || delta_delivered)
>> +             delivered_perf = (reference_perf * delta_delivered) /
>> +                                     delta_reference;
>> +     else
>> +             delivered_perf = cpu->perf_ctrls.desired_perf;
>> +
>> +     return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>> +}
>> +
>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>> +{
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>> +     int ret;
>> +
>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     udelay(2); /* 2usec delay between sampling */
>> +
>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>> +}
>> +
>>   static struct cpufreq_driver cppc_cpufreq_driver = {
>>        .flags = CPUFREQ_CONST_LOOPS,
>>        .verify = cppc_verify_policy,
>>        .target = cppc_cpufreq_set_target,
>> +     .get = cppc_cpufreq_get_rate,
>>        .init = cppc_cpufreq_cpu_init,
>>        .stop_cpu = cppc_cpufreq_stop_cpu,
>>        .name = "cppc_cpufreq",
> 
