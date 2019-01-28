From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Date: Mon, 28 Jan 2019 11:36:56 -0800
Message-ID: <20190128193656.GI81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-3-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 04:55:17PM +0000, Quentin Perret wrote:
> Now that PM_OPP provides a helper function to estimate the power
> consumed by CPUs, make sure to try and register an Energy Model (EM)
> from cpufreq-dt, hence ensuring interested subsystems (the task
> scheduler, for example) can make use of that information when available.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..7556e07e7a9f 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -152,6 +153,7 @@ static int resources_available(void)
>  
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
>  	struct cpufreq_frequency_table *freq_table;
>  	struct opp_table *opp_table = NULL;
>  	struct private_data *priv;
> @@ -160,7 +162,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned int transition_latency;
>  	bool fallback = false;
>  	const char *name;
> -	int ret;
> +	int ret, nr_opp;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -237,6 +239,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;
>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);

The perf domain is registered here but not unregistered in exit()
(there is currently no API do do this). When init() is called for the
second (or third, ...) time em_register_perf_domain() is called again,
though it skips the registration. To make things more explicit and not
rely on internal behavior of em_register_perf_domain() you could place
the registration inside an 'if (!em_cpu_get(cpu))' branch.

You should probably check the return value of em_register_perf_domain()
and at least print a warning in case of failure. This would require to
call em_register_perf_domain() only when CONFIG_ENERGY_MODEL=y (the
function returns -EINVAL otherwise).

I think this patch will result in error messages at registration on
platforms that use the cpufreq-dt driver and don't specify
'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
a problem as long as the cpufreq initialization succeeds regardless,
it could be seen as a not-so-gentle nudge to add the values.

Cheers

Matthias
