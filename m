From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Date: Fri, 17 Aug 2018 15:43:59 +0200
Message-ID: <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806163946.28380-10-patrick.bellasi@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> In order to properly support hierarchical resources control, the cgroup
> delegation model requires that attribute writes from a child group never
> fail but still are (potentially) constrained based on parent's assigned
> resources. This requires to properly propagate and aggregate parent
> attributes down to its descendants.

I don't understand the reason mentioned here:

IMHO, a write to a child's (tg1/tg11) cpu.rt_runtime_us can fail if the 
value is restricted by the parents value:

root@juno:/sys/fs/cgroup/cpu# cat cpu.rt_*
1000000
950000
root@juno:/sys/fs/cgroup/cpu# cat tg1/cpu.rt_*
1000000
0
root@juno:/sys/fs/cgroup/cpu# cat tg1/tg11/cpu.rt_*
1000000
0
root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
-bash: echo: write error: Invalid argument
root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/cpu.rt_runtime_us
root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
root@juno:/sys/fs/cgroup/cpu#

> Let's implement this mechanism by adding a new "effective" clamp value
> for each task group. The effective clamp value is defined as the smaller
> value between the clamp value of a group and the effective clamp value
> of its parent. This represent also the clamp value which is actually
> used to clamp tasks in each task group.
> 
> Since it can be interesting for tasks in a cgroup to know exactly what
> is the currently propagated/enforced configuration, the effective clamp
> values are exposed to user-space by means of a new pair of read-only
> attributes: cpu.util.{min,max}.effective.

I assume here that the cpu.util.{min,max} of the child will not be used 
any more because the 'effective' counterparts are taken instead.

I wonder if this propagation not been provided with only 
cpu.util.{min,max}?

[...]
