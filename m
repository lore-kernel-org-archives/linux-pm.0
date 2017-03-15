From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Wed, 15 Mar 2017 18:06:48 +0000
Message-ID: <20170315180648.GJ18557@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
 <20170303034125.GH13760@vireshk-i7>
 <20170306092959.561fdf26@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306092959.561fdf26@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 06-Mar 09:29, Steven Rostedt wrote:
> On Fri, 3 Mar 2017 09:11:25 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 02-03-17, 15:45, Patrick Bellasi wrote:
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index e2ed46d..739b29d 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -3653,6 +3653,7 @@ static inline unsigned long rlimit_max(unsigned int limit)
> > >  #define SCHED_CPUFREQ_RT	(1U << 0)
> > >  #define SCHED_CPUFREQ_DL	(1U << 1)
> > >  #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> > > +#define SCHED_CPUFREQ_IDLE	(1U << 3)
> > >  
> > >  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
> > >  
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index fd46593..084a98b 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -281,6 +281,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> > >  
> > >  	raw_spin_lock(&sg_policy->update_lock);
> > >  
> > > +	/* CPU is entering IDLE, reset flags without triggering an update */
> > > +	if (flags & SCHED_CPUFREQ_IDLE) {  
> > 
> > Will "flags == SCHED_CPUFREQ_IDLE" generate better assembly ?
> > 
> 
> Even if it does, a bit check and an equal check are pretty negligible
> in difference wrt execution time. I would choose whatever is the most
> readable to humans.
> 
>  flags == SCHED_CPUFREQ_IDLE
> 
> will tell me (as a reviewer) that we expect no other flag to be set.
> 
>  flags & SCHED_CPUFREQ_IDLE
> 
> will tell me that we only care about the IDLE flag.
> 
> Which ever is the more meaningful is what should be used.

Agree on the approach, whenever not silly code should be written to be
easy to understand from other humans.

Here the intent is "whatever flags you set, if the IDLE one is set" we
assume we are entering idle. Thus, to me the current version is easier
to understand without being "overkilling" in its semantics.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
