From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/7] cpufreq: scpi: Register an Energy Model
Date: Tue, 29 Jan 2019 11:01:33 +0530
Message-ID: <20190129053133.l5wix4qgvty7bzig@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On 28-01-19, 16:55, Quentin Perret wrote:
> Now that PM_OPP provides a helper function to estimate the power
> consumed by CPUs, make sure to try and register an Energy Model (EM)
> from scpi-cpufreq, hence ensuring interested subsystems (the task
> scheduler, for example) can make use of that information when available.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 87a98ec77773..05fc7448f5cb 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> @@ -98,11 +99,12 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  
>  static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  {
> -	int ret;
> +	int ret, nr_opp;
>  	unsigned int latency;
>  	struct device *cpu_dev;
>  	struct scpi_data *priv;
>  	struct cpufreq_frequency_table *freq_table;
> +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -135,6 +137,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;

Same comment here.

-- 
viresh
