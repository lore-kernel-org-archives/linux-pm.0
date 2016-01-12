From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Tue, 12 Jan 2016 10:43:04 +0000
Message-ID: <20160112104304.GB11451@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
 <20160111220528.GJ6344@twins.programming.kicks-ass.net>
 <1926777.mcNa33svoL@vostro.rjw.lan>
 <20160112082718.GN6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33340 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbcALKmm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 05:42:42 -0500
Content-Disposition: inline
In-Reply-To: <20160112082718.GN6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

Hi,

On 12/01/16 09:27, Peter Zijlstra wrote:
> On Tue, Jan 12, 2016 at 12:03:39AM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 11, 2016 11:05:28 PM Peter Zijlstra wrote:
> > > On Mon, Jan 11, 2016 at 05:35:45PM +0000, Juri Lelli wrote:
> > > > +/**
> > > > + * The "cpufreq driver" - the arch- or hardware-dependent low
> > > > + * level driver of CPUFreq support, and its spinlock (cpufreq_driver_lock).
> > > > + * This lock also protects cpufreq_cpu_data array and cpufreq_policy_list.
> > > > + */
> > > > +static struct cpufreq_driver *cpufreq_driver;
> > > > +static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
> > > >  static LIST_HEAD(cpufreq_policy_list);
> > > > +static DEFINE_RWLOCK(cpufreq_driver_lock);
> > > 
> > > Part of my suggestion was to fold the per-cpu data of cpufreq_cpu_data
> > > into struct cpufreq_driver.
> > > 
> > > That way each cpufreq_driver will have its own copy and there'd be only
> > > the one global pointer to swizzle. Something very well suited to RCU.
> > 
> > Well, I'm not really sure reworking all that is necessary.
> > 
> > What we need is to be able to call something analogous to dbs_timer_handler()
> > from the scheduler and a driver callback from there (if present).  For that,
> > it should be sufficient to have a pointer to that callback (that may be set
> > upon driver registration) protected by RCU (or should that be sched RCU
> > rather?) if I'm not missing anything.
> 
> But such a callback will invariably want to use the per-cpu state. And
> now you have two pointers, one for the driver and one for the per-cpu
> state. Keeping that in sync is a pain.
> 
> Moving the per-cpu data into the driver solves that trivially.
> 

Oh, I think I now finally get your suggestion completely (I hope :-));
and it makes sense to me. On top of this series I have patches that
implement RCU logic. What I tried to do is to protect all cpufreq.c
stuff with a single mutex (plus RCU logic) and single policies with
another mutex (plus RCU logic). What you are saying should make things
easier to get right. I have to go back and try that.

My idea was to try to build some confidence that this first set is right
and then post the second part implementing RCU logic. 

Thanks,

- Juri
