From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Thu, 6 Jul 2017 11:26:55 +0530
Message-ID: <20170706055655.GR3532@vireshk-i7>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-4-git-send-email-patrick.bellasi@arm.com>
 <20170705060136.GO3532@vireshk-i7>
 <20170705134126.GD2659@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705134126.GD2659@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Brendan Jackman <brendan.jackman@arm.com>
List-Id: linux-pm@vger.kernel.org

On 05-07-17, 14:41, Patrick Bellasi wrote:
> On 05-Jul 11:31, Viresh Kumar wrote:

> Just had a fast check but I think something like that can work.
> We had an internal discussion with Brendan (in CC now) which had a
> similar proposal.
> 
> Main counter arguments for me was:
> 1. we wanna to reduce the pollution of scheduling classes code with
>    schedutil specific code, unless strictly necessary

s/schedutil/cpufreq, as the util hooks are getting called for some other stuff
as well.

> 2. we never had a "clear bit" semantics for flags updates
> 
> Thus this proposal seemed to me less of a discontinuity wrt the
> current interface. However, something similar to what you propose
> below should also work.

With the kind of problems we have in hand now, it seems that it would be good
for the governors to know what kind of stuff is queued on the CPU (i.e. the
aggregation of all the flags) and the only sane way of doing that is by clearing
the flag once a class is done with it.

Else we would be required to have code that tries to find the same information
in an indirect way, like what this patch does with the current task.

> Let's collect some more feedback...

Sure.
 
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index d2be2ccbb372..e81a6b5591f5 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -11,6 +11,10 @@
> >  #define SCHED_CPUFREQ_DL       (1U << 1)
> >  #define SCHED_CPUFREQ_IOWAIT   (1U << 2)
> >  
> > +#define SCHED_CPUFREQ_CLEAR    (1U << 31)
> > +#define SCHED_CPUFREQ_CLEAR_RT (SCHED_CPUFREQ_CLEAR | SCHED_CPUFREQ_RT)
> > +#define SCHED_CPUFREQ_CLEAR_DL (SCHED_CPUFREQ_CLEAR | SCHED_CPUFREQ_DL)
> > +
> >  #define SCHED_CPUFREQ_RT_DL    (SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
> >  
> >  #ifdef CONFIG_CPU_FREQ
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 076a2e31951c..f32e15d59d62 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -218,6 +218,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >         unsigned int next_f;
> >         bool busy;
> >  
> > +       if (flags & SCHED_CPUFREQ_CLEAR)
> > +               return;
> 
> Here we should still clear the flags, like what we do for the shared
> case... just to keep the internal status consiste with the
> notifications we have got from the scheduling classes.

The sg_cpu->flags field isn't used currently for the single CPU per policy case,
but only for shared policies. But yes, we need to maintain that here now as
well to know what all is queued on a CPU.

-- 
viresh
