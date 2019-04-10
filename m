From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's
 OPP tables
Date: Wed, 10 Apr 2019 16:46:20 +0530
Message-ID: <8aeedc48150da49b7ab2ce27dd45a455@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-8-sibis@codeaurora.org>
 <20190410103316.sxev2f54klemq2p6@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410103316.sxev2f54klemq2p6@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org, bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org
List-Id: linux-pm@vger.kernel.org

On 2019-04-10 16:03, Viresh Kumar wrote:
> On 28-03-19, 20:58, Sibi Sankar wrote:
>> Add support to parse and update OPP tables attached to the cpu nodes.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 4b0b50403901..5c268dd2346c 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -73,6 +73,25 @@ static unsigned int 
>> qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>>  	return policy->freq_table[index].frequency;
>>  }
>> 
>> +static int qcom_find_update_opp(struct device *cpu_dev, unsigned long 
>> freq,
>> +				unsigned long volt)
>> +{
>> +	int ret;
>> +	struct dev_pm_opp *opp;
>> +
>> +	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
>> +	if (IS_ERR(opp)) {
>> +		ret = dev_pm_opp_add(cpu_dev, freq, volt);
> 
> With my comment on the other patch, you can just call
> dev_pm_opp_update_voltage() and if that fails then call 
> dev_pm_opp_add().

yeah that should simplify things.

Also through the above approach I cannot
really disable opps that the OSM does not
support. I can only try enabling opp's that
OSM supports. But that would require all
opp's nodes to start with "disabled" but
that is not allowed I guess.

> 
>> +	} else {
>> +		dev_pm_opp_disable(cpu_dev, freq);
>> +		ret = dev_pm_opp_update_voltage(cpu_dev, freq, volt);
>> +		dev_pm_opp_enable(cpu_dev, freq);
> 
> Perhaps no one else should be using the CPU OPP table at this point of 
> time and
> so we can get away with disable and enable stuff ? Just add a comment 
> on why
> that works.

we can get away without enable/disable here

> 
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>  				    struct cpufreq_policy *policy,
>>  				    void __iomem *base)
>> @@ -81,11 +100,16 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  	u32 volt;
>>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>>  	struct cpufreq_frequency_table	*table;
>> +	int ret;
>> 
>>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>  	if (!table)
>>  		return -ENOMEM;
>> 
>> +	ret = dev_pm_opp_of_add_table(cpu_dev);
>> +	if (ret)
>> +		dev_dbg(cpu_dev, "Couldn't add OPP table\n");
>> +
>>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>>  		data = readl_relaxed(base + REG_FREQ_LUT +
>>  				      i * LUT_ROW_SIZE);
>> @@ -104,7 +128,7 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>> 
>>  		if (freq != prev_freq && core_count == max_cores) {
>>  			table[i].frequency = freq;
>> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
>> +			qcom_find_update_opp(cpu_dev, freq * 1000, volt);
>>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>>  				freq, core_count);
>>  		} else {
>> @@ -125,7 +149,8 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  			if (prev_cc != max_cores) {
>>  				prev->frequency = prev_freq;
>>  				prev->flags = CPUFREQ_BOOST_FREQ;
>> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
>> +				qcom_find_update_opp(cpu_dev, prev_freq * 1000,
>> +						     volt);
>>  			}
>> 
>>  			break;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
