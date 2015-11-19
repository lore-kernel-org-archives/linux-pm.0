From: Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH RFC 18/27] drivers: cpu-pd: Add PM Domain governor for
 CPUs
Date: Thu, 19 Nov 2015 09:50:30 +0100
Message-ID: <564D8D56.1080206@baylibre.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-19-git-send-email-lina.iyer@linaro.org>
 <20151118184245.GA28755@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20151118184245.GA28755@red-moon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, ahaslam@baylibre.com
List-Id: linux-pm@vger.kernel.org

On 18/11/2015 19:42, Lorenzo Pieralisi wrote:
> On Tue, Nov 17, 2015 at 03:37:42PM -0700, Lina Iyer wrote:
>> A PM domain comprising of CPUs may be powered off when all the CPUs in
>> the domain are powered down. Powering down a CPU domain is generally a
>> expensive operation and therefore the power performance trade offs
>> should be considered. The time between the last CPU powering down and
>> the first CPU powering up in a domain, is the time available for the
>> domain to sleep. Ideally, the sleep time of the domain should fulfill
>> the residency requirement of the domains' idle state.
>>
>> To do this effectively, read the time before the wakeup of the cluster's
>> CPUs and ensure that the domain's idle state sleep time guarantees the
>> QoS requirements of each of the CPU, the PM QoS CPU_DMA_LATENCY and the
>> state's residency.
>
> To me this information should be part of the CPUidle governor (it is
> already there), we should not split the decision into multiple layers.
>
> The problem you are facing is that the CPUidle governor(s) do not take
> cross cpus relationship into account, I do not think that adding another
> decision layer in the power domain subsystem helps, you are doing that
> just because adding it to the existing CPUidle governor(s) is invasive.
>
> Why can't we use the power domain work you put together to eg disable
> idle states that share multiple cpus and make them "visible" only
> when the power domain that encompass them is actually going down ?
>
> You could use the power domains information to detect states that
> are shared between cpus.
>
> It is just an idea, what I am saying is that having another governor in
> the power domain subsytem does not make much sense, you split the
> decision in two layers while there is actually one, the existing
> CPUidle governor and that's where the decision should be taken.
>
> Thoughts appreciated.

Maybe this is silly and not thought-through, but I wonder if the 
responsibilities could be split or instance with an outer control loop 
that has the heuristic to compute the next tick time, and the required 
cpu-power needed during that time slot, and an inner control loop 
(genpd) that has a per-domain QoS and can optimize power consumption.

Marc.

>
> Lorenzo
>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>   drivers/base/power/cpu-pd.c | 83 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
>> index 617ce54..a00abc1 100644
>> --- a/drivers/base/power/cpu-pd.c
>> +++ b/drivers/base/power/cpu-pd.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/pm_qos.h>
>>   #include <linux/rculist.h>
>>   #include <linux/slab.h>
>> +#include <linux/tick.h>
>>
>>   #define CPU_PD_NAME_MAX 36
>>
>> @@ -66,6 +67,86 @@ static void get_cpus_in_domain(struct generic_pm_domain *genpd,
>>   	}
>>   }
>>
>> +static bool cpu_pd_down_ok(struct dev_pm_domain *pd)
>> +{
>> +	struct generic_pm_domain *genpd = pd_to_genpd(pd);
>> +	struct cpu_pm_domain *cpu_pd = to_cpu_pd(genpd);
>> +	int qos = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>> +	u64 sleep_ns = ~0;
>> +	ktime_t earliest;
>> +	int cpu;
>> +	int i;
>> +
>> +	/* Reset the last set genpd state, default to index 0 */
>> +	genpd->state_idx = 0;
>> +
>> +	/* We dont want to power down, if QoS is 0 */
>> +	if (!qos)
>> +		return false;
>> +
>> +	/*
>> +	 * Find the sleep time for the cluster.
>> +	 * The time between now and the first wake up of any CPU that
>> +	 * are in this domain hierarchy is the time available for the
>> +	 * domain to be idle.
>> +	 */
>> +	earliest.tv64 = KTIME_MAX;
>> +	for_each_cpu_and(cpu, cpu_pd->cpus, cpu_online_mask) {
>> +		struct device *cpu_dev = get_cpu_device(cpu);
>> +		struct gpd_timing_data *td;
>> +
>> +		td = &dev_gpd_data(cpu_dev)->td;
>> +
>> +		if (earliest.tv64 < td->next_wakeup.tv64)
>> +			earliest = td->next_wakeup;
>> +	}
>> +
>> +	sleep_ns = ktime_to_ns(ktime_sub(earliest, ktime_get()));
>> +	if (sleep_ns <= 0)
>> +		return false;
>> +
>> +	/*
>> +	 * Find the deepest sleep state that satisfies the residency
>> +	 * requirement and the QoS constraint
>> +	 */
>> +	for (i = genpd->state_count - 1; i > 0; i--) {
>> +		u64 state_sleep_ns;
>> +
>> +		state_sleep_ns = genpd->states[i].power_off_latency_ns +
>> +			genpd->states[i].power_on_latency_ns +
>> +			genpd->states[i].residency_ns;
>> +
>> +		/*
>> +		 * If we cant sleep to save power in the state, move on
>> +		 * to the next lower idle state.
>> +		 */
>> +		if (state_sleep_ns > sleep_ns)
>> +		       continue;
>> +
>> +		/*
>> +		 * We also dont want to sleep more than we should to
>> +		 * gaurantee QoS.
>> +		 */
>> +		if (state_sleep_ns < (qos * NSEC_PER_USEC))
>> +			break;
>> +	}
>> +
>> +	if (i >= 0)
>> +		genpd->state_idx = i;
>> +
>> +	return  (i >= 0) ? true : false;
>> +}
>> +
>> +static bool cpu_stop_ok(struct device *dev)
>> +{
>> +	return true;
>> +}
>> +
>> +struct dev_power_governor cpu_pd_gov = {
>> +	.power_down_ok = cpu_pd_down_ok,
>> +	.stop_ok = cpu_stop_ok,
>> +};
>> +
>>   static int cpu_pd_power_off(struct generic_pm_domain *genpd)
>>   {
>>   	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>> @@ -183,7 +264,7 @@ int of_register_cpu_pm_domain(struct device_node *dn,
>>
>>   	/* Register the CPU genpd */
>>   	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);
>> -	ret = of_pm_genpd_init(dn, pd->genpd, &simple_qos_governor, false);
>> +	ret = of_pm_genpd_init(dn, pd->genpd, &cpu_pd_gov, false);
>>   	if (ret) {
>>   		pr_err("Unable to initialize domain %s\n", dn->full_name);
>>   		return ret;
>> --
>> 2.1.4
>>
