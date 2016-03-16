From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/8] sched/cpufreq: pass sched class into
 cpufreq_update_util
Date: Wed, 16 Mar 2016 08:41:23 +0100
Message-ID: <20160316074123.GP6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212520.GF6344@twins.programming.kicks-ass.net>
 <20160315220609.30639.67271@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47708 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933671AbcCPHlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 03:41:25 -0400
Content-Disposition: inline
In-Reply-To: <20160315220609.30639.67271@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Tue, Mar 15, 2016 at 03:06:09PM -0700, Michael Turquette wrote:
> Quoting Peter Zijlstra (2016-03-15 14:25:20)
> > On Sun, Mar 13, 2016 at 10:22:09PM -0700, Michael Turquette wrote:
> > > +++ b/include/linux/sched.h
> > > @@ -2362,15 +2362,25 @@ extern u64 scheduler_tick_max_deferment(void);
> > >  static inline bool sched_can_stop_tick(void) { return false; }
> > >  #endif
> > >  
> > > +enum sched_class_util {
> > > +     cfs_util,
> > > +     rt_util,
> > > +     dl_util,
> > > +     nr_util_types,
> > > +};
> > > +
> > >  #ifdef CONFIG_CPU_FREQ
> > >  struct freq_update_hook {
> > > +     void (*func)(struct freq_update_hook *hook,
> > > +                  enum sched_class_util sched_class, u64 time,
> > >                    unsigned long util, unsigned long max);
> > >  };
> > >  
> > Have you looked at the asm that generated? At some point you'll start
> > spilling on the stack and it'll be a god awful mess.
> > 
> 
> Is your complaint about the enum that I added to the existing function
> signature, or do you not like the original function signature[0] from
> Rafael's patch, sans enum?

No, my complaint is more about the call ABI for all our platforms, at
some point we start passing arguments on the stack instead of through
registers.

I'm not sure where that starts hurting, but its always a concern when
adding arguments to functions.
