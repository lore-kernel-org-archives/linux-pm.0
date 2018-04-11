From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
Date: Wed, 11 Apr 2018 17:29:01 +0200
Message-ID: <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <20180411151450.GK4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411151450.GK4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 11 April 2018 at 17:14, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Apr 10, 2018 at 12:04:12PM +0100, Patrick Bellasi wrote:
>> On 09-Apr 10:51, Vincent Guittot wrote:
>
>> > Peter,
>> > what was your goal with adding the condition "if
>> > (rq->cfs.h_nr_running)" for the aggragation of CFS utilization
>>
>> The original intent was to get rid of sched class flags, used to track
>> which class has tasks runnable from within schedutil. The reason was
>> to solve some misalignment between scheduler class status and
>> schedutil status.
>>
>> The solution, initially suggested by Viresh, and finally proposed by
>> Peter was to exploit RQ knowledges directly from within schedutil.
>>
>> The problem is that now schedutil updated depends on two information:
>> utilization changes and number of RT and CFS runnable tasks.
>>
>> Thus, using cfs_rq::h_nr_running is not the problem... it's actually
>> part of a much more clean solution of the code we used to have.
>>
>> The problem, IMO is that we now depend on other information which
>> needs to be in sync before calling schedutil... and the patch I
>> proposed is meant to make it less likely that all the information
>> required are not aligned (also in the future).
>
> Specifically, the h_nr_running test was get rid of
>
>                 if (delta_ns > TICK_NSEC) {
>                         j_sg_cpu->iowait_boost = 0;
>                         j_sg_cpu->iowait_boost_pending = false;
> -                       j_sg_cpu->util_cfs = 0;
>
>                         ^^^^^^^^^^^^^^^^^^^^^^^ that..
>
> -                       if (j_sg_cpu->util_dl == 0)
> -                               continue;
>                 }
>
>
> because that felt rather arbitrary.

yes I agree.

With the patch that updates blocked idle load, we should not have the
problem of blocked utilization anymore and get rid of the code above
and h_nr_running test
