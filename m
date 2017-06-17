From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/5] x86: use common aperfmperf_khz_on_cpu() to calculate
 KHz using APERF/MPERF
Date: Fri, 16 Jun 2017 21:49:00 -0400
Message-ID: <CAJvTdKmK6SPq1L1nWpkAcVgXBT92r=-EZsTNPi1C5eBDaux5xQ@mail.gmail.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
 <aba8474c690306eb708d4737d0b63c5ca448d019.1496889051.git.len.brown@intel.com> <2034981.ATAhzOCgUq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36582 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbdFQBtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 21:49:02 -0400
In-Reply-To: <2034981.ATAhzOCgUq@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, Jun 16, 2017 at 8:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 07, 2017 07:39:13 PM Len Brown wrote:
>> From: Len Brown <len.brown@intel.com>
>>
>> The goal of this change is to give users a uniform and meaningful
>> result when they read /sys/...cpufreq/scaling_cur_freq
>> on modern x86 hardware, as compared to what they get today.
>>
>> Modern x86 processors include the hardware needed
>> to accurately calculate frequency over an interval --
>> APERF, MPERF, and the TSC.
>>
>> Here we provide an x86 routine to make this calculation
>> on supported hardware, and use it in preference to any
>> driver driver-specific cpufreq_driver.get() routine.
>>
>> MHz is computed like so:
>>
>> MHz = base_MHz * delta_APERF / delta_MPERF
>>
>> MHz is the average frequency of the busy processor
>> over a measurement interval.  The interval is
>> defined to be the time between successive invocations
>> of aperfmperf_khz_on_cpu(), which are expected to to
>> happen on-demand when users read sysfs attribute
>> cpufreq/scaling_cur_freq.
>>
>> As with previous methods of calculating MHz,
>> idle time is excluded.
>>
>> base_MHz above is from TSC calibration global "cpu_khz".
>>
>> This x86 native method to calculate MHz returns a meaningful result
>> no matter if P-states are controlled by hardware or firmware
>> and/or if the Linux cpufreq sub-system is or is-not installed.
>>
>> When this routine is invoked more frequently, the measurement
>> interval becomes shorter.  However, the code limits re-computation
>> to 10ms intervals so that average frequency remains meaningful.
>>
>> Discerning users are encouraged to take advantage of
>> the turbostat(8) utility, which can gracefully handle
>> concurrent measurement intervals of arbitrary length.
>>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>> ---
>>  arch/x86/kernel/cpu/Makefile     |  1 +
>>  arch/x86/kernel/cpu/aperfmperf.c | 82 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/cpufreq/cpufreq.c        |  7 +++-
>>  include/linux/cpufreq.h          | 13 +++++++
>>  4 files changed, 102 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/x86/kernel/cpu/aperfmperf.c
>>
>> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
>> index 5200001..cdf8249 100644
>> --- a/arch/x86/kernel/cpu/Makefile
>> +++ b/arch/x86/kernel/cpu/Makefile
>> @@ -21,6 +21,7 @@ obj-y                       += common.o
>>  obj-y                        += rdrand.o
>>  obj-y                        += match.o
>>  obj-y                        += bugs.o
>> +obj-$(CONFIG_CPU_FREQ)       += aperfmperf.o
>>
>>  obj-$(CONFIG_PROC_FS)        += proc.o
>>  obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
>> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
>> new file mode 100644
>> index 0000000..5ccf63a
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/aperfmperf.c
>> @@ -0,0 +1,82 @@
>> +/*
>> + * x86 APERF/MPERF KHz calculation for
>> + * /sys/.../cpufreq/scaling_cur_freq
>> + *
>> + * Copyright (C) 2017 Intel Corp.
>> + * Author: Len Brown <len.brown@intel.com>
>> + *
>> + * This file is licensed under GPLv2.
>> + */
>> +
>> +#include <linux/jiffies.h>
>> +#include <linux/math64.h>
>> +#include <linux/percpu.h>
>> +#include <linux/smp.h>
>> +
>> +struct aperfmperf_sample {
>> +     unsigned int khz;
>> +     unsigned long jiffies;
>> +     u64 aperf;
>> +     u64 mperf;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
>> +
>> +/*
>> + * aperfmperf_snapshot_khz()
>> + * On the current CPU, snapshot APERF, MPERF, and jiffies
>> + * unless we already did it within 10ms
>> + * calculate kHz, save snapshot
>> + */
>> +static void aperfmperf_snapshot_khz(void *dummy)
>> +{
>> +     u64 aperf, aperf_delta;
>> +     u64 mperf, mperf_delta;
>> +     struct aperfmperf_sample *s = &get_cpu_var(samples);
>> +
>> +     /* Don't bother re-computing within 10 ms */
>> +     if (time_before(jiffies, s->jiffies + HZ/100))
>> +             goto out;
>> +
>> +     rdmsrl(MSR_IA32_APERF, aperf);
>> +     rdmsrl(MSR_IA32_MPERF, mperf);
>> +
>> +     aperf_delta = aperf - s->aperf;
>> +     mperf_delta = mperf - s->mperf;
>> +
>> +     /*
>> +      * There is no architectural guarantee that MPERF
>> +      * increments faster than we can read it.
>> +      */
>> +     if (mperf_delta == 0)
>> +             goto out;
>> +
>> +     /*
>> +      * if (cpu_khz * aperf_delta) fits into ULLONG_MAX, then
>> +      *      khz = (cpu_khz * aperf_delta) / mperf_delta
>> +      */
>> +     if (div64_u64(ULLONG_MAX, cpu_khz) > aperf_delta)
>> +             s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
>> +     else    /* khz = aperf_delta / (mperf_delta / cpu_khz) */
>> +             s->khz = div64_u64(aperf_delta,
>> +                     div64_u64(mperf_delta, cpu_khz));
>> +     s->jiffies = jiffies;
>> +     s->aperf = aperf;
>> +     s->mperf = mperf;
>> +
>> +out:
>> +     put_cpu_var(samples);
>> +}
>> +
>> +unsigned int aperfmperf_khz_on_cpu(unsigned int cpu)
>> +{
>> +     if (!cpu_khz)
>> +             return 0;
>> +
>> +     if (!static_cpu_has(X86_FEATURE_APERFMPERF))
>> +             return 0;
>> +
>> +     smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
>> +
>> +     return per_cpu(samples.khz, cpu);
>> +}
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 26b643d..a667fac 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -635,8 +635,13 @@ show_one(scaling_max_freq, max);
>>  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>>  {
>>       ssize_t ret;
>> +     unsigned int freq;
>>
>> -     if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
>> +     freq = arch_freq_get_on_cpu(policy->cpu);
>> +     if (freq)
>> +             ret = sprintf(buf, "%u\n", freq);
>> +     else if (cpufreq_driver && cpufreq_driver->setpolicy &&
>> +                     cpufreq_driver->get)
>>               ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>>       else
>>               ret = sprintf(buf, "%u\n", policy->cur);
>
> I wonder if we could change intel_pstate_get() to simply return
> aperfmperf_khz_on_cpu(cpu_num)?
>
> That would allow us to avoid the extra branch here and get rid of the
> #ifdef x86 from the header.

The reason I put the hook here is specifically so that the same
code would always be called on the x86 architecture,
no not matter what cpufreq driver is loaded.

Yes, alternatively, all possible driver.get routines could be updated
to call the same routine.  That is acpi-cpufreq.c, intel_pstate.c,
others?

Do I think that saving a branch is meaningful in a system call to retrieve
the average frequency from the kernel?  No, I don't.

I'm not religious about "if (CONFIG_X86)" appearing in cpufreq.h.
If somebody really cares, then the purist approach would be
to add an additional arch-specific-hook header -- though that seemed
overkill to me...

thanks,
-Len


>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index a5ce0bbe..cfc6220 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -883,6 +883,19 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>>  }
>>  #endif
>>
>> +#ifdef CONFIG_X86
>> +extern unsigned int aperfmperf_khz_on_cpu(unsigned int cpu);
>> +static inline unsigned int arch_freq_get_on_cpu(int cpu)
>> +{
>> +     return aperfmperf_khz_on_cpu(cpu);
>> +}
>> +#else
>> +static inline unsigned int arch_freq_get_on_cpu(int cpu)
>> +{
>> +     return 0;
>> +}
>> +#endif
>> +
>>  /* the following are really really optional */
>>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
>>
>
> Thanks,
> Rafael
>



-- 
Len Brown, Intel Open Source Technology Center
