From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Tue, 8 Mar 2016 19:00:57 +0100
Message-ID: <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
	<56D8AEB7.2050100@linaro.org>
	<36459679.vzZnOsAVeg@vostro.rjw.lan>
	<20160308112759.GF6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36234 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcCHSA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 13:00:59 -0500
In-Reply-To: <20160308112759.GF6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>

On Tue, Mar 8, 2016 at 12:27 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 07, 2016 at 03:41:15AM +0100, Rafael J. Wysocki wrote:
>
>> If my understanding of the requency invariant utilization idea is correct,
>> it is about re-scaling utilization so it is always relative to the capacity
>> at the max frequency.
>
> Right. So if a workload runs for 5ms at @1GHz and 10ms @500MHz, it would
> still result in the exact same utilization.
>
>> If that's the case, then instead of using
>>   x = util_raw / max
>> we will use something like
>>   y = (util_raw / max) * (f / max_freq) (f - current frequency).
>
> I don't get the last term.

The "(f - current frequency)" thing?  It doesn't belong to the
formula, sorry for the confusion.

So it is almost the same as your (1) below (except for the max in the
denominator), so my y is your x. :-)

> Assuming fixed frequency hardware (we can't
> really assume anything else) I get to:
>
>   util = util_raw * (current_freq / max_freq)           (1)
>   x = util / max                                        (2)
>
>> so there's no hope that the same formula will ever work for both "raw"
>> and "frequency invariant" utilization.
>
> Here I agree, however the above (current_freq / max_freq) term is easily
> computable, and really the only thing we can assume if the arch doesn't
> implement freq invariant accounting.

Right.

>> (c) Code for using either "raw" or "frequency invariant" depending on
>>     a callback flag or something like that.
>
> Seeing how frequency invariance is an arch feature, and cpufreq drivers
> are also typically arch specific, do we really need a flag at this
> level?

The next frequency is selected by the governor and that's why.  The
driver gets a frequency to set only.

Now, the governor needs to work with different platforms, so it needs
to know how to deal with the given one.

> In any case, I think the only difference between the two formula should
> be the addition of (1) for the platforms that do not already implement
> frequency invariance.

OK

So I'm reading this as a statement that linear is a better
approximation for frequency invariant utilization.

This means that on platforms where the utilization is frequency
invariant we should use

  next_freq = a * x

(where x is given by (2) above) and for platforms where the
utilization is not frequency invariant

  next_freq = a * x * current_freq / max_freq

and all boils down to finding a.

Now, it seems reasonable for a to be something like (1 + 1/n) *
max_freq, so for non-frequency invariant we get

  nex_freq = (1 + 1/n) * current_freq * x

> That is actually correct for platforms which do as told with their DVFS
> bits. And there's really not much else we can do short of implementing
> the scheduler arch hook to do better.
>
>> (b) Make all architecuters use "frequency invariant" and then look for a
>>     working formula (seems rather less than realistic to me to be honest).
>
> There was a proposal to implement arch_scale_freq_capacity() as a weak
> function and have it serve the cpufreq selected frequency for (1) so
> that everything would default to that.
>
> We didn't do that because that makes the function call and
> multiplications unconditional. It's cheaper to add (1) to the cpufreq
> side when selecting a freq rather than at every single time we update
> the util statistics.

That's fine by me.

My point was that we need different formulas for frequency invariant
and the other basically.
