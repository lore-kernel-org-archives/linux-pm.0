From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: sched-freq locking
Date: Thu, 21 Jan 2016 02:22:44 +0100
Message-ID: <2058083.HonoCMD469@vostro.rjw.lan>
References: <56984C30.8040402@linaro.org> <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com> <569EE1E1.3050407@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569EE1E1.3050407@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 19, 2016 05:24:49 PM Steve Muckle wrote:
> On 01/19/2016 03:40 PM, Michael Turquette wrote:
> > Right, this was _the_ original impetus behind the design decision to
> > muck around with struct cpufreq_policy in the hot path which goes al
> > the way back to v1.
> > 
> > An alternative thought is that we can make copies of the relevant bits
> > of struct cpufreq_policy that we do not expect too change often. These
> > will not require any locks as they are mostly read-only data on the
> > scheduler side of the interface. Or we could even go all in and just
> > make local copies of the struct directly, during the GOV_START
> > perhaps, with:
> 
> I believe this is a good first step as it avoids reworking a huge amount
> of locking and can get us to something functionally correct. It is what
> I had proposed earlier, copying the enabled CPUs and freq table in
> during the governor start callback. Unless there are objections to it
> I'll add it to the next schedfreq RFC.
> 
> > 
> ...
> > 
> > Well if we're going to try an optimize out every single false-positive
> > wakeup then I think that the cleanest long term solution would be
> > rework the per-policy locking around struct cpufreq_policy to use a
> > raw spinlock.
> 
> It would be nice if the policy lock was a spinlock but I don't know how
> easy that is. From a quick look at cpufreq there's a blocking notifier
> chain that's called with rwsem held, so it looks messy. Potentially long
> term indeed.
> 
> >> Also it'd be good I think to avoid building in an assumption that we'll
> >> never want to run solely in the fast (atomic) path. Perhaps ARM won't,
> >> and x86 may never use this, but it's reasonable to think another
> >> platform might come along which uses cpufreq and has the capability to
> >> kick off cpufreq transitions swiftly and without sleeping. Maybe ARM
> >> platforms will evolve to have that capability.
> > 
> > The current design of the cpufreq subsystem and its interfaces have
> > made this choice for us. sched-freq is just another consumer of
> > cpufreq, and until cpufreq's own locking scheme is improved then we
> > have no choice.
> 
> I did not word that very well - I should have said, we should avoid
> building in an assumption that we never want to try and run in the fast
> path.
> 
> AFAICS, once we've calculated that a frequency change is required we can
> down_write_trylock(&policy->rwsem) in the fast path and go ahead with
> the transition, if the trylock succeeds and the driver supports fast
> path transitions. We can fall back to the slow path (waking up the
> kthread) if that fails.
> 
> > This discussion is pretty useful. Should we Cc lkml to this thread?
> 
> Done (added linux-pm, PeterZ and Rafael as well).

Thanks!

One comment here (which may be a bit off in which case please ignore it).

You seem to be thinking that sched-freq needs to be a cpufreq governor
and thus be handled in the same way as ondemand, for example.

However, this doesn't have to be the case in principle.  For example,
if we have a special driver callback specifically to work with sched-freq,
it may just use that callback and bypass (almost) all of the usual
cpufreq mechanics.  This way you may avoid worrying about the governor
locking and related ugliness entirely.

Thanks,
Rafael
