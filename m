From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Thu, 14 Jan 2016 09:44:31 +0000
Message-ID: <20160114094431.GF18603@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160113182131.1168.45753@quark.deferred.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 13/01/16 10:21, Michael Turquette wrote:
> Hi Viresh,
> 
> Quoting Viresh Kumar (2016-01-12 22:31:48)
> > On 12-01-16, 16:54, Michael Turquette wrote:
> > > __cpufreq_driver_target should be using a per-policy lock.
> > 
> > It doesn't :)
> 
> It should.
> 
> A less conceited response is that a per-policy lock should be held
> around calls to __cpufreq_driver_target. This can obviously be done by
> cpufreq_driver_target (no double underscore), but there are quite a few
> drivers that call __cpufreq_driver_target, and since we're touching the
> policy structure we need a lock around it.
> 

Agree, we should enforce the rule that everything that touches policy
structure has to lock it before.

> Juri's cover letter did not explicitly state my original, full intention
> for the patches I was working on. I'll spell that out below and
> hopefully we can gather consensus around it before moving forward. Juri,
> I'm implicitly assuming that you agree with the stuff below, but please
> correct me if I am wrong.

Right. I decided to post with this RFC only a subset of the patches we
came up with because I needed to build some more confidence with the
subsystem I was going to propose changes for. Review comments received
are helping me on that front. I didn't mention at all next steps (RCU)
because I wanted to focus on understanding and documenting, and maybe
fixing where required, the current status, before we change it.

> The original idea for overhauling the locking
> in cpufreq is to use two locks:
> 
> 1) per-policy lock (my patches were using a mutex), which is the only
> lock that needs to be touched during a frequency transition. We do not
> want any lock contention between policy's during freq transition. For
> read-side operation this locking scheme should utilize RCU so that the
> scheduler can safely access the values in struct cpufreq_policy within
> it's schedule() context. [a note on RCU below]
> 
> 2) a single, framework-wide lock (my patches were using a mutex) that
> handles all of the other synchronization: governor events, driver events
> and anything else that does not happen on a per-policy basis. I don't
> think RCU is necessary for this. These operations are all slow-path ones
> so reducing the mess of 6-ish locks in cpufreq.c and friends down to a
> single mutex simplifies things greatly, eliminates the "drop the lock
> here for a few instructions" hacks and generally makes things more
> readable.
> 

This is basically what I also have on top of this series. I actually
went for RCUs also for 2, but yes, that's maybe overkilling.

A comment on 1 above, and something on which I got stuck upon for some
time, is that, if we implement RCU logic as it is supposed to be, I
think we can generate a lot of copy-update operations when changing
frequency (as policy structure needs to be changed). Also, we might read
stale data. So, I'm not sure this will pay off. However, I tried to get
around this problem and I guess we will discuss if 1 is doable in the
next RFC :-).

> A quick note on RCU and the scheduler-driven DVFS stuff: RCU only helps
> us on read-side operations. For the purposes of sched-dvfs, this means
> that when we look at capacity utilization and want to normalize
> frequency based on that, we need to access the per-policy structure in a
> lockless way. RCU makes this possible.
> 
> RCU is absolutely not a magic bullet or elixir that lets us kick off
> DVFS transitions from the schedule() context. The frequency transitions
> are write-side operations, as we invariably touch struct cpufreq_policy.
> This means that the read-side stuff can live in the schedule() context,
> but write-side needs to be kicked out to a thread.
> 

Correct. We will still need the kthread machinery even after this
changes.

Thanks for clarifying things!

Best,

- Juri
