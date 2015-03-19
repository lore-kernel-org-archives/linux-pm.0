From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] thermal: hisilicon: add new hisilicon thermal sensor
 driver
Date: Thu, 19 Mar 2015 14:17:53 +0000
Message-ID: <20150319141753.GB25967@leverpostej>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37302 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980AbbCSOS0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Mar 2015 10:18:26 -0400
Content-Disposition: inline
In-Reply-To: <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kongxinwei <kong.kongxinwei@hisilicon.com>
Cc: "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>

On Thu, Mar 19, 2015 at 07:57:27AM +0000, kongxinwei wrote:
> This patch adds the support for hisilicon thermal sensor, within
> hisilicon SoC. there will register sensors for thermal framework
> and use device tree to bind cooling device.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> ---
>  drivers/thermal/Kconfig        |   8 +
>  drivers/thermal/Makefile       |   1 +
>  drivers/thermal/hisi_thermal.c | 531 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 540 insertions(+)
>  create mode 100644 drivers/thermal/hisi_thermal.c

[...]

> +       ret = of_property_read_u32(np, "hisilicon,tsensor-lag-value",
> +                                  &sensor->lag);

This wasn't in the binding.

[...]

> +       ret = of_property_read_u32(np, "hisilicon,tsensor-thres-temp",
> +                                  &sensor->thres_temp);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to get thres value %d: %d\n",
> +                       index, ret);
> +               return ret;
> +       }
> +
> +       ret = of_property_read_u32(np, "hisilicon,tsensor-reset-temp",
> +                                  &sensor->reset_temp);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to get reset value %d: %d\n",
> +                       index, ret);
> +               return ret;
> +       }

I see now that these properties result in the HW being programmed. You
should figure out how to reconcile these with thermal-zone trip points
rather than having parallel properties.

> +
> +       if (of_property_read_bool(np, "hisilicon,tsensor-bind-irq")) {
> +
> +               if (data->irq_bind_sensor != -1)
> +                       dev_warn(&pdev->dev, "irq has bound to index %d\n",
> +                                data->irq_bind_sensor);
> +
> +               /* bind irq to this sensor */
> +               data->irq_bind_sensor = index;
> +       }

I don't see why this should be specified in the DT. Why do you believe
it should?

[...]

> +static int hisi_thermal_probe(struct platform_device *pdev)
> +{
> +       struct hisi_thermal_data *data;
> +       struct resource *res;
> +       int i;
> +       int ret;
> +
> +       if (!cpufreq_get_current_driver()) {
> +               dev_dbg(&pdev->dev, "no cpufreq driver!");
> +               return -EPROBE_DEFER;
> +       }

Surely we care about not burning out the board even if we don't have
cpufreq?

Is there any ordering guarantee between the probing of this driver and
cpufreq?


[...]

> +       data->clk = devm_clk_get(&pdev->dev, NULL);

You gave this clock a name in the binding. Use it or drop it.

Mark. 
