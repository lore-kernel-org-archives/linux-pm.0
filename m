From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 3/7] cpufreq / sched: Check cpu_of(rq) in cpufreq_update_util()
Date: Mon, 01 Aug 2016 16:57:42 +0200
Message-ID: <11247103.Rf1PtOX8n5@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <2892951.2FPdDYdaoa@vostro.rjw.lan> <20160801072957.GA4220@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160801072957.GA4220@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 01, 2016 09:29:57 AM Dominik Brodowski wrote:
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

Right.

Thanks,
Rafael
