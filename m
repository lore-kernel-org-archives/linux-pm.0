From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Thu, 17 Jan 2019 12:35:54 +0530
Message-ID: <09114ef8-6ea7-ea92-caab-d5ea2904523f@codeaurora.org>
References: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
 <20190109085400.mscuzezwxta4fpfh@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109085400.mscuzezwxta4fpfh@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Hello Viresh,

On 1/9/2019 2:24 PM, Viresh Kumar wrote:
> On 09-01-19, 13:37, Taniya Das wrote:
>> @@ -98,6 +107,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> 
> You are only using this "dev" parameter for dev_dbg(), instead of that
> pass cpu_dev pointer.
> 

Sure, will clean it up to use cpu_dev.

>>   			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>>   		} else {
>>   			table[i].frequency = freq;
>> +			dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +					freq * 1000, volt);
>>   			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>>   				freq, core_count);
>>   		}
>> @@ -116,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>   			if (prev_cc != max_cores) {
>>   				prev->frequency = prev_freq;
>>   				prev->flags = CPUFREQ_BOOST_FREQ;
>> +				dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +						prev_freq * 1000, volt);
>>   			}
>>
>>   			break;
>> @@ -127,6 +140,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>
>>   	table[i].frequency = CPUFREQ_TABLE_END;
>>   	policy->freq_table = table;
>> +	dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu), policy->cpus);
> 
> and then all the above sites can be simplified a bit.
> 
>>   	return 0;
>>   }
>> @@ -159,10 +173,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   	struct device *dev = &global_pdev->dev;
>>   	struct of_phandle_args args;
>>   	struct device_node *cpu_np;
>> +	struct device *cpu_dev;
>>   	struct resource *res;
>>   	void __iomem *base;
>>   	int ret, index;
>>
>> +	cpu_dev = get_cpu_device(policy->cpu);
>> +	if (!cpu_dev) {
>> +		pr_err("%s: failed to get cpu%d device\n", __func__,
>> +		       policy->cpu);
>> +		return -ENODEV;
>> +	}
>> +
>>   	cpu_np = of_cpu_device_node_get(policy->cpu);
>>   	if (!cpu_np)
>>   		return -EINVAL;
>> @@ -205,6 +227,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   		goto error;
>>   	}
>>
>> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
>> +	if (ret <= 0) {
>> +		dev_err(cpu_dev, "OPP table is not ready\n");
> 
> Rather say "Failed to add OPPs\n".
> 

Sure will update it.

>> +		goto error;
>> +	}
>> +
>>   	policy->fast_switch_possible = true;
>>
>>   	return 0;
>> @@ -217,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>   	void __iomem *base = policy->driver_data - REG_PERF_STATE;
>>
>> +	dev_pm_opp_remove_all_dynamic(&global_pdev->dev);
> 
> This is platform device's device structure, while you added the OPPs
> using cpu_dev. You sure this will work ?
> 

Hmm, yeah, would update it in the next patch.

>>   	kfree(policy->freq_table);
>>   	devm_iounmap(&global_pdev->dev, base);
>>
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
