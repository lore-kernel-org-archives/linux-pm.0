From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: =?gbk?Q?=B4=F0=B8=B4=3A_=5BPATCH_v3_2/2=5D_thermal=3A?=
 =?gbk?Q?_hisilicon=3A_add_new_hisilicon_thermal_sensor_dri?=
 =?gbk?Q?ver?=
Date: Wed, 22 Apr 2015 13:47:40 +0800
Message-ID: <553735FC.2020704@hisilicon.com>
References: <1428403252-8208-1-git-send-email-kong.kongxinwei@hisilicon.com>,<1428403252-8208-3-git-send-email-kong.kongxinwei@hisilicon.com> <62D2F9B90E00B742A0ABA02CC88C65EA298E4D81@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <62D2F9B90E00B742A0ABA02CC88C65EA298E4D81-tJwL4pWccCbk2xaCPkHFjwK1hpo4iccwjNknBlVQO8k@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wangfei (William, Euler)" <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org" <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, "jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Liguozhu (Kenneth)" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 2015/4/21 17:09, Wangfei (William, Euler) wrote:
> =B7=A2=BC=FE=C8=CB: linuxarm-bounces-hv44wF8Li93QT0dZR+AlfA@public.gmane.org [linuxarm-bounces@hua=
wei.com] =B4=FA=B1=ED Xinwei Kong [kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org]
> =B7=A2=CB=CD=CA=B1=BC=E4: 2015=C4=EA4=D4=C27=C8=D5 18:40
> =CA=D5=BC=FE=C8=CB: rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; mporte=
r@konsulko.com; jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; haojian.zhuang@linaro.o=
rg; linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> =B3=AD=CB=CD: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g; Linuxarm; Liguozhu (Kenneth); linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> =D6=F7=CC=E2: [PATCH v3 2/2] thermal: hisilicon: add new hisilicon th=
ermal sensor driver
>=20
> From: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>=20
> This patch adds the support for hisilicon thermal sensor, within
> hisilicon SoC. there will register sensors for thermal framework
> and use device tree to bind cooling device.
>=20
> Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> ---
>  drivers/thermal/Kconfig        |   8 +
>  drivers/thermal/Makefile       |   1 +
>  drivers/thermal/hisi_thermal.c | 438 +++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 447 insertions(+)
>  create mode 100644 drivers/thermal/hisi_thermal.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index af40db0..81aee01 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -136,6 +136,14 @@ config THERMAL_EMULATION
>           because userland can easily disable the thermal policy by s=
imply
>           flooding this sysfs node with low temperature values.
>=20
> +config HISI_THERMAL
> +       tristate "Hisilicon thermal driver"
> +       depends on ARCH_HISI && CPU_THERMAL && OF
> +       help
> +         Enable this to plug hisilicon's thermal sensor driver into =
the Linux
> +         thermal framework. cpufreq is used as the cooling device to=
 throttle
