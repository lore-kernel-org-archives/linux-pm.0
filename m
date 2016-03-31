From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to update_cfs_rq_load_avg()
Date: Thu, 31 Mar 2016 14:50:54 +0200
Message-ID: <CAKfTPtDVAKZHdJp3K6fVq5K63+a0Oyxbo3ddnGBuak5ZjUcKUA@mail.gmail.com>
References: <56F91D56.4020007@arm.com> <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com> <56F98832.3030207@linaro.org> <20160330193544.GD407@worktop>
 <CAKfTPtCPfd2-jGDn-9ZLjNKTni4czuvrkH7KFh5L2EtDeTQE5A@mail.gmail.com>
 <20160331093408.GB12845@twins.programming.kicks-ass.net> <CAKfTPtCuDQz8KxndwA1Kx4Xe-DohuUOhYXXabBDsp7r8j6cPgw@mail.gmail.com>
 <20160331104705.GG3430@twins.programming.kicks-ass.net> <CAKfTPtD-knx3ySY+ad8BwDLs9bK5KhAb7mKd3xXc63AXhREh3A@mail.gmail.com>
 <20160331123424.GI3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160331123424.GI3430@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 31 March 2016 at 14:34, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 31, 2016 at 02:14:50PM +0200, Vincent Guittot wrote:
>> In fact, I looks for the sequence where the utilization of a rq is not
>> updated until the next tick but i can't find it.
>
> No, util it always updated, however..
>
>> If cpu doesn't share cache, task is added to wake list and an ipi is
>> sent and the utilization.
>
> Here we run:
>
>  ttwu_do_activate()
>    ttwu_activate()
>      activate_task()
>        enqueue_task()
>          p->sched_class->enqueue_task() := enqueue_task_fair()
>            update_load_avg()
>              update_cfs_rq_load_avg()
>                cfs_rq_util_change()
>
> On the local cpu, and we can indeed call out to have the frequency
> changed.
>
>> Otherwise, we directly enqueue the task on
>> the rq and the utilization is updated
>
> But here we run it on a remote cpu, so we cannot call out and the
> frequency remains the same.
>
> So if a remote wakeup on the same LLC domain happens, utilization will
> increase but we will not observe until the next tick.

ok. I forgot that we have the condition cpu == smp_processor_id() in
cfs_rq_util_change.
