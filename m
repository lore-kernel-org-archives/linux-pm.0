From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Sun, 6 Mar 2016 03:17:09 +0100
Message-ID: <CAJZ5v0je8158B9jjbMU1MMPyduZXaao7sKhAniq4TPVfTb3JQA@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<15684081.T4iOMUSHCY@vostro.rjw.lan>
	<56DA09B1.4010005@linaro.org>
	<CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
	<CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
	<CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
	<20160305164900.GX6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35318 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbcCFCRM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Mar 2016 21:17:12 -0500
In-Reply-To: <20160305164900.GX6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Sat, Mar 5, 2016 at 5:49 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Mar 05, 2016 at 12:18:54AM +0100, Rafael J. Wysocki wrote:
>
>> >>> Even if there are platforms which may change the CPU frequency behind
>> >>> cpufreq's back, breaking the transition notifiers, I'm worried about the
>> >>> addition of an interface which itself breaks them. The platforms which
>> >>> do change CPU frequency on their own have probably evolved to live with
>> >>> or work around this behavior. As other platforms migrate to fast
>> >>> frequency switching they might be surprised when things don't work as
>> >>> advertised.
>
> There's only 43 sites of cpufreq_register_notifier in 37 files, that
> should be fairly simple to audit.
>
>> >>> I'm not sure what the easiest way to deal with this is. I see the
>> >>> transition notifiers are the srcu type, which I understand to be
>> >>> blocking. Going through the tree and reworking everyone's callbacks and
>> >>> changing the type to atomic is obviously not realistic.
>> >>
>> >> Right.
>
> Even if it was (and per the above it looks entirely feasible), that's
> just not going to happen. We're not ever going to call random notifier
> crap from this deep within the scheduler.
>
>> >>> How about modifying cpufreq_register_notifier to return an error if the
>> >>> driver has a fast_switch callback installed and an attempt to register a
>> >>> transition notifier is made?
>> >>
>> >> That sounds like a good idea.
>
> Agreed, fail the stuff hard.
>
> Simply make cpufreq_register_notifier a __must_check function and add
> error handling to all call sites.

Quite frankly, I don't see a compelling reason to do anything about
the notifications at this point.

The ACPI driver is the only one that will support fast switching for
the time being and on practically all platforms that can use the ACPI
driver the transition notifications cannot be relied on anyway for a
few reasons.  First, if intel_pstate or HWP is in use, they won't be
coming at all.  Second, anything turbo will just change frequency at
will without notifying (like HWP).  Finally, if they are coming,
whoever receives them is notified about the frequency that is
requested and not the real one, which is misleading, because (a) the
request may just make the CPU go into the turbo range and then see
above or (b) if the CPU is in a platform-coordinated package, its
request will only be granted if it's the winning one.

>> > I guess what might be done would be to spawn a work item to carry out
>> > a notify when the frequency changes.
>>
>> In fact, the mechanism may be relatively simple if I'm not mistaken.
>>
>> In the "fast switch" case, the governor may spawn a work item that
>> will just execute cpufreq_get() on policy->cpu.  That will notice that
>> policy->cur is different from the real current frequency and will
>> re-adjust.
>>
>> Of course, cpufreq_driver_fast_switch() will need to be modified so it
>> doesn't update policy->cur then perhaps with a comment that the
>> governor using it will be responsible for that.
>
> No no no, that's just horrible. Why would you want to keep this
> notification stuff alive? If your platform can change frequency 'fast'
> you don't want notifiers.

I'm not totally sure about that.

>
> What's the point of a notification that says: "At some point in the
> random past my frequency has changed, and it likely has changed again
> since then, do 'something'."
>
> That's pointless. If you have dependent clock domains or whatever, you
> simply _cannot_ be fast.
>

What about thermal?  They don't need to get very accurate information,
but they need to be updated on a regular basis.  It would do if they
get averages instead of momentary values (and may be better even).
