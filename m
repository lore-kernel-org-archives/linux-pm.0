From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 03/12] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
Date: Tue, 1 Mar 2016 11:00:10 -0700
Message-ID: <20160301180010.GK1440@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
 <20160226191016.GW28849@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33036 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcCASAO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 13:00:14 -0500
Received: by mail-pa0-f41.google.com with SMTP id fl4so116185412pad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 10:00:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160226191016.GW28849@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Feb 26 2016 at 12:10 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
>> new file mode 100644
>> index 0000000..981592f
>> --- /dev/null
>> +++ b/drivers/base/power/cpu_domains.c
>> @@ -0,0 +1,267 @@
>> +
>> +/* List of CPU PM domains we care about */
>> +static LIST_HEAD(of_cpu_pd_list);
>> +static DEFINE_SPINLOCK(cpu_pd_list_lock);
>
>Can this be a mutex?
>
Yes, will change. The init function would not be called from atomic context.

>> +	genpd = kzalloc(sizeof(*(genpd)), GFP_KERNEL);
>
>Drop extra parenthesis
>

>> +	/* Register the CPU genpd */
>> +	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);
>
>Drop the full stop?
>
OK

>> +	kfree(genpd);
>> +	kfree(genpd->name);
>
>Switch order so that name is freed first to avoid junk deref here.
>
Sounds good.

>> +	kfree(pd);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static struct generic_pm_domain *of_get_cpu_domain(struct device_node *dn,
>> +		const struct cpu_pd_ops *ops, int cpu)
>> +{

>> +	genpd = of_genpd_get_from_provider(&args);
>> +	if (!IS_ERR(genpd))
>> +		goto skip_parent;
>
>Why not just return genpd and drop the goto?
>
Ok

>> +	genpd = of_init_cpu_pm_domain(dn, ops);
>> +	if (IS_ERR(genpd))
>> +		return genpd;
>> +
>> +	/* Is there a domain provider for this domain? */
>> +	ret = of_parse_phandle_with_args(dn, "power-domains",
>> +			"#power-domain-cells", 0, &args);
>> +	of_node_put(dn);
>
>Shouldn't this be of_node_put(args.np)? I suppose it's the same
>so this isn't too important.
>
>> +	if (ret < 0)
>> +		goto skip_parent;
>> +
>> +	/* Find its parent and attach this domain to it, recursively */
>> +	parent = of_get_cpu_domain(args.np, ops, cpu);
>
>Except that we use the np here. So perhaps move the of_node_put()
>down to the skip_parent goto?
>
Ok

>> +	if (IS_ERR(parent)) {
>> +		struct cpu_pm_domain *cpu_pd, *parent_cpu_pd;
>> +
>> +		ret = pm_genpd_add_subdomain(genpd, parent);
>
>parent is an error pointer here... isn't this always going to
>fail? Maybe that should be if (!IS_ERR(parent)) up there?
>
Good catch. Yes, it should be.

>> +		/*
>> +		 * Reference parent domain for easy access.
>> +		 * Note: We could be attached to a domain that is not a
>> +		 * CPU PM domain in that case dont reference the parent.
>
>s/dont/don't/
>
Done.

>> +	dn = of_get_cpu_node(cpu, NULL);
>> +	if (!dn)
>> +		return -ENODEV;
>> +
>> +	dn = of_parse_phandle(dn, "power-domains", 0);
>> +	if (!dn)
>> +		return -ENODEV;
>> +	of_node_put(dn);
>
>This should be put after of_get_cpu_domain().
>
Thanks for this review, Stephen.

Thanks,
Lina

>> +
>> +	/* Find the genpd for this CPU, create if not found */
>> +	genpd = of_get_cpu_domain(dn, ops, cpu);
>> +	if (IS_ERR(genpd))
>> +		return PTR_ERR(genpd);
>> +
>> +	return cpu_pd_attach_cpu(cpu);
>> +}
>> +EXPORT_SYMBOL(of_setup_cpu_pd_single);
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
