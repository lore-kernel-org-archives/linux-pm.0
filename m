From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Tue, 19 Jan 2016 22:52:22 +0100
Message-ID: <10535878.57N9JsXUl5@vostro.rjw.lan>
References: <1452533760-13787-19-git-send-email-juri.lelli@arm.com> <20160119191734.GB6357@twins.programming.kicks-ass.net> <20160119192111.GC6373@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47985 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932689AbcASVvk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 16:51:40 -0500
In-Reply-To: <20160119192111.GC6373@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Tuesday, January 19, 2016 08:21:11 PM Peter Zijlstra wrote:
> On Tue, Jan 19, 2016 at 08:17:34PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 19, 2016 at 04:01:55PM +0000, Juri Lelli wrote:
> > > Right, read path is fast, but write path still requires some sort of
> > > locking (malloc, copy and update). So, I'm wondering if this still pays
> > > off for a structure that gets written a lot.
> > 
> > No, not at all.
> > 

This is very similar to what I was thinking about, plus-minus a couple of
things.

> > struct cpufreq_driver *driver;
> > 
> > void sched_util_change(unsigned int util)
> > {
> > 	struct my_per_cpu_data *foo;
> > 
> > 	rcu_read_lock();
> 
> That should obviously be:
> 
> 	d = rcu_dereference(driver);
> 	if (d) {
> 		foo = __this_cpu_ptr(d->data);

If we do this, it would be convenient to define ->set_util() to take
foo as an arg too, in addition to util.

And is there any particular reason why d->data has to be per-cpu?

> 
> > 		if (abs(util - foo->last_util) > 10) {

Even if the utilization doesn't change, it still may be too high or too low,
so we may want to call foo->set_util() in that case too, at least once a
while.

> > 			foo->last_util = util;
> > 			foo->set_util(util);
> > 		}
> > 	}
> > 	rcu_read_unlock();
> > }
> > 
> > 
> > struct cpufreq_driver *cpufreq_flip_driver(struct cpufreq_driver *new_driver)
> > {
> > 	struct cpufreq_driver *old_driver;
> > 
> > 	mutex_lock(&cpufreq_driver_lock);
> > 	old_driver = driver;
> > 	rcu_assign_driver(driver, new_driver);
> > 	if (old_driver)
> > 		synchronize_rcu();
> > 	mutex_unlock(&cpufreq_driver_lock);
> > 
> > 	return old_driver;
> > }

We never need to do this, because we never replace one driver with another in
one go.  We need to go from a valid driver pointer to NULL and the other way
around only.

This means there may be other pointers around that may be accessed safely
from foo->set_util() above if there's a rule that they must be set before
the driver pointer and the data structures they point to must stay around
until the syncronize_rcu() returns.

Thanks,
Rafael

