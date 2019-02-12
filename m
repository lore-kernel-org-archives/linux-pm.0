From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
Date: Tue, 12 Feb 2019 17:05:40 +0800
Message-ID: <1549962340.7155.2.camel@mtksdaap41>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
 <CANMq1KAbaZWM0BQWdKgg8nQhOovBR9Y=cFyd1kG0FAteWhZtiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CANMq1KAbaZWM0BQWdKgg8nQhOovBR9Y=cFyd1kG0FAteWhZtiw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>, Fan Chen <fan.chen@mediatek.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2019-02-01 at 10:43 +0700, Nicolas Boichat wrote:
> On Tue, Jan 29, 2019 at 1:36 PM Andrew-sh Cheng
> <andrew-sh.cheng@mediatek.com> wrote:
> >
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> >
> > For big/little cpu cluster architecture,
> > not only CPU frequency, but CCI frequency will also affect performance.
> >
> > Little cores and cci share the same buck in Mediatek mt8183 IC,
> > so we add a CCI devfreq which will get notification when buck voltage
> > is changed, then CCI devfreq can set cci frequency as high as possible.
> >
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  drivers/devfreq/Kconfig              |   9 ++
> >  drivers/devfreq/Makefile             |   1 +
> >  drivers/devfreq/mt8183-cci-devfreq.c | 224 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 234 insertions(+)
> >  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> >
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 6a172d3..0b14aab 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -113,6 +113,15 @@ config ARM_RK3399_DMC_DEVFREQ
> >            It sets the frequency for the memory controller and reads the usage counts
> >            from hardware.
> >
> > +config ARM_MT8183_CCI_DEVFREQ
> > +       tristate "MT8183 CCI DEVFREQ Driver"
> > +       depends on ARM_MEDIATEK_CPUFREQ
> > +       help
> > +               This adds devfreq for cci clock
> 
> It might be nice to spell out that CCI stands for "Cache Coherent Interconnect".
I will modify in next patch.
> 
> > +               which is shared the same regulator with cpu cluster.
> > +               It can track buck voltage and update a proper cci frequency.
> > +               Use notification to get regulator status.
> > +
> >  source "drivers/devfreq/event/Kconfig"
> >
> >  endif # PM_DEVFREQ
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 32b8d4d..25afe8c 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)     += governor_passive.o
> >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)   += exynos-bus.o
> >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)   += rk3399_dmc.o
> >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)                += tegra-devfreq.o
> > +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)   += mt8183-cci-devfreq.o
> >
> >  # DEVFREQ Event Drivers
> >  obj-$(CONFIG_PM_DEVFREQ_EVENT)         += event/
> > diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> > new file mode 100644
> > index 0000000..4837892
> > --- /dev/null
> > +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> > @@ -0,0 +1,224 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (c) 2018 MediaTek Inc.
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/devfreq.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include "governor.h"
> > +
> > +struct cci_devfreq_data {
> > +       struct devfreq          *devfreq;
> > +       struct regulator        *proc_reg;
> > +       struct clk              *cci_clk;
> > +       unsigned long           buck_volt;
> > +       int                     volt_increasing;
> > +       struct notifier_block   nb;
> > +};
> > +
> > +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> > +                                      unsigned long *freq)
> > +{
> > +       struct cci_devfreq_data *cci_devdata;
> > +       int     i, opp_count;
> 
> No tab here: single space between int and i.
I will modify in next patch.
> 
> > +       struct dev_pm_opp       *opp;
> > +       unsigned long   opp_rate, opp_voltage;
> > +
> > +       cci_devdata = dev_get_drvdata(devfreq->dev.parent);
> > +
> > +       /* find available frequency */
> > +       opp_count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
> > +       for (i = 0, opp_rate = ULONG_MAX; i < opp_count; i++, opp_rate--) {
> > +               opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent,
> > +                                                &opp_rate);
> 
> This is quite inefficient as each call to dev_pm_opp_find_freq_floor
> may go through the whole OPP table (so your loop is O(n**2), but this
> can be done in O(n) by simply walking through the list).
> 
> I'd just copy what dev_pm_opp_find_freq_ceil does
> (https://elixir.bootlin.com/linux/v4.19/source/drivers/opp/core.c#L425).
> Or maybe we need a new function in the opp core.
I will add an API for opp framework for this in next patch
> 
> > +               opp_voltage = dev_pm_opp_get_voltage(opp);
> > +               dev_pm_opp_put(opp);
> > +
> > +               if (opp_voltage <= cci_devdata->buck_volt)
> > +                       break;
> > +       }
> > +       *freq = opp_rate;
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> > +                                         unsigned int event, void *data)
> > +{
> > +       return 0;
> > +}
> > +
> > +static struct devfreq_governor mtk_cci_devfreq_governor = {
> > +       .name = "voltage_monitor",
> > +       .get_target_freq = mtk_cci_governor_get_target,
> > +       .event_handler = mtk_cci_governor_event_handler,
> > +};
> > +
> > +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> > +                                 u32 flags)
> > +{
> > +       struct cci_devfreq_data *cci_devdata;
> > +
> > +       cci_devdata = dev_get_drvdata(dev);
> > +
> > +       clk_set_rate(cci_devdata->cci_clk, *freq);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct devfreq_dev_profile cci_devfreq_profile = {
> > +       .polling_ms     = 0,
> > +       .target         = mtk_cci_devfreq_target,
> > +};
> > +
> > +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> > +                                         unsigned long val, void *data)
> > +{
> > +       struct cci_devfreq_data *cci_devdata =
> > +               container_of(nb, struct cci_devfreq_data, nb);
> > +
> > +       /* deal with reduce frequency */
> > +       if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> > +               struct pre_voltage_change_data *pvc_data = data;
> > +
> > +               if (pvc_data->old_uV > pvc_data->min_uV) {
> > +                       cci_devdata->volt_increasing = 0;
> > +                       cci_devdata->buck_volt =
> > +                               (unsigned long)(pvc_data->min_uV);
> > +                       mutex_lock(&cci_devdata->devfreq->lock);
> > +                       update_devfreq(cci_devdata->devfreq);
> > +                       mutex_unlock(&cci_devdata->devfreq->lock);
> > +               } else {
> > +                       cci_devdata->volt_increasing = 1;
> > +               }
> > +       }
> > +       /* deal with abort reduce frequency */
> > +       if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) ||
> > +           /* deal with increase frequency */
> > +           ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> > +            cci_devdata->volt_increasing == 1)) {
> > +               cci_devdata->buck_volt = (unsigned long)data;
> > +               mutex_lock(&cci_devdata->devfreq->lock);
> > +               update_devfreq(cci_devdata->devfreq);
> > +               mutex_unlock(&cci_devdata->devfreq->lock);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> > +{
> > +       struct device *cci_dev = &pdev->dev;
> > +       struct cci_devfreq_data *cci_devdata;
> > +       struct notifier_block *nb;
> > +       int ret;
> > +
> > +       dev_pm_opp_of_add_table(&pdev->dev);
> > +
> > +       cci_devdata = devm_kzalloc(cci_dev, sizeof(*cci_devdata), GFP_KERNEL);
> > +       if (!cci_devdata)
> > +               return -ENOMEM;
> > +       nb = &cci_devdata->nb;
> > +       cci_devdata->cci_clk = ERR_PTR(-ENODEV);
> 
> This one is useless as you set cci_clk again just below.
> 
> > +       cci_devdata->proc_reg = ERR_PTR(-ENODEV);
> 
> For this one, I'd just create 2 goto targets below, instead of those
> ifs in the error path.
I will modify and change to 2 goto in next patch.
> 
> > +
> > +       cci_devdata->cci_clk = clk_get(cci_dev, "cci_clock");
> > +       ret = PTR_ERR_OR_ZERO(cci_devdata->cci_clk);
> > +       if (ret) {
> > +               if (ret == -EPROBE_DEFER)
> > +                       pr_err("cci clock not ready, retry\n");
> > +               else
> > +                       pr_err("no clock for cci: %d\n", ret);
> > +
> > +               goto out_free_resources;
> > +       }
> > +
> > +       cci_devdata->proc_reg = regulator_get_optional(cci_dev, "proc");
> > +       ret = PTR_ERR_OR_ZERO(cci_devdata->proc_reg);
> > +       if (ret) {
> > +               if (ret == -EPROBE_DEFER)
> > +                       pr_err("cci regulator not ready, retry\n");
> > +               else
> > +                       pr_err("no regulator for cci: %d\n", ret);
> > +
> > +               goto out_free_resources;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, cci_devdata);
> > +
> > +       /* create cci_devfreq and add to cci device.
> > +        * governor is voltage_monitor.
> > +        * governor will get platform_device data to make decision.
> > +        */
> > +       cci_devdata->devfreq = devm_devfreq_add_device(cci_dev,
> > +                                                      &cci_devfreq_profile,
> > +                                                      "voltage_monitor",
> > +                                                      NULL);
> > +
> > +       nb->notifier_call = cci_devfreq_regulator_notifier;
> > +       regulator_register_notifier(cci_devdata->proc_reg,
> > +                                   nb);
> > +
> > +       return 0;
> > +
> > +out_free_resources:
> > +       if (!IS_ERR(cci_devdata->cci_clk))
> > +               clk_put(cci_devdata->cci_clk);
> > +       if (!IS_ERR(cci_devdata->proc_reg))
> > +               regulator_put(cci_devdata->proc_reg);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
> > +       { .compatible = "mediatek,mt8183-cci" },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> > +
> > +static struct platform_driver cci_devfreq_driver = {
> > +       .probe  = mtk_cci_devfreq_probe,
> > +       .driver = {
> > +               .name = "mediatek-cci-devfreq",
> > +               .of_match_table = mediatek_cci_devfreq_of_match,
> > +       },
> > +};
> > +
> > +static int __init mtk_cci_devfreq_init(void)
> > +{
> > +       int ret = 0;
> > +
> > +       ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> > +       if (ret) {
> > +               pr_err("%s: failed to add governor: %d\n", __func__, ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = platform_driver_register(&cci_devfreq_driver);
> > +       if (ret)
> > +               devfreq_remove_governor(&mtk_cci_devfreq_governor);
> > +
> > +       return ret;
> > +}
> > +module_init(mtk_cci_devfreq_init)
> > +
> > +static void __exit mtk_cci_devfreq_exit(void)
> > +{
> > +       int ret = 0;
> > +
> > +       platform_driver_unregister(&cci_devfreq_driver);
> > +
> > +       ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> > +       if (ret)
> > +               pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> > +}
> > +module_exit(mtk_cci_devfreq_exit)
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> > +MODULE_AUTHOR("andrew-sh.cheng");
> > +
> > --
> > 1.8.1.1.dirty
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
