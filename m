From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RFC v3 03/12] PM / cpu_domains: Setup PM domains for CPUs/clusters
Date: Wed, 02 Mar 2016 17:18:13 -0800
Message-ID: <7hfuw8xstm.fsf@baylibre.com>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
	<1456866931-37851-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35769 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbcCCBSP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 20:18:15 -0500
Received: by mail-pf0-f169.google.com with SMTP id w128so4394250pfb.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 17:18:14 -0800 (PST)
In-Reply-To: <1456866931-37851-5-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Tue, 1 Mar 2016 14:15:22 -0700")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>

Lina Iyer <lina.iyer@linaro.org> writes:

> Define and add Generic PM domains (genpd) for CPU clusters. Many new

Not sure this is "new". :)

> SoCs group CPUs as clusters. Clusters share common resources like power
> rails, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> CPUs may be associated with their domain providers in DT. The domains in
> turn may be associated with their providers.

Not sure what this sentence means.

> This is clean way to model
> the cluster hierarchy like that of ARM's big.little architecture.

... or any multi-cluster architecture with independent power rails.

> For each CPU in the DT, we identify the domain provider; initialize and
> register the PM domain if isn't already registered and attach all the
> CPU devices to the domain. Usually, when there are multiple clusters of
> CPUs, there is a top level coherency domain that is dependent on these
> individual domains. All domains thus created are marked IRQ safe
> automatically and therefore may be powered down when the CPUs in the
> domain are powered down by cpuidle.

s/by cpuidle/during the idle path/

A bit about why IRQ safe is needed during the idle path would be good also.

> Reading DT, initializing Generic PM domains, attaching CPUs to it

s/it/their/

> domains are common functionalities across ARM SoCs. Provide a common set

s/ARM/many/

> of APIs to setup PM domains for CPU clusters and its parents. The
> platform drivers may just call of_setup_cpu_pd() to do a single step
> setup of CPU domains.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Suggested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/Makefile      |   1 +
>  drivers/base/power/cpu_domains.c | 267 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpu_domains.h      |  35 +++++

nit: cpu_pm_domains.[ch] ?

>  3 files changed, 303 insertions(+)
>  create mode 100644 drivers/base/power/cpu_domains.c
>  create mode 100644 include/linux/cpu_domains.h
>

[...]

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
> +	pd->genpd = genpd;
> +	pd->genpd->power_off = cpu_pd_power_off;
> +	pd->genpd->power_on = cpu_pd_power_on;
> +	pd->genpd->flags |= GENPD_FLAG_IRQ_SAFE;

Again, just to be thorough, maybe a comment here describing that CPU PM
domains must be IRQ safe because the callbacks happend during the idle
path when interrupts are disabled.

[...]

I ran out of time for the day here, but will continue looking at the
rest implementation later.  Thought it best to send what I already
reviewed though.

Kevin


