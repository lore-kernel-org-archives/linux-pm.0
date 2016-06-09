From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5] soc: qcom: Add suspend to idle support
Date: Thu, 9 Jun 2016 09:39:34 +0200
Message-ID: <CAPDyKFrAGVPkc=ycm-cQg6Y5NLx_d4xGeg8SaSiB-K5sxtv76A@mail.gmail.com>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org> <1463634020-17252-2-git-send-email-andy.gross@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35112 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423277AbcFIHjm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 03:39:42 -0400
Received: by mail-wm0-f52.google.com with SMTP id v199so94402033wmv.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2016 00:39:41 -0700 (PDT)
In-Reply-To: <1463634020-17252-2-git-send-email-andy.gross@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, stanimir.varbanov@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>

+ Daniel

On 19 May 2016 at 07:00, Andy Gross <andy.gross@linaro.org> wrote:
> This patch adds suspend to idle support for Qualcomm processors.  While
> suspend to memory will be a valid state, there won't be any special
> handling or power savings over the suspend to idle.
>
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/soc/qcom/Makefile  |  1 +
>  drivers/soc/qcom/suspend.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 drivers/soc/qcom/suspend.c
>
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index fdd664e..7c479d3 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>  obj-$(CONFIG_QCOM_SMP2P)       += smp2p.o
>  obj-$(CONFIG_QCOM_SMSM)        += smsm.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
> +obj-$(CONFIG_SUSPEND)  +=      suspend.o
> diff --git a/drivers/soc/qcom/suspend.c b/drivers/soc/qcom/suspend.c
> new file mode 100644
> index 0000000..7d3f2dd
> --- /dev/null
> +++ b/drivers/soc/qcom/suspend.c
> @@ -0,0 +1,77 @@
> +/*
> + * (C) Copyright 2016 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/cpuidle.h>
> +#include <linux/suspend.h>
> +
> +
> +static void qcom_pm_enter_freeze(struct cpuidle_device *dev,
> +       struct cpuidle_driver *drv,
> +       int index)
> +{
> +       drv->states[index].enter(dev, drv, index);
> +}
> +
> +static const struct of_device_id qcom_idle_state_match[] = {
> +       { .compatible = "qcom,idle-state-spc", },
> +       { },
> +};
> +
> +static const struct platform_suspend_ops qcom_suspend_ops = {
> +       .valid          = suspend_valid_only_mem,
> +};
> +
> +static int __init qcom_pm_init(void)
> +{
> +       struct cpuidle_device *cpu_dev;
> +       struct cpuidle_driver *cpu_drv;
> +       int state_count;
> +       struct device_node *state_np, *cpu_np;
> +       const struct of_device_id *match;
> +       int i;
> +
> +       /* configure CPU enter_freeze if applicable */
> +       for_each_present_cpu(i) {
> +               cpu_np = of_get_cpu_node(i, NULL);
> +               cpu_dev = per_cpu_ptr(cpuidle_devices, i);
> +               cpu_drv = cpuidle_get_cpu_driver(cpu_dev);
> +
> +               if (!cpu_dev || !cpu_drv) {
> +                       of_node_put(cpu_np);
> +                       return -EPROBE_DEFER;

This isn't a driver, so returning -EPROBE_DEFER doesn't make sense.

> +               }
> +
> +               state_count = 0;
> +               state_np = of_parse_phandle(cpu_np, "cpu-idle-states",
> +                                                 state_count);
> +
> +               while (state_np) {
> +                       match = of_match_node(qcom_idle_state_match,
> +                                             state_np);
> +
> +                       state_count++;
> +                       if (match)
> +                               cpu_drv->states[state_count].enter_freeze =
> +                                               &qcom_pm_enter_freeze;
> +                       of_node_put(state_np);
> +
> +                       state_np = of_parse_phandle(cpu_np, "cpu-idle-states",
> +                                                   state_count);
> +               }
> +
> +               of_node_put(cpu_np);
> +       }
> +
> +       suspend_set_ops(&qcom_suspend_ops);

I don't think this will work!

When building a multi defconfig for ARM, you might overwrite the
suspend_ops (there's only one set) as here you don't know that it's
actually the QCOM platform that is running, right!?

Perhaps this code actually belongs closer to the cpuidle driver?

> +
> +       return 0;
> +}
> +
> +late_initcall(qcom_pm_init);
> --
> 1.9.1

Kind regards
Uffe
