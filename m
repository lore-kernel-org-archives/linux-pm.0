From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal/drivers/cpu_cooling: Remove pointless test in
 power2state()
Date: Thu, 25 Apr 2019 11:03:43 +0530
Message-ID: <20190425053343.zmvwd3ndpxkh24j5@vireshk-i7>
References: <20190424205610.9376-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424205610.9376-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 24-04-19, 22:56, Daniel Lezcano wrote:
> When the static power computation was removed, the test with the power
> being negative was not removed. However, the substraction which was
> responsible of the negative value was removed and the variable is now
> an u32. A double reason to remove the test which does not make sense.
> 
> Fixes: 84fe2cab48590 ("cpu_cooling: Drop static-power related stuff")
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..ee8419a6390c 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -541,7 +541,6 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>  	struct cpufreq_policy *policy = cpufreq_cdev->policy;
>  
> -	power = power > 0 ? power : 0;
>  	last_load = cpufreq_cdev->last_load ?: 1;
>  	normalised_power = (power * 100) / last_load;
>  	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
