From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH V2] intel_pstate: Add Haswell CPU models
Date: Mon, 09 Sep 2013 09:39:27 -0700
Message-ID: <522DF9BF.3060900@gmail.com>
References: <51D0B831.3000707@spicious.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51D0B831.3000707@spicious.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nell Hardcastle <nell@spicious.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, dirk.j.brandewie@intel.com, dirk.brandewie@gmail.com
List-Id: linux-pm@vger.kernel.org

On 06/30/2013 03:58 PM, Nell Hardcastle wrote:
> Enable the intel_pstate driver for Haswell CPUs. One missing Ivy Bridge
> model (0x3E) is also included. Models referenced from
> tools/power/x86/turbostat/turbostat.c:has_nehalem_turbo_ratio_limit
>

Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Nell Hardcastle <nell@spicious.com>
> ---
>   drivers/cpufreq/intel_pstate.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 07f2840..dbd1032 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -522,6 +522,11 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>   	ICPU(0x2a, default_policy),
>   	ICPU(0x2d, default_policy),
>   	ICPU(0x3a, default_policy),
> +	ICPU(0x3c, default_policy),
> +	ICPU(0x3e, default_policy),
> +	ICPU(0x3f, default_policy),
> +	ICPU(0x45, default_policy),
> +	ICPU(0x46, default_policy),
>   	{}
>   };
>   MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
>

