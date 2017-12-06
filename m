From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 4/6] sched/rt: fast switch to maximum frequency when RT
 tasks are scheduled
Date: Wed, 6 Dec 2017 13:36:00 +0100
Message-ID: <CAKfTPtD7iytL5CSyn3qEZDjOTqvvZ1PPNeotuwgUB+=Q+ma4_Q@mail.gmail.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-5-patrick.bellasi@arm.com> <CAKfTPtCoUVoxhG5mem9fcf30VoQBUCMZr-CLkFVoKRMHr_=btQ@mail.gmail.com>
 <20171206113821.GO31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206113821.GO31247@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 6 December 2017 at 12:38, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Hi Vincent,
>
> On 06-Dec 10:39, Vincent Guittot wrote:
>> Hi Patrick,
>>
>> On 30 November 2017 at 12:47, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> >  static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>> > @@ -1564,6 +1564,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>> >
>> >         p = _pick_next_task_rt(rq);
>> >
>> > +       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
>>
>> p is null when there is no rt task to pick.
>> You should test this condition before calling cpufreq_update_util
>
> Mmm... for what I see, from the above function's implementation,
> _pick_next_task_rt() is always returning a valid pointer to an RT
> task.
>
> The above call does a:
>
>    p->se.exec_start = rq_clock_task(rq);
>
> right before returning, and there is also a BUG_ON(!rt_se) in the
> previous RT tasks scanning loop.
>
> Am I missing something?

No you're right the return Null is done earlier if there is no task

>
>> > +       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
>> > +
>> >         /* The running task is never eligible for pushing */
>> >         dequeue_pushable_task(rq, p);
>
> [...]
>
>> > @@ -2317,6 +2323,9 @@ static void set_curr_task_rt(struct rq *rq)
>> >
>> >         p->se.exec_start = rq_clock_task(rq);
>> >
>> > +       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
>> > +       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
>>
>> Is this change linked to the "- when a task is set to be RT" in the
>> commit message ?
>>
>> I can't see a situation where this is call without the previous one.
>> AFAICT, enqueue_task_rt will be called before each call to this
>> function
>
> Yeah, you right, in core.c the pattern seems to always be:
>
>     if (queued)
>             enqueue_task()
>     if (running)
>             set_curr_task()
>
> I'll remove this chunk from the next version.
>
>>
>> > +
>> >         /* The running task is never eligible for pushing */
>> >         dequeue_pushable_task(rq, p);
>> >  }
>
> Thanks for the review!
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
