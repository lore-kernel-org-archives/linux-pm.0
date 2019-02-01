From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
Date: Fri, 1 Feb 2019 12:13:38 -0800
Message-ID: <20190201201338.GS81583@google.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fan.chen@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Andrew,

On Tue, Jan 29, 2019 at 02:35:04PM +0800, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>

the 'From' tag is only needed when you send patches not authored by
yourself. It doesn't do any harm either, but you can drop it in future
submissions.

> For big/little cpu cluster architecture,
> not only CPU frequency, but CCI frequency will also affect performance.

This doesn't provide much information, I suggest to drop it unless
others find it valuable.

> Little cores and cci share the same buck in Mediatek mt8183 IC,
> so we add a CCI devfreq which will get notification when buck voltage
> is changed, then CCI devfreq can set cci frequency as high as
> possible.

Possible alternative:

"This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
of the Mediatek MT8183.

On the MT8183 the CCI is supplied by the same regulator as the LITTLE
cores. The driver is notified when the regulator voltage changes
(driven by cpufreq) and adjusts the CCI frequency to the maximum
possible value."

Feel free to ignore or to adjust.

> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig              |   9 ++
>  drivers/devfreq/Makefile             |   1 +
>  drivers/devfreq/mt8183-cci-devfreq.c | 224 +++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d3..0b14aab 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -113,6 +113,15 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> +config ARM_MT8183_CCI_DEVFREQ
> +	tristate "MT8183 CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	help
> +		This adds devfreq for cci clock

"This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
of the Mediatek MT8183"?

> +		which is shared the same regulator with cpu cluster.
> +		It can track buck voltage and update a proper cci frequency.
> +		Use notification to get regulator status.

not sure how important this info is here, sounds more like an
implementation detail to me.

> +
>  source "drivers/devfreq/event/Kconfig"
>  
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d..25afe8c 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 0000000..4837892
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.

2019 :)

> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/devfreq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "governor.h"
> +
> +struct cci_devfreq_data {

nit: consider dropping the '_data' suffix, it doesn't add much/any
value.

> +	struct devfreq		*devfreq;
> +	struct regulator	*proc_reg;
> +	struct clk		*cci_clk;
> +	unsigned long		buck_volt;

proc_reg_uV?

place after proc_reg

> +	int			volt_increasing;

should be bool

actually, is it really needed? See comment in cci_devfreq_regulator_notifier()

> +	struct notifier_block	nb;
> +};
> +
> +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> +				       unsigned long *freq)
> +{
> +	struct cci_devfreq_data *cci_devdata;

nit: consider calling it 'cci_df' (here and elsewhere). In the context
the abbreviation is clear and there is less clutter when accessing
fields in the structure.

> +	int	i, opp_count;
> +	struct dev_pm_opp	*opp;
> +	unsigned long	opp_rate, opp_voltage;
> +
> +	cci_devdata = dev_get_drvdata(devfreq->dev.parent);
> +
> +	/* find available frequency */
> +	opp_count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
> +	for (i = 0, opp_rate = ULONG_MAX; i < opp_count; i++, opp_rate--) {
> +		opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent,
> +						 &opp_rate);
> +		opp_voltage = dev_pm_opp_get_voltage(opp);
> +		dev_pm_opp_put(opp);
> +
> +		if (opp_voltage <= cci_devdata->buck_volt)
> +			break;
> +	}
> +	*freq = opp_rate;
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> +					  unsigned int event, void *data)
> +{
> +	return 0;
> +}
> +
> +static struct devfreq_governor mtk_cci_devfreq_governor = {
> +	.name = "voltage_monitor",

"mtk_cci_vmon" or similar?

> +	.get_target_freq = mtk_cci_governor_get_target,
> +	.event_handler = mtk_cci_governor_event_handler,
> +};
> +
> +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	struct cci_devfreq_data *cci_devdata;
> +
> +	cci_devdata = dev_get_drvdata(dev);
> +
> +	clk_set_rate(cci_devdata->cci_clk, *freq);
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.polling_ms	= 0,
> +	.target		= mtk_cci_devfreq_target,
> +};
> +
> +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> +					  unsigned long val, void *data)
> +{
> +	struct cci_devfreq_data *cci_devdata =
> +		container_of(nb, struct cci_devfreq_data, nb);
> +
> +	/* deal with reduce frequency */
> +	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> +		struct pre_voltage_change_data *pvc_data = data;
> +
> +		if (pvc_data->old_uV > pvc_data->min_uV) {

I would suggest to invert the condition. For humans it is easier to
parse "is the new voltage smaller than the previous one", than
viceversa.

> +			cci_devdata->volt_increasing = 0;
> +			cci_devdata->buck_volt =
> +				(unsigned long)(pvc_data->min_uV);
> +			mutex_lock(&cci_devdata->devfreq->lock);
> +			update_devfreq(cci_devdata->devfreq);
> +			mutex_unlock(&cci_devdata->devfreq->lock);
> +		} else {
> +			cci_devdata->volt_increasing = 1;
> +		}
> +	}

