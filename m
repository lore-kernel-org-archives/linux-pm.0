From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Date: Wed, 23 Jan 2019 16:06:24 +0530
Message-ID: <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Tao Wang <kevin.wangtao@hisilicon.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21-01-19, 21:10, Amit Kucheria wrote:
> @@ -151,6 +152,11 @@ struct cpufreq_policy {
>  
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
> +
> +#ifdef CONFIG_CPU_THERMAL
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
> +#endif
>  };
>  
>  /* Only for ACPI */
> @@ -386,6 +392,12 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>  
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device.
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
>  			policy->cpuinfo.max_freq);
>  }
>  
> +#ifdef CONFIG_CPU_THERMAL
> +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> +	policy->cdev = of_cpufreq_cooling_register(policy);
> +}
> +
> +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> +	cpufreq_cooling_unregister(policy->cdev);
> +	policy->cdev = NULL;
> +}
> +#else
> +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> +#endif

The whole ifdef hackery here saves space for a pointer per policy.
Just get rid of it, it isn't worth it.

-- 
viresh
