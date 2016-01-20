From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Wed, 20 Jan 2016 18:04:48 +0100
Message-ID: <20160120170448.GO6357@twins.programming.kicks-ass.net>
References: <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160119191734.GB6357@twins.programming.kicks-ass.net>
 <20160119192111.GC6373@twins.programming.kicks-ass.net>
 <10535878.57N9JsXUl5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10535878.57N9JsXUl5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Juri Lelli <juri.lelli@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 19, 2016 at 10:52:22PM +0100, Rafael J. Wysocki wrote:
> This is very similar to what I was thinking about, plus-minus a couple of
> things.
> 
> > > struct cpufreq_driver *driver;
> > > 
> > > void sched_util_change(unsigned int util)
> > > {
> > > 	struct my_per_cpu_data *foo;
> > > 
> > > 	rcu_read_lock();
> > 
> > That should obviously be:
> > 
> > 	d = rcu_dereference(driver);
> > 	if (d) {
> > 		foo = __this_cpu_ptr(d->data);
> 
> If we do this, it would be convenient to define ->set_util() to take
> foo as an arg too, in addition to util.
> 
> And is there any particular reason why d->data has to be per-cpu?

Seems sensible, at best it actually is per cpu data, at worst this per
cpu pointer points to the same data for multiple cpus (the freq domain).

> > 
> > > 		if (abs(util - foo->last_util) > 10) {
> 
> Even if the utilization doesn't change, it still may be too high or too low,
> so we may want to call foo->set_util() in that case too, at least once a
> while.
> 
> > > 			foo->last_util = util;

Ah, the whole point of this was that ^^^ store.

Modifying the data structure doesn't need a new alloc / copy etc.. We
only use RCU to guarantee the data exists, once we have the data, the
data itself can be modified however.

Here its strictly per-cpu data, so modifying it can be unserialized
since CPUs themselves are sequentially consistent.

If you have a freq domain with multiple CPUs in, you'll have to go stick
a lock in.

> > > 			foo->set_util(util);
> > > 		}
> > > 	}
> > > 	rcu_read_unlock();
> > > }
> > > 
> > > 
> > > struct cpufreq_driver *cpufreq_flip_driver(struct cpufreq_driver *new_driver)
> > > {
> > > 	struct cpufreq_driver *old_driver;
> > > 
> > > 	mutex_lock(&cpufreq_driver_lock);
> > > 	old_driver = driver;
> > > 	rcu_assign_driver(driver, new_driver);
> > > 	if (old_driver)
> > > 		synchronize_rcu();
> > > 	mutex_unlock(&cpufreq_driver_lock);
> > > 
> > > 	return old_driver;
> > > }
> 
> We never need to do this, because we never replace one driver with another in
> one go.  We need to go from a valid driver pointer to NULL and the other way
> around only.

The above can do those transitions :-)

> This means there may be other pointers around that may be accessed safely
> from foo->set_util() above if there's a rule that they must be set before
> the driver pointer and the data structures they point to must stay around
> until the syncronize_rcu() returns.

I would dangle _everything_ off the one driver pointer, that's much
easier.
