From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Fri, 11 Dec 2015 16:52:53 +0900
Message-ID: <566A80D5.2070703@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
 <1449810479-14763-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449810479-14763-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear MyungJoo,

Almost device tree patches in this series are reviewed by Exynos mainta=
iner.
Could you please review this series?

Best Regards,
Chanwoo Choi

On 2015=EB=85=84 12=EC=9B=94 11=EC=9D=BC 14:07, Chanwoo Choi wrote:
> This patch adds the generic exynos bus frequency driver for AMBA AXI =
bus
> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exyno=
s SoC
> have the common architecture for bus between DRAM and sub-blocks in S=
oC.
> This driver can support the generic bus frequency driver for Exynos S=
oCs.
>=20
> In devicetree, Each bus block has a bus clock, regulator, operation-p=
oint
> and devfreq-event devices which measure the utilization of each bus b=
lock.
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [linux.amoon: Tested on Odroid U3]
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/devfreq/Kconfig             |  15 ++
>  drivers/devfreq/Makefile            |   1 +
>  drivers/devfreq/exynos/Makefile     |   1 +
>  drivers/devfreq/exynos/exynos-bus.c | 449 ++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 466 insertions(+)
>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>=20
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 64281bb2f650..55ec774f794c 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -66,6 +66,21 @@ config DEVFREQ_GOV_USERSPACE
> =20
>  comment "DEVFREQ Drivers"
> =20
> +config ARM_EXYNOS_BUS_DEVFREQ
> +	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
> +	depends on ARCH_EXYNOS
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select DEVFREQ_EVENT_EXYNOS_PPMU
> +	select PM_DEVFREQ_EVENT
> +	select PM_OPP
> +	help
> +	  This adds the common DEVFREQ driver for Exynos Memory bus. Exynos
> +	  Memory bus has one more group of memory bus (e.g, MIF and INT blo=
ck).
> +	  Each memory bus group could contain many memoby bus block. It rea=
ds
> +	  PPMU counters of memory controllers by using DEVFREQ-event device
> +	  and adjusts the operating frequencies and voltages with OPP suppo=
rt.
> +	  This does not yet operate with optimal voltages.
> +
>  config ARM_EXYNOS4_BUS_DEVFREQ
>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
>  	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) && =
!ARCH_MULTIPLATFORM
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 5134f9ee983d..375ebbb4fcfb 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_pow=
ersave.o
>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o
> =20
>  # DEVFREQ Drivers
> +obj-$(CONFIG_ARCH_EXYNOS)		+=3D exynos/
>  obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)	+=3D exynos/
>  obj-$(CONFIG_ARM_EXYNOS5_BUS_DEVFREQ)	+=3D exynos/
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra-devfreq.o
> diff --git a/drivers/devfreq/exynos/Makefile b/drivers/devfreq/exynos=
/Makefile
> index 49bc9175f923..4ec06d322996 100644
> --- a/drivers/devfreq/exynos/Makefile
> +++ b/drivers/devfreq/exynos/Makefile
> @@ -1,3 +1,4 @@
>  # Exynos DEVFREQ Drivers
> +obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o
>  obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)	+=3D exynos_ppmu.o exynos4_bus=
=2Eo
>  obj-$(CONFIG_ARM_EXYNOS5_BUS_DEVFREQ)	+=3D exynos_ppmu.o exynos5_bus=
=2Eo
> diff --git a/drivers/devfreq/exynos/exynos-bus.c b/drivers/devfreq/ex=
ynos/exynos-bus.c
> new file mode 100644
> index 000000000000..f1bc20839650
> --- /dev/null
> +++ b/drivers/devfreq/exynos/exynos-bus.c
> @@ -0,0 +1,449 @@
> +/*
> + * Generic Exynos Bus frequency driver with DEVFREQ Framework
> + *
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
> + * Author : Chanwoo Choi <cw00.choi@samsung.com>
> + *
> + * This driver support Exynos Bus frequency feature by using
> + * DEVFREQ framework and is based on drivers/devfreq/exynos/exynos4_=
bus.c.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/devfreq-event.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#define DEFAULT_SATURATION_RATIO	40
> +
> +struct exynos_bus {
> +	struct device *dev;
> +
> +	struct devfreq *devfreq;
> +	struct devfreq_event_dev **edev;
> +	unsigned int edev_count;
> +	struct mutex lock;
> +
> +	struct dev_pm_opp *curr_opp;
> +
> +	struct regulator *regulator;
> +	struct clk *clk;
> +	int ratio;
> +};
> +
> +/*
> + * Control the devfreq-event device to get the current state of bus
> + */
> +#define exynos_bus_ops_edev(ops)				\
> +static int exynos_bus_##ops(struct exynos_bus *bus)		\
> +{								\
> +	int i, ret;						\
> +								\
> +	for (i =3D 0; i < bus->edev_count; i++) {			\
> +		if (!bus->edev[i])				\
> +			continue;				\
> +		ret =3D devfreq_event_##ops(bus->edev[i]);	\
> +		if (ret < 0)					\
> +			return ret;				\
> +	}							\
> +								\
> +	return 0;						\
> +}
> +exynos_bus_ops_edev(enable_edev);
> +exynos_bus_ops_edev(disable_edev);
> +exynos_bus_ops_edev(set_event);
> +
> +static int exynos_bus_get_event(struct exynos_bus *bus,
> +				struct devfreq_event_data *edata)
> +{
> +	struct devfreq_event_data event_data;
> +	unsigned long load_count =3D 0, total_count =3D 0;
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; i < bus->edev_count; i++) {
> +		if (!bus->edev[i])
> +			continue;
> +
> +		ret =3D devfreq_event_get_event(bus->edev[i], &event_data);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (i =3D=3D 0 || event_data.load_count > load_count) {
> +			load_count =3D event_data.load_count;
> +			total_count =3D event_data.total_count;
> +		}
> +	}
> +
> +	edata->load_count =3D load_count;
> +	edata->total_count =3D total_count;
> +
> +	return ret;
> +}
> +
> +/*
> + * Must necessary function for devfreq governor
> + */
> +static int exynos_bus_target(struct device *dev, unsigned long *freq=
, u32 flags)
> +{
> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
> +	struct dev_pm_opp *new_opp;
> +	unsigned long old_freq, new_freq, old_volt, new_volt;
> +	int ret =3D 0;
> +
> +	/* Get new opp-bus instance according to new bus clock */
> +	rcu_read_lock();
> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR_OR_NULL(new_opp)) {
> +		dev_err(dev, "failed to get recommed opp instance\n");
> +		rcu_read_unlock();
> +		return PTR_ERR(new_opp);
> +	}
> +
> +	new_freq =3D dev_pm_opp_get_freq(new_opp);
> +	new_volt =3D dev_pm_opp_get_voltage(new_opp);
> +	old_freq =3D dev_pm_opp_get_freq(bus->curr_opp);
> +	old_volt =3D dev_pm_opp_get_voltage(bus->curr_opp);
> +	rcu_read_unlock();
> +
> +	if (old_freq =3D=3D new_freq)
> +		return 0;
> +
> +	/* Change voltage and frequency according to new OPP level */
> +	mutex_lock(&bus->lock);
> +
> +	if (old_freq < new_freq) {
> +		ret =3D regulator_set_voltage(bus->regulator, new_volt, new_volt);
> +		if (ret < 0) {
> +			dev_err(bus->dev, "failed to set voltage\n");
> +			regulator_set_voltage(bus->regulator, old_volt,
> +						old_volt);
> +			goto out;
> +		}
> +	}
> +
> +	ret =3D clk_set_rate(bus->clk, new_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to change clock of bus\n");
> +		clk_set_rate(bus->clk, old_freq);
> +		goto out;
> +	}
> +
> +	if (old_freq > new_freq) {
> +		ret =3D regulator_set_voltage(bus->regulator, new_volt, new_volt);
> +		if (ret < 0) {
> +			dev_err(bus->dev, "failed to set voltage\n");
> +			regulator_set_voltage(bus->regulator, old_volt,
> +						old_volt);
> +			goto out;
> +		}
> +	}
> +	bus->curr_opp =3D new_opp;
> +
> +	dev_dbg(dev, "Set the frequency of bus (%ldkHz -> %ldkHz)\n",
> +			old_freq/1000, new_freq/1000);
> +out:
> +	mutex_unlock(&bus->lock);
> +
> +	return ret;
> +}
> +
> +static int exynos_bus_get_dev_status(struct device *dev,
> +				     struct devfreq_dev_status *stat)
> +{
> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
> +	struct devfreq_event_data edata;
> +	int ret;
> +
> +	rcu_read_lock();
> +	stat->current_frequency =3D dev_pm_opp_get_freq(bus->curr_opp);
> +	rcu_read_unlock();
> +
> +	ret =3D exynos_bus_get_event(bus, &edata);
> +	if (ret < 0) {
> +		stat->total_time =3D stat->busy_time =3D 0;
> +		goto err;
> +	}
> +
> +	stat->busy_time =3D (edata.load_count * 100) / bus->ratio;
> +	stat->total_time =3D edata.total_count;
> +
> +	dev_dbg(dev, "Usage of devfreq-event : %ld/%ld\n", stat->busy_time,
> +							stat->total_time);
> +
> +err:
> +	ret =3D exynos_bus_set_event(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set event to devfreq-event devices\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void exynos_bus_exit(struct device *dev)
> +{
> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D exynos_bus_disable_edev(bus);
> +	if (ret < 0)
> +		dev_warn(dev, "failed to disable the devfreq-event devices\n");
> +
> +	if (bus->regulator)
> +		regulator_disable(bus->regulator);
> +
> +	dev_pm_opp_of_remove_table(dev);
> +}
> +
> +static int exynos_bus_parse_of(struct device_node *np,
> +			      struct exynos_bus *bus)
> +{
> +	struct device *dev =3D bus->dev;
> +	unsigned long rate;
> +	int i, ret, count, size;
> +
> +	/* Get the clock to provide each bus with source clock */
> +	bus->clk =3D devm_clk_get(dev, "bus");
> +	if (IS_ERR(bus->clk)) {
> +		dev_err(dev, "failed to get bus clock\n");
> +		return PTR_ERR(bus->clk);
> +	}
> +
> +	ret =3D clk_prepare_enable(bus->clk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get enable clock\n");
> +		return ret;
> +	}
> +
> +	/* Get the freq/voltage OPP table to scale the bus frequency */
> +	rcu_read_lock();
> +	ret =3D dev_pm_opp_of_add_table(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get OPP table\n");
> +		rcu_read_unlock();
> +		return ret;
> +	}
> +
> +	rate =3D clk_get_rate(bus->clk);
> +	bus->curr_opp =3D dev_pm_opp_find_freq_ceil(dev, &rate);
> +	if (IS_ERR(bus->curr_opp)) {
> +		dev_err(dev, "failed to find dev_pm_opp\n");
> +		rcu_read_unlock();
> +		ret =3D PTR_ERR(bus->curr_opp);
> +		goto err_opp;
> +	}
> +	rcu_read_unlock();
> +
> +	/* Get the regulator to provide each bus with the power */
> +	bus->regulator =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(bus->regulator)) {
> +		dev_err(dev, "failed to get VDD regulator\n");
> +		ret =3D PTR_ERR(bus->regulator);
> +		goto err_opp;
> +	}
> +
> +	ret =3D regulator_enable(bus->regulator);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable VDD regulator\n");
> +		goto err_opp;
> +	}
> +
> +	/*
> +	 * Get the devfreq-event devices to get the current utilization of
> +	 * buses. This raw data will be used in devfreq ondemand governor.
> +	 */
> +	count =3D devfreq_event_get_edev_count(dev);
> +	if (count < 0) {
> +		dev_err(dev, "failed to get the count of devfreq-event dev\n");
> +		ret =3D count;
> +		goto err_regulator;
> +	}
> +	bus->edev_count =3D count;
> +
> +	size =3D sizeof(*bus->edev) * count;
> +	bus->edev =3D devm_kzalloc(dev, size, GFP_KERNEL);
> +	if (!bus->edev) {
> +		ret =3D -ENOMEM;
> +		goto err_regulator;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		bus->edev[i] =3D devfreq_event_get_edev_by_phandle(dev, i);
> +		if (IS_ERR(bus->edev[i])) {
> +			ret =3D -EPROBE_DEFER;
> +			goto err_regulator;
> +		}
> +	}
> +
> +	/*
> +	 * Optionally, Get the saturation ratio according to Exynos SoC
> +	 * When measuring the utilization of each AXI bus with devfreq-even=
t
> +	 * devices, the measured real cycle might be much lower than the
> +	 * total cycle of bus during sampling rate. In result, the devfreq
> +	 * simple-ondemand governor might not decide to change the current
> +	 * frequency due to too utilization (=3D real cycle/total cycle).
> +	 * So, this property is used to adjust the utilization when calcula=
ting
> +	 * the busy_time in exynos_bus_get_dev_status().
> +	 */
> +	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio=
))
> +		bus->ratio =3D DEFAULT_SATURATION_RATIO;
> +
> +	return 0;
> +
> +err_regulator:
> +	regulator_disable(bus->regulator);
> +err_opp:
> +	dev_pm_opp_of_remove_table(dev);
> +
> +	return ret;
> +}
> +
> +static int exynos_bus_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct devfreq_dev_profile *profile;
> +	struct devfreq_simple_ondemand_data *ondemand_data;
> +	struct exynos_bus *bus;
> +	int ret;
> +
> +	if (!np) {
> +		dev_err(dev, "failed to find devicetree node\n");
> +		return -EINVAL;
> +	}
> +
> +	bus =3D devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	if (!bus)
> +		return -ENOMEM;
> +	mutex_init(&bus->lock);
> +	bus->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, bus);
> +
> +	/* Parse the device-tree to get the resource information */
> +	ret =3D exynos_bus_parse_of(np, bus);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Initalize the struct profile and governor data */
> +	profile =3D devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> +	if (!profile)
> +		return -ENOMEM;
> +	profile->polling_ms =3D 50;
> +	profile->target =3D exynos_bus_target;
> +	profile->get_dev_status =3D exynos_bus_get_dev_status;
> +	profile->exit =3D exynos_bus_exit;
> +
> +	ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KER=
NEL);
> +	if (!ondemand_data)
> +		return -ENOMEM;
> +	ondemand_data->upthreshold =3D 40;
> +	ondemand_data->downdifferential =3D 5;
> +
> +	/* Add devfreq device to monitor and handle the exynos bus */
> +	bus->devfreq =3D devm_devfreq_add_device(dev, profile, "simple_onde=
mand",
> +						ondemand_data);
> +	if (IS_ERR_OR_NULL(bus->devfreq)) {
> +		dev_err(dev, "failed to add devfreq device\n");
> +		return  PTR_ERR(bus->devfreq);
> +	}
> +
> +	/* Register opp_notifier to catch the change of OPP  */
> +	ret =3D devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register opp notifier\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Enable devfreq-event to get raw data which is used to determine
> +	 * current bus load.
> +	 */
> +	ret =3D exynos_bus_enable_edev(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable devfreq-event devices\n");
> +		return ret;
> +	}
> +
> +	ret =3D exynos_bus_set_event(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set event to devfreq-event devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int exynos_bus_resume(struct device *dev)
> +{
> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (bus->regulator) {
> +		ret =3D regulator_enable(bus->regulator);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable VDD regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D exynos_bus_enable_edev(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable the devfreq-event devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int exynos_bus_suspend(struct device *dev)
> +{
> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D exynos_bus_disable_edev(bus);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to disable the devfreq-event devices\n");
> +		return ret;
> +	}
> +
> +	if (bus->regulator)
> +		regulator_disable(bus->regulator);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops exynos_bus_pm =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(exynos_bus_suspend, exynos_bus_resume)
> +};
> +
> +static const struct of_device_id exynos_bus_of_match[] =3D {
> +	{ .compatible =3D "samsung,exynos-bus", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, exynos_bus_of_match);
> +
> +static struct platform_driver exynos_bus_platdrv =3D {
> +	.probe		=3D exynos_bus_probe,
> +	.driver =3D {
> +		.name	=3D "exynos-bus",
> +		.pm	=3D &exynos_bus_pm,
> +		.of_match_table =3D of_match_ptr(exynos_bus_of_match),
> +	},
> +};
> +module_platform_driver(exynos_bus_platdrv);
> +
> +MODULE_DESCRIPTION("Generic Exynos Bus frequency driver");
> +MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
> +MODULE_LICENSE("GPL v2");
>=20
