From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [TEST PATCH] cpufreq: intel_pstate: Workaround to for wrong ACPI
 perf table entry
Date: Wed, 18 Nov 2015 04:19:40 +0100
Message-ID: <CAJZ5v0ideLEQB9m-s6ApL6ub-6sdPFunf4_vspF_HR6DVzxOag@mail.gmail.com>
References: <1447801252-3626-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<8524647.rknTxxgTfO@vostro.rjw.lan>
	<1447812635.2778.90.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35400 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbKRDTm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 22:19:42 -0500
Received: by lbbsy6 with SMTP id sy6so16997026lbb.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 19:19:40 -0800 (PST)
In-Reply-To: <1447812635.2778.90.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Nov 18, 2015 at 3:10 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Wed, 2015-11-18 at 02:33 +0100, Rafael J. Wysocki wrote:
>> On Tuesday, November 17, 2015 03:00:52 PM Srinivas Pandruvada wrote:
>> > With the implementation of ACPI _PSS and _PPC processing in the Intel P
>> > state driver, a bad ACPI configuration can impact max/min states. For
>> > example as reported by Borislav Petkov <bp@alien8.de>, the log shows:
>> >
>> > [    0.826119] intel_pstate: default limits 0xc 0x1d 0x24
>> > [    0.827000] intel_pstate: CPU0 - ACPI _PSS perf data
>> > [    0.827020]      *P0: 2901 MHz, 35000 mW, 0xff00
>> > The above control value of 0xff00, is invalid. The first entry sets the
>> > max control value for turbo with a max non turbo frequency + 1 MHz. Here
>> > the control values should be 0x1d00.

[cut]

>> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> > index d3159f0..fc99e97 100644
>> > --- a/drivers/cpufreq/intel_pstate.c
>> > +++ b/drivers/cpufreq/intel_pstate.c
>> > @@ -311,6 +311,13 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
>> >              * correct max turbo frequency based on the turbo ratio.
>> >              * Also need to convert to MHz as _PSS freq is in MHz.
>> >              */
>> > +           if (turbo_pss_ctl > cpu->pstate.turbo_pstate) {
>> > +                   /* We hava an invalid control value here */
>> > +                   turbo_pss_ctl = cpu->pstate.turbo_pstate;
>> > +                   cpu->acpi_perf_data.states[0].control =
>> > +                                                   turbo_pss_ctl << 8;
>> > +           }
>>
>> Should we update pstate.turbo_pstate otherwise?
>
> It will happen as the policy will reduce the frequency based on the
> _PSS[PPC_INDEX] frequency. So if turbo_pstate is less then the
> intel_pstate_set_policy will be called with reduced max->policy.
>

Well, OK, but here we're leaving policy->cpuinfo.max_freq and
acpi_perf_data.states[0].core_frequency somewhat inconsistent which at
least looks confusing.

>>
>> > +
>> >             cpu->acpi_perf_data.states[0].core_frequency =
>> >                             turbo_pss_ctl * cpu->pstate.scaling / 1000;
>> >     }
>>
>> We seem to have one more bug in this function, but it doesn't affect the case
>> at hand.  Namely, if the turbo range is not present in the _PSS, we should
>> set pstate.turbo_pstate to pstate.max_pstate after we've updated the latter
>> and not before updating it.
>
> Doing it before we have good known reference for max_sysf_pct. which is
> either physical max turbo or physical max non turbo as 100%. The policy
> will limit to actual pss max pstate frequency. which will be reflected
> in reduced max_perf_pct.
>

So say we have the "non-turbo" situation, so we set the
pstate.turbo_pstate to pstate.max_pstate and then we update
pstate.max_pstate.  policy->cpuinfo.max_freq is updated to reflect the
new max_pstate and turbo_pstate points to physical max non turbo which
is above max_pstate.  Why is this correct?  What about
update_turbo_state(), for example?

And now we're claiming "no turbo", but we're presenting the "non-PSS
max_pstate" as an "effective turbo" and the max_pstate from _PSS is
the new limit.  How is this not confusing?

>>
>> I'm also wondering if turbo should be enabled when turbo_pass_ctl is less than
>> pstate.min_state.  Perhaps not?
>>
> This is too bad entry in that case. But we can disable the turbo.
>> > @@ -1272,6 +1279,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>> >
>> >  #if IS_ENABLED(CONFIG_ACPI)
>> >     cpu = all_cpu_data[policy->cpu];
>> > +   limits->min_perf_ctl = 0;
>> > +   limits->max_perf_ctl = 0;
>>
>> Wouldn't this re-introduce the problem fixed by commit 4ef451487019
>> (cpufreq: intel_pstate: Avoid calculation for max/min) in corner cases?
>
> If there is a match in _PSS, it will be correctly set in loop below.

Sure, but what if there isn't?  We'll end up with 0 and that may not
work (or the commit mentioned above was not necessary).

> In the current problem case we failed to match the _PSS for policy->max so
> we were relying on the max_perf calculation. But later some thermal
> issue happened, which reduced the policy to minimum. We stuck in that
> because limits->max_perf_ctl was not reset even after when policy
> changed to turbo max. With reset we should have used max pstate
> calculated value, which will not be as bad as last value.
>>
>> >     for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
>> >             int control;
>>
>> That whole loop is fragile.
> Could you suggest or submit a change for this?  Trying to do get max and
> min in one for-loop assuming not sorted.

I'll try to cut a patch for that tomorrow.

Thanks,
Rafael
