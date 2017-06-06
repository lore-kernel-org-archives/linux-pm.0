From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 6 Jun 2017 19:03:45 +0100
Message-ID: <20170606180345.GB684@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
 <20170606092651.GC5103@vireshk-i7>
 <CAJZ5v0h2PB0eNo664nKXsTD8JVycncg8C0Tsj-pp6=AbGdJzWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751404AbdFFSDv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jun 2017 14:03:51 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h2PB0eNo664nKXsTD8JVycncg8C0Tsj-pp6=AbGdJzWw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 06-Jun 17:56, Rafael J. Wysocki wrote:
> On Tue, Jun 6, 2017 at 11:26 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 02-03-17, 15:45, Patrick Bellasi wrote:
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index e2ed46d..739b29d 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -3653,6 +3653,7 @@ static inline unsigned long rlimit_max(unsigned int limit)
> >>  #define SCHED_CPUFREQ_RT     (1U << 0)
> >>  #define SCHED_CPUFREQ_DL     (1U << 1)
> >>  #define SCHED_CPUFREQ_IOWAIT (1U << 2)
> >> +#define SCHED_CPUFREQ_IDLE   (1U << 3)
> >>
> >>  #define SCHED_CPUFREQ_RT_DL  (SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
> >>
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> index fd46593..084a98b 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -281,6 +281,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >>
> >>       raw_spin_lock(&sg_policy->update_lock);
> >>
> >> +     /* CPU is entering IDLE, reset flags without triggering an update */
> >> +     if (flags & SCHED_CPUFREQ_IDLE) {
> >> +             sg_cpu->flags = 0;
> >> +             goto done;
> >> +     }
> >> +
> >>       sg_cpu->util = util;
> >>       sg_cpu->max = max;
> >>       sg_cpu->flags = flags;
> >> @@ -293,6 +299,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >>               sugov_update_commit(sg_policy, time, next_f);
> >>       }
> >>
> >> +done:
> >>       raw_spin_unlock(&sg_policy->update_lock);
> >>  }
> >>
> >> diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
> >> index 0c00172..a844c91 100644
> >> --- a/kernel/sched/idle_task.c
> >> +++ b/kernel/sched/idle_task.c
> >> @@ -29,6 +29,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >>       put_prev_task(rq, prev);
> >>       update_idle_core(rq);
> >>       schedstat_inc(rq->sched_goidle);
> >> +
> >> +     /* kick cpufreq (see the comment in kernel/sched/sched.h). */
> >> +     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IDLE);
> >> +
> >>       return rq->idle;
> >>  }
> >
> > I was discussing about almost the same problem with Vincent today and we were
> > convinced to write exactly the same patch to solve that. And then I saw this old
> > thread again :)
> >
> > Why did this thread die completely ?
> 
> Because nobody followed up? :-)
> 
> > Can we at least get the patches which don't have any objections merged
> > separately first ?
> 
> Yes, we can in general, but someone needs to "shepherd" them and I've
> been traveling lately.
> 
> So, if there's anything that appears non-controversial and looks like
> it could be applied, the best way to make that happen would be to
> resend it.

You right guys, I should had done it since some time.
Will do the best to resend it in few days.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
