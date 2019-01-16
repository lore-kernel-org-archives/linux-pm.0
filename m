From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 01/10] cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date: Wed, 16 Jan 2019 23:56:05 +0100
Message-ID: <1718046.8NPD0iV1Wv@aspire.rjw.lan>
References: <cover.1547481320.git.amit.kucheria@linaro.org> <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 14, 2019 5:34:53 PM CET Amit Kucheria wrote:
> Several cpufreq drivers register themselves as thermal cooling devices.
> Adding a pointer to struct cpufreq_policy removes the need for them to
> store this pointer in a private data structure.
> 
> We can then auto-register the cpufreq driver as a thermal cooling device
> from cpufreq core code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  include/linux/cpufreq.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8bdfed..7d0cf54125fa 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -95,6 +95,11 @@ struct cpufreq_policy {
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;
>  
> +#ifdef CONFIG_CPU_THERMAL
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cooldev;
> +#endif
> +

Why here and not at the end of the struct?

>  	struct list_head        policy_list;
>  	struct kobject		kobj;
>  	struct completion	kobj_unregister;
> 

Also, I would suggest combining this one with patch [02/10].
