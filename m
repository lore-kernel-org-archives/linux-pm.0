From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Tue, 30 Sep 2014 09:41:42 -0600
Message-ID: <20140930154142.GA528@ilina-mac.local>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <5429E8D6.6080101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44226 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbaI3Plt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 11:41:49 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so9405104pab.34
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 08:41:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5429E8D6.6080101@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org

On Mon, Sep 29 2014 at 17:18 -0600, Stephen Boyd wrote:
>On 09/26/14 17:58, Lina Iyer wrote:
>> diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle-qcom.c
>> new file mode 100644
>> index 0000000..2fcf79a
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-qcom.c
>> @@ -0,0 +1,89 @@
>> +/*
>> + * Copyright (c) 2014, Linaro Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/cpu_pm.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <soc/qcom/pm.h>
>> +#include "dt_idle_states.h"
>> +
>> +static void (*qcom_idle_enter)(enum pm_sleep_mode);
>> +
>> +static int qcom_lpm_enter_wfi(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int index)
>> +{
>> +	qcom_idle_enter(PM_SLEEP_MODE_WFI);
>
>Why can't we just pass index here? It would be nice to not need to
>include soc/qcom/pm.h in this file.
>

This is the right place, the translation of QCOM's idle states is done
while registering and needs to be translated back to QCOM's idle states.
The interpretation of idle state bindings to the QCOM is hence
contained in one place.

>> +
>> +	return index;
>> +}
>> +
>> +static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int index)
>> +{
>> +	cpu_pm_enter();
>> +	qcom_idle_enter(PM_SLEEP_MODE_SPC);
>> +	cpu_pm_exit();
>> +
>> +	return index;
>> +}
>> +
>> +static struct cpuidle_driver qcom_cpuidle_driver = {
>> +	.name	= "qcom_cpuidle",
>> +	.owner	= THIS_MODULE,
>> +};
>> +
>> +static const struct of_device_id qcom_idle_state_match[] __initconst = {
>> +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
>> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
>> +	{ },
>> +};
>> +
>> +static int qcom_cpuidle_probe(struct platform_device *pdev)
>> +{
>> +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
>> +	int ret;
>> +
>> +	qcom_idle_enter = (void *)(pdev->dev.platform_data);
>> +	if (!qcom_idle_enter)
>> +		return -EFAULT;
>
>Error code looks a little wrong. -ENODEV?
>
The dev is there, not just the expected platform data.
I can change.

>> +
>> +	 /* Probe for other states including platform WFI */
>> +	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
>> +	if (ret <= 0) {
>> +		pr_err("%s: No cpuidle state found.\n", __func__);
>
>This would be true if ret == 0, but if it's < 0 that isn't true. Drop
>the print?
>
Okay
>> +		return ret;
>> +	}
>> +
>> +	ret = cpuidle_register(drv, NULL);
>> +	if (ret) {
>> +		pr_err("%s: failed to register cpuidle driver\n", __func__);
>
>This seems redundant given that cpuidle_register() already prints an
>error when it fails.
>

>> +		return ret;
>> +	}
>> +
>> +	return 0;
>
>Could just be return cpuidle_register(drv, NULL);
>
Sure.

>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>hosted by The Linux Foundation
>
