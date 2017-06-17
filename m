From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] intel_pstate: skip scheduler hook when in
 "performance" mode.
Date: Fri, 16 Jun 2017 21:31:15 -0400
Message-ID: <CAJvTdKnULzQCdwg7vqfSymr+nbS=7UgVPBCqYpqcH8gApUHrxQ@mail.gmail.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
 <6542869.y10POnRxLl@aspire.rjw.lan> <CAJvTdKmoV4WbHOCy9WsspcLSNeCxO-egZP_j9XbbTTCTT7OeVA@mail.gmail.com>
 <4318906.Nci2R8jF0d@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36452 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdFQBbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 21:31:16 -0400
In-Reply-To: <4318906.Nci2R8jF0d@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, Jun 16, 2017 at 9:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, June 16, 2017 08:52:53 PM Len Brown wrote:
>> On Fri, Jun 16, 2017 at 8:04 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, June 07, 2017 07:39:15 PM Len Brown wrote:
>> >> From: Len Brown <len.brown@intel.com>
>> >>
>> >> When the governor is set to "performance", intel_pstate does not
>> >> need the scheduler hook for doing any calculations.  Under these
>> >> conditions, its only purpose is to continue to maintain
>> >> cpufreq/scaling_cur_freq.
>> >>
>> >> But the cpufreq/scaling_cur_freq sysfs attribute is now provided by
>> >> the x86 cpufreq core on all modern x86 systems, including
>> >> all systems supported by the intel_pstate driver.
>> >>
>> >> So in "performance" governor mode, the scheduler hook can be skipped.
>> >> This applies to both in Software and Hardware P-state control modes.
>> >>
>> >> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> >> Signed-off-by: Len Brown <len.brown@intel.com>
>> >> ---
>> >>  drivers/cpufreq/intel_pstate.c | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> >> index 5d67780..0ff3a4b 100644
>> >> --- a/drivers/cpufreq/intel_pstate.c
>> >> +++ b/drivers/cpufreq/intel_pstate.c
>> >> @@ -2025,10 +2025,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>> >>                */
>> >>               intel_pstate_clear_update_util_hook(policy->cpu);
>> >
>> > The statement above shouldn't be necessary any more after the change below.
>>
>> The policy can change at run time form something other than  performance
>> to performance, so we want to clear the hook in that case, no?
>
> Yes.
>
>> >>               intel_pstate_max_within_limits(cpu);
>> >> +     } else {
>> >> +             intel_pstate_set_update_util_hook(policy->cpu);
>> >>       }
>> >>
>> >> -     intel_pstate_set_update_util_hook(policy->cpu);
>> >> -
>> >>       if (hwp_active)
>> >>               intel_pstate_hwp_set(policy->cpu);
>> >>
>> >
>> > What about update_turbo_pstate()?
>> >
>> > In theory MSR_IA32_MISC_ENABLE_TURBO_DISABLE can be set at any time, so
>> > wouldn't that become problematic after this change?
>>
>> yes, the sysfs "no_turbo" attribute can be modified at any time, invoking
>> update_turbo_state(), which will update MSR_IA32_MISC_ENABLE_TURBO_DISABLE
>
> If that was the only way it could change, I wouldn't worry about it, but what
> about changes by BMCs and similar?  Are they not a concern?
>
>> But how is the presence or change in turbo related to the lack of a
>> need to hook the scheduler callback in "performance" mode?  The hook
>> literally does nothing in this case, except consume cycles, no?
>
> No.
>
> It actually sets the P-state to the current maximum (which admittedly is
> excessive) exactly because the maximum may change on the fly in theory.

There are 2 cases.

If turbo was enabled and were we requesting max turbo
and "somebody" disabled turbo in an MSR, then the HW would
simply clip our excessive req
> If it can't change on the fly (or we don't care), we can do some more
> simplifications there. :-)

I do not think it is Linux's responsibility to monitor changes to MSRs
such as Turbo enable/disable done behind its back by a BMC at run-time.
(if this is even possible)


-- 
Len Brown, Intel Open Source Technology Center
