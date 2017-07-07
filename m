From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 11:43:41 +0100
Message-ID: <20170707104341.vrx4gm2bgoaaixwf@e106622-lin>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-4-juri.lelli@arm.com>
 <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdGGKns (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 06:43:48 -0400
Content-Disposition: inline
In-Reply-To: <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>Rafael J

Hi,

On 06/07/17 20:56, Joel Fernandes wrote:
> Hi Juri,
> 
> On Wed, Jul 5, 2017 at 1:59 AM, Juri Lelli <juri.lelli@arm.com> wrote:

[...]

> >         if (attr->sched_flags &
> > -               ~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
> > +               ~(SCHED_FLAG_RESET_ON_FORK |
> > +                 SCHED_FLAG_RECLAIM |
> > +                 SCHED_FLAG_SPECIAL))
> >                 return -EINVAL;
> 
> I was thinking if its better to name SCHED_FLAG_SPECIAL something more
> descriptive than "special", since it will not be clear looking at
> other parts of the code that this is used for the frequency scaling
> thread or that its a DL task. I was thinking since this flag is
> specifically setup for the sugov thread frequency scaling purpose, a
> better flag name than SPECIAL might be SCHED_FLAG_DL_FREQ_SCALE or
> SCHED_FLAG_FREQ_SCALE. But I am Ok with whatever makes sense to do
> here. Thanks,
> 

Sure.

How about SCHED_FLAG_SUGOV then?

Thanks,

- Juri
