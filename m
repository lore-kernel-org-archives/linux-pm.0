From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 1/6] clk: mediatek: add missing cpu mux causing Mediatek
 cpufreq can't work
Date: Thu, 25 May 2017 15:30:04 +0800
Message-ID: <1495697404.22797.2.camel@mtkswgap22>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
         <1493997974-17699-2-git-send-email-sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:13166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752611AbdEYHaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 03:30:09 -0400
In-Reply-To: <1493997974-17699-2-git-send-email-sean.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org
Cc: viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>

Hi Michael and Stephen


Just a gentle ping on this one :)


Cheers, Sean


On Fri, 2017-05-05 at 23:26 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds CPU multiplexer clocks which are essential for Mediatek
> cpufreq driver. It would use the CPU clock multiplexer to switch to the
> intermediate clock source temporarily and then wait for the primary clock
> changing getting stable.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/clk/mediatek/Makefile     |   2 +-
>  drivers/clk/mediatek/clk-cpumux.c | 120 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-cpumux.h |  30 ++++++++++
>  3 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-cpumux.c
>  create mode 100644 drivers/clk/mediatek/clk-cpumux.h
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 5c3afb8..2a755b5 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1,4 +1,4 @@
> -obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o
> +obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o
>  obj-$(CONFIG_RESET_CONTROLLER) += reset.o
>  obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
> new file mode 100644
> index 0000000..edd8e69
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (c) 2015 Linaro Ltd.
> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/slab.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-cpumux.h"
> +
> +static inline struct mtk_clk_cpumux *to_mtk_clk_cpumux(struct clk_hw *_hw)
> +{
> +	return container_of(_hw, struct mtk_clk_cpumux, hw);
> +}
> +
> +static u8 clk_cpumux_get_parent(struct clk_hw *hw)
> +{
> +	struct mtk_clk_cpumux *mux = to_mtk_clk_cpumux(hw);
> +	int num_parents = clk_hw_get_num_parents(hw);
> +	unsigned int val;
> +
> +	regmap_read(mux->regmap, mux->reg, &val);
> +
> +	val >>= mux->shift;
> +	val &= mux->mask;
> +
> +	if (val >= num_parents)
> +		return -EINVAL;
> +
> +	return val;
> +}
> +
> +static int clk_cpumux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct mtk_clk_cpumux *mux = to_mtk_clk_cpumux(hw);
> +	u32 mask, val;
> +
> +	val = index << mux->shift;
> +	mask = mux->mask << mux->shift;
> +
> +	return regmap_update_bits(mux->regmap, mux->reg, mask, val);
> +}
> +
> +static const struct clk_ops clk_cpumux_ops = {
> +	.get_parent = clk_cpumux_get_parent,
> +	.set_parent = clk_cpumux_set_parent,
> +};
> +
> +static struct clk __init *
> +mtk_clk_register_cpumux(const struct mtk_composite *mux,
> +			struct regmap *regmap)
> +{
> +	struct mtk_clk_cpumux *cpumux;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	cpumux = kzalloc(sizeof(*cpumux), GFP_KERNEL);
> +	if (!cpumux)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = mux->name;
> +	init.ops = &clk_cpumux_ops;
> +	init.parent_names = mux->parent_names;
> +	init.num_parents = mux->num_parents;
> +	init.flags = mux->flags;
> +
> +	cpumux->reg = mux->mux_reg;
> +	cpumux->shift = mux->mux_shift;
> +	cpumux->mask = BIT(mux->mux_width) - 1;
> +	cpumux->regmap = regmap;
> +	cpumux->hw.init = &init;
> +
> +	clk = clk_register(NULL, &cpumux->hw);
> +	if (IS_ERR(clk))
> +		kfree(cpumux);
> +
> +	return clk;
> +}
> +
> +int __init mtk_clk_register_cpumuxes(struct device_node *node,
> +				     const struct mtk_composite *clks, int num,
> +				     struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +
> +	regmap = syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap)) {
> +		pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
> +		       PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		const struct mtk_composite *mux = &clks[i];
> +
> +		clk = mtk_clk_register_cpumux(mux, regmap);
> +		if (IS_ERR(clk)) {
> +			pr_err("Failed to register clk %s: %ld\n",
> +			       mux->name, PTR_ERR(clk));
> +			continue;
> +		}
> +
> +		clk_data->clks[mux->id] = clk;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
> new file mode 100644
> index 0000000..dddaad5
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-cpumux.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright (c) 2015 Linaro Ltd.
> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DRV_CLK_CPUMUX_H
> +#define __DRV_CLK_CPUMUX_H
> +
> +struct mtk_clk_cpumux {
> +	struct clk_hw	hw;
> +	struct regmap	*regmap;
> +	u32		reg;
> +	u32		mask;
> +	u8		shift;
> +};
> +
> +int mtk_clk_register_cpumuxes(struct device_node *node,
> +			      const struct mtk_composite *clks, int num,
> +			      struct clk_onecell_data *clk_data);
> +
> +#endif /* __DRV_CLK_CPUMUX_H */
