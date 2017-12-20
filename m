From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Wed, 20 Dec 2017 13:57:05 +0100
Message-ID: <20171220125705.djemtgopmmthzqjz@hirez.programming.kicks-ass.net>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-4-juri.lelli@redhat.com>
 <20171205115509.GK31247@e110439-lin>
 <20171205123400.GA15085@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205123400.GA15085@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 05, 2017 at 01:34:00PM +0100, Juri Lelli wrote:
> > What about using for all these wrappers the same utility function you
> > already use in this source file? I.e.
> > 
> >         if (unlikely(dl_entity_is_special(dl_se)))
> >                 return;
> >         __add_rq_bw(dl_se->dl_bw, dl_rq);

> > > +static inline int dl_entity_is_special(struct sched_dl_entity *dl_se)
> > > +{
> > #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > > +	return dl_se->flags & SCHED_FLAG_SUGOV;
> > #else
> >         return false;
> > #endif
> > > +}

Move the unlikely in here, saves on typing.
