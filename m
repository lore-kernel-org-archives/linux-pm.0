From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Fri, 23 Mar 2018 15:47:45 +0000
Message-ID: <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
 <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:
> On Wed, Mar 21, 2018 at 8:35 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > [...]
> >
> >> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >>                       break;
> >>               }
> >>
> >> +             /*
> >> +              * Energy-aware task placement is performed on the highest
> >> +              * non-overutilized domain spanning over cpu and prev_cpu.
> >> +              */
> >> +             if (want_energy && !sd_overutilized(tmp) &&
> >> +                 cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
> >> +                     energy_sd = tmp;
> >> +
> >
> > Not entirely sure, but I was trying to understand if we can avoid to
> > modify the definition of want_affine (in the previous chunk) and move
> > this block before the previous "if (want_affine..." (in mainline but
> > not in this chunk), which will became an else, e.g.
> >
> >         if (want_energy && !sd_overutilized(tmp) &&
> >                 // ...
> >         else if (want_energy && !sd_overutilized(tmp) &&
> >                 // ...
> >
> > Isn't that the same?
> >
> > Maybe there is a code path I'm missing... but otherwise it seems a
> > more self contained modification of select_task_rq_fair...
> 
> Just replying to this here Patrick instead of the other thread.
> 
> I think this is the right place for the block from Quentin quoted
> above because we want to search for the highest domain that is
> !overutilized and look among those for the candidates. So from that
> perspective, we can't move the block to the beginning and it seems to
> be in the right place. My main concern on the other thread was
> different, I was talking about the cases where sd_flag & tmp->flags
> don't match. In that case, sd = NULL would trump EAS and I was
> wondering if that's the right thing to do...

You mean if SD_BALANCE_WAKE isn't set on sched_domains?

The current code seems to rely on that flag to be set to work correctly.
Otherwise, the loop might bail out on !want_affine and we end up doing
the find_energy_efficient_cpu() on the lowest level sched_domain even if
there is higher level one which isn't over-utilized.

However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is set so
sd == NULL shouldn't be possible? This only holds as long as we only
want EAS for asymmetric systems.
