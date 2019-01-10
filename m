From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 3/7] cpu_cooling: Add generic driver ready callback
Date: Thu, 10 Jan 2019 11:44:50 +0530
Message-ID: <20190110061450.tdvanixjr6zdajhb@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <9cccfabf22ccae92dfd31175b57baab3206eac0d.1547078153.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9cccfabf22ccae92dfd31175b57baab3206eac0d.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10-01-19, 05:30, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a generic call back so we can get rid of duplicated code in the
> drivers.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/thermal/cpu_cooling.c | 18 ++++++++++++++++++
>  include/linux/cpu_cooling.h   |  9 +++++++++
>  2 files changed, 27 insertions(+)

We may be doing this differently, but I found some other issues with
the patch.

> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dfd23245f778..5154ffc12332 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -694,6 +694,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  
>  	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
>  	cpufreq_cdev->cdev = cdev;
> +	policy->cooldev = cdev;

Why was this required ? The below routine was already doing it...

>  
>  	mutex_lock(&cooling_list_lock);
>  	/* Register the notifier for first cpufreq cooling device */
> @@ -785,6 +786,23 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  }
>  EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
>  
> +/**
> + * generic_cpufreq_ready - generic driver callback to register a thermal_cooling_device
> + * @policy: cpufreq policy
> + */
> +void generic_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct thermal_cooling_device **cdev = &policy->cooldev;
> +
> +	*cdev = of_cpufreq_cooling_register(policy);

... here

> +	if (IS_ERR(*cdev)) {

We never get an error here, only NULL.

> +		pr_err("Failed to register cpufreq cooling device for CPU%d: %ld\n",
> +		       policy->cpu, PTR_ERR(cdev));

The of_cpufreq_cooling_register() routine already prints enough error
messages on failures.

> +		cdev = NULL;

This is a meaningless statement, perhaps you wanted to do *cdev = NULL
:)

-- 
viresh
