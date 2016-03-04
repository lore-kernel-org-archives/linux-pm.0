From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Fri, 4 Mar 2016 23:32:22 +0100
Message-ID: <CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<15684081.T4iOMUSHCY@vostro.rjw.lan>
	<56DA09B1.4010005@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34809 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707AbcCDWcY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 17:32:24 -0500
In-Reply-To: <56DA09B1.4010005@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Fri, Mar 4, 2016 at 11:18 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 03/03/2016 07:07 PM, Rafael J. Wysocki wrote:
>> +void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>> +                             unsigned int target_freq, unsigned int relation)
>> +{
>> +     unsigned int freq;
>> +
>> +     freq = cpufreq_driver->fast_switch(policy, target_freq, relation);
>> +     if (freq != CPUFREQ_ENTRY_INVALID) {
>> +             policy->cur = freq;
>> +             trace_cpu_frequency(freq, smp_processor_id());
>> +     }
>> +}
>
> Even if there are platforms which may change the CPU frequency behind
> cpufreq's back, breaking the transition notifiers, I'm worried about the
> addition of an interface which itself breaks them. The platforms which
> do change CPU frequency on their own have probably evolved to live with
> or work around this behavior. As other platforms migrate to fast
> frequency switching they might be surprised when things don't work as
> advertised.

Well, intel_pstate doesn't do notifies at all, so anything depending
on them is already broken when it is used.  Let alone the hardware
P-states coordination mechanism (HWP) where the frequency is
controlled by the processor itself entirely.

That said I see your point.

> I'm not sure what the easiest way to deal with this is. I see the
> transition notifiers are the srcu type, which I understand to be
> blocking. Going through the tree and reworking everyone's callbacks and
> changing the type to atomic is obviously not realistic.

Right.

> How about modifying cpufreq_register_notifier to return an error if the
> driver has a fast_switch callback installed and an attempt to register a
> transition notifier is made?

That sounds like a good idea.

There also is the CPUFREQ_ASYNC_NOTIFICATION driver flag that in
principle might be used as a workaround, but I'm not sure how much
work that would require ATM.

> In the future, perhaps an additional atomic transition callback type can
> be added, which platform/driver owners can switch to if they wish to use
> fast transitions with their platform.

I guess you mean an atomic notification mechanism based on registering
callbacks?  While technically viable that's somewhat risky, because we
are in a fast path and allowing anyone to add stuff to it would be
asking for trouble IMO.

Thanks,
Rafael
