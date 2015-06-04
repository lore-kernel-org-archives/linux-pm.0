From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 3/5] clk: add support for clocks provided by
 SCP(System Control Processor)
Date: Thu, 4 Jun 2015 13:20:09 -0700
Message-ID: <20150604202009.GI676@codeaurora.org>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
 <1432720398-5701-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56589 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbFDUUL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 16:20:11 -0400
Content-Disposition: inline
In-Reply-To: <1432720398-5701-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>

On 05/27, Sudeep Holla wrote:
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/scpi_protocol.h>
> +
> +struct scpi_clk {
> +	u32 id;
> +	const char *name;
> +	struct clk_hw hw;
> +	struct scpi_dvfs_info *info;
> +	unsigned long rate_min;
> +	unsigned long rate_max;
> +};
> +
> +#define to_scpi_clk(clk) container_of(clk, struct scpi_clk, hw)
> +
> +static struct scpi_ops *scpi_ops;

Why do we need this singleton? Can we put this pointer into scpi_clk?

> +
> +static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +
> +	return scpi_ops->clk_get_val(clk->id);
> +}
> +
> +static long scpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +
> +	if (WARN_ON(clk->rate_min && rate < clk->rate_min))
> +		rate = clk->rate_min;
> +	if (WARN_ON(clk->rate_max && rate > clk->rate_max))
> +		rate = clk->rate_max;
> +
> +	return rate;
> +}

Hm.. this seems really generic. It might be better to support a
way to tell the framework to limit the min/max rate that's
accepted for a clk. That could be done later though.

> +
> +static int scpi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +
> +	return scpi_ops->clk_set_val(clk->id, rate);
> +}
> +
[..]
> +
> +static int scpi_clk_add(struct device *dev, struct device_node *np)
> +{
> +	struct clk **clks;
> +	int idx, count;
> +	struct clk_onecell_data *clk_data;
> +
> +	count = of_property_count_strings(np, "clock-output-names");
> +	if (count < 0) {
> +		dev_err(dev, "%s: invalid clock output count\n", np->name);
> +		return -EINVAL;
> +	}
> +
> +	clk_data = devm_kmalloc(dev, sizeof(*clk_data), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	clks = devm_kcalloc(dev, count, sizeof(*clks), GFP_KERNEL);
> +	if (!clks)
> +		return -ENOMEM;
> +
> +	for (idx = 0; idx < count; idx++) {
> +		struct scpi_clk *sclk;
> +		u32 val;
> +
> +		sclk = devm_kzalloc(dev, sizeof(*sclk), GFP_KERNEL);
> +		if (!sclk)
> +			return -ENOMEM;
> +
> +		if (of_property_read_string_index(np, "clock-output-names",
> +						  idx, &sclk->name)) {
> +			dev_err(dev, "invalid clock name @ %s\n", np->name);
> +			return -EINVAL;
> +		}
> +
> +		if (of_property_read_u32_index(np, "clock-indices",
> +					       idx, &val)) {
> +			dev_err(dev, "invalid clock index @ %s\n", np->name);
> +			return -EINVAL;
> +		}
> +
> +		sclk->id = val;
> +
> +		clks[idx] = scpi_clk_ops_init(dev, np, sclk);
> +		if (IS_ERR_OR_NULL(clks[idx]))
> +			dev_err(dev, "failed to register clock '%s'\n",
> +				sclk->name);
> +		else
> +			dev_dbg(dev, "Registered clock '%s'\n", sclk->name);
> +	}
> +
> +	clk_data->clks = clks;
> +	clk_data->clk_num = idx;
> +	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);

And if of_clk_add_provider() fails?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
