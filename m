From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/7] sched/core: uclamp: add utilization clamping to the
 CPU controller
Date: Mon, 9 Apr 2018 15:24:17 -0700
Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-5-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409165615.2326-5-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

Hello, Patrick.

Comments purely on cgroup interface side.

On Mon, Apr 09, 2018 at 05:56:12PM +0100, Patrick Bellasi wrote:
> This patch extends the CPU controller by adding a couple of new attributes,
> util_min and util_max, which can be used to enforce frequency boosting and
> capping. Specifically:
> 
> - util_min: defines the minimum CPU utilization which should be considered,
> 	    e.g. when  schedutil selects the frequency for a CPU while a
> 	    task in this group is RUNNABLE.
> 	    i.e. the task will run at least at a minimum frequency which
> 	         corresponds to the min_util utilization
> 
> - util_max: defines the maximum CPU utilization which should be considered,
> 	    e.g. when schedutil selects the frequency for a CPU while a
> 	    task in this group is RUNNABLE.
> 	    i.e. the task will run up to a maximum frequency which
> 	         corresponds to the max_util utilization

I'm not too enthusiastic about util_min/max given that it can easily
be read as actual utilization based bandwidth control when what's
actually implemented, IIUC, is affecting CPU frequency selection.
Maybe something like cpu.freq.min/max are better names?

> These attributes:
> a) are tunable at all hierarchy levels, i.e. at root group level too, thus
>    allowing to define the minimum and maximum frequency constraints for all
>    otherwise non-classified tasks (e.g. autogroups) and to be a sort-of
>    replacement for cpufreq's powersave, ondemand and performance
>    governors.

This is a problem which exists for all other interfaces.  For
historical and other reasons, at least till now, we've opted to put
everything at system level outside of cgroup interface.  We might
change this in the future and duplicate system-level information and
interfaces in the root cgroup but we wanna do that in a more systemtic
fashion than adding an one-off knob in the cgroup root.

Besides, if a feature makes sense at the system level which is the
cgroup root, it makes sense without cgroup mounted or enabled, so it
needs a place outside cgroup one way or the other.

> b) allow to create subgroups of tasks which are not violating the
>    utilization constraints defined by the parent group.

Tying creation / config operations to the config propagation doesn't
work well with delegation and is inconsistent with what other
controllers are doing.  For cases where the propagated config being
visible in a sub cgroup is necessary, please add .effective files.

> Tasks on a subgroup can only be more boosted and/or capped, which is

Less boosted.  .low at a parent level must set the upper bound of .low
that all its descendants can have.

Thanks.

-- 
tejun
