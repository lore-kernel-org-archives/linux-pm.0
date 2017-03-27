From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be
 SCHED_DEADLINE
Date: Mon, 27 Mar 2017 18:01:34 +0100
Message-ID: <20170327170134.GC10289@e106622-lin>
References: <20170324140900.7334-1-juri.lelli@arm.com>
 <20170324140900.7334-4-juri.lelli@arm.com>
 <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdC0RMa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Mar 2017 13:12:30 -0400
Content-Disposition: inline
In-Reply-To: <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Mark Brown <broonie@kernel.org>

On 27/03/17 18:50, Peter Zijlstra wrote:
> On Fri, Mar 24, 2017 at 02:08:58PM +0000, Juri Lelli wrote:
> > Worker kthread needs to be able to change frequency for all other
> > threads.
> > 
> > Make it special, just under STOP class.
> 
> *yuck* ;-)
> 

Eh, I know. :/

> So imagine our I2C/SPI bus is 'busy' and its mutex taken, then this
> 'soecial' task will need to boost it. Now add BWI to your thinking and
> shudder.
> 

Currently that kthread is FIFO already, so boosting still applies. Not as
bad as in the BWI case though. More thinking required.

> 
> On IRC broonie mentioned that:
> 
>  - most PMIC operations are fire and forget (no need to wait for a
>    response).
>  - PMIC 'packets' are 'small'.
>  - SPI has the possibility to push stuff on the queue.
> 
> Taken together this seems to suggest we can rework cpufreq drivers to
> function in-context, either directly push the packet on the bus if
> available, or queue it and let whoever owns it sort it without blocking.
> 
> It might be possible to rework/augment I2C to also support pushing stuff
> on a queue.
> 
> 
> So if we can make all that work, we can do away with this horrible
> horrible kthread. Which is, IMO, a much better solution.
> 
> Thoughts?

Right. This is more a schedutil (cpufreq) problem though, IMHO. Even if
I agree that what you are proposing is way more clean (and here I
actually assume it's feasible at all), I fear it will take quite some
time to get reworked.

Do we want to wait until that moment to get DEADLINE contribution
accounted for? :(

Thanks,

- Juri
