From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Thu, 6 Jul 2017 11:16:54 +0530
Message-ID: <20170706054654.GQ3532@vireshk-i7>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com>
 <20170705045012.GM3532@vireshk-i7>
 <20170705130446.GC2659@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36447 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdGFFq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 01:46:59 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so5820991pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Jul 2017 22:46:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705130446.GC2659@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 05-07-17, 14:04, Patrick Bellasi wrote:
> On 05-Jul 10:20, Viresh Kumar wrote:
> > And also why is it important to write 0 to sg_cpu->flags ? What wouldn't work if
> > we set sg_cpu->flags to SCHED_CPUFREQ_IDLE in this case ? i.e. Just the below
> > statement should be good for us.
> 
> Let say flags have the RT/DL flag set when the RT task sleep, is there
> any specific reason to keep this flag up while the CPU is IDLE?
> IOW, why should we care about an information related to an even which
> is now over?

Maybe I wasn't able to communicate what I wanted to say, but I am not asking you
to keep RT/DL flags as is, but rather set the flags variable to
SCHED_CPUFREQ_IDLE (1 << 3). My concerns were about adding an additional
conditional statement here, while we can live without one.

> The proposal of this patch is just meant to make sure that the flags,
> being a state variable, always describe the current status of the
> sugov "state machine".
> If a CPU is IDLE there are not sensible events going on and thus flags
> should better be reset.

or set to SCHED_CPUFREQ_IDLE.

> > This looks correct.
> > 
> > Can we completely avoid the utilization contribution of the CPUs which have gone
> > idle? Right now we avoid them with help of (delta_ns > TICK_NSEC). Can we
> > instead check this SCHED_CPUFREQ_IDLE flag ?
> 
> I would say that the blocked utilization of an IDLE CPU is still worth
> to be considered, at least for a limited amount of time, for few main
> reasons:
> 
> 1. it represents CPU bandwidth that is likely to be required by a task
>    which can wakeup in a short while. Consider for example an 80% task
>    activated every 16ms: even if it's not running right now it's
>    likely to wakeup in the next ~3ms to run for the following ~13ms.
>    Thus, we should probably better consider that CPU utilization.
> 
> 2. we already have policies to gratefully reduce the current OPP if
>    its utilization decrease. This means that we are interested in a
>    sort of policy which favors higher OPPs to avoid impacting
>    performance of tasks which suddenly wakeup.
>  
> 3. A CPU entering IDLE is not a great source of new information
>    for OPP selection, I would not strictly bind an OPP change to this
>    event. That's also why this patch propose to clear the flags
>    without actually triggering an OPP change.
> 
> Moreover, maybe the issue you are trying to solve it's more related to
> having a stale utilization for an IDLE CPUs?

I wasn't trying to solve any issue here, but just discussing about what should
we do here. Yeah it seems fair to keep the utilization of the idle CPU for
another TICK, after which we are ignoring it anyway.

-- 
viresh
