From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v2 06/14] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
Date: Thu, 4 Aug 2016 16:59:47 +0100
Message-ID: <20160804155947.GD1732@brendan-thinkstation>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52104 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758757AbcHDQA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Aug 2016 12:00:29 -0400
Content-Disposition: inline
In-Reply-To: <1469829385-11511-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Lina,

I spotted a couple more nits..

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
> +	genpd = kzalloc(sizeof(*genpd), GFP_KERNEL);
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
> +	if (!zalloc_cpumask_var(&pd->cpus, GFP_KERNEL))
> +		goto fail;
> +
> +	genpd->power_off = cpu_pd_power_off;
> +	genpd->power_on = cpu_pd_power_on;
> +	genpd->flags |= GENPD_FLAG_IRQ_SAFE;
> +	genpd->of_node = dn;
> +	pd->genpd = genpd;
> +	pd->ops.power_on = ops->power_on;
> +	pd->ops.power_off = ops->power_off;
> +
> +	INIT_LIST_HEAD_RCU(&pd->link);
> +	mutex_lock(&cpu_pd_list_lock);
> +	list_add_rcu(&pd->link, &of_cpu_pd_list);
> +	mutex_unlock(&cpu_pd_list_lock);
> +
> +	/* Populate platform specific states from DT */
> +	if (ops->populate_state_data) {
> +		struct device_node *np;
> +		int i;
> +
> +		/* Initialize the arm,idle-state properties */
> +		ret = pm_genpd_of_parse_power_states(genpd);
> +		if (ret) {
> +			pr_warn("%s domain states not initialized (%d)\n",
> +					dn->full_name, ret);
> +			goto fail;
> +		}
> +		for (i = 0; i < genpd->state_count; i++) {
> +			np = of_parse_phandle(dn, "domain-idle-states", i);
> +			ret = ops->populate_state_data(np,
> +					&genpd->states[i].param);
> +			of_node_put(np);
> +			if (ret)
> +				goto fail;
> +		}
> +	}

It seems a bit unfortunate to do of_parse_phandle for "domain-idle-states"
again, when pm_genpd_of_parse_power_states has just done that. Maybe we could
could add an `of_node` member to `struct genpd_power_state` and have
pm_genpd_of_parse_power_states populate that?

> +
> +	/* Register the CPU genpd */
> +	pr_debug("adding %s as CPU PM domain\n", pd->genpd->name);
> +	ret = pm_genpd_init(pd->genpd, &simple_qos_governor, false);
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
> +	kfree(genpd->name);
> +	kfree(genpd);
> +	if (pd)
> +		kfree(pd->cpus);
> +	kfree(pd);
> +	return ERR_PTR(ret);
> +}
> +


> +int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
> +{
> +
> +	struct device_node *dn;
> +	struct generic_pm_domain *genpd;
> +	struct cpu_pm_domain *cpu_pd;
> +
> +	dn = of_get_cpu_node(cpu, NULL);
> +	if (!dn)
> +		return -ENODEV;

of_get_cpu_node increments the refcount so we need an of_node_put at some point.

There are loads of instances around the kernel of of_get_cpu_node without
corresponding of_node_put, though, I could be misunderstanding...

> +
> +	dn = of_parse_phandle(dn, "power-domains", 0);
> +	if (!dn)
> +		return -ENODEV;
> +
> +	/* Find the genpd for this CPU, create if not found */
> +	genpd = of_get_cpu_domain(dn, ops, cpu);
> +	if (IS_ERR(genpd))
> +		return PTR_ERR(genpd);
> +
> +	of_node_put(dn);
> +	cpu_pd = to_cpu_pd(genpd);
> +	if (!cpu_pd) {
> +		pr_err("%s: Genpd was created outside CPU PM domains\n",
> +				__func__);
> +		return -ENOENT;
> +	}
> +
> +	return cpu_pd_attach_cpu(cpu_pd, cpu);
> +}

Cheers,
Brendan
