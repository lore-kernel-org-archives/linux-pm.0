From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Mon, 29 Sep 2014 16:18:46 -0700
Message-ID: <5429E8D6.6080101@codeaurora.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 09/26/14 17:58, Lina Iyer wrote:
> diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle-qcom.c
> new file mode 100644
> index 0000000..2fcf79a
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-qcom.c
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright (c) 2014, Linaro Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/cpu_pm.h>
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include <soc/qcom/pm.h>
> +#include "dt_idle_states.h"
> +
> +static void (*qcom_idle_enter)(enum pm_sleep_mode);
> +
> +static int qcom_lpm_enter_wfi(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	qcom_idle_enter(PM_SLEEP_MODE_WFI);

Why can't we just pass index here? It would be nice to not need to
include soc/qcom/pm.h in this file.

> +
> +	return index;
> +}
> +
> +static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	cpu_pm_enter();
> +	qcom_idle_enter(PM_SLEEP_MODE_SPC);
> +	cpu_pm_exit();
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver qcom_cpuidle_driver = {
> +	.name	= "qcom_cpuidle",
> +	.owner	= THIS_MODULE,
> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] __initconst = {
> +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
> +	{ },
> +};
> +
> +static int qcom_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
> +	int ret;
> +
> +	qcom_idle_enter = (void *)(pdev->dev.platform_data);
> +	if (!qcom_idle_enter)
> +		return -EFAULT;

Error code looks a little wrong. -ENODEV?

> +
> +	 /* Probe for other states including platform WFI */
> +	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
> +	if (ret <= 0) {
> +		pr_err("%s: No cpuidle state found.\n", __func__);

This would be true if ret == 0, but if it's < 0 that isn't true. Drop
the print?

> +		return ret;
> +	}
> +
> +	ret = cpuidle_register(drv, NULL);
> +	if (ret) {
> +		pr_err("%s: failed to register cpuidle driver\n", __func__);

This seems redundant given that cpuidle_register() already prints an
error when it fails.

> +		return ret;
> +	}
> +
> +	return 0;

Could just be return cpuidle_register(drv, NULL);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
