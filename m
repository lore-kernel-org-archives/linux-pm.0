From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 15/18] thermal: samsung: core: Exynos TMU rework to
 use device tree for configuration
Date: Wed, 21 Jan 2015 05:14:15 -0400
Message-ID: <20150121091412.GD13468@developer.hsd1.ca.comcast.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-16-git-send-email-l.majewski@samsung.com>
 <20150121031816.GA22176@developer.hsd1.ca.comcast.net>
 <20150121094055.6b4a7c40@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150121094055.6b4a7c40@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2015 at 09:40:55AM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > On Mon, Jan 19, 2015 at 12:20:59PM +0100, Lukasz Majewski wrote:
> > > This patch brings support for providing configuration via device
> > > tree. Previously this data has been hardcoded in the
> > > exynos_tmu_data.c file. Such approach was not scalable and very
> > > often required copying the whole data.
> > >=20
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > ---
> > > Changes for v2:
> > > - Adjust exynos_tmu.c code to the newest ti-soc-thermal repository
> > > - Usage of of-thermal.c exported trip points table
> > > Changes for v3:
> > > - Adding exynos_of_get_soc_type() method to set SOC type from
> > > device's compatible string
> > > - "samsung,tmu_" prefix for TMU specific properties has been added
> > > Changes for v4:
> > > - None
> > > Changes for v5:
> > > - Remove duplicated exynos_tmu_initialize() - reported by Abhilash
> > > Kesavan <a.kesavan@samsung.com>
> > >=20
> >=20
> > several checkpatch.pl items to be reviewed in this patch:
> > CHECK: No space is necessary after a cast
> > #509: FILE: drivers/thermal/samsung/exynos_tmu.c:821:
> > +       pdata->gain =3D (u8) value;
> >=20
> > CHECK: No space is necessary after a cast
> > #511: FILE: drivers/thermal/samsung/exynos_tmu.c:823:
> > +       pdata->reference_voltage =3D (u8) value;
> >=20
> >=20
> > Can you please make sure all of your patches pass:
> > checkpatch.pl --strict
>=20
> `		^^^^^^^^^ Is now checkpatch.pl required to run with
> --strict rule?=20
>=20
> I've tested those patches only with checkpatch with no errors.
>=20
> Has kernel policy changed recently? Are all developers now obliged to
> use the --strict rule?

no change in policy. the --strict is just appreciated. it depends on
maintainer to maintainer. --strict catches more checks and warnings
though. that is probably why I see people asking for it.

>=20
>=20
> >=20
> > ?
> >=20
> >=20
> > > ---
> > >  drivers/thermal/samsung/Makefile     |   2 -
> > >  drivers/thermal/samsung/exynos_tmu.c | 339
> > > ++++++++++++++++++++++-------------
> > > drivers/thermal/samsung/exynos_tmu.h |  53 +----- 3 files changed,
> > > 220 insertions(+), 174 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/samsung/Makefile
> > > b/drivers/thermal/samsung/Makefile index c09d830..1e47d0d 100644
> > > --- a/drivers/thermal/samsung/Makefile
> > > +++ b/drivers/thermal/samsung/Makefile
> > > @@ -3,5 +3,3 @@
> > >  #
> > >  obj-$(CONFIG_EXYNOS_THERMAL)			+=3D
> > > exynos_thermal.o exynos_thermal-y				:=3D
> > > exynos_tmu.o -exynos_thermal-y				+=3D
> > > exynos_tmu_data.o
> > > -exynos_thermal-$(CONFIG_EXYNOS_THERMAL_CORE)	+=3D
> > > exynos_thermal_common.o diff --git
> > > a/drivers/thermal/samsung/exynos_tmu.c
> > > b/drivers/thermal/samsung/exynos_tmu.c index ae30f6a..9d2d685
> > > 100644 --- a/drivers/thermal/samsung/exynos_tmu.c +++
> > > b/drivers/thermal/samsung/exynos_tmu.c @@ -1,6 +1,10 @@ /*
> > >   * exynos_tmu.c - Samsung EXYNOS TMU (Thermal Management Unit)
> > >   *
> > > + *  Copyright (C) 2014 Samsung Electronics
> > > + *  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > + *  Lukasz Majewski <l.majewski@samsung.com>
> > > + *
> > >   *  Copyright (C) 2011 Samsung Electronics
> > >   *  Donggeun Kim <dg77.kim@samsung.com>
> > >   *  Amit Daniel Kachhap <amit.kachhap@linaro.org>
> > > @@ -31,8 +35,8 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regulator/consumer.h>
> > > =20
> > > -#include "exynos_thermal_common.h"
> > >  #include "exynos_tmu.h"
> > > +#include "../thermal_core.h"
> > > =20
> > >  /* Exynos generic registers */
> > >  #define EXYNOS_TMU_REG_TRIMINFO		0x0
> > > @@ -115,6 +119,7 @@
> > >  #define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
> > >  #define EXYNOS5440_EFUSE_SWAP_OFFSET		8
> > > =20
> > > +#define MCELSIUS	1000
> > >  /**
> > >   * struct exynos_tmu_data : A structure to hold the private data
> > > of the TMU driver
> > > @@ -150,7 +155,8 @@ struct exynos_tmu_data {
> > >  	struct clk *clk, *clk_sec;
> > >  	u8 temp_error1, temp_error2;
> > >  	struct regulator *regulator;
> > > -	struct thermal_sensor_conf *reg_conf;
> > > +	struct thermal_zone_device *tzd;
> > > +
> > >  	int (*tmu_initialize)(struct platform_device *pdev);
> > >  	void (*tmu_control)(struct platform_device *pdev, bool on);
> > >  	int (*tmu_read)(struct exynos_tmu_data *data);
> > > @@ -159,6 +165,33 @@ struct exynos_tmu_data {
> > >  	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
> > >  };
> > > =20
> > > +static void exynos_report_trigger(struct exynos_tmu_data *p)
> > > +{
> > > +	char data[10], *envp[] =3D { data, NULL };
> > > +	struct thermal_zone_device *tz =3D p->tzd;
> > > +	unsigned long temp;
> > > +	unsigned int i;
> > > +
> > > +	if (!p) {
> > > +		pr_err("Wrong temperature configuration data\n");
> > > +		return;
> > > +	}
> > > +
> > > +	thermal_zone_device_update(tz);
> > > +
> > > +	mutex_lock(&tz->lock);
> > > +	/* Find the level for which trip happened */
> > > +	for (i =3D 0; i < of_thermal_get_ntrips(tz); i++) {
> > > +		tz->ops->get_trip_temp(tz, i, &temp);
> > > +		if (tz->last_temperature < temp)
> > > +			break;
> > > +	}
> > > +
> > > +	snprintf(data, sizeof(data), "%u", i);
> > > +	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, envp);
> > > +	mutex_unlock(&tz->lock);
> > > +}
> > > +
> > >  /*
> > >   * TMU treats temperature as a mapped temperature code.
> > >   * The temperature is converted differently depending on the
> > > calibration type. @@ -234,14 +267,25 @@ static void
> > > sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)=20
> > >  static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold,
> > > bool falling) {
> > > -	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> > > +	struct thermal_zone_device *tz =3D data->tzd;
> > > +	const struct thermal_trip * const trips =3D
> > > +		of_thermal_get_trip_points(tz);
> > > +	unsigned long temp;
> > >  	int i;
> > > =20
> > > -	for (i =3D 0; i < pdata->non_hw_trigger_levels; i++) {
> > > -		u8 temp =3D pdata->trigger_levels[i];
> > > +	if (!trips) {
> > > +		pr_err("%s: Cannot get trip points from
> > > of-thermal.c!\n",
> > > +		       __func__);
> > > +		return 0;
> > > +	}
> > > =20
> > > +	for (i =3D 0; i < of_thermal_get_ntrips(tz); i++) {
> > > +		if (trips[i].type =3D=3D THERMAL_TRIP_CRITICAL)
> > > +			continue;
> > > +
> > > +		temp =3D trips[i].temperature / MCELSIUS;
> > >  		if (falling)
> > > -			temp -=3D pdata->threshold_falling;
> > > +			temp -=3D (trips[i].hysteresis / MCELSIUS);
> > >  		else
> > >  			threshold &=3D ~(0xff << 8 * i);
> > > =20
> > > @@ -305,9 +349,19 @@ static void exynos_tmu_control(struct
> > > platform_device *pdev, bool on) static int
> > > exynos4210_tmu_initialize(struct platform_device *pdev) {
> > >  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> > > -	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> > > -	unsigned int status;
> > > +	struct thermal_zone_device *tz =3D data->tzd;
> > > +	const struct thermal_trip * const trips =3D
> > > +		of_thermal_get_trip_points(tz);
> > >  	int ret =3D 0, threshold_code, i;
> > > +	unsigned long reference, temp;
> > > +	unsigned int status;
> > > +
> > > +	if (!trips) {
> > > +		pr_err("%s: Cannot get trip points from
> > > of-thermal.c!\n",
> > > +		       __func__);
> > > +		ret =3D -ENODEV;
> > > +		goto out;
> > > +	}
> > > =20
> > >  	status =3D readb(data->base + EXYNOS_TMU_REG_STATUS);
> > >  	if (!status) {
> > > @@ -318,12 +372,19 @@ static int exynos4210_tmu_initialize(struct
> > > platform_device *pdev) sanitize_temp_error(data, readl(data->base +
> > > EXYNOS_TMU_REG_TRIMINFO));=20
> > >  	/* Write temperature code for threshold */
> > > -	threshold_code =3D temp_to_code(data, pdata->threshold);
> > > +	reference =3D trips[0].temperature / MCELSIUS;
> > > +	threshold_code =3D temp_to_code(data, reference);
> > > +	if (threshold_code < 0) {
> > > +		ret =3D threshold_code;
> > > +		goto out;
> > > +	}
> > >  	writeb(threshold_code, data->base +
> > > EXYNOS4210_TMU_REG_THRESHOLD_TEMP);=20
> > > -	for (i =3D 0; i < pdata->non_hw_trigger_levels; i++)
> > > -		writeb(pdata->trigger_levels[i], data->base +
> > > +	for (i =3D 0; i < of_thermal_get_ntrips(tz); i++) {
> > > +		temp =3D trips[i].temperature / MCELSIUS;
> > > +		writeb(temp - reference, data->base +
> > >  		       EXYNOS4210_TMU_REG_TRIG_LEVEL0 + i * 4);
> > > +	}
> > > =20
> > >  	data->tmu_clear_irqs(data);
> > >  out:
> > > @@ -333,9 +394,11 @@ out:
> > >  static int exynos4412_tmu_initialize(struct platform_device *pdev)
> > >  {
> > >  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> > > -	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> > > +	const struct thermal_trip * const trips =3D
> > > +		of_thermal_get_trip_points(data->tzd);
> > >  	unsigned int status, trim_info, con, ctrl,
> > > rising_threshold; int ret =3D 0, threshold_code, i;
> > > +	unsigned long crit_temp =3D 0;
> > > =20
> > >  	status =3D readb(data->base + EXYNOS_TMU_REG_STATUS);
> > >  	if (!status) {
> > > @@ -373,17 +436,29 @@ static int exynos4412_tmu_initialize(struct
> > > platform_device *pdev) data->tmu_clear_irqs(data);
> > > =20
> > >  	/* if last threshold limit is also present */
> > > -	i =3D pdata->max_trigger_level - 1;
> > > -	if (pdata->trigger_levels[i] && pdata->trigger_type[i] =3D=3D
> > > HW_TRIP) {
> > > -		threshold_code =3D temp_to_code(data,
> > > pdata->trigger_levels[i]);
> > > -		/* 1-4 level to be assigned in th0 reg */
> > > -		rising_threshold &=3D ~(0xff << 8 * i);
> > > -		rising_threshold |=3D threshold_code << 8 * i;
> > > -		writel(rising_threshold, data->base +
> > > EXYNOS_THD_TEMP_RISE);
> > > -		con =3D readl(data->base + EXYNOS_TMU_REG_CONTROL);
> > > -		con |=3D (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
> > > -		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> > > +	for (i =3D 0; i < of_thermal_get_ntrips(data->tzd); i++) {
> > > +		if (trips[i].type =3D=3D THERMAL_TRIP_CRITICAL) {
> > > +			crit_temp =3D trips[i].temperature;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (i =3D=3D of_thermal_get_ntrips(data->tzd)) {
> > > +		pr_err("%s: No CRITICAL trip point defined at
> > > of-thermal.c!\n",
> > > +		       __func__);
> > > +		ret =3D -EINVAL;
> > > +		goto out;
> > >  	}
> > > +
> > > +	threshold_code =3D temp_to_code(data, crit_temp / MCELSIUS);
> > > +	/* 1-4 level to be assigned in th0 reg */
> > > +	rising_threshold &=3D ~(0xff << 8 * i);
> > > +	rising_threshold |=3D threshold_code << 8 * i;
> > > +	writel(rising_threshold, data->base +
> > > EXYNOS_THD_TEMP_RISE);
> > > +	con =3D readl(data->base + EXYNOS_TMU_REG_CONTROL);
> > > +	con |=3D (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
> > > +	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> > > +
> > >  out:
> > >  	return ret;
> > >  }
> > > @@ -391,9 +466,9 @@ out:
> > >  static int exynos5440_tmu_initialize(struct platform_device *pdev)
> > >  {
> > >  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> > > -	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> > >  	unsigned int trim_info =3D 0, con, rising_threshold;
> > > -	int ret =3D 0, threshold_code, i;
> > > +	int ret =3D 0, threshold_code;
> > > +	unsigned long crit_temp =3D 0;
> > > =20
> > >  	/*
> > >  	 * For exynos5440 soc triminfo value is swapped between
> > > TMU0 and @@ -422,9 +497,8 @@ static int
> > > exynos5440_tmu_initialize(struct platform_device *pdev)
> > > data->tmu_clear_irqs(data);=20
> > >  	/* if last threshold limit is also present */
> > > -	i =3D pdata->max_trigger_level - 1;
> > > -	if (pdata->trigger_levels[i] && pdata->trigger_type[i] =3D=3D
> > > HW_TRIP) {
> > > -		threshold_code =3D temp_to_code(data,
> > > pdata->trigger_levels[i]);
> > > +	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp))
> > > {
> > > +		threshold_code =3D temp_to_code(data, crit_temp /
> > > MCELSIUS); /* 5th level to be assigned in th2 reg */
> > >  		rising_threshold =3D
> > >  			threshold_code <<
> > > EXYNOS5440_TMU_TH_RISE4_SHIFT; @@ -442,7 +516,7 @@ static int
> > > exynos5440_tmu_initialize(struct platform_device *pdev) static void
> > > exynos4210_tmu_control(struct platform_device *pdev, bool on) {
> > >  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> > > -	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> > > +	struct thermal_zone_device *tz =3D data->tzd;
> > >  	unsigned int con, interrupt_en;
> > > =20
> > >  	con =3D get_con_reg(data, readl(data->base +
> > > EXYNOS_TMU_REG_CONTROL)); @@ -450,10 +524,15 @@ static void
> > > exynos4210_tmu_control(struct platform_device *pdev, bool on) if
> > > (on) { con |=3D (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > >  		interrupt_en =3D
> > > -			pdata->trigger_enable[3] <<
> > > EXYNOS_TMU_INTEN_RISE3_SHIFT |
> > > -			pdata->trigger_enable[2] <<
> > > EXYNOS_TMU_INTEN_RISE2_SHIFT |
> > > -			pdata->trigger_enable[1] <<
> > > EXYNOS_TMU_INTEN_RISE1_SHIFT |
> > > -			pdata->trigger_enable[0] <<
> > > EXYNOS_TMU_INTEN_RISE0_SHIFT;
> > > +			(of_thermal_is_trip_valid(tz, 3)
> > > +			 << EXYNOS_TMU_INTEN_RISE3_SHIFT) |
> > > +			(of_thermal_is_trip_valid(tz, 2)
> > > +			 << EXYNOS_TMU_INTEN_RISE2_SHIFT) |
> > > +			(of_thermal_is_trip_valid(tz, 1)
> > > +			 << EXYNOS_TMU_INTEN_RISE1_SHIFT) |
> > > +			(of_thermal_is_trip_valid(tz, 0)
> > > +			 << EXYNOS_TMU_INTEN_RISE0_SHIFT);
> > > +
> > >  		if (data->soc !=3D SOC_ARCH_EXYNOS4210)
> > >  			interrupt_en |=3D
> > >  				interrupt_en <<
> > > EXYNOS_TMU_INTEN_FALL0_SHIFT; @@ -468,7 +547,7 @@ static void
> > > exynos4210_tmu_control(struct platform_device *pdev, bool on)
> > > static void exynos5440_tmu_control(struct platform_device *pdev,
> > > bool on) { struct exynos_tmu_data *data =3D
> > > platform_get_drvdata(pdev);
> > > -	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> > > +	struct thermal_zone_device *tz =3D data->tzd;
> > >  	unsigned int con, interrupt_en;
> > > =20
> > >  	con =3D get_con_reg(data, readl(data->base +
> > > EXYNOS5440_TMU_S0_7_CTRL)); @@ -476,11 +555,16 @@ static void
> > > exynos5440_tmu_control(struct platform_device *pdev, bool on) if
> > > (on) { con |=3D (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > >  		interrupt_en =3D
> > > -			pdata->trigger_enable[3] <<
> > > EXYNOS5440_TMU_INTEN_RISE3_SHIFT |
> > > -			pdata->trigger_enable[2] <<
> > > EXYNOS5440_TMU_INTEN_RISE2_SHIFT |
> > > -			pdata->trigger_enable[1] <<
> > > EXYNOS5440_TMU_INTEN_RISE1_SHIFT |
> > > -			pdata->trigger_enable[0] <<
> > > EXYNOS5440_TMU_INTEN_RISE0_SHIFT;
> > > -		interrupt_en |=3D interrupt_en <<
> > > EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
> > > +			(of_thermal_is_trip_valid(tz, 3)
> > > +			 << EXYNOS5440_TMU_INTEN_RISE3_SHIFT) |
> > > +			(of_thermal_is_trip_valid(tz, 2)
> > > +			 << EXYNOS5440_TMU_INTEN_RISE2_SHIFT) |
> > > +			(of_thermal_is_trip_valid(tz, 1)
> > > +			 << EXYNOS5440_TMU_INTEN_RISE1_SHIFT) |
> > > +			(of_thermal_is_trip_valid(tz, 0)
> > > +			 << EXYNOS5440_TMU_INTEN_RISE0_SHIFT);
> > > +		interrupt_en |=3D
> > > +			interrupt_en <<
> > > EXYNOS5440_TMU_INTEN_FALL0_SHIFT; } else {
> > >  		con &=3D ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > >  		interrupt_en =3D 0; /* Disable all interrupts */
> > > @@ -489,19 +573,22 @@ static void exynos5440_tmu_control(struct
> > > platform_device *pdev, bool on) writel(con, data->base +
> > > EXYNOS5440_TMU_S0_7_CTRL); }
> > > =20
> > > -static int exynos_tmu_read(struct exynos_tmu_data *data)
> > > +int exynos_get_temp(void *p, long *temp)
> > >  {
> > > -	int ret;
> > > +	struct exynos_tmu_data *data =3D p;
> > > +
> > > +	if (!data)
> > > +		return -EINVAL;
> > > =20
> > >  	mutex_lock(&data->lock);
> > >  	clk_enable(data->clk);
> > > -	ret =3D data->tmu_read(data);
> > > -	if (ret >=3D 0)
> > > -		ret =3D code_to_temp(data, ret);
> > > +
> > > +	*temp =3D code_to_temp(data, data->tmu_read(data)) *
> > > MCELSIUS; +
> > >  	clk_disable(data->clk);
> > >  	mutex_unlock(&data->lock);
> > > =20
> > > -	return ret;
> > > +	return 0;
> > >  }
> > > =20
> > >  #ifdef CONFIG_THERMAL_EMULATION
> > > @@ -613,7 +700,7 @@ static void exynos_tmu_work(struct work_struct
> > > *work) if (!IS_ERR(data->clk_sec))
> > >  		clk_disable(data->clk_sec);
> > > =20
> > > -	exynos_report_trigger(data->reg_conf);
> > > +	exynos_report_trigger(data);
> > >  	mutex_lock(&data->lock);
> > >  	clk_enable(data->clk);
> > > =20
> > > @@ -673,55 +760,89 @@ static irqreturn_t exynos_tmu_irq(int irq,
> > > void *id) static const struct of_device_id exynos_tmu_match[] =3D {
> > >  	{
> > >  		.compatible =3D "samsung,exynos3250-tmu",
> > > -		.data =3D &exynos3250_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D "samsung,exynos4210-tmu",
> > > -		.data =3D &exynos4210_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D "samsung,exynos4412-tmu",
> > > -		.data =3D &exynos4412_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D "samsung,exynos5250-tmu",
> > > -		.data =3D &exynos5250_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D "samsung,exynos5260-tmu",
> > > -		.data =3D &exynos5260_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D "samsung,exynos5420-tmu",
> > > -		.data =3D &exynos5420_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D
> > > "samsung,exynos5420-tmu-ext-triminfo",
> > > -		.data =3D &exynos5420_default_tmu_data,
> > >  	},
> > >  	{
> > >  		.compatible =3D "samsung,exynos5440-tmu",
> > > -		.data =3D &exynos5440_default_tmu_data,
> > >  	},
> > >  	{},
> > >  };
> > >  MODULE_DEVICE_TABLE(of, exynos_tmu_match);
> > > =20
> > > -static inline struct  exynos_tmu_platform_data
> > > *exynos_get_driver_data(
> > > -			struct platform_device *pdev, int id)
> > > +static int exynos_of_get_soc_type(struct device_node *np)
> > >  {
> > > -	struct  exynos_tmu_init_data *data_table;
> > > -	struct exynos_tmu_platform_data *tmu_data;
> > > -	const struct of_device_id *match;
> > > +	if (of_device_is_compatible(np, "samsung,exynos3250-tmu"))
> > > +		return SOC_ARCH_EXYNOS3250;
> > > +	else if (of_device_is_compatible(np,
> > > "samsung,exynos4210-tmu"))
> > > +		return SOC_ARCH_EXYNOS4210;
> > > +	else if (of_device_is_compatible(np,
> > > "samsung,exynos4412-tmu"))
> > > +		return SOC_ARCH_EXYNOS4412;
> > > +	else if (of_device_is_compatible(np,
> > > "samsung,exynos5250-tmu"))
> > > +		return SOC_ARCH_EXYNOS5250;
> > > +	else if (of_device_is_compatible(np,
> > > "samsung,exynos5260-tmu"))
> > > +		return SOC_ARCH_EXYNOS5260;
> > > +	else if (of_device_is_compatible(np,
> > > "samsung,exynos5420-tmu"))
> > > +		return SOC_ARCH_EXYNOS5420;
> > > +	else if (of_device_is_compatible(np,
> > > +
> > > "samsung,exynos5420-tmu-ext-triminfo"))
> > > +		return SOC_ARCH_EXYNOS5420_TRIMINFO;
> > > +	else if (of_device_is_compatible(np,
> > > "samsung,exynos5440-tmu"))
> > > +		return SOC_ARCH_EXYNOS5440;
> > > +
> > > +	return -EINVAL;
> > > +}
> > > =20
> > > -	match =3D of_match_node(exynos_tmu_match, pdev->dev.of_node);
> > > -	if (!match)
> > > -		return NULL;
> > > -	data_table =3D (struct exynos_tmu_init_data *) match->data;
> > > -	if (!data_table || id >=3D data_table->tmu_count)
> > > -		return NULL;
> > > -	tmu_data =3D data_table->tmu_data;
> > > -	return (struct exynos_tmu_platform_data *) (tmu_data + id);
> > > +static int exynos_of_sensor_conf(struct device_node *np,
> > > +				 struct exynos_tmu_platform_data
> > > *pdata) +{
> > > +	u32 value;
> > > +	int ret;
> > > +
> > > +	of_node_get(np);
> > > +
> > > +	ret =3D of_property_read_u32(np, "samsung,tmu_gain", &value);
> > > +	pdata->gain =3D (u8) value;
> > > +	of_property_read_u32(np, "samsung,tmu_reference_voltage",
> > > &value);
> > > +	pdata->reference_voltage =3D (u8) value;
> > > +	of_property_read_u32(np, "samsung,tmu_noise_cancel_mode",
> > > &value);
> > > +	pdata->noise_cancel_mode =3D (u8) value;
> > > +
> > > +	of_property_read_u32(np, "samsung,tmu_efuse_value",
> > > +			     &pdata->efuse_value);
> > > +	of_property_read_u32(np, "samsung,tmu_min_efuse_value",
> > > +			     &pdata->min_efuse_value);
> > > +	of_property_read_u32(np, "samsung,tmu_max_efuse_value",
> > > +			     &pdata->max_efuse_value);
> > > +
> > > +	of_property_read_u32(np, "samsung,tmu_first_point_trim",
> > > &value);
> > > +	pdata->first_point_trim =3D (u8) value;
> > > +	of_property_read_u32(np, "samsung,tmu_second_point_trim",
> > > &value);
> > > +	pdata->second_point_trim =3D (u8) value;
> > > +	of_property_read_u32(np,
> > > "samsung,tmu_default_temp_offset", &value);
> > > +	pdata->default_temp_offset =3D (u8) value;
> > > +
> > > +	of_property_read_u32(np, "samsung,tmu_cal_type",
> > > &pdata->cal_type);
> > > +	of_property_read_u32(np, "samsung,tmu_cal_mode",
> > > &pdata->cal_mode); +
> > > +	of_node_put(np);
> > > +	return 0;
> > >  }
> > > =20
> > >  static int exynos_map_dt_data(struct platform_device *pdev)
> > > @@ -771,14 +892,15 @@ static int exynos_map_dt_data(struct
> > > platform_device *pdev) return -EADDRNOTAVAIL;
> > >  	}
> > > =20
> > > -	pdata =3D exynos_get_driver_data(pdev, data->id);
> > > -	if (!pdata) {
> > > -		dev_err(&pdev->dev, "No platform init data
> > > supplied.\n");
> > > -		return -ENODEV;
> > > -	}
> > > +	pdata =3D devm_kzalloc(&pdev->dev,
> > > +			     sizeof(struct
> > > exynos_tmu_platform_data),
> > > +			     GFP_KERNEL);
> > > +	if (!pdata)
> > > +		return -ENOMEM;
> > > =20
> > > +	exynos_of_sensor_conf(pdev->dev.of_node, pdata);
> > >  	data->pdata =3D pdata;
> > > -	data->soc =3D pdata->type;
> > > +	data->soc =3D exynos_of_get_soc_type(pdev->dev.of_node);
> > > =20
> > >  	switch (data->soc) {
> > >  	case SOC_ARCH_EXYNOS4210:
> > > @@ -834,12 +956,16 @@ static int exynos_map_dt_data(struct
> > > platform_device *pdev) return 0;
> > >  }
> > > =20
> > > +static struct thermal_zone_of_device_ops exynos_sensor_ops =3D {
> > > +	.get_temp =3D exynos_get_temp,
> > > +	.set_emul_temp =3D exynos_tmu_set_emulation,
> > > +};
> > > +
> > >  static int exynos_tmu_probe(struct platform_device *pdev)
> > >  {
> > > -	struct exynos_tmu_data *data;
> > >  	struct exynos_tmu_platform_data *pdata;
> > > -	struct thermal_sensor_conf *sensor_conf;
> > > -	int ret, i;
> > > +	struct exynos_tmu_data *data;
> > > +	int ret;
> > > =20
> > >  	data =3D devm_kzalloc(&pdev->dev, sizeof(struct
> > > exynos_tmu_data), GFP_KERNEL);
> > > @@ -849,9 +975,15 @@ static int exynos_tmu_probe(struct
> > > platform_device *pdev) platform_set_drvdata(pdev, data);
> > >  	mutex_init(&data->lock);
> > > =20
> > > +	data->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, 0,
> > > data,
> > > +
> > > &exynos_sensor_ops);
> > > +	if (IS_ERR(data->tzd)) {
> > > +		pr_err("thermal: tz: %p ERROR\n", data->tzd);
> > > +		return PTR_ERR(data->tzd);
> > > +	}
> > >  	ret =3D exynos_map_dt_data(pdev);
> > >  	if (ret)
> > > -		return ret;
> > > +		goto err_sensor;
> > > =20
> > >  	pdata =3D data->pdata;
> > > =20
> > > @@ -860,20 +992,22 @@ static int exynos_tmu_probe(struct
> > > platform_device *pdev) data->clk =3D devm_clk_get(&pdev->dev,
> > > "tmu_apbif"); if (IS_ERR(data->clk)) {
> > >  		dev_err(&pdev->dev, "Failed to get clock\n");
> > > -		return  PTR_ERR(data->clk);
> > > +		ret =3D PTR_ERR(data->clk);
> > > +		goto err_sensor;
> > >  	}
> > > =20
> > >  	data->clk_sec =3D devm_clk_get(&pdev->dev,
> > > "tmu_triminfo_apbif"); if (IS_ERR(data->clk_sec)) {
> > >  		if (data->soc =3D=3D SOC_ARCH_EXYNOS5420_TRIMINFO) {
> > >  			dev_err(&pdev->dev, "Failed to get
> > > triminfo clock\n");
> > > -			return PTR_ERR(data->clk_sec);
> > > +			ret =3D PTR_ERR(data->clk_sec);
> > > +			goto err_sensor;
> > >  		}
> > >  	} else {
> > >  		ret =3D clk_prepare(data->clk_sec);
> > >  		if (ret) {
> > >  			dev_err(&pdev->dev, "Failed to get
> > > clock\n");
> > > -			return ret;
> > > +			goto err_sensor;
> > >  		}
> > >  	}
> > > =20
> > > @@ -889,45 +1023,6 @@ static int exynos_tmu_probe(struct
> > > platform_device *pdev) goto err_clk;
> > >  	}
> > > =20
> > > -	exynos_tmu_control(pdev, true);
> > > -
> > > -	/* Allocate a structure to register with the exynos core
> > > thermal */
> > > -	sensor_conf =3D devm_kzalloc(&pdev->dev,
> > > -				sizeof(struct
> > > thermal_sensor_conf), GFP_KERNEL);
> > > -	if (!sensor_conf) {
> > > -		ret =3D -ENOMEM;
> > > -		goto err_clk;
> > > -	}
> > > -	sprintf(sensor_conf->name, "therm_zone%d", data->id);
> > > -	sensor_conf->read_temperature =3D (int (*)(void
> > > *))exynos_tmu_read;
> > > -	sensor_conf->write_emul_temp =3D
> > > -		(int (*)(void *, unsigned
> > > long))exynos_tmu_set_emulation;
> > > -	sensor_conf->driver_data =3D data;
> > > -	sensor_conf->trip_data.trip_count =3D
> > > pdata->trigger_enable[0] +
> > > -			pdata->trigger_enable[1] +
> > > pdata->trigger_enable[2]+
> > > -			pdata->trigger_enable[3];
> > > -
> > > -	for (i =3D 0; i < sensor_conf->trip_data.trip_count; i++) {
> > > -		sensor_conf->trip_data.trip_val[i] =3D
> > > -			pdata->threshold +
> > > pdata->trigger_levels[i];
> > > -		sensor_conf->trip_data.trip_type[i] =3D
> > > -					pdata->trigger_type[i];
> > > -	}
> > > -
> > > -	sensor_conf->trip_data.trigger_falling =3D
> > > pdata->threshold_falling; -
> > > -	sensor_conf->dev =3D &pdev->dev;
> > > -	/* Register the sensor with thermal management interface */
> > > -	ret =3D exynos_register_thermal(sensor_conf);
> > > -	if (ret) {
> > > -		if (ret !=3D -EPROBE_DEFER)
> > > -			dev_err(&pdev->dev,
> > > -				"Failed to register thermal
> > > interface: %d\n",
> > > -				ret);
> > > -		goto err_clk;
> > > -	}
> > > -	data->reg_conf =3D sensor_conf;
> > > -
> > >  	ret =3D devm_request_irq(&pdev->dev, data->irq,
> > > exynos_tmu_irq, IRQF_TRIGGER_RISING | IRQF_SHARED,
> > > dev_name(&pdev->dev), data); if (ret) {
> > > @@ -935,21 +1030,25 @@ static int exynos_tmu_probe(struct
> > > platform_device *pdev) goto err_clk;
> > >  	}
> > > =20
> > > +	exynos_tmu_control(pdev, true);
> > >  	return 0;
> > >  err_clk:
> > >  	clk_unprepare(data->clk);
> > >  err_clk_sec:
> > >  	if (!IS_ERR(data->clk_sec))
> > >  		clk_unprepare(data->clk_sec);
> > > +err_sensor:
> > > +	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> > > +
> > >  	return ret;
> > >  }
> > > =20
> > >  static int exynos_tmu_remove(struct platform_device *pdev)
> > >  {
> > >  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> > > +	struct thermal_zone_device *tzd =3D data->tzd;
> > > =20
> > > -	exynos_unregister_thermal(data->reg_conf);
> > > -
> > > +	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
> > >  	exynos_tmu_control(pdev, false);
> > > =20
> > >  	clk_unprepare(data->clk);
> > > diff --git a/drivers/thermal/samsung/exynos_tmu.h
> > > b/drivers/thermal/samsung/exynos_tmu.h index 627dec9..d876d4c 100644
> > > --- a/drivers/thermal/samsung/exynos_tmu.h
> > > +++ b/drivers/thermal/samsung/exynos_tmu.h
> > > @@ -23,8 +23,7 @@
> > >  #ifndef _EXYNOS_TMU_H
> > >  #define _EXYNOS_TMU_H
> > >  #include <linux/cpu_cooling.h>
> > > -
> > > -#include "exynos_thermal_common.h"
> > > +#include <dt-bindings/thermal/thermal_exynos.h>
> > > =20
> > >  enum soc_type {
> > >  	SOC_ARCH_EXYNOS3250 =3D 1,
> > > @@ -36,38 +35,9 @@ enum soc_type {
> > >  	SOC_ARCH_EXYNOS5420_TRIMINFO,
> > >  	SOC_ARCH_EXYNOS5440,
> > >  };
> > > -#include <dt-bindings/thermal/thermal_exynos.h>
> > > =20
> > >  /**
> > >   * struct exynos_tmu_platform_data
> > > - * @threshold: basic temperature for generating interrupt
> > > - *	       25 <=3D threshold <=3D 125 [unit: degree Celsius]
> > > - * @threshold_falling: differntial value for setting threshold
> > > - *		       of temperature falling interrupt.
> > > - * @trigger_levels: array for each interrupt levels
> > > - *	[unit: degree Celsius]
> > > - *	0: temperature for trigger_level0 interrupt
> > > - *	   condition for trigger_level0 interrupt:
> > > - *		current temperature > threshold +
> > > trigger_levels[0]
> > > - *	1: temperature for trigger_level1 interrupt
> > > - *	   condition for trigger_level1 interrupt:
> > > - *		current temperature > threshold +
> > > trigger_levels[1]
> > > - *	2: temperature for trigger_level2 interrupt
> > > - *	   condition for trigger_level2 interrupt:
> > > - *		current temperature > threshold +
> > > trigger_levels[2]
> > > - *	3: temperature for trigger_level3 interrupt
> > > - *	   condition for trigger_level3 interrupt:
> > > - *		current temperature > threshold +
> > > trigger_levels[3]
> > > - * @trigger_type: defines the type of trigger. Possible values are,
> > > - *	THROTTLE_ACTIVE trigger type
> > > - *	THROTTLE_PASSIVE trigger type
> > > - *	SW_TRIP trigger type
> > > - *	HW_TRIP
> > > - * @trigger_enable[]: array to denote which trigger levels are
> > > enabled.
> > > - *	1 =3D enable trigger_level[] interrupt,
> > > - *	0 =3D disable trigger_level[] interrupt
> > > - * @max_trigger_level: max trigger level supported by the TMU
> > > - * @non_hw_trigger_levels: number of defined non-hardware trigger
> > > levels
> > >   * @gain: gain of amplifier in the positive-TC generator block
> > >   *	0 < gain <=3D 15
> > >   * @reference_voltage: reference voltage of amplifier
> > > @@ -79,21 +49,12 @@ enum soc_type {
> > >   * @efuse_value: platform defined fuse value
> > >   * @min_efuse_value: minimum valid trimming data
> > >   * @max_efuse_value: maximum valid trimming data
> > > - * @first_point_trim: temp value of the first point trimming
> > > - * @second_point_trim: temp value of the second point trimming
> > >   * @default_temp_offset: default temperature offset in case of no
> > > trimming
> > >   * @cal_type: calibration type for temperature
> > >   *
> > >   * This structure is required for configuration of exynos_tmu
> > > driver. */
> > >  struct exynos_tmu_platform_data {
> > > -	u8 threshold;
> > > -	u8 threshold_falling;
> > > -	u8 trigger_levels[MAX_TRIP_COUNT];
> > > -	enum trigger_type trigger_type[MAX_TRIP_COUNT];
> > > -	bool trigger_enable[MAX_TRIP_COUNT];
> > > -	u8 max_trigger_level;
> > > -	u8 non_hw_trigger_levels;
> > >  	u8 gain;
> > >  	u8 reference_voltage;
> > >  	u8 noise_cancel_mode;
> > > @@ -110,18 +71,6 @@ struct exynos_tmu_platform_data {
> > >  	u32 cal_mode;
> > >  };
> > > =20
> > > -/**
> > > - * struct exynos_tmu_init_data
> > > - * @tmu_count: number of TMU instances.
> > > - * @tmu_data: platform data of all TMU instances.
> > > - * This structure is required to store data for multi-instance
> > > exynos tmu
> > > - * driver.
> > > - */
> > > -struct exynos_tmu_init_data {
> > > -	int tmu_count;
> > > -	struct exynos_tmu_platform_data tmu_data[];
> > > -};
> > > -
> > >  extern struct exynos_tmu_init_data const
> > > exynos3250_default_tmu_data; extern struct exynos_tmu_init_data
> > > const exynos4210_default_tmu_data; extern struct
> > > exynos_tmu_init_data const exynos4412_default_tmu_data; --=20
> > > 2.0.0.rc2
> > >=20
>=20
>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUv23cAAoJEMLUO4d9pOJWLUQIAIEL1wA/z/3Fxmyo9feFKtbX
t6tv38ZV3I/Slkk7+PuLj25993MB6UfayQpkEeMNPXbkTAoqxjEtqTY6P2WgFmUV
ReYoV2c5fejpo63yQqzb2bCxxWpT5bNgGZkJBxY6q79CnGLyYLcZCIm6kap8XfgO
5XcgejAluWCOP9rN3q/hJFwKVxgYGywwefwLS98tAd96E9h89oYFkGPDV1HBGmWG
MMzrmfS5b0ReFV1TfQfgeqOsTSal4xaCitkTXpEqpGL0hpTMkr99kGv4+dahDVCW
lnaDIo2mJEtlxUPEKoN+X8JU1FSulQfVjG4N46RJ/2avU9h8yt8f0FpCSSZwVJQ=
=loHZ
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
