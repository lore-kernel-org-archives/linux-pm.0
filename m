From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v6 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Tue, 24 Jul 2018 16:14:15 +0530
Message-ID: <d5c00072-84d3-6eda-52db-6d6dd4e313e1@codeaurora.org>
References: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
 <1531892220-2046-3-git-send-email-tdas@codeaurora.org>
 <20180718054647.ysomgxiwzbuuptoc@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718054647.ysomgxiwzbuuptoc@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Hello Viresh,

Thanks for your review comments.

On 7/18/2018 11:16 AM, Viresh Kumar wrote:
> On 18-07-18, 11:07, Taniya Das wrote:
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu,
>> +				   unsigned long xo_rate)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	const u16 *offsets;
>> +	cpumask_t cpus_related;
>> +	int ret, i, cpu_r;
>> +	void __iomem *base;
>> +
>> +	cpumask_clear(&cpus_related);
>> +
>> +	ret = qcom_get_related_cpus(np, &cpus_related);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	/* Related CPUs */
>> +	cpu_r = cpumask_first(&cpus_related);
>> +	if (cpu != cpu_r) {
>> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
>> +		return 0;
>> +	}
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	offsets = of_device_get_match_data(&pdev->dev);
>> +	if (!offsets)
>> +		return -EINVAL;
>> +
>> +	if (of_address_to_resource(np, 0, &res))
>> +		return -ENOMEM;
>> +
>> +	base = devm_ioremap_resource(dev, &res);
>> +	if (!base)
>> +		return -ENOMEM;
>> +
>> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
>> +		c->reg_bases[i] = base + offsets[i];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
>> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpumask_copy(&c->related_cpus, &cpus_related);
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
>> +	if (!c->max_cores)
>> +		return -ENOENT;
>> +
>> +	c->xo_rate = xo_rate;
>> +
>> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	qcom_freq_domain_map[cpu] = c;
> 
> Set this for all related CPUs here and then the check at the top of
> this routine will be simply:
> 
> if (qcom_freq_domain_map[cpu])
>          return 0;
> 

Please check the latest series, I have updated the code.

>> +
>> +	return 0;
>> +}
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
