From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Tue, 01 Mar 2016 23:49:10 -0800
Message-ID: <20160302074910.10178.35029@quark.deferred.io>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan> <56CF9D8F.7010607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33459 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcCBHtO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 02:49:14 -0500
Received: by mail-pf0-f175.google.com with SMTP id 124so67546747pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 23:49:14 -0800 (PST)
In-Reply-To: <56CF9D8F.7010607@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>

Hi,

I'm still catching up on the plurality of scheduler/cpufreq threads but
I thought I would chime in with some historical reasons for why
cpufreq_sched.c looks the way it does today.

Quoting Steve Muckle (2016-02-25 16:34:23)
> On 02/24/2016 07:55 PM, Rafael J. Wysocki wrote:
> > On Monday, February 22, 2016 05:22:43 PM Steve Muckle wrote:
> > Besides, governors traditionally go to drivers/cpufreq.  Why is this different?
> 
> This predates my involvement but I'm guessing this was done because the
> long term vision was for cpufreq to eventually be removed from the
> picture. But it may be quite some time before that happens - I think
> communicating directly with drivers may be difficult due to the need to
> synchronize with thermal or userspace min/max requests etc, plus there's
> the fact that we've got a longstanding API exposed to userspace.
> 
> I'm happy to move this to drivers/cpufreq.

Originally it was put in kernel/sched/ because cpufreq_sched.c needed
access to kernel/sched/sched.h. Rafael's implementation flips the
push-pull relationship between the governor and scheduler so that this
is not necessary. If that requirement is removed from Steve's series
then there is no need to put the file outside of drivers/cpufreq.

...
> > One thing I personally like in the RCU-based approach is its universality.  The
> > callbacks may be installed by different entities in a uniform way: intel_pstate
> > can do that, the old governors can do that, my experimental schedutil code can
> > do that and your code could have done that too in principle.  And this is very
> > nice, because it is a common underlying mechanism that can be used by everybody
> > regardless of their particular implementations on the other side.
> > 
> > Why would I want to use something different, then?
> 
> I've got nothing against a callback registration mechanism. As you
> mentioned in another mail it could itself use static keys, enabling the
> static key when a callback is registered and disabling it otherwise to
> avoid calling into cpufreq_update_util().

I'm very happy to see the return of capacity/util ops. I had these in my
initial prototype back in 2014 but Peter shot it down, partially due to
the performance hit of indirect function call overhead in the fast path:

http://permalink.gmane.org/gmane.linux.kernel/1803410

...
> >> +
> >> +/*
> >> + * Capacity margin added to CFS and RT capacity requests to provide
> >> + * some head room if task utilization further increases.
> >> + */
> > 
> > OK, where does this number come from?
> 
> Someone's posterior :) .

Indeed, this margin is based on a posterior-derived value, in particular
the 25% imbalance_pct in struct sched_domain:

include/linux/sched.h:
struct sched_domain {
        /* These fields must be setup */
        ...
        unsigned int imbalance_pct;     /* No balance until over watermark */
...

and,

kernel/sched/core.c:
static struct sched_domain *
sd_init(struct sched_domain_topology_level *tl, int cpu)
{
        struct sched_domain *sd = *per_cpu_ptr(tl->data.sd, cpu);
        ...
        sd = (struct sched_domain){
                .min_interval           = sd_weight,
                .max_interval           = 2*sd_weight,
                .busy_factor            = 32,
                .imbalance_pct          = 125,
...

> 
> This really should be a tunable IMO, but there's a fairly strong
> anti-tunable sentiment, so it's been left hard-coded in an attempt to
> provide something that "just works."

It should definitely be tunable.

> 
> At the least I can add a comment saying that the 20% idle headroom
> requirement was an off the cuff estimate and that at this time, we don't
> have significant data to suggest it's the best number.

Yeah, it was just for prototyping.

...
> > Now, what really is the advantage of having those extra threads vs using
> > workqueues?

More historical anecdotes: The RT/DL stuff below is absolutely worth
talking about, but if your question is, "why did the design choose
kthreads over wq's", the answer is legacy.

Originally back in 2014 Morten played with queuing work up via wq within
schedule() context, but hit a problem where that caused re-entering
schedule() from schedule() and entering reentrancy hell and entering
reentrancy hell and entering reentrancy hell and entering reentrancy
hell ... well you get the idea.

I came up with an ugly workaround to wake up a dormant kthread with
wake_up_process() which was called from an arch-specific callback to
change cpu frequency and later Juri suggested to use irq_work to kick
the kthread, which is still the method used in Steve's patch series.

Seems that it is fine to toss work onto a workqueue from irq_work
context however, which is nice, except that the RT thread approach
yields better latency. I'll let you guys sort out the issues around
RT/DL starvation, which seems like a real issue.

> > 
> > I guess the underlying concern is that RT tasks may stall workqueues indefinitely
> > in theory and then the frequency won't be updated, but there's much more kernel
> > stuff run from workqueues and if that is starved, you won't get very far anyway.
> > 
> > If you take special measures to prevent frequency change requests from being
> > stalled by RT tasks, question is why are they so special?  Aren't there any
> > other kernel activities that also should be protected from that and may be
> > more important than CPU frequency changes?
> 
> I think updating the CPU frequency during periods of heavy RT/DL load is
> one of the most (if not the most) important things. I can't speak for
> other system activities that may get blocked, but there's an opportunity
> to protect CPU frequency changes here, and it seems worth taking to me.
> 
> > 
> > Plus if this really is the problem here, then it also affects the other cpufreq
> > governors, so maybe it should be solved for everybody in some common way?
> 
> Agreed, I'd think a freq change thread that serves frequency change
> requests would be a useful common component. The locking and throttling
> (slowpath_lock, finish_last_request()) are somewhat specific to this
> implementation, but could probably be done generically and maybe even
> used in other governors. If you're okay with it though I'd like to view
> that as a slightly longer term effort, as I think it would get unwieldy
> trying to do that as part of this initial change.

I do not have any data to back up a case for stalls caused by RT/DL
starvation, but conceptually I would say that latency is fundamentally
more important in a scheduler-driven cpu frequency selection scenario,
versus the legacy timer-based governors.

In the latter case we get woken up by a timer (prior to Rafael's recent
"cpufreq: governor: Replace timers with utilization update callbacks"
patch), we sample idleness/busyness, and change frequency, all in one go
and all from process context.

In the case of the scheduler selecting frequency in the hot path, with
hardware that takes a long time to transition frequency (and thus must
be done in a slow path), we want to minimize the time delta between the
scheduler picking a frequency and the thread that executes that change
actually being run.

In my over-simplified view of the scheduler, it would be great if we
could have a backdoor mechanism to place the frequency transition
kthread onto a runqueue from within the schedule() context and dispense
with the irq_work stuff in Steve's series altogether.

Regards,
Mike
