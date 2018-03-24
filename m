From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Sat, 24 Mar 2018 01:47:58 +0000
Message-ID: <20180324014757.GC1317@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
 <20180322180623.GE13951@e110439-lin>
 <CAJWu+oohaZbdk5oWZjLC-t1oY3cO3UuxbqvjgN+L+Do0mAag3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+oohaZbdk5oWZjLC-t1oY3cO3UuxbqvjgN+L+Do0mAag3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 Mar 2018 at 13:19:03 (-0700), Joel Fernandes wrote:
> On Thu, Mar 22, 2018 at 11:06 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> >> > @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >> >                         break;
> >> >                 }
> >> >
> >> > +               /*
> >> > +                * Energy-aware task placement is performed on the highest
> >> > +                * non-overutilized domain spanning over cpu and prev_cpu.
> >> > +                */
> >> > +               if (want_energy && !sd_overutilized(tmp) &&
> >> > +                   cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
> >>
> >> Shouldn't you check for the SD_ASYM_CPUCAPACITY flag here for tmp level?
> >
> > ... and this then should be covered by the previous check in
> > wake_energy(), which sets want_energy.
> 
> Right, but in a scenario which probably doesn't exist today where we
> have both SD_ASYM_CPUCAPACITY and !SD_ASYM_CPUCAPACITY domains in the
> hierarchy for which want_energy = 1, I was thinking if its more future
> proof to check it and not make assumptions...

So we can definitely have cases where SD_ASYM_CPUCAPACITY is not set at all
sd levels. Today, on mobile systems, this flag is typically set only at DIE
level for big.LITTLE platforms, and not at MC level.
We enable EAS if we find _at least_ one domain that has this flag in the
hierarchy, just to make sure we don't enable EAS for symmetric platform.
It's just a way to check a property about the topology when EAS starts, not
really a way to actually select the sd at which we do scheduling at
runtime.

I hope that helps !

Thanks,
Quentin
