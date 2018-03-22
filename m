From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Thu, 22 Mar 2018 13:19:03 -0700
Message-ID: <CAJWu+oohaZbdk5oWZjLC-t1oY3cO3UuxbqvjgN+L+Do0mAag3Q@mail.gmail.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com> <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
 <20180322180623.GE13951@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322180623.GE13951@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 22, 2018 at 11:06 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
[..]
>> > +static inline bool wake_energy(struct task_struct *p, int prev_cpu)
>> > +{
>> > +       struct sched_domain *sd;
>> > +
>> > +       if (!static_branch_unlikely(&sched_energy_present))
>> > +               return false;
>> > +
>> > +       sd = rcu_dereference_sched(cpu_rq(prev_cpu)->sd);
>> > +       if (!sd || sd_overutilized(sd))
>>
>> Shouldn't you check for the SD_ASYM_CPUCAPACITY flag here?
>
> I think that should be already covered by the static key check
> above...
>

I understand there is an assumption like that but I was wondering if
its more future proof for checking it explicity. I am Ok if everyone
thinks its a valid assumption...

>>
>> > +               return false;
>> > +
>> > +       return true;
>> > +}
>> > +
>> >  /*
>> >   * select_task_rq_fair: Select target runqueue for the waking task in domains
>> >   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
>> > @@ -6529,18 +6583,22 @@ static int
>> >  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>> >  {
>> >         struct sched_domain *tmp, *affine_sd = NULL, *sd = NULL;
>> > +       struct sched_domain *energy_sd = NULL;
>> >         int cpu = smp_processor_id();
>> >         int new_cpu = prev_cpu;
>> > -       int want_affine = 0;
>> > +       int want_affine = 0, want_energy = 0;
>> >         int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>> >
>> > +       rcu_read_lock();
>> > +
>> >         if (sd_flag & SD_BALANCE_WAKE) {
>> >                 record_wakee(p);
>> > +               want_energy = wake_energy(p, prev_cpu);
>> >                 want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
>> > -                             && cpumask_test_cpu(cpu, &p->cpus_allowed);
>> > +                             && cpumask_test_cpu(cpu, &p->cpus_allowed)
>> > +                             && !want_energy;
>> >         }
>> >
>> > -       rcu_read_lock();
>> >         for_each_domain(cpu, tmp) {
>> >                 if (!(tmp->flags & SD_LOAD_BALANCE))
>> >                         break;
>> > @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>> >                         break;
>> >                 }
>> >
>> > +               /*
>> > +                * Energy-aware task placement is performed on the highest
>> > +                * non-overutilized domain spanning over cpu and prev_cpu.
>> > +                */
>> > +               if (want_energy && !sd_overutilized(tmp) &&
>> > +                   cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
>>
>> Shouldn't you check for the SD_ASYM_CPUCAPACITY flag here for tmp level?
>
> ... and this then should be covered by the previous check in
> wake_energy(), which sets want_energy.

Right, but in a scenario which probably doesn't exist today where we
have both SD_ASYM_CPUCAPACITY and !SD_ASYM_CPUCAPACITY domains in the
hierarchy for which want_energy = 1, I was thinking if its more future
proof to check it and not make assumptions...

>>
>> > +                       energy_sd = tmp;
>> > +
>> >                 if (tmp->flags & sd_flag)
>> >                         sd = tmp;
>> >                 else if (!want_affine)
>> > @@ -6586,6 +6652,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>> >                         if (want_affine)
>> >                                 current->recent_used_cpu = cpu;
>> >                 }
>> > +       } else if (energy_sd) {
>> > +               new_cpu = find_energy_efficient_cpu(energy_sd, p, prev_cpu);
>>
>> Even if want_affine = 0 (want_energy = 1), we can have sd = NULL if
>> sd_flag and tmp->flags don't match. In this case we wont enter the EAS
>> selection path because sd will be = NULL. So should you be setting sd
>> = NULL explicitly if energy_sd != NULL , or rather do the if
>> (energy_sd) before doing the if (!sd) ?
>
> That's the same think I was also proposing in my reply to this patch.
> But in my case the point was mainly to make the code easier to
> follow... which at the end it's also to void all the consideration on
> dependencies you describe above.
>
> Joel, can you have a look at what I proposed... I was not entirely
> sure that we miss some code paths doing it that way.

Replied to this in the other thread.

thanks,

- Joel