> +         CPUs when the passive trip is crossed.
> +
>  config IMX_THERMAL
>         tristate "Temperature sensor driver for Freescale i.MX SoCs"
>         depends on CPU_THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index fa0dc48..08ae7ac 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_TI_SOC_THERMAL)  +=3D ti-soc-thermal/
>  obj-$(CONFIG_INT340X_THERMAL)  +=3D int340x_thermal/
>  obj-$(CONFIG_ST_THERMAL)       +=3D st/
>  obj-$(CONFIG_TEGRA_SOCTHERM)   +=3D tegra_soctherm.o
> +obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_th=
ermal.c
> new file mode 100644
> index 0000000..50ffb45
> --- /dev/null
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -0,0 +1,438 @@
> +/*
> + * Hisilicon thermal sensor driver
> + *
> + * Copyright (c) 2014-2015 Hisilicon Limited.
> + * Copyright (c) 2014-2015 Linaro Limited.
> + *
> + * Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> + * Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/cpu_cooling.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +
> +#include "thermal_core.h"
> +
> +#define TEMP0_LAG                      (0x0)
> +#define TEMP0_TH                       (0x4)
> +#define TEMP0_RST_TH                   (0x8)
> +#define TEMP0_CFG                      (0xC)
> +#define TEMP0_EN                       (0x10)
> +#define TEMP0_INT_EN                   (0x14)
> +#define TEMP0_INT_CLR                  (0x18)
> +#define TEMP0_RST_MSK                  (0x1C)
> +#define TEMP0_RAW_INT                  (0x20)
> +#define TEMP0_MSK_INT                  (0x24)
> +#define TEMP0_VALUE                    (0x28)
> +
> +#define HISI_TEMP_BASE                 (-60)
> +#define HISI_TEMP_RESET                (100000)
> +#define HISI_TEMP_PASSIVE              (85000)
>=20
> Don't use it in this drver

Good comment!!
>=20
> +
> +#define HISI_MAX_SENSORS               4
> +
> +struct hisi_thermal_sensor {
> +       struct hisi_thermal_data *thermal;
> +       struct thermal_zone_device *tzd;
> +       const struct thermal_trip *trip;
> +
> +       uint32_t id;
> +       uint32_t thres_temp;
> +       uint32_t reset_temp;
> +};
> +
> +struct hisi_thermal_data {
> +       struct mutex thermal_lock;
> +       struct platform_device *pdev;
> +       struct clk *clk;
> +
> +       int irq, irq_bind_sensor;
> +       bool irq_enabled;
> +
> +       unsigned int sensors_num;
> +       long sensor_temp[HISI_MAX_SENSORS];
> +       struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
> +
> +       void __iomem *regs;
> +};
> +
> +/* in millicelsius */
> +static inline int _step_to_temp(int step)
> +{
> +       /*
> +        * Every step equals (1 * 200) / 255 celsius, and finally
> +        * need convert to millicelsius.
> +        */
> +       return (HISI_TEMP_BASE + (step * 200 / 255)) * 1000;
> +}
> +
> +static inline int _temp_to_step(int temp)
> +{
> +       return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
> +}
> +
> +static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *d=
ata,
> +                                        struct hisi_thermal_sensor *=
sensor)
> +{
> +       int val;
> +
> +       mutex_lock(&data->thermal_lock);
> +
> +       /* disable interrupt */
> +       writel(0x0, data->regs + TEMP0_INT_EN);
> +       writel(0x1, data->regs + TEMP0_INT_CLR);
> +
> +       /* disable module firstly */
> +       writel(0x0, data->regs + TEMP0_EN);
> +
> +       /* select sensor id */
> +       writel((sensor->id << 12), data->regs + TEMP0_CFG);
> +
> +       /* enable module */
> +       writel(0x1, data->regs + TEMP0_EN);
> +
> +       msleep(5);
>=20
> usleep_range() replace of msleep(), You can see it: (/Documentation/t=
imers/timers-howto.txt)
>=20
I will study it and use it, Thanks!!

> +
> +       val =3D readl(data->regs + TEMP0_VALUE);
> +       val =3D _step_to_temp(val);
> +
> +       /* adjust for negative value */
> +       val =3D (val < 0) ? 0 : val;
> +
> +       mutex_unlock(&data->thermal_lock);
> +
> +       return val;
> +}
> +
> +static void hisi_thermal_bind_irq(struct hisi_thermal_data *data)
> +{
> +       struct hisi_thermal_sensor *sensor;
> +
> +       sensor =3D &data->sensors[data->irq_bind_sensor];
> +
> +       mutex_lock(&data->thermal_lock);
> +
> +       /* setting the hdak time */
> +       writel(0x0, data->regs + TEMP0_CFG);
> +
> +       /* disable module firstly */
> +       writel(0x0, data->regs + TEMP0_RST_MSK);
> +       writel(0x0, data->regs + TEMP0_EN);
> +
> +       /* select sensor id */
> +       writel((sensor->id << 12), data->regs + TEMP0_CFG);
> +
> +       /* enable for interrupt */
> +       writel(_temp_to_step(sensor->thres_temp)
> +                       | 0x0FFFFFF00, data->regs + TEMP0_TH);
> +
> +       writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST=
_TH);
> +
> +       /* enable module */
> +       writel(0x1, data->regs + TEMP0_RST_MSK);
> +       writel(0x1, data->regs + TEMP0_EN);
> +
> +       writel(0x0, data->regs + TEMP0_INT_CLR);
> +       writel(0x1, data->regs + TEMP0_INT_EN);
> +       msleep(5);
> +
> +       mutex_unlock(&data->thermal_lock);
> +
> +}
> +
> +static void hisi_thermal_enable_sensor(struct hisi_thermal_data *dat=
a)
> +{
> +       hisi_thermal_bind_irq(data);
> +}
> +
> +static void hisi_thermal_disable_sensor(struct hisi_thermal_data *da=
ta)
> +{
> +
> +       mutex_lock(&data->thermal_lock);
> +
> +       /* disable sensor module */
> +       writel(0x0, data->regs + TEMP0_INT_EN);
> +       writel(0x0, data->regs + TEMP0_RST_MSK);
> +       writel(0x0, data->regs + TEMP0_EN);
> +
> +       mutex_unlock(&data->thermal_lock);
> +
> +}
> +
> +static int hisi_thermal_get_temp(void *_sensor, long *temp)
> +{
> +       struct hisi_thermal_sensor *sensor =3D _sensor;
> +       struct hisi_thermal_data *data =3D sensor->thermal;
> +
> +       int sensor_id =3D 0, i;
> +       long max_temp =3D 0;
> +
> +       *temp =3D hisi_thermal_get_sensor_temp(data, sensor);
> +
> +       data->sensor_temp[sensor->id] =3D *temp;
> +
> +       for (i =3D 0; i < HISI_MAX_SENSORS; i++) {
> +               if (data->sensor_temp[i] >=3D max_temp) {
> +                       max_temp =3D data->sensor_temp[i];
> +                       sensor_id =3D i;
> +               }
> +       }
> +
> +       data->irq_bind_sensor =3D sensor_id;
> +
> +       dev_dbg(&data->pdev->dev, "id=3D%d, irq=3D%d, temp=3D%ld, thr=
es=3D%d\n",
> +               sensor->id, data->irq_enabled, *temp, sensor->thres_t=
emp);
> +       /*
> +        * Bind irq to sensor for two cases:
> +        *   Reenable alarm IRQ if temperature below threshold;
> +        *   if irq has been enabled, always set it;
> +        */
> +       if (!data->irq_enabled && max_temp < sensor->thres_temp) {
> +               data->irq_enabled =3D true;
> +               hisi_thermal_bind_irq(data);
> +               enable_irq(data->irq);
> +       } else if (data->irq_enabled)
> +               hisi_thermal_bind_irq(data);
> +
> +       return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops hisi_of_thermal_ops =3D {
> +       .get_temp =3D hisi_thermal_get_temp,
> +};
> +
> +static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
> +{
> +       struct hisi_thermal_data *data =3D dev;
> +
> +       disable_irq_nosync(irq);
> +       data->irq_enabled =3D false;
> +
> +       return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
> +{
> +       struct hisi_thermal_data *data =3D dev;
> +       struct hisi_thermal_sensor *sensor;
> +       int i;
> +
> +       sensor =3D &data->sensors[data->irq_bind_sensor];
> +
> +       dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
> +                sensor->thres_temp / 1000);
> +
> +       for (i =3D 0; i < data->sensors_num; i++)
> +               thermal_zone_device_update(data->sensors[i].tzd);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int hisi_thermal_register_sensor(struct platform_device *pdev=
,
> +                                       struct hisi_thermal_data *dat=
a,
> +                                       struct hisi_thermal_sensor *s=
ensor,
> +                                       int index)
> +{
> +       int ret, i;
> +
> +       sensor->id =3D index;
> +       sensor->thermal =3D data;
> +
> +       sensor->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, s=
ensor->id,
> +                               sensor, &hisi_of_thermal_ops);
> +       if (IS_ERR(sensor->tzd)) {
> +               ret =3D PTR_ERR(sensor->tzd);
> +               dev_err(&pdev->dev, "failed to register sensor id %d:=
 %d\n",
> +                       sensor->id, ret);
> +               return ret;
> +       }
> +
> +       sensor->trip =3D of_thermal_get_trip_points(sensor->tzd);
> +
> +       for (i =3D 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
> +               if (sensor->trip[i].type =3D=3D THERMAL_TRIP_PASSIVE)=
 {
> +                       sensor->thres_temp =3D sensor->trip[i].temper=
ature;
> +                       break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id of_hisi_thermal_match[] =3D {
> +       { .compatible =3D "hisilicon,tsensor" },
> +       { /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
> +
> +static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *s=
ensor,
> +                                      bool on)
> +{
> +       struct thermal_zone_device *tzd =3D sensor->tzd;
> +
> +       tzd->ops->set_mode(tzd,
> +               on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED=
);
> +}
> +
> +static int hisi_thermal_probe(struct platform_device *pdev)
> +{
> +       struct hisi_thermal_data *data;
> +       struct resource *res;
> +       int i;
> +       int ret;
> +
> +       data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       mutex_init(&data->thermal_lock);
> +       data->pdev =3D pdev;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       data->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(data->regs)) {
> +               dev_err(&pdev->dev, "failed to get io address\n");
> +               return PTR_ERR(data->regs);
> +       }
> +
> +       data->irq =3D platform_get_irq(pdev, 0);
> +       if (data->irq < 0)
> +               return data->irq;
> +
> +       ret =3D devm_request_threaded_irq(&pdev->dev, data->irq,
> +                       hisi_thermal_alarm_irq, hisi_thermal_alarm_ir=
q_thread,
> +                       0, "hisi_thermal", data);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to request alarm irq: %d\=
n", ret);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       data->clk =3D devm_clk_get(&pdev->dev, "thermal_clk");
> +       if (IS_ERR(data->clk)) {
> +               ret =3D PTR_ERR(data->clk);
> +               if (ret !=3D -EPROBE_DEFER)
> +                       dev_err(&pdev->dev,
> +                               "failed to get thermal clk: %d\n", re=
t);
> +               return ret;
> +       }
> +
> +       /* enable clock for thermal */
> +       ret =3D clk_prepare_enable(data->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable thermal clk: %d=
\n", ret);
> +               return ret;
> +       }
> +
> +       for (i =3D 0; i < HISI_MAX_SENSORS; ++i) {
> +               ret =3D hisi_thermal_register_sensor(pdev, data,
> +                                       &data->sensors[i], i);
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                       "failed to register thermal sensor: %d\n", re=
t);
> +                       goto err_get_sensor_data;
> +                       return ret;
> Don't follow return, delete it.
>=20
> Feiwang

OK!!
>=20


> +               }
> +       }
> +
> +       hisi_thermal_enable_sensor(data);
> +       data->irq_enabled =3D true;
> +
> +       for (i =3D 0; i < data->sensors_num; i++)
> +               hisi_thermal_toggle_sensor(&data->sensors[i], true);
> +
> +       return 0;
> +
> +err_get_sensor_data:
> +       clk_disable_unprepare(data->clk);
> +       return ret;
> +}
> +
> +static int hisi_thermal_remove(struct platform_device *pdev)
> +{
> +       struct hisi_thermal_data *data =3D platform_get_drvdata(pdev)=
;
> +       int i;
> +
> +       for (i =3D 0; i < data->sensors_num; i++) {
> +               struct hisi_thermal_sensor *sensor =3D &data->sensors=
[i];
> +
> +               hisi_thermal_toggle_sensor(sensor, false);
> +               thermal_zone_of_sensor_unregister(&pdev->dev, sensor-=
>tzd);
> +       }
> +
> +       hisi_thermal_disable_sensor(data);
> +       clk_disable_unprepare(data->clk);
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int hisi_thermal_suspend(struct device *dev)
> +{
> +       struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
> +
> +       hisi_thermal_disable_sensor(data);
> +       data->irq_enabled =3D false;
> +
> +       clk_disable_unprepare(data->clk);
> +
> +       return 0;
> +}
> +
> +static int hisi_thermal_resume(struct device *dev)
> +{
> +       struct hisi_thermal_data *data =3D dev_get_drvdata(dev);
> +
> +       clk_prepare_enable(data->clk);
> +
> +       data->irq_enabled =3D true;
> +       hisi_thermal_enable_sensor(data);
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
> +                        hisi_thermal_suspend, hisi_thermal_resume);
> +
> +static struct platform_driver hisi_thermal_driver =3D {
> +       .driver =3D {
> +               .name   =3D "hisi_thermal",
> +               .owner  =3D THIS_MODULE,
> +               .pm     =3D &hisi_thermal_pm_ops,
> +               .of_match_table =3D of_hisi_thermal_match,
> +       },
> +       .probe          =3D hisi_thermal_probe,
> +       .remove         =3D hisi_thermal_remove,
> +};
> +
> +module_platform_driver(hisi_thermal_driver);
> +
> +MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>");
> +MODULE_AUTHOR("Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
> +MODULE_DESCRIPTION("Hisilicon thermal driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>=20
>=20
> _______________________________________________
> linuxarm mailing list
> linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
