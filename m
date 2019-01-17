From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v3] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Thu, 17 Jan 2019 16:30:37 +0530
Message-ID: <d9cf7ab9-a5f9-5c1a-940b-5ddb12d8ff9a@codeaurora.org>
References: <1547708936-25661-1-git-send-email-tdas@codeaurora.org>
 <20190117072716.iy3glrtdpobsh5u2@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117072716.iy3glrtdpobsh5u2@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
List-Id: linux-pm@vger.kernel.org



On 1/17/2019 12:57 PM, Viresh Kumar wrote:
> On 17-01-19, 12:38, Taniya Das wrote:
>> @@ -159,10 +170,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
>> @@ -199,12 +218,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>
>>   	policy->driver_data = base + REG_PERF_STATE;
>>
>> -	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
>> +	ret = qcom_cpufreq_hw_read_lut(policy, base);
> 
> I asked you to pass cpu_dev here instead of dev and you said okay in
> the previous version of the patch. Didn't like it ?
> 

:(, sent the next patch for review.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
