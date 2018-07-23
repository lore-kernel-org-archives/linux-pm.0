From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Mon, 23 Jul 2018 08:30:40 -0700
Message-ID: <20180723153040.GG1934745@devbig577.frc2.facebook.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716082906.6061-9-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On Mon, Jul 16, 2018 at 09:29:02AM +0100, Patrick Bellasi wrote:
> The cgroup's CPU controller allows to assign a specified (maximum)
> bandwidth to the tasks of a group. However this bandwidth is defined and
> enforced only on a temporal base, without considering the actual
> frequency a CPU is running on. Thus, the amount of computation completed
> by a task within an allocated bandwidth can be very different depending
> on the actual frequency the CPU is running that task.
> The amount of computation can be affected also by the specific CPU a
> task is running on, especially when running on asymmetric capacity
> systems like Arm's big.LITTLE.

One basic problem I have with this patchset is that what's being
described is way more generic than what actually got implemented.
What's described is computation bandwidth control but what's
implemented is just frequency clamping.  So, there are fundamental
discrepancies between description+interface vs. what it actually does.

I really don't think that's something we can fix up later.

> These attributes:
> 
> a) are available only for non-root nodes, both on default and legacy
>    hierarchies
> b) do not enforce any constraints and/or dependency between the parent
>    and its child nodes, thus relying on the delegation model and
>    permission settings defined by the system management software

cgroup does host attributes which only concern the cgroup itself and
thus don't need any hierarchical behaviors on their own, but what's
being implemented does control resource allocation, and what you're
describing inherently breaks the delegation model.

> c) allow to (eventually) further restrict task-specific clamps defined
>    via sched_setattr(2)

Thanks.

-- 
tejun
