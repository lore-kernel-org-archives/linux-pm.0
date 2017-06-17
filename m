From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] intel_pstate: skip scheduler hook when in "performance" mode.
Date: Sat, 17 Jun 2017 03:06:29 +0200
Message-ID: <4318906.Nci2R8jF0d@aspire.rjw.lan>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org> <6542869.y10POnRxLl@aspire.rjw.lan> <CAJvTdKmoV4WbHOCy9WsspcLSNeCxO-egZP_j9XbbTTCTT7OeVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47954 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752234AbdFQBNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 21:13:41 -0400
In-Reply-To: <CAJvTdKmoV4WbHOCy9WsspcLSNeCxO-egZP_j9XbbTTCTT7OeVA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Friday, June 16, 2017 08:52:53 PM Len Brown wrote:
> On Fri, Jun 16, 2017 at 8:04 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, June 07, 2017 07:39:15 PM Len Brown wrote:
> >> From: Len Brown <len.brown@intel.com>
> >>
> >> When the governor is set to "performance", intel_pstate does not
> >> need the scheduler hook for doing any calculations.  Under these
> >> conditions, its only purpose is to continue to maintain
> >> cpufreq/scaling_cur_freq.
> >>
> >> But the cpufreq/scaling_cur_freq sysfs attribute is now provided by
> >> the x86 cpufreq core on all modern x86 systems, including
> >> all systems supported by the intel_pstate driver.
> >>
> >> So in "performance" governor mode, the scheduler hook can be skipped.
> >> This applies to both in Software and Hardware P-state control modes.
> >>
> >> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >> Signed-off-by: Len Brown <len.brown@intel.com>
> >> ---
> >>  drivers/cpufreq/intel_pstate.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> >> index 5d67780..0ff3a4b 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -2025,10 +2025,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
> >>                */
> >>               intel_pstate_clear_update_util_hook(policy->cpu);
> >
> > The statement above shouldn't be necessary any more after the change below.
> 
> The policy can change at run time form something other than  performance
> to performance, so we want to clear the hook in that case, no?

Yes.

> >>               intel_pstate_max_within_limits(cpu);
> >> +     } else {
> >> +             intel_pstate_set_update_util_hook(policy->cpu);
> >>       }
> >>
> >> -     intel_pstate_set_update_util_hook(policy->cpu);
> >> -
> >>       if (hwp_active)
> >>               intel_pstate_hwp_set(policy->cpu);
> >>
> >
> > What about update_turbo_pstate()?
> >
> > In theory MSR_IA32_MISC_ENABLE_TURBO_DISABLE can be set at any time, so
> > wouldn't that become problematic after this change?
> 
> yes, the sysfs "no_turbo" attribute can be modified at any time, invoking
> update_turbo_state(), which will update MSR_IA32_MISC_ENABLE_TURBO_DISABLE

If that was the only way it could change, I wouldn't worry about it, but what
about changes by BMCs and similar?  Are they not a concern?

> But how is the presence or change in turbo related to the lack of a
> need to hook the scheduler callback in "performance" mode?  The hook
> literally does nothing in this case, except consume cycles, no?

No.

It actually sets the P-state to the current maximum (which admittedly is
excessive) exactly because the maximum may change on the fly in theory.

If it can't change on the fly (or we don't care), we can do some more
simplifications there. :-)

Thanks,
Rafael
