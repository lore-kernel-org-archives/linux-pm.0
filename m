From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 18/18] cpufreq: scmi: add support for fast frequency
 switching
Date: Wed, 9 Aug 2017 09:58:25 +0530
Message-ID: <20170809042825.GI28857@vireshk-i7>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-19-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501857104-11279-19-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Alexey Klimov <alexey.klimov@arm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-08-17, 15:31, Sudeep Holla wrote:
> The cpufreq core provides option for drivers to implement fast_switch
> callback which is invoked for frequency switching from interrupt context.
> 
> This patch adds support for fast_switch callback in SCMI cpufreq driver
> by making use of polling based SCMI transfer. It also sets the flag
> fast_switch_possible.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 034359cafea5..cb1084cb1ef1 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -61,6 +61,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	return perf_ops->freq_set(priv->handle, priv->domain_id, freq, false);
>  }
>  
> +static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +					     unsigned int target_freq)
> +{
> +	struct scmi_data *priv = policy->driver_data;
> +	struct scmi_perf_ops *perf_ops = priv->handle->perf_ops;
> +
> +	if (!perf_ops->freq_set(priv->handle, priv->domain_id,
> +				target_freq * 1000, true))
> +		return target_freq;
> +
> +	return CPUFREQ_ENTRY_INVALID;
> +}

This is very much similar to the target routine, perhaps we should write another
local routine which is used by both target and fast switch.

Do we guarantee that the frequency is changed by the time this routine returns?
Or we just send a SCMI request and return back ?

If we just send the request and don't wait for freq to get changed, what
protects another scmi_cpufreq_fast_switch() to get called before the first one
is finished? And what will happen on that call ?

>  static int
>  scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  {
> @@ -164,6 +177,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> +	policy->fast_switch_possible = true;
>  	return 0;
>  
>  out_free_cpufreq_table:
> @@ -180,6 +194,7 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct scmi_data *priv = policy->driver_data;
>  
> +	policy->fast_switch_possible = false;
>  	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
> @@ -228,6 +243,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>  	.init			= scmi_cpufreq_init,
>  	.exit			= scmi_cpufreq_exit,
>  	.ready			= scmi_cpufreq_ready,
> +	.fast_switch		= scmi_cpufreq_fast_switch,

Maybe add it right after target_index ?

-- 
viresh
