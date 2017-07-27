From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Wed, 26 Jul 2017 22:14:56 -0700
Message-ID: <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Jul 26, 2017 at 2:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
<snip>
>
> With Android UI and benchmarks the latency of cpufreq response to
> certain scheduling events can become very critical. Currently, callbacks
> into schedutil are only made from the scheduler if the target CPU of the
> event is the same as the current CPU. This means there are certain
> situations where a target CPU may not run schedutil for some time.
>
> One testcase to show this behavior is where a task starts running on
> CPU0, then a new task is also spawned on CPU0 by a task on CPU1. If the
> system is configured such that new tasks should receive maximum demand
> initially, this should result in CPU0 increasing frequency immediately.
> Because of the above mentioned limitation though this does not occur.
> This is verified using ftrace with the sample [1] application.

I think you dropped [1] in your cover-letter. May be you meant to add
it at the end of the cover letter?

I noticed from your v2 that its:
https://pastebin.com/7LkMSRxE

Also one more comment about this usecase:

You mentioned in our discussion at [2] sometime back, about the
question of initial utilization,

"We don't have any such configurable way possible right
now, but there were discussions on how much utilization should a new
task be assigned when it first comes up."

But, then in your cover letter above, you mentioned "This is verified
using ftrace". So my question is how has this been verified with
ftrace if the new initial utilization as you said in [2] is currently
still under discussion? Basically how could you verify with ftrace
that the target CPU frequency isn't increasing immediately on spawning
of a new task remotely, if the initial utilization of a new task isn't
something we set/configure with current code? Am I missing something?

[2] https://lists.linaro.org/pipermail/eas-dev/2017-January/000785.html

>
> Maybe the ideal solution is to always allow remote callbacks but that
> has its own challenges:
>
> o There is no protection required for single CPU per policy case today,
>   and adding any kind of locking there, to supply remote callbacks,
>   isn't really a good idea.
>
> o If is local CPU isn't part of the same cpufreq policy as the target
>   CPU, then we wouldn't be able to do fast switching at all and have to
>   use some kind of bottom half to schedule work on the target CPU to do
>   real switching. That may be overkill as well.
>
>
> And so this series only allows remote callbacks for target CPUs that
> share the cpufreq policy with the local CPU.
>
> This series is tested with couple of usecases (Android: hackbench,
> recentfling, galleryfling, vellamo, Ubuntu: hackbench) on ARM hikey
> board (64 bit octa-core, single policy). Only galleryfling showed minor
> improvements, while others didn't had much deviation.
>
> The reason being that this patchset only targets a corner case, where
> following are required to be true to improve performance and that
> doesn't happen too often with these tests:
>
> - Task is migrated to another CPU.
> - The task has maximum demand initially, and should take the CPU to

Just to make the cover-letter more clear and also confirming with you
I understand the above usecase, maybe in the future this can reworded
from "initially" to "before the migration" and "take the CPU" to "take
the target CPU of the migration" ?

>   higher OPPs.
> - And the target CPU doesn't call into schedutil until the next tick.

I found this usecase to be more plausible and can see this patch
series being useful there.

Could you also keep me in CC on these patches (at joelaf@google.com)?
I'm interested in this series.

thanks!

-Joel
