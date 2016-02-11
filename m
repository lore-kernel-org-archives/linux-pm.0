From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 21:47:27 +0100
Message-ID: <CAJZ5v0ica14-=iGSUW2krOQnd9-fiG24AXvn7wL97F5EfGwKzQ@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<20160211115157.GH6357@twins.programming.kicks-ass.net>
	<CAJZ5v0ju1vSf4moYmpPZu2dyhPaLpn++P6PBwCVN1tupp1_jFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36039 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbcBKUr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 15:47:29 -0500
In-Reply-To: <CAJZ5v0ju1vSf4moYmpPZu2dyhPaLpn++P6PBwCVN1tupp1_jFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Doug Smythies <dsmythies@telus.net>

On Thu, Feb 11, 2016 at 1:08 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Feb 11, 2016 at 12:51 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Tue, Feb 09, 2016 at 09:05:05PM +0100, Rafael J. Wysocki wrote:
>>> > > One concern I had was, given that the lone scheduler update hook is in
>>> > > CFS, is it possible for governor updates to be stalled due to RT or DL
>>> > > task activity?
>>> >
>>> > I don't think they may be completely stalled, but I'd prefer Peter to
>>> > answer that as he suggested to do it this way.
>>>
>>> In any case, if that concern turns out to be significant in practice, it may
>>> be addressed like in the appended modification of patch [1/3] from the $subject
>>> series.
>>>
>>> With that things look like before from the cpufreq side, but the other sched
>>> classes also get a chance to trigger a cpufreq update.  The drawback is the
>>> cpu_clock() call instead of passing the time value from update_load_avg(), but
>>> I guess we can live with that if necessary.
>>>
>>> FWIW, this modification doesn't seem to break things on my test machine.
>>
>> Not really pretty though. It blows a bit that you require this callback
>> to be periodic (in order to replace a timer).
>
> We need it for now, but that's because of how things work on the cpufreq side.

In fact, I don't need the new callback to be invoked periodically.  I
only need it to be called often enough, where "enough" means at least
once in every sampling interval (for the lack of a better name) on the
rough average.  Less often than that may be kind of OK too depending
on the case.

I guess I need to explain that in more detail, though, at least for
the record if not anything else, so let me do that.

To start with let me note that things in cpufreq don't happen
periodically even today with timers, because all of those timers are
deferrable, so you never know when you'll get the next update
realistically.  We try to compensate for that in a kind of poor man's
way (which may be a source of problems by itself as mentioned by
Doug), but that's a band-aid rather.

With that in mind, there are two cases, the intel_pstate case and the
ondemand/conservative governor case.

intel_pstate is simpler, because it can do everything it needs in the
new callback (or in a timer function previously).  Periodicity might
matter to it, but it only uses two last points in its computations,
the current one and the previous one.  Thus it is not that important
how long the particular interval is.  Of course, if it is way too
long, we may miss some intermediate peaks and valleys and if the peaks
are intermittent enough, people may see poor performance.  In
practice, though, it turns out that the new callback is invoked (even
from CFS alone) much more frequently than we need on the average, so
we apply a "sample delay" rate limit to it.

In turn, the ondemand/conservative governor case is outright
ridiculous, because they don't even compute anything in the callback
(or a timer function previously).  They simply use it to spawn a work
item in process context that will estimate the "utilization" and
possibly change the P-state.  That may be delayed by the scheduling
interval, then pushed back by RT tasks and so on, so the time between
the moment they decide to take a "sample" and the moment that actually
happens may be, well, arbitrary.  So really timers are used here to
poke at things on a regular basis rather than for any actually
periodic stuff.

That may be improved in two ways in principle.  First, by moving as
much as we can into the utilization update callback without adding too
much overhead to the scheduler path.  Governor computations are the
primary candidate for that.  They need to take all of the tunables
accessible from user space into account, but that shouldn't be a big
problem.  We may be able to call at least some drivers from there too
(even the ACPI driver may be able to switch P-states via register
writes in some cases).  The second way would be to use the utilization
numbers provided by the scheduler for making governor decisions.

If we can do both, we should be much better off than we are today
already, even without the EAS stuff.

Thanks,
Rafael
