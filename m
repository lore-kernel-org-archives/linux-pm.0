From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: sched-freq locking
Date: Wed, 20 Jan 2016 12:18:01 +0000
Message-ID: <20160120121801.GR8573@e106622-lin>
References: <56984C30.8040402@linaro.org>
 <20160115104051.GP18603@e106622-lin>
 <569D568D.5000500@linaro.org>
 <CAEG3pNDoDHpgO7WdC8n7C8Ri+KNKZqOi9rKHMkTV0c5dkyevOw@mail.gmail.com>
 <CAKfTPtCYUWBm_=GQ-NLLZ01xJqG+83vy4uapxRLjqMx_61HSew@mail.gmail.com>
 <569E90CF.9050503@linaro.org>
 <CAEG3pND5kHqJhrvwVjsnCnfT-nSrV8SrUaNk2p=ZfEx0MmmB=A@mail.gmail.com>
 <569EB225.4040707@linaro.org>
 <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
 <569EE1E1.3050407@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44968 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbcATMRd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Jan 2016 07:17:33 -0500
Content-Disposition: inline
In-Reply-To: <569EE1E1.3050407@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

[+Punit, Javi]

Hi,

On 19/01/16 17:24, Steve Muckle wrote:
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

I fear that caching could break thermal. If everybody was already using
sched-freq interface to control frequency this won't probably be a
problem, but we are not yet there :(. So, IIUC by caching policy->max,
for example, we might affect what thermal expects from cpufreq.

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

Right. Blocking notifiers are one problem, as I was saying to Peter
yesterday.

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
> 

This discussion is pretty interesting, yes. I'm a bit afraid people
bumped into this might have troubles understanding context, though.
And I'm not sure how to give them that context; maybe start a new thread
summarizing what has been discussed so far?

Best,

- Juri