nit: add empty line

> +	/* deal with abort reduce frequency */

Shouldn't this be "abort voltage change?". If so I suggest to drop the
comment, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE in the condition makes
it clear.

> +	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) ||
> +	    /* deal with increase frequency */
> +	    ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> +	     cci_devdata->volt_increasing == 1)) {

to check for a voltage increase you could use 'cci_devdata->buck_volt
< (unsigned long)data' instead of ->volt_increasing.

> +		cci_devdata->buck_volt = (unsigned long)data;
> +		mutex_lock(&cci_devdata->devfreq->lock);
> +		update_devfreq(cci_devdata->devfreq);
> +		mutex_unlock(&cci_devdata->devfreq->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq_data *cci_devdata;
> +	struct notifier_block *nb;
> +	int ret;
> +
> +	dev_pm_opp_of_add_table(&pdev->dev);
> +
> +	cci_devdata = devm_kzalloc(cci_dev, sizeof(*cci_devdata), GFP_KERNEL);
> +	if (!cci_devdata)
> +		return -ENOMEM;
> +	nb = &cci_devdata->nb;
> +	cci_devdata->cci_clk = ERR_PTR(-ENODEV);

initialization not needed, the field is assigned a few lines below.

> +	cci_devdata->proc_reg = ERR_PTR(-ENODEV);

also not really needed with the right gotos in place

> +
> +	cci_devdata->cci_clk = clk_get(cci_dev, "cci_clock");
> +	ret = PTR_ERR_OR_ZERO(cci_devdata->cci_clk);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			pr_err("cci clock not ready, retry\n");
> +		else
> +			pr_err("no clock for cci: %d\n", ret);
> +
> +		goto out_free_resources;

nothing to be freed here, just return ret.

> +	}
> +
> +	cci_devdata->proc_reg = regulator_get_optional(cci_dev, "proc");
> +	ret = PTR_ERR_OR_ZERO(cci_devdata->proc_reg);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			pr_err("cci regulator not ready, retry\n");
> +		else
> +			pr_err("no regulator for cci: %d\n", ret);
> +
> +		goto out_free_resources;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_devdata);
> +
> +	/* create cci_devfreq and add to cci device.
> +	 * governor is voltage_monitor.
> +	 * governor will get platform_device data to make decision.
> +	 */
> +	cci_devdata->devfreq = devm_devfreq_add_device(cci_dev,
> +						       &cci_devfreq_profile,
> +						       "voltage_monitor",

adjust name in case you follow my suggestion above.

check cci_devdata->devfreq for errors.

> +						       NULL);
> +
> +	nb->notifier_call = cci_devfreq_regulator_notifier;
> +	regulator_register_notifier(cci_devdata->proc_reg,
> +				    nb);
> +
> +	return 0;
> +
> +out_free_resources:
> +	if (!IS_ERR(cci_devdata->cci_clk))
> +		clk_put(cci_devdata->cci_clk);
> +	if (!IS_ERR(cci_devdata->proc_reg))
> +		regulator_put(cci_devdata->proc_reg);

use individual labels and get rid of the IS_ERRs.

e.g.

err_put_reg:
	regulator_put(cci_devdata->proc_reg);

err_put_clk:
	clk_put(cci_devdata->cci_clk);


and jump to the corresponding lable above.

> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = mediatek_cci_devfreq_of_match,
> +	},
> +};
> +
> +static int __init mtk_cci_devfreq_init(void)
> +{
> +	int ret = 0;

initialization not needed

> +
> +	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> +	if (ret) {
> +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&cci_devfreq_driver);
> +	if (ret)
> +		devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +
> +	return ret;
> +}
> +module_init(mtk_cci_devfreq_init)
> +
> +static void __exit mtk_cci_devfreq_exit(void)
> +{
> +	int ret = 0;

initialization not needed

> +	platform_driver_unregister(&cci_devfreq_driver);
> +
> +	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +	if (ret)
> +		pr_err("%s: failed to remove governor: %d\n", __func__, ret);

typically you reverse the order of initialization, i.e. remove the
governor, then unregister the driver.

> +}
> +module_exit(mtk_cci_devfreq_exit)
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("andrew-sh.cheng");

should be either "Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>" or
"Andrew-sh.Cheng"

Cheers

Matthias
