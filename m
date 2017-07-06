From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/6] cpufreq: schedutil: ignore sugov kthreads
Date: Thu, 6 Jul 2017 10:20:18 +0530
Message-ID: <20170706045018.GP3532@vireshk-i7>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-2-git-send-email-patrick.bellasi@arm.com>
 <20170705050056.GN3532@vireshk-i7>
 <20170705113834.GB2659@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705113834.GB2659@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On 05-07-17, 12:38, Patrick Bellasi wrote:
> On 05-Jul 10:30, Viresh Kumar wrote:
> > Yes we discussed this last time as well (I looked again at those discussions and
> > am still confused a bit), but wanted to clarify one more time.
> > 
> > After the 2nd patch of this series is applied, why will we still have this
> > problem? As we concluded it last time, the problem wouldn't happen until the
> > time the sugov RT thread is running (Hint: work_in_progress). And once the sugov
> > RT thread is gone, one of the other scheduling classes will take over and should
> > update the flag pretty quickly.
> > 
> > Are we worried about the time between the sugov RT thread finishes and when the
> > CFS or IDLE sched class call the util handler again? If yes, then we will still
> > have that problem for any normal RT/DL task. Isn't it ?
> 
> Yes, we are worried about that time,

But isn't that a very very small amount of time? i.e. As soon as the RT thread
is finished, we will select the next task from CFS or go to IDLE class (of
course if there is nothing left in DL/RT). And this should happen very quickly.
Are we sure we really see problems in that short time? Sure it can happen, but
it looks to be an extreme corner case and just wanted to check if it really
happened for you after the 2nd patch.

> without this we can generate
> spikes to the max OPP even when only relatively small FAIR tasks are
> running.
> 
> The same problem is not there for the other "normal RT/DL" tasks, just
> because for those tasks this is the expected behavior: we wanna go to
> max.

By same problem I meant that after the last RT task is finished and before the
pick_next_task of the IDLE_CLASS (or CFS) is called, we can still get a callback
into schedutil and that may raise the frequency to MAX. Its a similar kind of
problem, but yes we never wanted the freq to go to max for sugov thread.

> To the contrary the sugov kthread, although being a RT task, is just
> functional to the "machinery" to work, it's an actuator. Thus, IMO it
> makes no sense from a design standpoint for it to interfere whatsoever
> with what the "machinery" is doing.

I think everyone agrees on this. I was just exploring if that can be achieved
without any special code like what this patch proposes.

I was wondering about what will happen for a case where we have two RT tasks
(one of them is sugov thread) and when we land into schedutil the current task
is sugov. With this patch we will not set the flag, but actually we have another
task which is RT.

-- 
viresh
