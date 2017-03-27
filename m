From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Mon, 27 Mar 2017 19:37:39 +0200
Message-ID: <1721120.3Th1GMboUn@aspire.rjw.lan>
References: <20170324140900.7334-1-juri.lelli@arm.com> <37277532.TseFq3j8HT@aspire.rjw.lan> <20170327171336.GD10289@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63362 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751287AbdC0RnU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 13:43:20 -0400
In-Reply-To: <20170327171336.GD10289@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mark Brown <broonie@kernel.org>

On Monday, March 27, 2017 06:13:36 PM Juri Lelli wrote:
> On 27/03/17 19:05, Rafael J. Wysocki wrote:
> > On Monday, March 27, 2017 06:01:34 PM Juri Lelli wrote:
> > > On 27/03/17 18:50, Peter Zijlstra wrote:
> > > > On Fri, Mar 24, 2017 at 02:08:58PM +0000, Juri Lelli wrote:
> > > > > Worker kthread needs to be able to change frequency for all other
> > > > > threads.
> > > > > 
> > > > > Make it special, just under STOP class.
> > > > 
> > > > *yuck* ;-)
> > > > 
> > > 
> > > Eh, I know. :/
> > > 
> > > > So imagine our I2C/SPI bus is 'busy' and its mutex taken, then this
> > > > 'soecial' task will need to boost it. Now add BWI to your thinking and
> > > > shudder.
> > > > 
> > > 
> > > Currently that kthread is FIFO already, so boosting still applies. Not as
> > > bad as in the BWI case though. More thinking required.
> > > 
> > > > 
> > > > On IRC broonie mentioned that:
> > > > 
> > > >  - most PMIC operations are fire and forget (no need to wait for a
> > > >    response).
> > > >  - PMIC 'packets' are 'small'.
> > > >  - SPI has the possibility to push stuff on the queue.
> > > > 
> > > > Taken together this seems to suggest we can rework cpufreq drivers to
> > > > function in-context, either directly push the packet on the bus if
> > > > available, or queue it and let whoever owns it sort it without blocking.
> > > > 
> > > > It might be possible to rework/augment I2C to also support pushing stuff
> > > > on a queue.
> > > > 
> > > > 
> > > > So if we can make all that work, we can do away with this horrible
> > > > horrible kthread. Which is, IMO, a much better solution.
> > > > 
> > > > Thoughts?
> > > 
> > > Right. This is more a schedutil (cpufreq) problem though, IMHO. Even if
> > > I agree that what you are proposing is way more clean (and here I
> > > actually assume it's feasible at all), I fear it will take quite some
> > > time to get reworked.
> > 
> > Why do you think so?
> > 
> 
> It simply seemed a major rework to me. :)

OK

So there are two pieces here.

One is that if we want *all* drivers to work with schedutil, we need to keep
the kthread for the ones that will never be reworked (because nobody cares
etc).  But then perhaps the kthread implementation may be left alone (because
nobody cares etc).

The second one is that there are drivers operating in-context that work with
schedutil already, so I don't see major obstacles to making more drivers work
that way.  That would be only a matter of reworking the drivers in question.

Thanks,
Rafael
