From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 0/2] sched: cpufreq: Allow remote callbacks
Date: Wed, 02 Aug 2017 01:22:46 +0200
Message-ID: <2779554.PPOFIyaKmk@aspire.rjw.lan>
References: <cover.1501223897.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501223897.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, skannan@codeaurora.org, joelaf@google.com, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 28, 2017 12:16:37 PM Viresh Kumar wrote:
> With Android UI and benchmarks the latency of cpufreq response to
> certain scheduling events can become very critical. Currently, callbacks
> into cpufreq governors are only made from the scheduler if the target
> CPU of the event is the same as the current CPU. This means there are
> certain situations where a target CPU may not run the cpufreq governor
> for some time.
> 
> One testcase [1] to show this behavior is where a task starts running on
> CPU0, then a new task is also spawned on CPU0 by a task on CPU1. If the
> system is configured such that the new tasks should receive maximum
> demand initially, this should result in CPU0 increasing frequency
> immediately. But because of the above mentioned limitation though, this
> does not occur.
> 
> This series updates the scheduler core to call the cpufreq callbacks for
> remote CPUs as well and updates the registered hooks to handle that.
> 
> This is tested with couple of usecases (Android: hackbench, recentfling,
> galleryfling, vellamo, Ubuntu: hackbench) on ARM hikey board (64 bit
> octa-core, single policy). Only galleryfling showed minor improvements,
> while others didn't had much deviation.
> 
> The reason being that this patch only targets a corner case, where
> following are required to be true to improve performance and that
> doesn't happen too often with these tests:
> 
> - Task is migrated to another CPU.
> - The task has high demand, and should take the target CPU to higher
>   OPPs.
> - And the target CPU doesn't call into the cpufreq governor until the
>   next tick.
> 
> Rebased over: pm/linux-next
> 
> V4->V5:
> - Drop cpu field from "struct update_util_data" and add it in "struct
>   sugov_cpu" instead.
> - Can't have separate patches now because of the above change and so
>   merged all the patches from V4 into a single patch.
> - Add a comment suggested by PeterZ.
> - Commit log of 1/2 is improved to contain more details.
> - A new patch (which was posted during V1) is also added to take care of
>   platforms where any CPU can do DVFS on behalf of any other CPU, even
>   if they are part of different cpufreq policies. This has been
>   requested by Saravana several times already and as the series is quite
>   straight forward now, I decided to include it in.
> 
> V3->V4:
> - Respect iowait boost flag and util updates for the all remote
>   callbacks.
> - Minor updates in commit log of 2/3.
> 
> V2->V3:
> - Rearranged/merged patches as suggested by Rafael (looks much better
>   now)
> - Also handle new hook added to intel-pstate driver.
> - The final code remains the same as V2, except for the above hook.
> 
> V1->V2:
> - Don't support remote callbacks for unshared cpufreq policies.
> - Don't support remote callbacks where local CPU isn't part of the
>   target CPU's cpufreq policy.
> - Dropped dvfs_possible_from_any_cpu flag.
> 

Applied with the tags from Peter and Saravana.

Thanks,
Rafael
