From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 17 Dec 2015 15:17:33 +0800
Message-ID: <20151217071733.GB6195@leoy-linaro>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
 <20151216034825.GA11303@leoy-linaro>
 <56720EE8.1090507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56720EE8.1090507@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On Wed, Dec 16, 2015 at 05:24:56PM -0800, Steve Muckle wrote:
> Hi Leo,
> 
> On 12/15/2015 07:48 PM, Leo Yan wrote:
> > I also think "set_current_state(TASK_INTERRUPTIBLE)" will introduce
> > logic error when software flow run into "else" block. The reason is
> > after you set state with TASK_INTERRUPTIBLE, if there have some
> > scheduling happen within cpufreq_sched_try_driver_target(), then the
> > thread will be remove from rq. But generally we suppose the thread
> > will be on rq and can continue run after next tick.
> > 
> > Juri's suggestion can fix this issue. And we can use atomic_t to
> > safely accessing gd->requested_freq.
> 
> I agree, it's incorrect. As I replied earlier I believe setting the task
> state back to TASK_RUNNING at the top of the else block is the easiest fix.

Could you check if below corner case will introduce logic error?
The task still will be removed from rq if timer tick is triggered
between two time's set_current_state().

set_current_state(TASK_INTERRUPTIBLE);
           `-------> timer_tick and
                     schedule();
do_something...
set_current_state(TASK_RUNNING);

It will be safe for combination for set_current_state()/schedule()
with waken_up_process():

Thread_A:                                       Thread_B:

set_current_state(TASK_INTERRUPTIBLE);
             `-------> timer_tick and
                       schedule();
....
                                                wake_up_process(Thread_A);
                           <---------------------/
schedule();

The first time's schedule() will remove task from rq which is caused
by timer tick and call schedule(), and the second time schdule() will
be equal yeild().

Thanks,
Leo Yan
