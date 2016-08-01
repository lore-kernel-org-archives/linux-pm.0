From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 3/7] cpufreq / sched: Check cpu_of(rq) in cpufreq_update_util()
Date: Tue, 02 Aug 2016 01:43:45 +0200
Message-ID: <1582934.0pqYKyDQkU@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <20160801072957.GA4220@light.dominikbrodowski.net> <20160801194818.GY19455@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47271 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755393AbcHAXpP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 19:45:15 -0400
In-Reply-To: <20160801194818.GY19455@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Monday, August 01, 2016 12:48:18 PM Steve Muckle wrote:
> On Mon, Aug 01, 2016 at 09:29:57AM +0200, Dominik Brodowski wrote:
> > A small nitpick:
> > 
> > On Mon, Aug 01, 2016 at 01:36:01AM +0200, Rafael J. Wysocki wrote:
> > > --- linux-pm.orig/kernel/sched/sched.h
> > > +++ linux-pm/kernel/sched/sched.h
> > > @@ -1760,7 +1760,7 @@ DECLARE_PER_CPU(struct update_util_data
> > >  
> > >  /**
> > >   * cpufreq_update_util - Take a note about CPU utilization changes.
> > > - * @time: Current time.
> > > + * @rq: Runqueue to carry out the update for.
> > >   *
> > >   * This function is called by the scheduler on every invocation of
> > >   * update_load_avg() on the CPU whose utilization is being updated.
> > 
> > This comment seems to need an update due to the smp_processor_id() check
> > being moved into this function.
> 
> The callers of this have also changed - it is no longer called directly
> by update_load_avg(), rather via cfs_rq_util_change() from several other
> locations (I believe it was my patch that failed to update this
> comment).
> 
> Could this be replaced with a more generic statement such as "called by
> CFS in various paths?"

Good observation.

I'll modify that comment to match the code.

Thanks,
Rafael

