From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their locks
Date: Tue, 12 Jan 2016 17:47:55 +0100
Message-ID: <2217844.KCH1R2Lmsr@vostro.rjw.lan>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com> <1926777.mcNa33svoL@vostro.rjw.lan> <20160112082718.GN6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160112082718.GN6344@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 12, 2016 09:27:18 AM Peter Zijlstra wrote:
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
> But such a callback will invariably want to use the per-cpu state.

Which likely is the driver's own per-cpu state, not the policy object itself.

> And now you have two pointers, one for the driver and one for the per-cpu
> state. Keeping that in sync is a pain.

Well, I basically need to guarantee that all of the pointers involved are set
and the data structures are valid when the driver pointer is set.

> Moving the per-cpu data into the driver solves that trivially.

It doesn't really address the case when the driver has its own per-cpu state
as I said above.

Thanks,
Rafael
