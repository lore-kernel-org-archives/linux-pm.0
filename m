From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 26 Aug 2015 13:47:36 +0100
Message-ID: <20150826124736.GA10956@e104805>
References: <20150820161402.GA4951@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150820161402.GA4951@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

I missed this because I wasn't CCed :(  Thankfully, I'll be in
MAINTAINERS for this soon.

On Thu, Aug 20, 2015 at 05:14:02PM +0100, Vaishali Thakkar wrote:
> In the function cpufreq_get_requested_power, the memory allocated
> for load_cpu is live within the function only. And after the
> allocation it is immediately freed with devm_kfree. There is no
> need to allocate memory for load_cpu with devm function so replace
> devm_kcalloc with kcalloc and devm_kfree with kfree.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
> Changes since v1:
> 	- Introduce new label based on Viresh Kumar's suggestion
> ---
>  drivers/thermal/cpu_cooling.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 620dcd4..7027923 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -584,8 +584,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  	if (trace_thermal_power_cpu_get_power_enabled()) {
>  		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
>  
> -		load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> -					GFP_KERNEL);
> +		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
>  	}
>  
>  	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
> @@ -607,22 +606,21 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  
>  	dynamic_power = get_dynamic_power(cpufreq_device, freq);
>  	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
> -	if (ret) {
> -		if (load_cpu)
> -			devm_kfree(&cdev->device, load_cpu);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free;
>  
> -	if (load_cpu) {
> +	if (load_cpu)
>  		trace_thermal_power_cpu_get_power(
>  			&cpufreq_device->allowed_cpus,
>  			freq, load_cpu, i, dynamic_power, static_power);
>  
> -		devm_kfree(&cdev->device, load_cpu);

This introduces a memory leak.  Keep the kfree() here, you can't drop
it.  Cheers,
Javi

> -	}
> -
>  	*power = static_power + dynamic_power;
>  	return 0;
> +
> +free:
> +	kfree(load_cpu);
> +
> +	return ret;
>  }
>  
>  /**
