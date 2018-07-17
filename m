From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Tue, 17 Jul 2018 08:29:06 +0530
Message-ID: <3163a20a-31ca-15a0-56e2-38e977b21ae2@codeaurora.org>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
 <20180716051219.36rdvxux3lz3rjed@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716051219.36rdvxux3lz3rjed@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org



On 7/16/2018 10:42 AM, Viresh Kumar wrote:
> On 12-07-18, 23:35, Taniya Das wrote:
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	unsigned int offset, cpu_r;
>> +	int ret;
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	c->reg_offset = of_device_get_match_data(&pdev->dev);
>> +	if (!c->reg_offset)
>> +		return -EINVAL;
>> +
>> +	if (of_address_to_resource(np, 0, &res))
>> +		return -ENOMEM;
>> +
>> +	c->base = devm_ioremap(dev, res.start, resource_size(&res));
>> +	if (!c->base) {
>> +		dev_err(dev, "Unable to map %s base\n", np->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	offset = c->reg_offset[REG_ENABLE];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->base + offset) & 0x1)) {
>> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
>> +	if (!c->max_cores)
>> +		return -ENOENT;
>> +
>> +	ret = qcom_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	qcom_freq_domain_map[cpu] = c;
>> +
>> +	/* Related CPUs to keep a single copy */
>> +	cpu_r = cpumask_first(&c->related_cpus);
>> +	if (cpu != cpu_r) {
>> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
>> +		devm_kfree(dev, c);
>> +	}
> 
> Sorry about missing this, you have actually worked on my comments.
> 
> But I think this isn't the clever way of doing it. You allocate the
> structures, fill everything and then finally free them because we were
> related. Why can't we have similar check at the top of this routine
> and skip everything then ?
> 

Thanks Viresh, I actually replied to all the reviewers with the changes 
I have made in v5 series, sorry for not replying individually to all 
reviewers. Yes, I agree I should have put this check at the beginning of 
the function.

Please help review of the new series[v5] which takes care of the below.

- Remove mapping different register regions of perf/lut/enable,
   instead map the entire HW region.
- Add reg_offset/cpufreq_qcom_std_offsets to be supplied as device data.
- Check of src == 0 during lut read.
- Add of_node_put(cpu_np) in qcom_get_related_cpus
- Update the qcom_cpu_resources_init for register offset data,
   and cleanup the related cpus to keep a single copy of CPUfreq.
- Replace FW with HW, update Kconfig, rename filename qcom-cpufreq-hw.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
