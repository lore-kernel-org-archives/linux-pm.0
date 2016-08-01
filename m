From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 3/7] cpufreq / sched: Check cpu_of(rq) in
 cpufreq_update_util()
Date: Mon, 1 Aug 2016 12:48:18 -0700
Message-ID: <20160801194818.GY19455@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <2892951.2FPdDYdaoa@vostro.rjw.lan>
 <20160801072957.GA4220@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160801072957.GA4220@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 01, 2016 at 09:29:57AM +0200, Dominik Brodowski wrote:
> A small nitpick:
> 
> On Mon, Aug 01, 2016 at 01:36:01AM +0200, Rafael J. Wysocki wrote:
> > --- linux-pm.orig/kernel/sched/sched.h
> > +++ linux-pm/kernel/sched/sched.h
> > @@ -1760,7 +1760,7 @@ DECLARE_PER_CPU(struct update_util_data
> >  
> >  /**
> >   * cpufreq_update_util - Take a note about CPU utilization changes.
> > - * @time: Current time.
> > + * @rq: Runqueue to carry out the update for.
> >   *
> >   * This function is called by the scheduler on every invocation of
> >   * update_load_avg() on the CPU whose utilization is being updated.
> 
> This comment seems to need an update due to the smp_processor_id() check
> being moved into this function.

The callers of this have also changed - it is no longer called directly
by update_load_avg(), rather via cfs_rq_util_change() from several other
locations (I believe it was my patch that failed to update this
comment).

Could this be replaced with a more generic statement such as "called by
CFS in various paths?"

thanks,
Steve
