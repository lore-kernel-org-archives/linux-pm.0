From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Tue, 11 Jul 2017 14:37:02 +0200
Message-ID: <20170711123702.jvu47jahuo47uyab@hirez.programming.kicks-ass.net>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-4-juri.lelli@arm.com>
 <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45667 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbdGKMhT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 08:37:19 -0400
Content-Disposition: inline
In-Reply-To: <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>"Rafael J . Wysocki" <r>

On Thu, Jul 06, 2017 at 08:56:32PM -0700, Joel Fernandes wrote:

> > @@ -3998,7 +3998,9 @@ static int __sched_setscheduler(struct task_struct *p,
> >         }
> >
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

SCHED_FLAG_IM_DOING_IT_WRONG ;-)
