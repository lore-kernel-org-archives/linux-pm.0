From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v2 06/14] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
Date: Thu, 4 Aug 2016 11:15:15 +0100
Message-ID: <20160804101515.GA29537@brendan-thinkstation>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49995 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbcHDKPU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Aug 2016 06:15:20 -0400
Content-Disposition: inline
In-Reply-To: <1469829385-11511-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Lina,

On Fri, Jul 29, 2016 at 03:56:17PM -0600, Lina Iyer wrote:
> +static struct generic_pm_domain *of_get_cpu_domain(struct device_node *dn,
> +		const struct cpu_pd_ops *ops, int cpu)
> +{
> +	struct of_phandle_args args;
> +	struct generic_pm_domain *genpd, *parent;
> +	struct cpu_pm_domain *cpu_pd, *parent_cpu_pd;
> +	int ret;
> +
> +	/* Do we have this domain? If not, create the domain */
> +	args.np = dn;
> +	args.args_count = 0;
> +
> +	genpd = of_genpd_get_from_provider(&args);
> +	if (!IS_ERR(genpd))
> +		return genpd;
> +
> +	genpd = of_init_cpu_pm_domain(dn, ops);
> +	if (IS_ERR(genpd))
> +		return genpd;
> +
> +	/* Is there a domain provider for this domain? */
> +	ret = of_parse_phandle_with_args(dn, "power-domains",
> +			"#power-domain-cells", 0, &args);
> +	if (ret < 0)
> +		goto skip_parent;
> +
> +	/* Find its parent and attach this domain to it, recursively */
> +	parent = of_get_cpu_domain(args.np, ops, cpu);
> +	if (IS_ERR(parent))
> +		goto skip_parent;
> +
> +	ret = pm_genpd_add_subdomain(genpd, parent);

Looks like the arguments are the wrong way around here, it should be:

	ret = pm_genpd_add_subdomain(parent, genpd);

> +	if (ret) {
> +		pr_err("%s: Unable to add sub-domain (%s)\n err: %d",
> +				__func__, genpd->name, ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/*
> +	 * Reference parent domain for easy access.
> +	 * Note: We could be attached to a domain that is not a
> +	 * CPU PM domain in that case don't reference the parent.
> +	 */
> +	cpu_pd = to_cpu_pd(genpd);
> +	parent_cpu_pd = to_cpu_pd(parent);
> +
> +	if (cpu_pd && parent_cpu_pd)
> +		cpu_pd->parent = parent_cpu_pd;
> +
> +skip_parent:
> +	of_node_put(dn);
> +	return genpd;
> +}

Cheers,
Brendan
