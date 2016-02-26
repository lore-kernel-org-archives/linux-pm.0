From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC v2 03/12] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
Date: Fri, 26 Feb 2016 11:10:16 -0800
Message-ID: <20160226191016.GW28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54838 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbcBZTKT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 14:10:19 -0500
Content-Disposition: inline
In-Reply-To: <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>

On 02/12, Lina Iyer wrote:
> diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
> new file mode 100644
> index 0000000..981592f
> --- /dev/null
> +++ b/drivers/base/power/cpu_domains.c
> @@ -0,0 +1,267 @@
> +
> +/* List of CPU PM domains we care about */
> +static LIST_HEAD(of_cpu_pd_list);
> +static DEFINE_SPINLOCK(cpu_pd_list_lock);

Can this be a mutex?

> +
> +/**
> + * of_init_cpu_pm_domain() - Initialize a CPU PM domain from a device node
> + *
> + * @dn: The domain provider's device node
> + * @ops: The power_on/_off callbacks for the domain
> + *
> + * Returns the generic_pm_domain (genpd) pointer to the domain on success
> + */
> +static struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
> +				const struct cpu_pd_ops *ops)
> +{
> +	struct cpu_pm_domain *pd = NULL;
> +	struct generic_pm_domain *genpd = NULL;
> +	int ret = -ENOMEM;
> +
> +	if (!of_device_is_available(dn))
> +		return ERR_PTR(-ENODEV);
> +
> +	genpd = kzalloc(sizeof(*(genpd)), GFP_KERNEL);

Drop extra parenthesis

> +	if (!genpd)
> +		goto fail;
> +
> +	genpd->name = kstrndup(dn->full_name, CPU_PD_NAME_MAX, GFP_KERNEL);
> +	if (!genpd->name)
> +		goto fail;
> +
> +	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		goto fail;
> +
> +	pd->genpd = genpd;
> +	pd->genpd->power_off = cpu_pd_power_off;
> +	pd->genpd->power_on = cpu_pd_power_on;
> +	pd->genpd->flags |= GENPD_FLAG_IRQ_SAFE;
> +	pd->ops.power_on = ops->power_on;
> +	pd->ops.power_off = ops->power_off;
> +
> +	INIT_LIST_HEAD_RCU(&pd->link);
> +	spin_lock(&cpu_pd_list_lock);
> +	list_add_rcu(&pd->link, &of_cpu_pd_list);
> +	spin_unlock(&cpu_pd_list_lock);
> +
> +	/* Register the CPU genpd */
> +	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);

Drop the full stop?

> +	ret = of_pm_genpd_init(dn, pd->genpd, &simple_qos_governor, false);
> +	if (ret) {
> +		pr_err("Unable to initialize domain %s\n", dn->full_name);
> +		goto fail;
> +	}
> +
> +	ret = of_genpd_add_provider_simple(dn, pd->genpd);
> +	if (ret)
> +		pr_warn("Unable to add genpd %s as provider\n",
> +				pd->genpd->name);
> +
> +	return pd->genpd;
> +fail:
> +
> +	kfree(genpd);
> +	kfree(genpd->name);

Switch order so that name is freed first to avoid junk deref here.

> +	kfree(pd);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct generic_pm_domain *of_get_cpu_domain(struct device_node *dn,
> +		const struct cpu_pd_ops *ops, int cpu)
> +{
> +	struct of_phandle_args args;
> +	struct generic_pm_domain *genpd, *parent;
> +	int ret;
> +
> +	/* Do we have this domain? If not, create the domain */
> +	args.np = dn;
> +	args.args_count = 0;
> +
> +	genpd = of_genpd_get_from_provider(&args);
> +	if (!IS_ERR(genpd))
> +		goto skip_parent;

Why not just return genpd and drop the goto?

> +
> +	genpd = of_init_cpu_pm_domain(dn, ops);
> +	if (IS_ERR(genpd))
> +		return genpd;
> +
> +	/* Is there a domain provider for this domain? */
> +	ret = of_parse_phandle_with_args(dn, "power-domains",
> +			"#power-domain-cells", 0, &args);
> +	of_node_put(dn);

Shouldn't this be of_node_put(args.np)? I suppose it's the same
so this isn't too important.

> +	if (ret < 0)
> +		goto skip_parent;
> +
> +	/* Find its parent and attach this domain to it, recursively */
> +	parent = of_get_cpu_domain(args.np, ops, cpu);

Except that we use the np here. So perhaps move the of_node_put()
down to the skip_parent goto?

> +	if (IS_ERR(parent)) {
> +		struct cpu_pm_domain *cpu_pd, *parent_cpu_pd;
> +
> +		ret = pm_genpd_add_subdomain(genpd, parent);

parent is an error pointer here... isn't this always going to
fail? Maybe that should be if (!IS_ERR(parent)) up there?

> +		if (ret) {
> +			pr_err("%s: Unable to add sub-domain (%s) to parent (%s)\n err: %d",
> +					__func__, genpd->name, parent->name,
> +					ret);
> +			return ERR_PTR(ret);
> +		}
> +
> +		/*
> +		 * Reference parent domain for easy access.
> +		 * Note: We could be attached to a domain that is not a
> +		 * CPU PM domain in that case dont reference the parent.

s/dont/don't/

> +		 */
> +		cpu_pd = to_cpu_pd(genpd);
> +		parent_cpu_pd = to_cpu_pd(parent);
> +
> +		if (cpu_pd && parent_cpu_pd)
> +			cpu_pd->parent = parent_cpu_pd;
> +	}
> +
> +skip_parent:
> +	return genpd;
> +}
> +
> +/**
> + * of_setup_cpu_pd_single() - Setup the PM domains for a CPU
> + *
> + * @cpu: The CPU for which the PM domain is to be set up.
> + * @ops: The PM domain suspend/resume ops for the CPU's domain
> + *
> + * If the CPU PM domain exists already, then the CPU is attached to
> + * that CPU PD. If it doesn't, the domain is created, the @ops are
> + * set for power_on/power_off callbacks and then the CPU is attached
> + * to that domain. If the domain was created outside this framework,
> + * then we do not attach the CPU to the domain.
> + */
> +int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
> +{
> +
> +	struct device_node *dn;
> +	struct generic_pm_domain *genpd;
> +
> +	dn = of_get_cpu_node(cpu, NULL);
> +	if (!dn)
> +		return -ENODEV;
> +
> +	dn = of_parse_phandle(dn, "power-domains", 0);
> +	if (!dn)
> +		return -ENODEV;
> +	of_node_put(dn);

This should be put after of_get_cpu_domain().

> +
> +	/* Find the genpd for this CPU, create if not found */
> +	genpd = of_get_cpu_domain(dn, ops, cpu);
> +	if (IS_ERR(genpd))
> +		return PTR_ERR(genpd);
> +
> +	return cpu_pd_attach_cpu(cpu);
> +}
> +EXPORT_SYMBOL(of_setup_cpu_pd_single);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
