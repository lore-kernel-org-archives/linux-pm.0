From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2 07/17] soc: tegra: pmc: Add generic PM domain support
Date: Mon, 06 Apr 2015 15:37:37 -0700
Message-ID: <7h1tjwx4r2.fsf@deeprootsystems.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
	<1426162518-7405-8-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36614 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbDFWhk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 18:37:40 -0400
Received: by pdea3 with SMTP id a3so58006936pde.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2015 15:37:40 -0700 (PDT)
In-Reply-To: <1426162518-7405-8-git-send-email-vinceh@nvidia.com> (Vince Hsu's
	message of "Thu, 12 Mar 2015 20:15:08 +0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vince Hsu <vinceh@nvidia.com>
Cc: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Thierry Reding <treding@nvidia.com>

Hi Vince,

Vince Hsu <vinceh@nvidia.com> writes:

> From: Thierry Reding <treding@nvidia.com>
>
> The PM domains are populated from DT, and the PM domain consumer devices are
> also bound to their relevant PM domains by DT.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> [vinceh: make changes based on Thierry and Peter's suggestions]
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> ---
> v2: revise comment in tegra_powergate_remove_clamping()
>     address Alex's comments

Sorry for the late review..., somehow I just noticed this while
reviewing some other PM domain support.

It's nice to see this migrating to PM domains.  Some comments below...

[...]

>  /**
>   * struct tegra_pmc - NVIDIA Tegra PMC
> + * @dev: pointer to parent device
>   * @base: pointer to I/O remapped register region
>   * @clk: pointer to pclk clock
> + * @soc: SoC-specific data
>   * @rate: currently configured rate of pclk
>   * @suspend_mode: lowest suspend mode available
>   * @cpu_good_time: CPU power good time (in microseconds)
> @@ -126,7 +158,9 @@ struct tegra_pmc_soc {
>   * @cpu_pwr_good_en: CPU power good signal is enabled
>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>   * @lp0_vec_size: size of the LP0 warm boot code
> + * @powergates: list of power gates
>   * @powergates_lock: mutex for power gate register access
> + * @nb: bus notifier for generic power domains
>   */
>  struct tegra_pmc {
>  	struct device *dev;
> @@ -150,7 +184,12 @@ struct tegra_pmc {
>  	u32 lp0_vec_phys;
>  	u32 lp0_vec_size;
>  
> +	struct tegra_powergate *powergates;
>  	struct mutex powergates_lock;
> +	struct notifier_block nb;

I don't see these notifiers used anywhere in this series.  What is the
intended use here?   There have been some other discussions about how to
do this more generically for  PM domains[1], so I'd prefer not to see this
in SoC specific PM domains.  In this case, it appears unused, so should
be fine to drop (for now.)

[...]

> +static int tegra_pmc_powergate_power_off(struct generic_pm_domain *domain)
> +{
> +	struct tegra_powergate *powergate = to_powergate(domain);
> +	struct tegra_pmc *pmc = powergate->pmc;
> +	int err;
> +
> +	dev_dbg(pmc->dev, "> %s(domain=%p)\n", __func__, domain);
> +	dev_dbg(pmc->dev, "  name: %s\n", domain->name);
> +
> +	/* never turn off these partitions */
> +	switch (powergate->id) {
> +	case TEGRA_POWERGATE_CPU:
> +	case TEGRA_POWERGATE_CPU1:
> +	case TEGRA_POWERGATE_CPU2:
> +	case TEGRA_POWERGATE_CPU3:
> +	case TEGRA_POWERGATE_CPU0:
> +	case TEGRA_POWERGATE_C0NC:
> +	case TEGRA_POWERGATE_IRAM:
> +		dev_dbg(pmc->dev, "not disabling always-on partition %s\n",
> +			domain->name);
> +		err = -EINVAL;
> +		goto out;
> +	}

You're re-inventing the per-device QoS flag: PM_QOS_FLAG_NO_POWER_OFF
which could be used here to prevent ->power_off from ever being called.

Alternately, if this really a static configuraion, why even register the
->power_off hook for these domains in the first place?

[...]

> +static int tegra_pmc_powergate_init_subdomain(struct tegra_pmc *pmc)
> +{
> +	struct tegra_powergate *powergate;
> +
> +	list_for_each_entry(powergate, &pmc->powergate_list, head) {
> +		struct device_node *pdn;
> +		struct tegra_powergate *parent = NULL;
> +		struct tegra_powergate *temp;
> +		int err;
> +
> +		pdn = of_parse_phandle(powergate->of_node, "depend-on", 0);
> +		if (!pdn)
> +			continue;

I'm not really following the need for the "depend-on" property here.

Looking at the example .dtsi files in this series, it seems to me what
is being described is nested hardware power domains, which genpd already
supports.  Any reason you're not using that build-in support?

[...]

> @@ -831,12 +1405,19 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>  
>  	tegra_pmc_init_tsense_reset(pmc);
>  
> +	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
> +		err = tegra_powergate_init(pmc);
> +		if (err < 0)
> +			return err;
> +	}

On many SoCs there's some special handling for the !CONFIG_PM case here
such that all the PM domains are enabled by default in case they are not
enabled by the bootloader.

>  	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>  		err = tegra_powergate_debugfs_init();
>  		if (err < 0)
>  			return err;
>  	}
>  
> +	dev_dbg(&pdev->dev, "< %s()\n", __func__);
>  	return 0;
>  }

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/299345.html
