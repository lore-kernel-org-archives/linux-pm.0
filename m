From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 01/13] clk: qcom: Add support for GDSCs
Date: Wed, 22 Jul 2015 17:25:57 -0700
Message-ID: <55B03495.8050902@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-2-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45527 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbGWA0A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 20:26:00 -0400
In-Reply-To: <1437549069-29655-2-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 07/22/2015 12:10 AM, Rajendra Nayak wrote:
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 59d1666..a7c2eea 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -39,6 +39,11 @@ config IPQ_LCC_806X
>   	  Say Y if you want to use audio devices such as i2s, pcm,
>   	  S/PDIF, etc.
>   
> +config QCOM_GDSC
> +	bool
> +	select PM_GENERIC_DOMAINS if PM
> +	depends on COMMON_CLK_QCOM
>

We can drop this depends because it should only be selected if 
COMMON_CLK_QCOM anyway.

> +
>   config MSM_GCC_8660
>   	tristate "MSM8660 Global Clock Controller"
>   	depends on COMMON_CLK_QCOM
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> new file mode 100644
> index 0000000..a59655b
> --- /dev/null
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/jiffies.h>
> +#include <linux/slab.h>

#include <linux/bitops.h> for BIT?
#include <linux/kernel.h> for container_of?

Please include linux/pm_domain.h here and linux/regmap.h as well for 
completeness even though gdsc.h includes it.

> +#include "gdsc.h"
> +
> +#define PWR_ON_MASK		BIT(31)
> +#define EN_REST_WAIT_MASK	GENMASK(23, 20)
> +#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
> +#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)
> +#define SW_OVERRIDE_MASK	BIT(2)
> +#define HW_CONTROL_MASK		BIT(1)
> +#define SW_COLLAPSE_MASK	BIT(0)
> [...]
> +
> +static int gdsc_toggle_logic(struct gdsc *sc, bool en)
> +{
> +	int ret;
> +	u32 val = en ? 0 : SW_COLLAPSE_MASK;
> +	u32 check = en ? PWR_ON_MASK : 0;
> +	unsigned long timeout;
> +
> +	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> +	do {
> +		ret = regmap_read(sc->regmap, sc->gdscr, &val);
> +		if (ret)
> +			return ret;
> +
> +		if ((val & PWR_ON_MASK) == check)
> +			return 0;
> +	} while (time_before(jiffies, timeout));
> +
> +	ret =  regmap_read(sc->regmap, sc->gdscr, &val);

Weird double space here.

> +	if (ret)
> +		return ret;
> +
> +	if ((val & PWR_ON_MASK) == check)
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
> [...]
> +
> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
> +		  struct regmap *regmap)
> +{
> +	int i, ret;
> +	struct genpd_onecell_data *data;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
> +				     GFP_KERNEL);
> +	if (!data->domains)
> +		return -ENOMEM;
> +
> +	data->num_domains = num;
> +	for (i = 0; i < num; i++) {
> +		if (!scs[i])
> +			continue;
> +		scs[i]->regmap = regmap;
> +		ret = gdsc_init(scs[i]);
> +		if (ret)
> +			return ret;
> +		data->domains[i] = &scs[i]->pd;
> +	}
> +
> +	return of_genpd_add_provider_onecell(dev->of_node, data);
> +}

EXPORT_SYMBOL?

> +
> +void gdsc_unregister(struct device *dev)
> +{
> +	of_genpd_del_provider(dev->of_node);
> +}

EXPORT_SYMBOL?

> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> new file mode 100644
> index 0000000..e26a496
> --- /dev/null
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __QCOM_GDSC_H__
> +#define __QCOM_GDSC_H__
> +
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>

Drop this include and forward declare struct regmap.

> +
> +/**
> + * struct gdsc - Globally Distributed Switch Controller
> + * @pd: generic power domain
> + * @regmap: regmap for MMIO accesses
> + * @gdscr: gsdc control register
> + */
> +struct gdsc {
> +	struct generic_pm_domain	pd;
> +	struct regmap			*regmap;
> +	unsigned int			gdscr;
> +};
> +
> +#ifdef CONFIG_QCOM_GDSC
> +int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
> +void gdsc_unregister(struct device *);
> +#else
> +static inline int gdsc_register(struct device *d, struct gdsc **g, size_t n,
> +				struct regmap *r)
> +{
> +	return -ENOSYS;

We need err.h for this one...

> +}
> +
> +static inline void gdsc_unregister(struct device *d)
> +{};

one line instead of two for this?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

