From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V2 3/4] intel_pstate: Ignore scheduler cpufreq callbacks
 on remote CPUs
Date: Thu, 29 Jun 2017 14:23:58 -0700
Message-ID: <1498771438.7952.118.camel@linux.intel.com>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
         <a33ba3746dacce67a7c2e17b64e54ee89f64a3bc.1498712046.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17848 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbdF2VYA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jun 2017 17:24:00 -0400
In-Reply-To: <a33ba3746dacce67a7c2e17b64e54ee89f64a3bc.1498712046.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

On Thu, 2017-06-29 at 10:56 +0530, Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> In preparation for the scheduler cpufreq callback happening on remote
> CPUs, check for this case in intel_pstate which currently requires
> the
> callback run on the local CPU. Such callbacks are ignored for now.
Is it possible that we miss a chance to calculate load periodically at
a predefined interval (10ms default), because the callback happened on
a different CPU?

Thanks,
Srinivas

> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 4ce501148790..7a2a8ee579ef 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1755,6 +1755,9 @@ static void intel_pstate_update_util(struct
> update_util_data *data, u64 time,
>  	struct cpudata *cpu = container_of(data, struct cpudata,
> update_util);
>  	u64 delta_ns;
>  
> +	if (smp_processor_id() != data->cpu)
> +		return;
> +
>  	if (flags & SCHED_CPUFREQ_IOWAIT) {
>  		cpu->iowait_boost = int_tofp(1);
>  	} else if (cpu->iowait_boost) {
