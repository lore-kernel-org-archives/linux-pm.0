From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be
 SCHED_DEADLINE
Date: Tue, 28 Mar 2017 12:20:31 +0200
Message-ID: <20170328102031.vkzkjq2gcqwcwb67@hirez.programming.kicks-ass.net>
References: <20170324140900.7334-1-juri.lelli@arm.com>
 <20170324140900.7334-4-juri.lelli@arm.com>
 <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
 <CAKfTPtCgQQU-8fdxyq+9pywAtu-DFo7ZBugjEaFxjVVxu_pqjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbdC1KU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 06:20:59 -0400
Content-Disposition: inline
In-Reply-To: <CAKfTPtCgQQU-8fdxyq+9pywAtu-DFo7ZBugjEaFxjVVxu_pqjw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Mar 28, 2017 at 11:29:31AM +0200, Vincent Guittot wrote:
> On 27 March 2017 at 18:50, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Mar 24, 2017 at 02:08:58PM +0000, Juri Lelli wrote:
> >> Worker kthread needs to be able to change frequency for all other
> >> threads.
> >>
> >> Make it special, just under STOP class.
> >
> > *yuck* ;-)
> >
> > So imagine our I2C/SPI bus is 'busy' and its mutex taken, then this
> > 'soecial' task will need to boost it. Now add BWI to your thinking and
> > shudder.
> >
> >
> > On IRC broonie mentioned that:
> >
> >  - most PMIC operations are fire and forget (no need to wait for a
> >    response).
> >  - PMIC 'packets' are 'small'.
> >  - SPI has the possibility to push stuff on the queue.
> >
> > Taken together this seems to suggest we can rework cpufreq drivers to
> > function in-context, either directly push the packet on the bus if
> > available, or queue it and let whoever owns it sort it without blocking.
> >
> > It might be possible to rework/augment I2C to also support pushing stuff
> > on a queue.
> 
> But sending new voltage value to PMIC is only part of the sequence.
> When cpufreq set a new opp, it does
> 
> -set new voltage
> -wait for the voltage to settle down.
> -set the new clock frequency
> 
> you can even have to switch to an intermediate clock source.
> 
> When such sequence is managed by the kernel, we can't easily git ride
> of a kthread

That stinks :-(

The whole blocking and bandwidth inheritance stuff gives me nightmares.
Makes all this stuff almost impossible to analyse.

Esp. if the bus (SPI/I2C) is shared with some other 'expensive' device
like a DSP or MMC flash crud.
