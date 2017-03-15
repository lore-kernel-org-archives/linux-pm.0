From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 0/9] cpufreq: schedutil: Allow remote wakeups
Date: Wed, 15 Mar 2017 12:45:27 +0100
Message-ID: <4261790.UfzOU18DRK@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 09, 2017 05:15:10 PM Viresh Kumar wrote:
> Hi,
> 
> This is based of the work done by Steve Muckle [1] before he left Linaro
> and most of the patches are still under his authorship. I have done
> couple of improvements (detailed in individual patches) and removed the
> late callback support [2] as I wasn't sure of the value it adds. We can
> include it separately if others feel it is required. This series is
> based on pm/linux-next with patches [3] and [4] applied on top of it.
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
> This is verified using ftrace with the sample [5] application.
> 
> This patchset updates the scheduler to call cpufreq callbacks for remote
> CPUs as well and updates schedutil governor to deal with it. An
> additional flag is added to cpufreq policies to avoid sending IPIs to
> remote CPUs to update the frequency, if CPUs on the platform can change
> frequency of any other CPU.
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
>   higher OPPs.
> - And the target CPU doesn't call into schedutil until the next tick,
>   without this patchset.

>From the first quick look patches [1-3/9] seem to be split out somewhat
artificially.

Any chance to fold them into the patches where the new stuff is actually used?

I'll be looking at the rest of the patchset shortly.

Thanks,
Rafael
