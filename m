From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Wed, 20 Jan 2016 12:59:54 +0000
Message-ID: <20160120125954.GT8573@e106622-lin>
References: <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
 <20160119140036.GG6344@twins.programming.kicks-ass.net>
 <20160119144233.GG8573@e106622-lin>
 <20160119153007.GZ6357@twins.programming.kicks-ass.net>
 <20160119160155.GH8573@e106622-lin>
 <20160119191734.GB6357@twins.programming.kicks-ass.net>
 <20160119192111.GC6373@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119192111.GC6373@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 19/01/16 20:21, Peter Zijlstra wrote:
> On Tue, Jan 19, 2016 at 08:17:34PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 19, 2016 at 04:01:55PM +0000, Juri Lelli wrote:
> > > Right, read path is fast, but write path still requires some sort of
> > > locking (malloc, copy and update). So, I'm wondering if this still pays
> > > off for a structure that gets written a lot.
> > 
> > No, not at all.
> > 
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
> 
> > 		if (abs(util - foo->last_util) > 10) {
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
> > 
> > 
> > 
> 

Right, this addresses the driver side (modulo what Rafael pointed out
about setting driver pointer to NULL and then to point to the new
driver); and for this part I think RCU works well. I'm not concerned
about the driver side :).

Now, assuming that we move cpufreq_cpu_data inside cpufreq_driver (IIUC
this is your d->data), we will have per_cpu pointers pointing to the
different policies. Inside these policy data structures we have
information regarding current frequency, maximum allowed frequency, cpus
covered by this policy, and a few more. IIUC this is your foo thing.
Since the structure pointed to by foo will be shared amongs several
cpus, we need some way to guarantee mutual exclusion and such. I think
we were thinking to use RCU for this bit as well and that is what I'm
concerned about, as curr frequency will change at every frequency
transition.

Maybe you are also implying that we need to change cpufreq_cpu_data as
well. I need to think more about that.
