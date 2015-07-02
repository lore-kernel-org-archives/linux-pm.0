From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by
 SCP(System Control Processor)
Date: Thu, 2 Jul 2015 10:23:10 -0700
Message-ID: <20150702172310.GF4301@codeaurora.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42040 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbbGBRXN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 13:23:13 -0400
Content-Disposition: inline
In-Reply-To: <1433760002-24120-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>

On 06/08, Sudeep Holla wrote:
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9897f353bf1a..0fe8daefc105 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -59,6 +59,16 @@ config COMMON_CLK_RK808
>  	  clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
>  	  by control register.
>  
> +config COMMON_CLK_SCPI
> +        tristate "Clock driver controlled via SCPI interface"
> +        depends on ARM_SCPI_PROTOCOL || COMPILE_TEST
> +        ---help---
> +          This driver provides support for clocks that are controlled
> +          by firmware that implements the SCPI interface.
> +
> +	  This driver uses SCPI Message Protocol to interact with the
> +	  firmware providing all the clock controls.

The tabbing is weird here. Both paragraphs should have the same
alignment.

> diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
> new file mode 100644
> index 000000000000..707b3430c55f
> --- /dev/null
> +++ b/drivers/clk/clk-scpi.c
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/scpi_protocol.h>

Please include <linux/platform_device.h> as well.

> +
> +struct scpi_clk {
> +	u32 id;
> +	const char *name;

Do you need this? Or can you just use __clk_get_name() in places
where the name is used?

> +	struct clk_hw hw;
> +	struct scpi_dvfs_info *info;
> +	struct scpi_ops *scpi_ops;
> +};
> +
> +#define to_scpi_clk(clk) container_of(clk, struct scpi_clk, hw)
> +
> +static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +
> +	return clk->scpi_ops->clk_get_val(clk->id);
> +}
> +
> +static long scpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{

Maybe a comment here like:

/*
 * We can't figure out what rate it will be, so just return the rate
 * back to the caller. scpi_clk_recalc_rate() will be called
 * after the rate is set and we'll know what rate the clock is
 * running at then.
 */

> +	return rate;
> +}
> +
> +static int scpi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +
> +	return clk->scpi_ops->clk_set_val(clk->id, rate);
> +}
> +
> +static void scpi_clk_disable(struct clk_hw *hw)
> +{
> +	scpi_clk_set_rate(hw, 0, 0);

Does this mean you have to set a rate to enable the clock? Are
you relying on drivers to call clk_set_rate() to implicitly
enable the clock? If so, it would be better to cache the rate of
the clock in set_rate if the clock isn't enabled in software and
then send the cached rate during enable.

> +}
> +
[..]
> +/* find closest match to given frequency in OPP table */
> +static int __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
> +{
> +	int idx;
> +	u32 fmin = 0, fmax = ~0, ftmp;
> +	struct scpi_opp *opp = clk->info->opps;
> +

const?

> +	for (idx = 0; idx < clk->info->count; idx++, opp++) {
> +		ftmp = opp->freq;
> +		if (ftmp >= (u32)rate) {
> +			if (ftmp <= fmax)
> +				fmax = ftmp;
> +			break;
> +		} else if (ftmp >= fmin) {
> +			fmin = ftmp;
> +		}
> +	}
> +	return fmax != ~0 ? fmax : fmin;
> +}
> +
> +static unsigned long scpi_dvfs_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +	int idx = clk->scpi_ops->dvfs_get_idx(clk->id);
> +	struct scpi_opp *opp;

const?

> +
> +	if (idx < 0)
> +		return 0;
> +
> +	opp = clk->info->opps + idx;
> +	return opp->freq;
> +}
> +
> +static long scpi_dvfs_round_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long *parent_rate)
> +{
> +	struct scpi_clk *clk = to_scpi_clk(hw);
> +
> +	return __scpi_dvfs_round_rate(clk, rate);
> +}
> +
> +static int __scpi_find_dvfs_index(struct scpi_clk *clk, unsigned long rate)
> +{
> +	int idx, max_opp = clk->info->count;
> +	struct scpi_opp *opp = clk->info->opps;

const?

> +
> +	for (idx = 0; idx < max_opp; idx++, opp++)
> +		if (opp->freq == rate)
> +			return idx;
> +	return -EINVAL;
> +}
> +
[..]
> +static struct clk *
> +scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
> +		  struct scpi_clk *sclk)
> +{
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	unsigned long min = 0, max = 0;
> +
> +	init.name = sclk->name;
> +	init.flags = CLK_IS_ROOT;
> +	init.num_parents = 0;
> +	init.ops = match->data;
> +	sclk->hw.init = &init;
> +	sclk->scpi_ops = get_scpi_ops();
> +
> +	if (init.ops == &scpi_dvfs_ops) {
> +		sclk->info = sclk->scpi_ops->dvfs_get_info(sclk->id);
> +		if (IS_ERR(sclk->info))
> +			return NULL;
> +	} else if (init.ops == &scpi_clk_ops) {
> +		if (sclk->scpi_ops->clk_get_range(sclk->id, &min, &max) || !max)
> +			return NULL;
> +	} else {
> +		return NULL;
> +	}
> +
> +	clk = devm_clk_register(dev, &sclk->hw);
> +	if (!IS_ERR(clk) && max)
> +		clk_set_rate_range(clk, min, max);

Hm.. we're planning to make clk_register() return a struct
clk_hw, so this will block that. We need some sort of clk_hw API
that allows us to setup min/max limits on the clock from the
provider side. Care to add that?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
