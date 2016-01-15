From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 13/16] soc: tegra: pmc: Add generic PM domain support
Date: Fri, 15 Jan 2016 09:42:24 +0000
Message-ID: <5698BF00.6090102@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-14-git-send-email-jonathanh@nvidia.com>
 <20160114143932.GE23082@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160114143932.GE23082@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 14/01/16 14:39, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Dec 04, 2015 at 02:57:14PM +0000, Jon Hunter wrote:
> [...]
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> [...]
>> +static int tegra_powergate_power_down(struct tegra_powergate *pg,
>> +				      bool enable_clocks)
>> +{
>> +	int err;
>> +
>> +	if (enable_clocks) {
>> +		err = tegra_powergate_enable_clocks(pg);
>> +		if (err)
>> +			return err;
>> +
>> +		usleep_range(10, 20);
>> +	}
>> +
>> +	err = tegra_powergate_reset_assert(pg);
>> +	if (err)
>> +		goto err_reset;
>> +
>> +	usleep_range(10, 20);
>> +
>> +	tegra_powergate_disable_clocks(pg);
> 
> There's no guarantee that all clocks are actually disabled at this
> point. Will the power down and subsequent power up sequences still
> work properly in such cases? If not perhaps we should add some way
> of checking for that case here (WARN_ON?) to make sure we can fix
> up all drivers to release their clock enable references.

The problem is that there is no easy way to check the status of a clock
and whether it is enabled. Yes clk-provider.h does provide a
__clk_is_enabled() API but I don't think that this is meant to be used
here. May be we need a clk API for disabling a clock that will WARN if
the clock is not disabled?

>> +static int tegra_powergate_of_get_clks(struct device *dev,
>> +				       struct tegra_powergate *pg)
>> +{
>> +	struct clk *clk;
>> +	unsigned int i, count;
>> +	int err;
>> +
>> +	/*
>> +	 * Determine number of clocks used by the powergate
>> +	 */
>> +	for (count = 0; ; count++) {
>> +		clk = of_clk_get(pg->of_node, count);
>> +		if (IS_ERR(clk))
>> +			break;
>> +
>> +		clk_put(clk);
>> +	}
> 
> of_count_phandle_with_args()?

Ok.

>> +static int tegra_powergate_of_get_resets(struct device *dev,
>> +					 struct tegra_powergate *pg)
>> +{
>> +	struct reset_control *rst;
>> +	unsigned int i, count;
>> +	int err;
>> +
>> +	/*
>> +	 * Determine number of resets used by the powergate
>> +	 */
>> +	for (count = 0; ; count++) {
>> +		rst = of_reset_control_get_by_index(pg->of_node, count);
>> +		if (IS_ERR(rst))
>> +			break;
>> +
>> +		reset_control_put(rst);
>> +	}
> 
> Same here.

Ok.

>> +static struct tegra_powergate *
>> +tegra_powergate_add_one(struct tegra_pmc *pmc, struct device_node *np,
>> +			struct generic_pm_domain *parent)
>> +{
> [...]
>> +	dev_info(pmc->dev, "added power domain %s\n", pg->genpd.name);
> 
> That's a little chatty, isn't it? Perhaps dev_dbg()?

Ok.

>> +static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np,
>> +			       struct generic_pm_domain *parent)
>> +{
>> +	struct tegra_powergate *pg;
>> +	struct device_node *child;
>> +	int err = 0;
>> +
>> +	for_each_child_of_node(np, child) {
>> +		if (err)
>> +			goto err;
> 
> This looks weird. Isn't the same check below good enough to catch all
> cases?

Yes, but this function is called recursively.

>> +
>> +		pg = tegra_powergate_add_one(pmc, child, parent);
>> +		if (IS_ERR(pg)) {
>> +			err = PTR_ERR(pg);
>> +			goto err;
>> +		}
>> +
>> +		if (pg)
>> +			err = tegra_powergate_add(pmc, child, pg->parent);
>> +
>> +err:
>> +		of_node_put(child);
>> +
>> +		if (err)
>> +			return err;
> 
> Perhaps break here instead of return?
> 
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static void tegra_powergate_remove(struct tegra_pmc *pmc)
>> +{
>> +	struct tegra_powergate *pg, *n;
>> +
>> +	list_for_each_entry_safe(pg, n, &pmc->powergates_list, node) {
>> +		of_genpd_del_provider(pg->of_node);
>> +		if (pg->parent)
>> +			pm_genpd_remove_subdomain(pg->parent, &pg->genpd);
>> +		pm_genpd_remove(&pg->genpd);
>> +
>> +		while (pg->num_clks--)
>> +			clk_put(pg->clks[pg->num_clks]);
>> +
>> +		while (pg->num_resets--)
>> +			reset_control_put(pg->resets[pg->num_resets]);
>> +
>> +		list_del(&pg->node);
>> +	}
>> +}
> 
> Are generic power domains reference counted? If not this will
> potentially leave dangling pointers in user drivers, won't it?
> 
> That's a problem common to many subsystems, but maybe something to be
> aware of.

pm_genpd_remove and pm_genpd_remove_subdomain can fail if they have
users and so I should check for this. The problem is what to do if one
fails? Just WARN and break? May be that is best even if some to do get
removed and we end up in a state with some populated and some removed.

>> @@ -850,21 +1286,31 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>>  
>>  	tegra_pmc_init_tsense_reset(pmc);
>>  
>> +	err = tegra_powergate_init(pmc);
>> +	if (err < 0)
>> +		return err;
>> +
>>  	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>>  		err = tegra_powergate_debugfs_init();
>>  		if (err < 0)
>> -			return err;
>> +			goto err_debugfs;
>>  	}
>>  
>>  	err = register_restart_handler(&tegra_pmc_restart_handler);
>>  	if (err) {
>> -		debugfs_remove(pmc->debugfs);
>>  		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
>>  			err);
>> -		return err;
>> +		goto err_restart;
>>  	}
>>  
>>  	return 0;
>> +
>> +err_restart:
>> +	debugfs_remove(pmc->debugfs);
>> +err_debugfs:
>> +	tegra_powergate_remove(pmc);
> 
> I prefer the labels to denote the action that is being taken rather than
> the error that they respond to. remove_debugfs and remove_powergate
> would therefore be better here, in my opinion. I think there were a
> couple more in this and earlier patches.

Ok.

Jon
