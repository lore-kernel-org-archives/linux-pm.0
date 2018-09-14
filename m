From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Fri, 14 Sep 2018 13:10:03 +0200
Message-ID: <20180914111003.GC24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906144053.GD25636@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 06, 2018 at 03:40:53PM +0100, Patrick Bellasi wrote:
> 1) _I think_ we don't want to depend on capable(CAP_SYS_NICE) but
>    instead on capable(CAP_SYS_ADMIN)
> 
>    Does that make sense ?

Neither of them really makes sense to me.

The max clamp makes a task 'consume' less and you should always be able
to reduce yourself.

The min clamp doesn't avoid while(1); and is therefore also not a
problem.

So I think setting clamps on a task should not be subject to additional
capabilities.

Now, of course, there is a problem of clamp resources, which are
limited. Consuming those _is_ a problem.

I think the problem here is that the two are conflated in the very same
interface.

Would it make sense to move the available clamp values out to some sysfs
interface like thing and guard that with a capability, while keeping the
task interface unprivilidged?

Another thing that has me 'worried' about this interface is the direct
tie to CPU capacity (not that I have a better suggestion). But it does
raise the point of how userspace is going to discover the relevant
values of the platform.
