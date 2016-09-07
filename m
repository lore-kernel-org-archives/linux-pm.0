From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Fix wrong comment call function
 name
Date: Wed, 7 Sep 2016 10:34:30 +0530
Message-ID: <20160907050430.GM27345@vireshk-i7>
References: <1473208539-17685-1-git-send-email-hugh.kang@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473208539-17685-1-git-send-email-hugh.kang@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inhyuk Kang <hugh.kang@lge.com>
Cc: Javi Merino <javi.merino@arm.com>, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07-09-16, 09:35, Inhyuk Kang wrote:
> The last_load is updated not cpufreq_get_actual_power() function call
> but cpufreq_get_requested_power() function call.
> 
> Signed-off-by: Inhyuk Kang <hugh.kang@lge.com>
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index a32b417..9ce0e9e 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -74,7 +74,7 @@ struct power_table {
>   *	cpufreq frequencies.
>   * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
>   * @node: list_head to link all cpufreq_cooling_device together.
> - * @last_load: load measured by the latest call to cpufreq_get_actual_power()
> + * @last_load: load measured by the latest call to cpufreq_get_requested_power()
>   * @time_in_idle: previous reading of the absolute time that this cpu was idle
>   * @time_in_idle_timestamp: wall time of the last invocation of
>   *	get_cpu_idle_time_us()

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
