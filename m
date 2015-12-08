From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 21/27] drivers: cpu-pd: Parse topology to setup CPU
 PM domains
Date: Tue, 8 Dec 2015 11:05:36 -0700
Message-ID: <20151208180536.GB2230@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-22-git-send-email-lina.iyer@linaro.org>
 <20151207145458.GA20538@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151207145458.GA20538@red-moon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, ahaslam@baylibre.com, mtitinger@baylibre.com, Rob Herring <robherring2@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 07 2015 at 07:53 -0700, Lorenzo Pieralisi wrote:
>Hi Lina,
>
>On Tue, Nov 17, 2015 at 03:37:45PM -0700, Lina Iyer wrote:
>> Architectures that support CPU domain control in the firmware specify
>> the domain heirarchy as part of the topology nodes. Parse and initialize
>> domains from the topology node for such architectures.
>>
>> Cc: Rob Herring <robherring2@gmail.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/cpu-pd.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/cpu-pd.h      |  1 +
>>  2 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
>> index e331ae6..2872c18 100644
>> --- a/drivers/base/power/cpu-pd.c
>> +++ b/drivers/base/power/cpu-pd.c
>> @@ -429,3 +429,79 @@ int of_attach_cpu_pm_domain(struct device_node *dn)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(of_attach_cpu_pm_domain);
>> +
>> +static int of_parse_cpu_pd(struct device_node *cluster,
>> +		const struct cpu_pd_ops *ops)
>> +{
>> +	struct device_node *domain_node;
>> +	struct generic_pm_domain *genpd;
>> +	char name[10];
>> +	struct device_node *c;
>> +	int i, ret;
>> +
>> +	for (i = 0; ; i++) {
>> +		snprintf(name, sizeof(name), "cluster%d", i);
>> +		c = of_get_child_by_name(cluster, name);
>> +		if (!c)
>> +			break;
>> +
>> +		domain_node = of_parse_phandle(c, "cluster", 0);
>> +		if (!domain_node)
>> +			return -1;
>> +
>> +		/* Initialize CPU PM domain domain at this level */
>> +		genpd = of_init_cpu_pm_domain(domain_node, ops);
>> +		if (IS_ERR(genpd))
>> +			return -1;
>> +
>> +		/* Initialize and attach child domains */
>> +		ret = of_parse_cpu_pd(c, ops);
>> +
>> +		/*
>> +		 * Attach the domain to its parent after reading
>> +		 * the children, so the mask of CPUs in this domain
>> +		 * are setup correctly.
>> +		 */
>> +		if (!ret)
>> +			of_attach_cpu_pm_domain(domain_node);
>> +
>> +		of_node_put(c);
>> +		if (ret != 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * of_setup_cpu_domain_topology() - Setup the CPU domains from the CPU
>> + * topology node in DT.
>> + *
>> + * @ops: The PM domain suspend/resume ops for all the domains in the topology
>> + */
>> +int of_setup_cpu_domain_topology(const struct cpu_pd_ops *ops)
>> +{
>> +	struct device_node *cn, *map;
>> +	int ret = 0;
>> +
>> +	cn = of_find_node_by_path("/cpus");
>> +	if (!cn) {
>> +		pr_err("No CPU information found in DT\n");
>> +		return 0;
>> +	}
>> +
>> +	map = of_get_child_by_name(cn, "cpu-map");
>> +	if (!map)
>> +		goto out;
>
>I commented on this before, is this reliance on cpu-map necessary ?
>Could not you just rely on the "power-domains" phandle in the cpu
>nodes to build the cpumask for a specific power domain ? I think
>you should try to decouple the concept of power domain from the cpu-map
>cluster and I think this would also simplify your code in the process.
>
Sorry, I missed seeing your comment on this earlier.

Hmm, it can be done, but I felt out of place to define just power
domains that have no devices in Linux, since they are handled in PSCI,
but also have no relation to PSCI. Hence, I felt cpu-map to be a good
place for the cluster domain. But I am not strongly inclined. I can
remove them from the cpu-map and keep them as separate nodes. However,
it would be nice to have a way to say these nodes are PSCI controlled.

Thanks,
Lina

>So to sum it up, I'd suggest you build the power domain cpumask by
>enumerating the cpus pointing at a specific power-domain node.
>

>> +
>> +	ret = of_parse_cpu_pd(map, ops);
>> +	if (ret != 0)
>> +		goto out_map;
>> +
>> +out_map:
>> +	of_node_put(map);
>> +out:
>> +	of_node_put(cn);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(of_setup_cpu_domain_topology);
>> diff --git a/include/linux/cpu-pd.h b/include/linux/cpu-pd.h
>> index 489ee2f..e8290db 100644
>> --- a/include/linux/cpu-pd.h
>> +++ b/include/linux/cpu-pd.h
>> @@ -32,4 +32,5 @@ struct cpu_pm_domain {
>>  struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
>>  		const struct cpu_pd_ops *ops);
>>  int of_attach_cpu_pm_domain(struct device_node *dn);
>> +int of_setup_cpu_domain_topology(const struct cpu_pd_ops *ops);
>>  #endif /* __CPU_PD_H__ */
>> --
>> 2.1.4
>>
