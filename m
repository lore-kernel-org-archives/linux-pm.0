From: YiPing Xu <xuyiping@hisilicon.com>
Subject: Re: [PATCH v1 1/2] thermal: hisilicon: add new hisilicon thermal
 sensor driver
Date: Sat, 28 Mar 2015 08:58:41 +0800
Message-ID: <5515FCC1.2060302@hisilicon.com>
References: <1427269825-11324-1-git-send-email-kong.kongxinwei@hisilicon.com> <1427269825-11324-2-git-send-email-kong.kongxinwei@hisilicon.com> <5513CDEE.8000807@hisilicon.com> <55151538.3020204@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55151538.3020204@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>, rui.zhuang@intel.com, edubezval@gmail.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org, liguozhu@hisilicon.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

=E5=9C=A8 2015/3/27 16:30, Xinwei Kong =E5=86=99=E9=81=93:
>
>
> On 2015/3/26 17:14, YiPing Xu wrote:
>> =E5=9C=A8 2015/3/25 15:50, Xinwei Kong =E5=86=99=E9=81=93:
>>> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>>>
>>> This patch adds the support for hisilicon thermal sensor, within
>>> hisilicon SoC. there will register sensors for thermal framework
>>> and use device tree to bind cooling device.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
>>> ---
>>>    drivers/thermal/Kconfig        |   8 +
>>>    drivers/thermal/Makefile       |   1 +
>>>    drivers/thermal/hisi_thermal.c | 526 +++++++++++++++++++++++++++=
++++++++++++++
>>>    3 files changed, 535 insertions(+)
>>>    create mode 100644 drivers/thermal/hisi_thermal.c
>>>
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>> index af40db0..81aee01 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -136,6 +136,14 @@ config THERMAL_EMULATION
>>>          because userland can easily disable the thermal policy by =
simply
>>>          flooding this sysfs node with low temperature values.
>>>
>>> +config HISI_THERMAL
>>> +    tristate "Hisilicon thermal driver"
>>> +    depends on ARCH_HISI && CPU_THERMAL && OF
>>> +    help
>>> +      Enable this to plug hisilicon's thermal sensor driver into t=
he Linux
>>> +      thermal framework. cpufreq is used as the cooling device to =
throttle
>>> +      CPUs when the passive trip is crossed.
>>> +
>>>    config IMX_THERMAL
>>>        tristate "Temperature sensor driver for Freescale i.MX SoCs"
>>>        depends on CPU_THERMAL
>>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>>> index fa0dc48..08ae7ac 100644
>>> --- a/drivers/thermal/Makefile
>>> +++ b/drivers/thermal/Makefile
>>> @@ -39,3 +39,4 @@ obj-$(CONFIG_TI_SOC_THERMAL)    +=3D ti-soc-therm=
al/
>>>    obj-$(CONFIG_INT340X_THERMAL)  +=3D int340x_thermal/
>>>    obj-$(CONFIG_ST_THERMAL)    +=3D st/
>>>    obj-$(CONFIG_TEGRA_SOCTHERM)    +=3D tegra_soctherm.o
>>> +obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
>>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_=
thermal.c
>>> new file mode 100644
>>> index 0000000..8edf83a
>>> --- /dev/null
>>> +++ b/drivers/thermal/hisi_thermal.c
>>
>>     are you sure all the SOCs in hisilicon use the same thermal IP ?
>>
>>     if not, this driver should not use the "hisi_" prefix.
>
> We can use this hisi thermal driver framework to satisfy diff thermal
> IP, all of SoC will use this drvier by adding a struct about diff IP.
> We may talk about hisi thermal diff IP how to satisfy this driver.
>
> Thanks
> Xinwei
>
>>
>>> @@ -0,0 +1,526 @@
>>> +/*
>>> + * Hisilicon thermal sensor driver
>>> + *
>>> + * Copyright (c) 2014-2015 Hisilicon Limited.
>>> + * Copyright (c) 2014-2015 Linaro Limited.
>>> + *
>>> + * Xinwei Kong <kong.kongxinwei@hisilicon.com>
>>> + * Leo Yan <leo.yan@linaro.org>
>>> + *
>>> + * This program is free software; you can redistribute it and/or m=
odify
>>> + * it under the terms of the GNU General Public License version 2 =
as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>> + * kind, whether express or implied; without even the implied warr=
anty
>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/cpu_cooling.h>
>>> +#include <linux/cpufreq.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/device.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/thermal.h>
>>> +#include <linux/types.h>
>>> +
>>> +#include "thermal_core.h"
>>> +
>>> +#define TEMP0_LAG            (0x0)
>>> +#define TEMP0_TH            (0x4)
>>> +#define TEMP0_RST_TH            (0x8)
>>> +#define TEMP0_CFG            (0xC)
>>> +#define TEMP0_EN            (0x10)
>>> +#define TEMP0_INT_EN            (0x14)
>>> +#define TEMP0_INT_CLR            (0x18)
>>> +#define TEMP0_RST_MSK            (0x1C)
>>> +#define TEMP0_RAW_INT            (0x20)
>>> +#define TEMP0_MSK_INT            (0x24)
>>> +#define TEMP0_VALUE            (0x28)
>>> +
>>> +#define HISI_TEMP_BASE            (-60)
>>> +#define HISI_TEMP_RESET            (100000)
>>> +#define HISI_TEMP_PASSIVE        (85000)
>>> +
>>> +#define HISI_MAX_SENSORS        4
>>> +
>>> +struct hisi_thermal_sensor {
>>> +    struct hisi_thermal_data *thermal;
>>> +    struct thermal_zone_device *tzd;
>>> +    const struct thermal_trip *trip;
>>> +
>>> +    uint32_t id;
>>> +    uint32_t thres_temp, reset_temp;
>>> +};
>>> +
>>> +struct hisi_thermal_data {
>>> +    struct platform_device *pdev;
>>> +    struct clk *clk;
>>> +
>>> +    int irq, irq_bind_sensor;
>>> +    bool irq_enabled;
>>> +
>>> +    unsigned int sensors_num;
>>> +    long sensor_temp[HISI_MAX_SENSORS];
>>> +    struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
>>> +
>>> +    void __iomem *regs;
>>> +};
>>> +
>>> +static DEFINE_SPINLOCK(thermal_lock);
>>> +
>>
>>     "thermal_lock" should be defined in "hisi_thermal_data" to suppo=
rt multi device instance.
>>
>
> ok,good comments
>
>>> +/* in millicelsius */
>>> +static inline int _step_to_temp(int step)
>>> +{
>>> +    /*
>>> +     * Every step equals (1 * 200) / 255 celsius, and finally
>>> +     * need convert to millicelsius.
>>> +     */
>>> +    return (HISI_TEMP_BASE + (step * 200 / 255)) * 1000;
>>> +}
>>> +
>>> +static inline int _temp_to_step(int temp)
>>> +{
>>> +    return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
>>> +}
>>> +
>>> +static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data =
*data,
>>> +                     struct hisi_thermal_sensor *sensor)
>>> +{
>>> +    unsigned long flags;
>>> +    int val;
>>> +
>>> +    spin_lock_irqsave(&thermal_lock, flags);
>>> +
>>> +    /* disable module firstly */
>>> +    writel(0x0, data->regs + TEMP0_EN);
>>> +
>>> +    /* select sensor id */
>>> +    writel((sensor->id << 12), data->regs + TEMP0_CFG);
>>> +
>>> +    /* enable module */
>>> +    writel(0x1, data->regs + TEMP0_EN);
>>> +
>>> +    mdelay(5);
>>> +
>>> +    val =3D readl(data->regs + TEMP0_VALUE);
>>> +    val =3D _step_to_temp(val);
>>> +
>>> +    /* adjust for negative value */
>>> +    val =3D (val < 0) ? 0 : val;
>>> +
>>> +    spin_unlock_irqrestore(&thermal_lock, flags);
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static void hisi_thermal_bind_irq(struct hisi_thermal_data *data)
>>> +{
>>> +    struct hisi_thermal_sensor *sensor;
>>> +    unsigned long flags;
>>> +
>>> +    sensor =3D &data->sensors[data->irq_bind_sensor];
>>> +
>>> +    spin_lock_irqsave(&thermal_lock, flags);
>>> +
>>> +    /* setting the hdak time */
>>> +    writel(0x0, data->regs + TEMP0_CFG);
>>> +
>>> +    /* disable module firstly */
>>> +    writel(0x0, data->regs + TEMP0_RST_MSK);
>>> +    writel(0x0, data->regs + TEMP0_EN);
>>> +
>>> +    /* select sensor id */
>>> +    writel((sensor->id << 12), data->regs + TEMP0_CFG);
>>> +
>>> +    /* enable for interrupt */
>>> +    writel(_temp_to_step(sensor->thres_temp)
>>> +            | 0x0FFFFFF00, data->regs + TEMP0_TH);
>>> +
>>> +    writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST_=
TH);
>>> +
>>> +    /* enable module */
>>> +    writel(0x1, data->regs + TEMP0_RST_MSK);
>>> +    writel(0x1, data->regs + TEMP0_EN);
>>> +
>>> +    writel(0x0, data->regs + TEMP0_INT_CLR);
>>> +    writel(0x1, data->regs + TEMP0_INT_EN);
>>> +
>>> +    mdelay(5);
>>> +
>>> +    spin_unlock_irqrestore(&thermal_lock, flags);
>>> +
>>> +}
>>> +
>>> +static void hisi_thermal_enable_sensor(struct hisi_thermal_data *d=
ata)
>>> +{
>>> +    struct hisi_thermal_sensor *sensor;
>>> +    unsigned long flags;
>>> +
>>> +    sensor =3D &data->sensors[data->irq_bind_sensor];
>>> +
>>> +    spin_lock_irqsave(&thermal_lock, flags);
>>> +
>>> +    /* setting the hdak time */
>>> +    writel(0x0, data->regs + TEMP0_CFG);
>>> +
>>> +    /* disable module firstly */
>>> +    writel(0x0, data->regs + TEMP0_RST_MSK);
>>> +    writel(0x0, data->regs + TEMP0_EN);
>>> +
>>> +    /* select sensor id */
>>> +    writel((sensor->id << 12), data->regs + TEMP0_CFG);
>>> +
>>> +    /* enable for interrupt */
>>> +    writel(_temp_to_step(sensor->thres_temp)
>>> +            | 0x0FFFFFF00, data->regs + TEMP0_TH);
>>> +
>>> +    writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST_=
TH);
>>> +
>>> +    /* enable module */
>>> +    writel(0x1, data->regs + TEMP0_RST_MSK);
>>> +    writel(0x1, data->regs + TEMP0_EN);
>>> +
>>> +    writel(0x0, data->regs + TEMP0_INT_CLR);
>>> +    writel(0x1, data->regs + TEMP0_INT_EN);
>>> +
>>> +    mdelay(5);
>>> +
>>> +    spin_unlock_irqrestore(&thermal_lock, flags);
>>> +

       Why take a 5ms delay in spin_lock_irq context ?

       Could we use mutex or other synchronization api here?

       For TEMP0_INT_EN, TEMP0_RST_MSK, we can use=20
