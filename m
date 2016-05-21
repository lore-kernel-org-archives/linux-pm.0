From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 3/5] sched: cpufreq: call cpufreq hook from remote CPUs
Date: Sat, 21 May 2016 12:46:06 -0700
Message-ID: <20160521194606.GG15383@graphite.smuckle.net>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
 <1462828814-32530-4-git-send-email-smuckle@linaro.org>
 <CAJZ5v0iWfc=cNaCVuQ9QLK0FMLy1i5zEVcZSutOAK=+1OxaRtg@mail.gmail.com>
 <CAJZ5v0i-9QhNt1o_MN9_kEut6vs53-nwkM44dYq8hnuxynn4eQ@mail.gmail.com>
 <20160519191916.GE17223@graphite.smuckle.net>
 <CAJZ5v0hu=6sp=p+jYXfesSC20ZfKcGL6f5fTpvC+RX1uAEbn=A@mail.gmail.com>
 <20160519230419.GB15383@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34944 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbcEUTqL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 15:46:11 -0400
Received: by mail-pa0-f49.google.com with SMTP id tb2so32739747pac.2
        for <linux-pm@vger.kernel.org>; Sat, 21 May 2016 12:46:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160519230419.GB15383@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

Hi Peter, Ingo,

On Thu, May 19, 2016 at 04:04:19PM -0700, Steve Muckle wrote:
> On Thu, May 19, 2016 at 11:06:14PM +0200, Rafael J. Wysocki wrote:
> > > In the case of a remote update the hook has to run (or not) after it is
> > > known whether preemption will occur so we don't do needless work or
> > > IPIs. If the policy CPUs aren't known in the scheduler then the early
> > > hook will always need to be called along with an indication that it is
> > > the early hook being called. If it turns out to be a remote update it
> > > could then be deferred to the later hook, which would only be called
> > > when a remote update has been deferred and preemption has not occurred.
> > >
> > > This means two hook inovcations for a remote non-preempting wakeup
> > > though instead of one.  Perhaps this is a good middle ground on code
> > > churn vs. optimization though.
> > 
> > I would think so.
> 
> Ok, I will pursue this approach.

I'd like to get your opinion here before proceeding further...

To catch you up and summarize, I'm trying to implement support for
calling the scheduler cpufreq callback during remote wakeups.  Currently
the scheduler cpufreq callback is only called when the target CPU is the
current CPU. If a remote wakeup does not result in preemption, the CPU
frequency may currently not be adjusted appropriately for up to a tick,
when we are guaranteed to call the hook again.

Invoking schedutil promptly for the target CPU in this situation means
sending an IPI if the current CPU is not in the target CPU's frequency
domain. This is because often a cpufreq driver must run on a CPU within
the frequency domain it is bound to.  But the catch is that we should
not do this and incur the overhead of an IPI if preemption will occur,
as in that case the scheduler (and schedutil) will run soon on the
target CPU anyway, potentially as a result of the scheduler sending its
own IPI.

I figured this unnecessary overhead would be unacceptable and so have
been working on an approach to avoid it. Unfortunately the current hooks
happen before the preemption decision is made. My current implementation
sets a flag if schedutil sees a remote wakeup and then bails. There's a
test to call the hook again at the end of check_preempt_curr() if the flag
is set.  The flag is cleared by resched_curr() as that means preemption
will happen on the target CPU. The flag currently lives at the end of
the rq struct. I could move it into the update_util_data hook structure
or elsewhere, but that would mean accessing another per-cpu item in
hot scheduler paths.

Thoughts? Note the current implementation described above differs a bit
from the last posting in this thread, per discussion with Rafael.

thanks,
Steve
