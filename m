From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 8/9] intel_pstate: ignore scheduler cpufreq callbacks on remote CPUs
Date: Thu, 30 Mar 2017 00:15:33 +0200
Message-ID: <11658751.uecjsoxtRb@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <fdd9ba5de92726cc953d36c0a84f68dda5356dd3.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fdd9ba5de92726cc953d36c0a84f68dda5356dd3.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 09, 2017 05:15:18 PM Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> In preparation for the scheduler cpufreq callback happening on remote
> CPUs, check for this case in intel_pstate which currently requires the
> callback run on the local CPU. Such callbacks are ignored for now.
> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3d37219a0dd7..bd60f1cd7ea6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1930,6 +1930,9 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>  	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
>  	u64 delta_ns;
>  
> +	if (smp_processor_id() != data->cpu)
> +		return;
> +
>  	if (pstate_funcs.get_target_pstate == get_target_pstate_use_cpu_load) {
>  		if (flags & SCHED_CPUFREQ_IOWAIT) {
>  			cpu->iowait_boost = int_tofp(1);
> 

This would need to be updated on top of some intel_pstate changes in the queue.

Thanks,
Rafael
