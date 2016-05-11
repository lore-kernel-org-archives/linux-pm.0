From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] intel_pstate: Clarify average performance computation
Date: Wed, 11 May 2016 15:46:43 +0200
Message-ID: <CAJZ5v0gg53q50FLbj+LR-JZO_+qWzYo8hnyTnWMg2r5C8E1oVg@mail.gmail.com>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
	<CAJZ5v0h3Z9Dr72KdXzCiv-5Yb6kjv-Bpt0weacQ2jO0gU96hEQ@mail.gmail.com>
	<1462910284.28729.116.camel@linux.intel.com>
	<1703361.r4IIOaCPTn@vostro.rjw.lan>
	<1462942869.4224.25.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34633 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcEKNqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 09:46:45 -0400
In-Reply-To: <1462942869.4224.25.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 11, 2016 at 7:01 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Tue, 2016-05-10 at 22:57 +0200, Rafael J. Wysocki wrote:
>> > > >
>
> [...]
>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH] intel_pstate: Clarify average performance
>> computation
>>
>> The core_pct_busy field of struct sample actually contains the
>> average performace during the last sampling period (in percent)
>> and not the utilization of the core as suggested by its name
>> which is confusing.
>>
>> For this reason, change the name of that field to core_avg_perf
>> and rename the function that computes its value accordingly.
>>
>> Also notice that storing this value as percentage requires a costly
>> integer multiplication to be carried out in a hot path, so instead
>> store it as an "extended fixed point" value with more fraction bits
>> and update the code using it accordingly (it is better to change the
>> name of the field along with its meaning in one go than to make those
>> two changes separately, as that would likely lead to more
>> confusion).
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/intel_pstate.c |   31 +++++++++++++++---------------
>> -
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> @@ -49,6 +49,9 @@
>>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
>>  #define fp_toint(X) ((X) >> FRAC_BITS)
>>
>> +#define EXT_BITS 6
>> +#define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
>> +
>>  static inline int32_t mul_fp(int32_t x, int32_t y)
>>  {
>>       return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
>> @@ -72,10 +75,10 @@ static inline int ceiling_fp(int32_t x)
>>
>>  /**
>>   * struct sample -   Store performance sample
>> - * @core_pct_busy:   Ratio of APERF/MPERF in percent, which is
>> actual
>> + * @core_avg_perf:   Ratio of APERF/MPERF which is the actual
>> average
>>   *                   performance during last sample period
>>   * @busy_scaled:     Scaled busy value which is used to calculate
>> next
>> - *                   P state. This can be different than
>> core_pct_busy
>> + *                   P state. This can be different than
>> core_avg_perf
>>   *                   to account for cpu idle period
>>   * @aperf:           Difference of actual performance frequency
>> clock count
>>   *                   read from APERF MSR between last and
>> current sample
>> @@ -90,8 +93,8 @@ static inline int ceiling_fp(int32_t x)
>>   * data for choosing next P State.
>>   */
>>  struct sample {
>> -     int32_t core_pct_busy;
>>       int32_t busy_scaled;
>> +     u64 core_avg_perf;
>>       u64 aperf;
>>       u64 mperf;
>>       u64 tsc;
>> @@ -1147,15 +1150,12 @@ static void intel_pstate_get_cpu_pstates
>>       intel_pstate_set_min_pstate(cpu);
>>  }
>>
>> -static inline void intel_pstate_calc_busy(struct cpudata *cpu)
>> +static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
>>  {
>>       struct sample *sample = &cpu->sample;
>> -     int64_t core_pct;
>> -
>> -     core_pct = sample->aperf * int_tofp(100);
>> -     core_pct = div64_u64(core_pct, sample->mperf);
>>
>> -     sample->core_pct_busy = (int32_t)core_pct;
>> +     sample->core_avg_perf = div64_u64(sample->aperf <<
>> EXT_FRAC_BITS,
>> +                                       sample->mperf);
>>  }
>>
>>  static inline bool intel_pstate_sample(struct cpudata *cpu, u64
>> time)
>> @@ -1198,9 +1198,8 @@ static inline bool intel_pstate_sample(s
>>
>>  static inline int32_t get_avg_frequency(struct cpudata *cpu)
>>  {
>> -     return fp_toint(mul_fp(cpu->sample.core_pct_busy,
>> -                            int_tofp(cpu-
>> >pstate.max_pstate_physical *
>> -                                             cpu->pstate.scaling
>> / 100)));
>> +     return (cpu->sample.core_avg_perf * cpu-
>> >pstate.max_pstate_physical *
>> +                     cpu->pstate.scaling) >> EXT_FRAC_BITS;
>
> This breaks frequency display. Needs cast
> return ((u64)cpu->sample.core_avg_perf * cpu->
>         pstate.max_pstate_physical * cpu->pstate.scaling) >>
> EXT_FRAC_BITS;

Well, that's strange, because sample.core_avg_perf is a u64 after this
patch already.

But if we are to make explicit type conversions, I'd rather store
sample.core_avg_perf in 32 bit.

> Otherwise results are very close with the version without this change.

OK, let me resend the series with this patch reworked once again.
