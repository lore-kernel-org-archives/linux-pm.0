From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Tue, 30 Sep 2014 09:58:49 +0100
Message-ID: <20140930085849.GA11393@e102568-lin.cambridge.arm.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <5429E8D6.6080101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5429E8D6.6080101@codeaurora.org>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 30, 2014 at 12:18:46AM +0100, Stephen Boyd wrote:
> On 09/26/14 17:58, Lina Iyer wrote:
> > diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle-qcom.c
> > new file mode 100644
> > index 0000000..2fcf79a
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-qcom.c
> > @@ -0,0 +1,89 @@
> > +/*
> > + * Copyright (c) 2014, Linaro Limited.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/cpu_pm.h>
> > +#include <linux/cpuidle.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <soc/qcom/pm.h>
> > +#include "dt_idle_states.h"
> > +
> > +static void (*qcom_idle_enter)(enum pm_sleep_mode);
> > +
> > +static int qcom_lpm_enter_wfi(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv, int index)
> > +{
> > +	qcom_idle_enter(PM_SLEEP_MODE_WFI);
> 
> Why can't we just pass index here? It would be nice to not need to
> include soc/qcom/pm.h in this file.

I think this is definitely worth exploring.

> > +	return index;
> > +}
> > +
> > +static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv, int index)
> > +{
> > +	cpu_pm_enter();
> > +	qcom_idle_enter(PM_SLEEP_MODE_SPC);
> > +	cpu_pm_exit();
> > +
> > +	return index;
> > +}
> > +
> > +static struct cpuidle_driver qcom_cpuidle_driver = {
> > +	.name	= "qcom_cpuidle",
> > +	.owner	= THIS_MODULE,
> > +};
> > +
> > +static const struct of_device_id qcom_idle_state_match[] __initconst = {
> > +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
> > +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
> > +	{ },
> > +};
> > +
> > +static int qcom_cpuidle_probe(struct platform_device *pdev)
> > +{
> > +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
> > +	int ret;
> > +
> > +	qcom_idle_enter = (void *)(pdev->dev.platform_data);
> > +	if (!qcom_idle_enter)
> > +		return -EFAULT;
> 
> Error code looks a little wrong. -ENODEV?
> 
> > +
> > +	 /* Probe for other states including platform WFI */
> > +	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
> > +	if (ret <= 0) {
> > +		pr_err("%s: No cpuidle state found.\n", __func__);
> 
> This would be true if ret == 0, but if it's < 0 that isn't true. Drop
> the print?

I think we can safely drop the print, DT parsing code already barfs on
error. Maybe you want to keep the (ret == 0) case to signal that driver
was probed but no idle states were found.

> > +		return ret;
> > +	}
> > +
> > +	ret = cpuidle_register(drv, NULL);
> > +	if (ret) {
> > +		pr_err("%s: failed to register cpuidle driver\n", __func__);
> 
> This seems redundant given that cpuidle_register() already prints an
> error when it fails.

Yes, I will drop it from arm64 driver too as part of a minor clean-up
when the merge window closes (also other drivers do that, and as you say
it is redundant).

Lorenzo
