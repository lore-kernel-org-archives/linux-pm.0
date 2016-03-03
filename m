From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 0/1] cpufreq: New governor based on
 scheduler-provided utilization data
Date: Thu, 3 Mar 2016 18:15:34 +0100
Message-ID: <CAJZ5v0gcNGYAqCrLofMOUzYbgfNZVmPELspt-bLoa-RoTbzDHA@mail.gmail.com>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
	<20160303142709.GB10948@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35772 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcCCRPg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 12:15:36 -0500
In-Reply-To: <20160303142709.GB10948@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Mar 3, 2016 at 3:27 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> So I wanted to give you some feedback for this, from the scheduler maintainer's
> POV.
>
> Looks like there are two cpufreq modernization efforts, one is this series, the
> other is Steve Muckle's:
>
>   [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency selection
>
> What I'd like to see from a scheduler metrics usage POV is a single central place,
> kernel/sched/cpufreq.c, where all the high level ('governor') decisions are made.
> This is the approach Steve's series takes.

The difference between this series and the Steve's one in that respect
is only the place where the new governor goes.  I can put it into
kernel/sched/ if you want me to, but it still will depend on some
things under drivers/cpufreq/.

> That is a central point that has ready access to the scheduler internal
> utilization metrics.
>
> drivers/cpufreq/ would contain legacy governors plus low level drivers that do
> frequency switching with a well-defined interface.
>
> Could you guys work out a single series that implements the sum of the two series?
> Looks like we are 90% 'there' already.

I'd like to have a clear picture of what you want here, so let me use
the opportunity to ask you about things.

I've CCed you on many occasions during this discussion and you have
been silent till now, so I have assumed that you have no objections.
>From what you're saying now, it looks like that may not be the case,
though.

I have a bunch of changes queued up for the next cycle that depend on
things in cpufreq in general to be called from the scheduler on a
regular basis instead of using timers.  There are two reasons for
that: first, having to set up a timer for every CPU every 10 ms or so
is quite a bit of overhead and Thomas doesn't like that from the timer
wheel management perspective and, second, getting rid of those timers
allows quite some irritating bugs in cpufreq to be fixed.  That's why
there is a metric ton of cpufreq cleanups and fixes on top of that in
my tree.

However, that requires an interface for cpufreq governors to provide
callbacks to be invoked from the scheduler.  Peter suggested to me how
that could be done and those callbacks get the scheduler utilization
numbers as arguments.  From what you're saying now it seems to me that
you may not agree with that approach.  It looks like you would prefer
it if the utilization numbers were not passed to those callbacks
unless they have been provided by the new "scheduler" governor which
then would reside under kernel/sched/, so there's a clear interface
separation between the "old style" cpufreq governors and the
scheduler.

Am I reading this correctly?

Thanks,
Rafael
