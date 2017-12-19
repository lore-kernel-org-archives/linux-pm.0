From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Resend][PATCH V2] cpufreq: intel_pstate: allow trace in passive mode
Date: Tue, 19 Dec 2017 01:24:41 +0100
Message-ID: <CAJZ5v0imBeL8tZwmJiB6UGBVgUUNcDm2izY0M7rZv=MtGsjTgA@mail.gmail.com>
References: <1513384980-3428-1-git-send-email-dsmythies@telus.net> <1513639857.31113.12.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39066 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935186AbdLSAYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 19:24:42 -0500
In-Reply-To: <1513639857.31113.12.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <doug.smythies@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Tue, Dec 19, 2017 at 12:30 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2017-12-15 at 16:43 -0800, Doug Smythies wrote:
>> Allow use of the trace_pstate_sample trace function
>> when the intel_pstate driver is in passive mode.
>> Since the core_busy and scaled_busy fields are not
>> used, and it might be desirable to know which path
>> through the driver was used, either intel_cpufreq_target
>> or intel_cpufreq_fast_switch, re-task the core_busy
>> field as a flag indicator.
>>
>> The user can then use the intel_pstate_tracer.py utility
>> to summarize and plot the trace.
>>
>> In Passive mode the driver is only called if there is
>> a need to change the target frequency, so durations
>> (time gaps between calls) can be very very long. The user
>> needs to understand, and not be confused by, this limitation.
>>
>> V2: prepare for resend. Rebase to current kernel, 4.15-rc3.
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 50
>> ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c
>> b/drivers/cpufreq/intel_pstate.c
>> index 93a0e88..fe25d69 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1949,7 +1949,10 @@ static int intel_cpufreq_target(struct
>> cpufreq_policy *policy,
>>  {
>>       struct cpudata *cpu = all_cpu_data[policy->cpu];
>>       struct cpufreq_freqs freqs;
>> -     int target_pstate;
>> +     struct sample *sample;
>> +     int target_pstate, from;
>> +     u64 time;
>> +     bool sample_taken;
>>
>>       update_turbo_state();
>>
>> @@ -1969,12 +1972,32 @@ static int intel_cpufreq_target(struct
>> cpufreq_policy *policy,
>>               break;
>>       }
>>       target_pstate = intel_pstate_prepare_request(cpu,
>> target_pstate);
>> +
>> +     from = cpu->pstate.current_pstate;
>> +     time = ktime_get();
>> +     sample_taken = intel_pstate_sample(cpu, time);
>> +
> This is quite a bit of overhead for tracing. Why not fold the above two
> statements in the next if () with conditional tracing?
>
>>       if (target_pstate != cpu->pstate.current_pstate) {
>>               cpu->pstate.current_pstate = target_pstate;
>>               wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
>>                             pstate_funcs.get_val(cpu,
>> target_pstate));
>>       }
>>       freqs.new = target_pstate * cpu->pstate.scaling;
>> +
>> +     if (sample_taken) {
> if (trace_pstate_sample_enabled() && sample_taken) {
>
>> +             intel_pstate_calc_avg_perf(cpu);
>> +             sample = &cpu->sample;
>> +             trace_pstate_sample(0,
> Not sure they are statement below are aligned correctly.
>
>> +             0,
>> +             from,
>> +             cpu->pstate.current_pstate,
>> +             sample->mperf,
>> +             sample->aperf,
>> +             sample->tsc,
>> +             get_avg_frequency(cpu),
>> +             fp_toint(cpu->iowait_boost * 100));
>> +     }
>> +
> Same below in the intel_cpufreq_fast_switch().

And it's quite a bit of code duplication too.

Maybe put this into a separate function and call it from the two places?
