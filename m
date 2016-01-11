From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their locks
Date: Tue, 12 Jan 2016 00:03:39 +0100
Message-ID: <1926777.mcNa33svoL@vostro.rjw.lan>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com> <1452533760-13787-5-git-send-email-juri.lelli@arm.com> <20160111220528.GJ6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53964 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753955AbcAKXDJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 18:03:09 -0500
In-Reply-To: <20160111220528.GJ6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Monday, January 11, 2016 11:05:28 PM Peter Zijlstra wrote:
> On Mon, Jan 11, 2016 at 05:35:45PM +0000, Juri Lelli wrote:
> > +/**
> > + * The "cpufreq driver" - the arch- or hardware-dependent low
> > + * level driver of CPUFreq support, and its spinlock (cpufreq_driver_lock).
> > + * This lock also protects cpufreq_cpu_data array and cpufreq_policy_list.
> > + */
> > +static struct cpufreq_driver *cpufreq_driver;
> > +static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
> >  static LIST_HEAD(cpufreq_policy_list);
> > +static DEFINE_RWLOCK(cpufreq_driver_lock);
> 
> Part of my suggestion was to fold the per-cpu data of cpufreq_cpu_data
> into struct cpufreq_driver.
> 
> That way each cpufreq_driver will have its own copy and there'd be only
> the one global pointer to swizzle. Something very well suited to RCU.

Well, I'm not really sure reworking all that is necessary.

What we need is to be able to call something analogous to dbs_timer_handler()
from the scheduler and a driver callback from there (if present).  For that,
it should be sufficient to have a pointer to that callback (that may be set
upon driver registration) protected by RCU (or should that be sched RCU
rather?) if I'm not missing anything.

Thanks,
Rafael

