From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for suspend
Date: Sat, 21 Nov 2015 08:45:20 -0800
Message-ID: <001901d1247c$043f3190$0cbd94b0$@net>
References: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com> <20150917053004.GB6665@amd> <36DF59CE26D8EE47B0655C516E9CE6402865A403@shsmsx102.ccr.corp.intel.com> <001701d102c4$1ac2bab0$50483010$@net> <36DF59CE26D8EE47B0655C516E9CE6402865AA02@shsmsx102.ccr.corp.intel.com> <002c01d1043c$133ba580$39b2f080$@net> <36DF59CE26D8EE47B0655C516E9CE64028662059@shsmsx102.ccr.corp.intel.com> <000901d118a8$8fda8450$af8f8cf0$@net> <36DF59CE26D8EE47B0655C516E9CE6402867326B@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta7.telus.net ([209.171.16.80]:40104 "EHLO cmta7.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761079AbbKUQpZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Nov 2015 11:45:25 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402867326B@shsmsx102.ccr.corp.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Chen, Yu C'" <yu.c.chen@intel.com>
Cc: "'Wysocki, Rafael J'" <rafael.j.wysocki@intel.com>, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de, "'Zhang, Rui'" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, "'Brown, Len'" <len.brown@intel.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Pavel Machek' <pavel@ucw.cz>, 'Kristen Carlson Accardi' <kristen@linux.intel.com>, "'Pandruvada, Srinivas'" <srinivas.pandruvada@intel.com>

On 2015.11.12 01:42 Chen, Yu C wrote:
> On 2015.11.06 11:34 Doug Smythies wrote: 
>> On 2015.11.01 08:50 Chen, Yu C wrote:
>>>> On 2015.10.10 19:27 Chen, Yu C wrote:
>>>>> On 2105.10.10 02:56 Doug Smythies wrote:
>>>>>
>>>>>>> The current version of the intel_pstate driver is incompatible
>>>>>>> with any use of Clock Modulation, always resulting in driving the
>>>>>>> target pstate to the minimum, regardless of load. The result is
>>>>>>> the apparent CPU frequency stuck at minimum * modulation percent.
>>>>>>
>>>>>>> The acpi-cpufreq driver works fine with Clock Modulation,
>>>>>>> resulting in desired frequency * modulation percent.
>>>>>>
>>>>
>>>>> [Yu] Why intel_pstate driver is incompatible with Clock Modulation?
>>>>
>>>> It is simply how the current control algorithm responds to the scenario.
>>>>
>>>> The problem is in intel_pstate_get_scaled_busy, here:
>>>>
>>>>         /*
>>>>          * core_busy is the ratio of actual performance to max
>>>>          * max_pstate is the max non turbo pstate available
>>>>          * current_pstate was the pstate that was requested during
>>>>          *      the last sample period.
>>>>          *
>>>>          * We normalize core_busy, which was our actual percent
>>>>          * performance to what we requested during the last sample
>>>>          * period. The result will be a percentage of busy at a
>>>>          * specified pstate.
>>>>          */
>>>>         core_busy = cpu->sample.core_pct_busy;
>>>>         max_pstate = int_tofp(cpu->pstate.max_pstate);
>>>>         current_pstate = int_tofp(cpu->pstate.current_pstate);
>>>>         core_busy = mul_fp(core_busy, div_fp(max_pstate,
>>>> current_pstate));
>>>>
>>>> With Clock Modulation enabled, the actual performance percent will
>>>> always be less than what was asked for, basically meaning
>>>> current_pstate is much less than what was asked for. Thus the
>>>> algorithm will drive down the target pstate regardless of load.
>>>>
>>> [Yu] Do you mean, there is some problem with the normalization,and we
>>> should use the actual pstate rather than the theoretical
>>> current_pstate, for example, the pseudocode might looked like:
>>>
>>> -  current_pstate = int_tofp(cpu->pstate.current_pstate);
>>> + current_pstate = int_tofp(cpu->pstate.current_pstat)*0.85;
>> 
>> I did not think of normalizing / compensating at this point.
>> That is a good idea.
>> Just for a test, I tried it and it seems to work well.
>> Before normalizing / compensating core_busy can be quite a small for lesser
>> clock modulation duty cycles, and so becomes a little noisy afterwards.
>> 
>> For my test, on an otherwise unaltered kernel v4.3 I did this:
>> 
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index aa33b92..97a90e1 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -821,6 +821,7 @@ static inline int32_t
>> intel_pstate_get_scaled_busy(struct cpudata *cpu)
>>         int32_t core_busy, max_pstate, current_pstate, sample_ratio;
>>         s64 duration_us;
>>         u32 sample_time;
>> +       u64 clock_modulation;
>> 
>>         /*
>          * core_busy is the ratio of actual performance to max @@ -836,6
>> +837,17 @@ static inline int32_t intel_pstate_get_scaled_busy(struct
>> cpudata *cpu)
>>         core_busy = cpu->sample.core_pct_busy;
>>         max_pstate = int_tofp(cpu->pstate.max_pstate);
>>         current_pstate = int_tofp(cpu->pstate.current_pstate);
>> +
>> +//     rdmsrl(MSR_IA32_CLOCK_MODULATION, clock_modulation);
>> +       rdmsrl(MSR_IA32_THERM_CONTROL, clock_modulation);
>> +       if(clock_modulation && 0X10) {
>> +               clock_modulation = clock_modulation & 0x0F;
>> +               if(clock_modulation == 0) clock_modulation = 8;
>> +               core_busy = mul_fp(core_busy, int_tofp(0x10));
>> +               core_busy = div_fp(core_busy, int_tofp(clock_modulation));
>> +       }
>> +
> rdmsr_safe  might be better,

I'll look into it, thanks.

> you can refer to acpi_throttling_rdmsr

I don't understand.

 ,
> and I'm OK with this code, are you planning to send a formal patch? 

The delay here is because I have always thought that some actual load
content needs to be brought back to the intel_pstate driver, which would
(or at least should) eliminate the need for this patch.

Anyway, and at least for the interim, I'll try to make and submit a formal version.

... Doug


