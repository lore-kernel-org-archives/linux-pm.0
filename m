From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Tue, 19 Jan 2016 20:21:11 +0100
Message-ID: <20160119192111.GC6373@twins.programming.kicks-ass.net>
References: <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
 <20160119140036.GG6344@twins.programming.kicks-ass.net>
 <20160119144233.GG8573@e106622-lin>
 <20160119153007.GZ6357@twins.programming.kicks-ass.net>
 <20160119160155.GH8573@e106622-lin>
 <20160119191734.GB6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37879 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745AbcASTVO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 14:21:14 -0500
Content-Disposition: inline
In-Reply-To: <20160119191734.GB6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Tue, Jan 19, 2016 at 08:17:34PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 19, 2016 at 04:01:55PM +0000, Juri Lelli wrote:
> > Right, read path is fast, but write path still requires some sort of
> > locking (malloc, copy and update). So, I'm wondering if this still pays
> > off for a structure that gets written a lot.
> 
> No, not at all.
> 
> struct cpufreq_driver *driver;
> 
> void sched_util_change(unsigned int util)
> {
> 	struct my_per_cpu_data *foo;
> 
> 	rcu_read_lock();

That should obviously be:

	d = rcu_dereference(driver);
	if (d) {
		foo = __this_cpu_ptr(d->data);

> 		if (abs(util - foo->last_util) > 10) {
> 			foo->last_util = util;
> 			foo->set_util(util);
> 		}
> 	}
> 	rcu_read_unlock();
> }
> 
> 
> struct cpufreq_driver *cpufreq_flip_driver(struct cpufreq_driver *new_driver)
> {
> 	struct cpufreq_driver *old_driver;
> 
> 	mutex_lock(&cpufreq_driver_lock);
> 	old_driver = driver;
> 	rcu_assign_driver(driver, new_driver);
> 	if (old_driver)
> 		synchronize_rcu();
> 	mutex_unlock(&cpufreq_driver_lock);
> 
> 	return old_driver;
> }
> 
> 
> 
