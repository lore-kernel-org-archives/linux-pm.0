From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2] cpufreq: intel_pstate: Proportional algorithm
 for Atom
Date: Thu, 6 Oct 2016 13:57:53 +0200
Message-ID: <CAJZ5v0jChkykn9XCY0APn0MxdinKFY-+v+yoJDWmef10aozD0g@mail.gmail.com>
References: <1565019.BFYQPSZAnN@vostro.rjw.lan> <002501d21f64$67356970$35a03c50$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34442 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934631AbcJFL54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 07:57:56 -0400
In-Reply-To: <002501d21f64$67356970$35a03c50$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Oct 6, 2016 at 1:58 AM, Doug Smythies <dsmythies@telus.net> wrote:
> Hi Rafael,
>
> It doesn't compile for me. See further down.
>
> On 2016.10.05 06:15 Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The PID algorithm used by the intel_pstate driver tends to drive
>> performance to the minimum for workloads with utilization below the
>> setpoint, which is undesirable, so replace it with a modified
>> "proportional" algorithm on Atom.
>>
>> The new algorithm will set the new P-state to be 1.25 times the
>> available maximum times the (frequency-invariant) utilization during
>> the previous sampling period except when the target P-state computed
>> this way is lower than the average P-state during the previous
>> sampling period.  In the latter case, it will increase the target by
>> 50% of the difference between it and the average P-state to prevent
>> performance from dropping down too fast in some cases.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> It is better to compare the average P-state to the target (than to
>> compare the average perf ratio to the utilization), because that takes
>> turbo into account more accurately.
>>
>> Plus if the target is below the min, it is better to compare the min
>> to the average instead of comparing the target to it.
>>
>> ---
>> drivers/cpufreq/intel_pstate.c |   22 +++++++++++++++++++++-
>> 1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> @@ -1232,6 +1232,7 @@ static inline int32_t get_target_pstate_
>>  {
>>       struct sample *sample = &cpu->sample;
>>       int32_t busy_frac, boost;
>> +     int target, avg_pstate;
>>
>>       busy_frac = div_fp(sample->mperf, sample->tsc);
>>
>> @@ -1242,7 +1243,26 @@ static inline int32_t get_target_pstate_
>>               busy_frac = boost;
>>
>>       sample->busy_scaled = busy_frac * 100;
>> -     return get_avg_pstate(cpu) - pid_calc(&cpu->pid, sample->busy_scaled);
>> +
>> +     target = limits->no_turbo || limits->turbo_disabled :
>                                                             ^
>                                                            ^^^
> For proper conditional expression syntax, shouldn't that be a "?" ?

Yes, my bad, sorry.

I'll send a v3 shortly.

Thanks,
Rafael