disable_irq(THERM_IRQ) instead.

>>> +}
>>> +
>>> +static void hisi_thermal_disable_sensor(struct hisi_thermal_data *=
data)
>>> +{
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&thermal_lock, flags);
>>> +
>>> +    /* disable sensor module */
>>> +    writel(0x0, data->regs + );
>>> +    writel(0x0, data->regs + TEMP0_RST_MSK);
>>> +    writel(0x0, data->regs + TEMP0_EN);
>>> +
>>> +    spin_unlock_irqrestore(&thermal_lock, flags);
>>> +
>>> +}
>>> +
>>> +static int hisi_thermal_get_temp(void *_sensor, long *temp)
>>> +{
>>> +    struct hisi_thermal_sensor *sensor =3D _sensor;
>>> +    struct hisi_thermal_data *data =3D sensor->thermal;
>>> +
>>> +    int sensor_id =3D 0, i;
>>> +    long max_temp =3D 0;
>>> +
>>> +    *temp =3D hisi_thermal_get_sensor_temp(data, sensor);
>>> +
>>> +    data->sensor_temp[sensor->id] =3D *temp;
>>> +
>>> +    for (i =3D 0; i < HISI_MAX_SENSORS; i++) {
>>> +        if (data->sensor_temp[i] >=3D max_temp) {
>>> +            max_temp =3D data->sensor_temp[i];
>>> +            sensor_id =3D i;
>>> +        }
>>> +    }
>>> +
>>> +    data->irq_bind_sensor =3D sensor_id;
>>> +
>>> +    dev_dbg(&data->pdev->dev, "id=3D%d, irq=3D%d, temp=3D%ld, thre=
s=3D%d\n",
>>> +        sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
>>> +
>>> +    /*
>>> +     * Bind irq to sensor for two cases:
>>> +     *   Reenable alarm IRQ if temperature below threshold;
>>> +     *   if irq has been enabled, always set it;
>>> +     */
>>> +    if (!data->irq_enabled && max_temp < sensor->thres_temp) {
>>> +        data->irq_enabled =3D true;
>>> +        hisi_thermal_bind_irq(data);
>>> +    } else if (data->irq_enabled)
>>> +        hisi_thermal_bind_irq(data);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct thermal_zone_of_device_ops hisi_of_thermal_ops =3D {
>>> +    .get_temp =3D hisi_thermal_get_temp,
>>> +};
>>> +
>>> +static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
>>> +{
>>> +    struct hisi_thermal_data *data =3D dev;
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&thermal_lock, flags);
>>> +
>>> +    /* disable interrupt */
>>> +    writel(0x0, data->regs + TEMP0_INT_EN);
>>> +    writel(0x1, data->regs + TEMP0_INT_CLR);
>>> +
>>> +    spin_unlock_irqrestore(&thermal_lock, flags);
>>> +    data->irq_enabled =3D false;
>>> +
>>> +    return IRQ_WAKE_THREAD;
>>> +}
>>> +
>>> +static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *de=
v)
>>> +{
>>> +    struct hisi_thermal_data *data =3D dev;
>>> +    struct hisi_thermal_sensor *sensor;
>>> +    int i;
>>> +
>>> +    sensor =3D &data->sensors[data->irq_bind_sensor];
>>> +
>>> +    dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
>>> +         sensor->thres_temp / 1000);
>>> +
>>> +    for (i =3D 0; i < data->sensors_num; i++)
>>> +        thermal_zone_device_update(data->sensors[i].tzd);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int hisi_thermal_init_sensor(struct platform_device *pdev,
>>> +                    struct device_node *np,
>>> +                    struct hisi_thermal_data *data,
>>> +                    int index)
>>> +{
>>> +    struct hisi_thermal_sensor *sensor;
>>> +    int ret, i;
>>> +
>>> +    sensor =3D &data->sensors[index];
>>> +
>>> +    ret =3D of_property_read_u32(np, "hisilicon,tsensor-id",
>>> +                    &sensor->id);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to get id %d: %d\n", index, re=
t);
>>> +        return ret;
>>> +    }
>>> +
>>> +    sensor->thermal =3D data;
>>> +    sensor->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, se=
nsor->id,
>>> +                sensor, &hisi_of_thermal_ops);
>>> +    if (IS_ERR(sensor->tzd)) {
>>> +        ret =3D PTR_ERR(sensor->tzd);
>>> +        dev_err(&pdev->dev, "failed to register sensor id %d: %d\n=
",
>>> +            sensor->id, ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    sensor->trip =3D of_thermal_get_trip_points(sensor->tzd);
>>> +
>>> +    for (i =3D 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
>>> +        if (sensor->trip[i].type =3D=3D THERMAL_TRIP_PASSIVE) {
>>> +            sensor->thres_temp =3D sensor->trip[i].temperature;
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int hisi_thermal_get_sensor_data(struct platform_device *pd=
ev)
>>> +{
>>> +    struct hisi_thermal_data *data =3D platform_get_drvdata(pdev);
>>> +    struct device_node *np =3D pdev->dev.of_node;
>>> +    struct device_node *child_np;
>>> +    int ret, i, index;
>>> +
>>> +    /* sensor initialization */
>>> +    index =3D 0;
>>> +    for_each_child_of_node(np, child_np) {
>>> +
>>> +        if (index >=3D HISI_MAX_SENSORS) {
>>> +            dev_err(&pdev->dev, "unsupported sensor number\n");
>>> +            ret =3D -EINVAL;
>>> +            goto err_init_sensors;
>>> +        }
>>> +
>>> +        ret =3D hisi_thermal_init_sensor(pdev, child_np, data, ind=
ex);
>>> +        if (ret)
>>> +            goto err_init_sensors;
>>> +
>>> +        index++;
>>> +    }
>>> +
>>> +    data->sensors_num =3D index;
>>> +    return 0;
>>> +
>>> +err_init_sensors:
>>> +    for (i =3D 0; i < index; i++)
>>> +        thermal_zone_of_sensor_unregister(&pdev->dev,
>>> +                data->sensors[i].tzd);
>>> +    return ret;
>>> +}
>>> +
>>> +static const struct of_device_id of_hisi_thermal_match[] =3D {
>>> +    { .compatible =3D "hisilicon,tsensor" },
>>> +    { /* end */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
>>> +
>>> +static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor =
*sensor,
>>> +                       bool on)
>>> +{
>>> +    struct thermal_zone_device *tzd =3D sensor->tzd;
>>> +
>>> +    tzd->ops->set_mode(tzd,
>>> +        on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
>>> +}
>>> +
>>> +static int hisi_thermal_probe(struct platform_device *pdev)
>>> +{
>>> +    struct hisi_thermal_data *data;
>>> +    struct resource *res;
>>> +    int i;
>>> +    int ret;
>>> +
>>> +    data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +    if (!data)
>>> +        return -ENOMEM;
>>> +
>>> +    data->pdev =3D pdev;
>>> +
>>> +    res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    data->regs =3D devm_ioremap_resource(&pdev->dev, res);
>>> +    if (IS_ERR(data->regs)) {
>>> +        dev_err(&pdev->dev, "failed to get io address\n");
>>> +        return PTR_ERR(data->regs);
>>> +    }
>>> +
>>> +    data->irq =3D platform_get_irq(pdev, 0);
>>> +    if (data->irq < 0)
>>> +        return data->irq;
>>> +
>>> +    ret =3D devm_request_threaded_irq(&pdev->dev, data->irq,
>>> +            hisi_thermal_alarm_irq, hisi_thermal_alarm_irq_thread,
>>> +            0, "hisi_thermal", data);
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "failed to request alarm irq: %d\n", r=
et);
>>> +        return ret;
>>> +    }
>>> +
>>> +    platform_set_drvdata(pdev, data);
>>> +
>>> +    data->clk =3D devm_clk_get(&pdev->dev, "thermal_clk");
>>> +    if (IS_ERR(data->clk)) {
>>> +        ret =3D PTR_ERR(data->clk);
>>> +        if (ret !=3D -EPROBE_DEFER)
>>> +            dev_err(&pdev->dev,
>>> +                "failed to get thermal clk: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* enable clock for thermal */
>>> +    ret =3D clk_prepare_enable(data->clk);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", =
ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret =3D hisi_thermal_get_sensor_data(pdev);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to get sensor data\n");
>>> +        goto err_get_sensor_data;
>>> +        return ret;
>>> +    }
>>> +
>>> +    hisi_thermal_enable_sensor(data);
>>> +    data->irq_enabled =3D true;
>>> +
>>> +    for (i =3D 0; i < data->sensors_num; i++)
>>> +        hisi_thermal_toggle_sensor(&data->sensors[i], true);
>>> +
>>> +    return 0;
>>> +
>>> +err_get_sensor_data:
>>> +    clk_disable_unprepare(data->clk);
>>> +    return ret;
>>> +}
>>> +
>>> +static int hisi_thermal_remove(struct platform_device *pdev)
>>> +{
>>> +    struct hisi_thermal_data *data =3D platform_get_drvdata(pdev);
>>> +    int i;
>>> +
>>> +    for (i =3D 0; i < data->sensors_num; i++) {
>>> +        struct hisi_thermal_sensor *sensor =3D &data->sensors[i];
>>> +
>>> +        hisi_thermal_toggle_sensor(sensor, false);
>>> +        thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd)=
;
>>> +    }
>>> +
>>> +    hisi_thermal_disable_sensor(data);
>>> +    clk_disable_unprepare(data->clk);
>>> +    return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int hisi_thermal_suspend(struct device *dev)
>>> +{
>>> +    struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
>>> +
>>> +    hisi_thermal_disable_sensor(data);
>>> +    data->irq_enabled =3D false;
>>> +
>>> +    clk_disable_unprepare(data->clk);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int hisi_thermal_resume(struct device *dev)
>>> +{
>>> +    struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
>>> +
>>> +    clk_prepare_enable(data->clk);
>>> +
>>> +    data->irq_enabled =3D true;
>>> +    hisi_thermal_enable_sensor(data);
>>> +
>>> +    return 0;
>>> +}
>>> +#endif
>>> +
>>> +static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
>>> +             hisi_thermal_suspend, hisi_thermal_resume);
>>> +
>>> +static struct platform_driver hisi_thermal_driver =3D {
>>> +    .driver =3D {
>>> +        .name    =3D "hisi_thermal",
>>> +        .owner  =3D THIS_MODULE,
>>> +        .pm    =3D &hisi_thermal_pm_ops,
>>> +        .of_match_table =3D of_hisi_thermal_match,
>>> +    },
>>> +    .probe        =3D hisi_thermal_probe,
>>> +    .remove        =3D hisi_thermal_remove,
>>> +};
>>> +
>>> +static int __init hisi_thermal_init(void)
>>> +{
>>> +    return platform_driver_register(&hisi_thermal_driver);
>>> +}
>>> +
>>> +static void __exit hisi_thermal_exit(void)
>>> +{
>>> +    platform_driver_unregister(&hisi_thermal_driver);
>>> +}
>>> +
>>> +late_initcall(hisi_thermal_init);
>>> +module_exit(hisi_thermal_exit);
>>> +
>>> +MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
>>> +MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
>>> +MODULE_DESCRIPTION("Hisilicon thermal driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
>>
>>
>> .
>>
>
>
> .
>
