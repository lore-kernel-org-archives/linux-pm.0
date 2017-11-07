From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 20/20] cpufreq: scmi: add support for fast frequency
 switching
Date: Tue, 7 Nov 2017 10:57:29 +0000
Message-ID: <7deac477-8400-a223-420b-63f5a483c546@arm.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-21-git-send-email-sudeep.holla@arm.com>
 <20171107061933.GC3297@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107061933.GC3297@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 07/11/17 06:19, Viresh Kumar wrote:
> On 03-11-17, 14:47, Sudeep Holla wrote:
>> The cpufreq core provides option for drivers to implement fast_switch
>> callback which is invoked for frequency switching from interrupt context.
>>
>> This patch adds support for fast_switch callback in SCMI cpufreq driver
>> by making use of polling based SCMI transfer. It also sets the flag
>> fast_switch_possible.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/cpufreq/scmi-cpufreq.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index b1057a13e6a7..91df5013f7b2 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -64,6 +64,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>>  	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
>>  }
>>  
>> +static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
>> +					     unsigned int target_freq)
>> +{
>> +	struct scmi_data *priv = policy->driver_data;
>> +	struct scmi_perf_ops *perf_ops = handle->perf_ops;
>> +
>> +	if (!perf_ops->freq_set(handle, priv->domain_id,
>> +				target_freq * 1000, true))
>> +		return target_freq;
>> +
>> +	return 0;
>> +}
>> +
>>  static int
>>  scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>>  {
>> @@ -167,6 +180,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  
>>  	policy->cpuinfo.transition_latency = latency;
>>  
>> +	policy->fast_switch_possible = true;
>>  	return 0;
>>  
>>  out_free_cpufreq_table:
>> @@ -183,6 +197,7 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>>  {
>>  	struct scmi_data *priv = policy->driver_data;
>>  
>> +	policy->fast_switch_possible = false;
> 
> You don't need this.
> 

OK, dropped now.

>>  	cpufreq_cooling_unregister(priv->cdev);
>>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>>  	kfree(priv);
>> @@ -226,6 +241,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>>  	.verify	= cpufreq_generic_frequency_table_verify,
>>  	.attr	= cpufreq_generic_attr,
>>  	.target_index	= scmi_cpufreq_set_target,
>> +	.fast_switch	= scmi_cpufreq_fast_switch,
>>  	.get	= scmi_cpufreq_get_rate,
>>  	.init	= scmi_cpufreq_init,
>>  	.exit	= scmi_cpufreq_exit,
> 
> Apart from that.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks

-- 
Regards,
Sudeep
