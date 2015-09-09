From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 3/5] thermal: Add devfreq cooling
Date: Tue, 8 Sep 2015 22:10:22 -0700
Message-ID: <20150909051020.GA4203@localhost.localdomain>
References: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
 <1440672951-7002-4-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35256 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbbIIFK1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 01:10:27 -0400
Content-Disposition: inline
In-Reply-To: <1440672951-7002-4-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, =?iso-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>, Zhang Rui <rui.zhang@intel.com>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Aug 27, 2015 at 11:55:49AM +0100, Javi Merino wrote:
> From: =D8rjan Eide <orjan.eide@arm.com>
>=20
> Add a generic thermal cooling device for devfreq, that is similar to
> cpu_cooling.
>=20
> The device must use devfreq.  In order to use the power extension of the
> cooling device, it must have registered its OPPs using the OPP library.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> Signed-off-by: =D8rjan Eide <orjan.eide@arm.com>

Thanks for taking this to upstream kernel.

Just minor comments as follows.

> ---
>=20
> I had a look at 02373d7c69b4 ("thermal: cpu_cooling: fix lockdep
> problems in cpu_cooling").  It doesn't affect devfreq cooling because
> we don't have notifiers, we only use locking for idr.
>=20

Thanks once again for checking it.

>  drivers/thermal/Kconfig           |  11 +
>  drivers/thermal/Makefile          |   3 +
>  drivers/thermal/devfreq_cooling.c | 546 ++++++++++++++++++++++++++++++++=
++++++
>  include/linux/devfreq_cooling.h   |  72 +++++
>  4 files changed, 632 insertions(+)
>  create mode 100644 drivers/thermal/devfreq_cooling.c
>  create mode 100644 include/linux/devfreq_cooling.h
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 118938ee8552..a2c6a6497804 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -147,6 +147,17 @@ config CLOCK_THERMAL
>  	  device that is configured to use this cooling mechanism will be
>  	  controlled to reduce clock frequency whenever temperature is high.
> =20
> +config DEVFREQ_THERMAL
> +	bool "Generic device cooling support"
> +	depends on PM_DEVFREQ
> +	depends on PM_OPP
> +	help
> +	  This implements the generic devfreq cooling mechanism through
> +	  frequency reduction for devices using devfreq.
> +
> +	  This will throttle the device by limiting the maximum allowed DVFS
> +	  frequency corresponding to the cooling level.
> +
>  	  If you want this support, you should say Y here.
> =20
>  config THERMAL_EMULATION
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 535dfee1496f..45f26978ff74 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -22,6 +22,9 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=3D cpu_cooling.o
>  # clock cooling
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+=3D clock_cooling.o
> =20
> +# devfreq cooling
> +thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_cooling.o
> +
>  # platform thermal drivers
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+=3D qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_=
cooling.c
> new file mode 100644
> index 000000000000..3d4abc746099
> --- /dev/null
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -0,0 +1,546 @@
> +/*
> + * devfreq_cooling: Thermal cooling device implementation for devices us=
ing
> + *                  devfreq
> + *
> + * Copyright (C) 2014-2015 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * TODO:
> + *    - If OPPs are added or removed after devfreq cooling has
> + *      registered, the devfreq cooling won't react to it.
> + */
> +
> +#include <linux/devfreq.h>
> +#include <linux/devfreq_cooling.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +#include <linux/pm_opp.h>
> +#include <linux/thermal.h>
> +
> +static DEFINE_MUTEX(devfreq_lock);
> +static DEFINE_IDR(devfreq_idr);
> +
> +/**
> + * struct devfreq_cooling_device - Devfreq cooling device
> + * @id:		unique integer value corresponding to each
> + *		devfreq_cooling_device registered.
> + * @cdev:	Pointer to associated thermal cooling device.
> + * @devfreq:	Pointer to associated devfreq device.
> + * @cooling_state:	Current cooling state.
> + * @power_table:	Pointer to table with maximum power draw for each
> + *			cooling state. State is the index into the table, and
> + *			the power is in mW.
> + * @freq_table:	Pointer to a table with the frequencies sorted in descen=
ding
> + *		order.  You can index the table by cooling device state
> + * @freq_table_size:	size of the @freq_table and @power_table
> + * @power_ops:	Pointer to power operations, used to generate @power_tabl=
e.
> + */
> +struct devfreq_cooling_device {
> +	int id;
> +	struct thermal_cooling_device *cdev;
> +	struct devfreq *devfreq;
> +	unsigned long cooling_state;
> +	u32 *power_table;
> +	u32 *freq_table;
> +	size_t freq_table_size;
> +	struct devfreq_cooling_ops *power_ops;
> +};
> +
> +/**
> + * get_idr - function to get a unique id.
> + * @idr: struct idr * handle used to create a id.
> + * @id: int * value generated by this function.
> + *
> + * This function will populate @id with an unique
> + * id, using the idr API.
> + *
> + * Return: 0 on success, an error code on failure.
> + */
> +static int get_idr(struct idr *idr, int *id)
> +{
> +	int ret;
> +
> +	mutex_lock(&devfreq_lock);
> +	ret =3D idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
> +	mutex_unlock(&devfreq_lock);
> +	if (unlikely(ret < 0))
> +		return ret;
> +	*id =3D ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * release_idr - function to free the unique id.
> + * @idr: struct idr * handle used for creating the id.
> + * @id: int value representing the unique id.
> + */
> +static void release_idr(struct idr *idr, int id)
> +{
> +	mutex_lock(&devfreq_lock);
> +	idr_remove(idr, id);
> +	mutex_unlock(&devfreq_lock);
> +}
> +
> +/**
> + * enable_disable_opps() - disable all opps above a given state

This function name is confusing. But, at the same time, I cannot think
of a name for it right now.

maybe partition_enable_opps()?

> + * @dfc:	Pointer to devfreq we are operating on
> + * @cdev_state:	cooling device state we're setting
> + *
> + * Go through the OPPs of the device, enabling all OPPs until
> + * @cdev_state and disabling those frequencies above it.
> + */
> +static int enable_disable_opps(struct devfreq_cooling_device *dfc,
> +			       unsigned long cdev_state)
> +{
> +	int i;
> +	struct device *dev =3D dfc->devfreq->dev.parent;
> +
> +	for (i =3D 0; i < dfc->freq_table_size; i++) {
> +		struct dev_pm_opp *opp;
> +		int ret =3D 0;
> +		unsigned int freq =3D dfc->freq_table[i];
> +		bool want_enable =3D i >=3D cdev_state ? true : false;
> +
> +		rcu_read_lock();
> +		opp =3D dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
> +		rcu_read_unlock();
> +
> +		if (PTR_ERR(opp) =3D=3D -ERANGE)
> +			continue;
> +		else if (IS_ERR(opp))
> +			return PTR_ERR(opp);
> +
> +		if (want_enable)
> +			ret =3D dev_pm_opp_enable(dev, freq);
> +		else
> +			ret =3D dev_pm_opp_disable(dev, freq);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int devfreq_cooling_get_max_state(struct thermal_cooling_device *=
cdev,
> +					 unsigned long *state)
> +{
> +	struct devfreq_cooling_device *dfc =3D cdev->devdata;
> +
> +	*state =3D dfc->freq_table_size - 1;
> +
> +	return 0;
> +}
> +
> +static int devfreq_cooling_get_cur_state(struct thermal_cooling_device *=
cdev,
> +					 unsigned long *state)
> +{
> +	struct devfreq_cooling_device *dfc =3D cdev->devdata;
> +
> +	*state =3D dfc->cooling_state;
> +
> +	return 0;
> +}
> +
> +static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *=
cdev,
> +					 unsigned long state)
> +{
> +	struct devfreq_cooling_device *dfc =3D cdev->devdata;
> +	struct devfreq *df =3D dfc->devfreq;
> +	struct device *dev =3D df->dev.parent;
> +	int ret;
> +
> +	if (state =3D=3D dfc->cooling_state)
> +		return 0;
> +
> +	dev_dbg(dev, "Setting cooling state %lu\n", state);
> +
> +	if (state >=3D dfc->freq_table_size)
> +		return -EINVAL;
> +
> +	ret =3D enable_disable_opps(dfc, state);
> +	if (ret)
> +		return ret;
> +
> +	dfc->cooling_state =3D state;
> +
> +	return 0;
> +}
> +
> +/**
> + * freq_get_state() - get the cooling state corresponding to a frequency
> + * @dfc:	Pointer to devfreq cooling device
> + * @freq:	frequency in Hz
> + *
> + * Return: the cooling state associated with the @freq, or
> + * THERMAL_CSTATE_INVALID if it wasn't found.
> + */
> +static unsigned long
> +freq_get_state(struct devfreq_cooling_device *dfc, unsigned long freq)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < dfc->freq_table_size; i++) {
> +		if (dfc->freq_table[i] =3D=3D freq)
> +			return i;
> +	}
> +
> +	return THERMAL_CSTATE_INVALID;
> +}
> +
> +/**
> + * state_get_freq() - get the frequency corresponding to a cooling state
> + * @dfc:	Pointer to devfreq cooling device
> + * @state:	cooling device state
> + *
> + * Return: the frequency for this cooling device state or 0 for
> + * invalid states.
> + */
> +static unsigned long
> +state_get_freq(struct devfreq_cooling_device *dfc, unsigned long state)
> +{
> +	if (state >=3D dfc->freq_table_size) {
> +		dev_warn(dfc->devfreq->dev.parent,
> +			 "State %lu bigger than frequency table\n", state);
> +		return 0;
> +	}
> +
> +	return dfc->freq_table[state];
> +}
> +
> +static unsigned long
> +get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
> +{
> +	struct devfreq *df =3D dfc->devfreq;
> +	struct device *dev =3D df->dev.parent;
> +	unsigned long voltage;
> +	struct dev_pm_opp *opp;
> +
> +	rcu_read_lock();
> +
> +	opp =3D dev_pm_opp_find_freq_exact(dev, freq, true);
> +	if (IS_ERR(opp) && (PTR_ERR(opp) =3D=3D -ERANGE))
> +		opp =3D dev_pm_opp_find_freq_exact(dev, freq, false);
> +
> +	voltage =3D dev_pm_opp_get_voltage(opp) / 1000; /* mV */
> +
> +	rcu_read_unlock();
> +
> +	if (voltage =3D=3D 0) {
> +		dev_warn_ratelimited(dev,
> +				     "Failed to get voltage for frequency %lu: %ld\n",
> +				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
> +		return 0;
> +	}
> +
> +	return dfc->power_ops->get_static_power(voltage);
> +}
> +
> +static int devfreq_cooling_get_requested_power(struct thermal_cooling_de=
vice *cdev,
> +					       struct thermal_zone_device *tz,
> +					       u32 *power)
> +{
> +	struct devfreq_cooling_device *dfc =3D cdev->devdata;
> +	struct devfreq *df =3D dfc->devfreq;
> +	struct devfreq_dev_status *status =3D &df->last_status;
> +	unsigned long state;
> +	unsigned long freq =3D status->current_frequency;
> +	u32 dyn_power, static_power;
> +
> +	/* Get dynamic power for state */
> +	state =3D freq_get_state(dfc, freq);
> +	if (state =3D=3D THERMAL_CSTATE_INVALID)
> +		return -EAGAIN;
> +
> +	dyn_power =3D dfc->power_table[state];
> +
> +	/* Scale dynamic power for utilization */
> +	dyn_power =3D (dyn_power * status->busy_time) / status->total_time;
> +
> +	/* Get static power */
> +	static_power =3D get_static_power(dfc, freq);
> +
> +	*power =3D dyn_power + static_power;
> +
> +	return 0;
> +}
> +
> +static int devfreq_cooling_state2power(struct thermal_cooling_device *cd=
ev,
> +				       struct thermal_zone_device *tz,
> +				       unsigned long state,
> +				       u32 *power)
> +{
> +	struct devfreq_cooling_device *dfc =3D cdev->devdata;
> +	unsigned long freq;
> +	u32 static_power;
> +
> +	freq =3D state_get_freq(dfc, state);
> +	static_power =3D get_static_power(dfc, freq);
> +
> +	*power =3D dfc->power_table[state] + static_power;

should we have a boundaries check here on state?

> +	return 0;
> +}
> +
> +static int devfreq_cooling_power2state(struct thermal_cooling_device *cd=
ev,
> +				       struct thermal_zone_device *tz,
> +				       u32 power, unsigned long *state)
> +{
> +	struct devfreq_cooling_device *dfc =3D cdev->devdata;
> +	struct devfreq *df =3D dfc->devfreq;
> +	struct devfreq_dev_status *status =3D &df->last_status;
> +	unsigned long freq =3D status->current_frequency;
> +	unsigned long busy_time;
> +	s32 dyn_power;
> +	u32 static_power;
> +	int i;
> +
> +	static_power =3D get_static_power(dfc, freq);
> +
> +	dyn_power =3D power - static_power;
> +	dyn_power =3D dyn_power > 0 ? dyn_power : 0;
> +
> +	/* Scale dynamic power for utilization */
> +	busy_time =3D status->busy_time ?: 1;
> +	dyn_power =3D (dyn_power * status->total_time) / busy_time;
> +
> +	/*
> +	 * Find the first cooling state that is within the power
> +	 * budget for dynamic power.
> +	 */
> +	for (i =3D 0; i < dfc->freq_table_size - 1; i++)
> +		if (dyn_power >=3D dfc->power_table[i])
> +			break;
> +
> +	*state =3D i;
> +	return 0;
> +}
> +
> +static struct thermal_cooling_device_ops devfreq_cooling_ops =3D {
> +	.get_max_state =3D devfreq_cooling_get_max_state,
> +	.get_cur_state =3D devfreq_cooling_get_cur_state,
> +	.set_cur_state =3D devfreq_cooling_set_cur_state,
> +};
> +
> +/**
> + * devfreq_cooling_gen_tables() - Generate power and freq tables.
> + * @dfc: Pointer to devfreq cooling device.
> + *
> + * Generate power and frequency tables: the power table hold the
> + * device's maximum power usage at each cooling state (OPP).  The
> + * static and dynamic power using the appropriate voltage and
> + * frequency for the state, is acquired from the struct
> + * devfreq_cooling_ops, and summed to make the maximum power draw.
> + *
> + * The frequency table holds the frequencies in descending order.
> + * That way its indexed by cooling device state.
> + *
> + * The tables are malloced, and pointers put in dfc.  They must be
> + * freed when unregistering the devfreq cooling device.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
> +{
> +	struct devfreq *df =3D dfc->devfreq;
> +	struct device *dev =3D df->dev.parent;
> +	int ret, num_opps;
> +	struct devfreq_cooling_ops *callbacks =3D dfc->power_ops;
> +	unsigned long freq;
> +	u32 *power_table =3D NULL;
> +	u32 *freq_table;
> +	int i;
> +
> +	num_opps =3D dev_pm_opp_get_opp_count(dev);
> +
> +	if (callbacks) {
> +		power_table =3D kcalloc(num_opps, sizeof(*power_table),
> +				      GFP_KERNEL);
> +		if (!power_table)
> +			ret =3D -ENOMEM;
> +	}
> +
> +	freq_table =3D kcalloc(num_opps, sizeof(*freq_table),
> +			     GFP_KERNEL);
> +	if (!freq_table) {
> +		ret =3D -ENOMEM;
> +		goto free_power_table;
> +	}
> +
> +	for (i =3D 0, freq =3D ULONG_MAX; i < num_opps; i++, freq--) {
> +		unsigned long power_dyn, voltage;
> +		struct dev_pm_opp *opp;
> +
> +		rcu_read_lock();
> +
> +		opp =3D dev_pm_opp_find_freq_floor(dev, &freq);
> +		if (IS_ERR(opp)) {
> +			rcu_read_unlock();
> +			ret =3D PTR_ERR(opp);
> +			goto free_tables;
> +		}
> +
> +		voltage =3D dev_pm_opp_get_voltage(opp) / 1000; /* mV */
> +
> +		rcu_read_unlock();
> +
> +		if (callbacks) {
> +			power_dyn =3D callbacks->get_dynamic_power(freq, voltage);
> +
> +			dev_info(dev, "Dynamic power table: %lu MHz @ %lu mV: %lu =3D %lu mW\=
n",

I would prefer this would not be dev_info though..

> +				 freq / 1000000, voltage, power_dyn, power_dyn);
> +
> +			power_table[i] =3D power_dyn;
> +		}
> +
> +		freq_table[i] =3D freq;
> +	}
> +
> +	if (callbacks)
> +		dfc->power_table =3D power_table;
> +
> +	dfc->freq_table =3D freq_table;
> +	dfc->freq_table_size =3D num_opps;
> +
> +	return 0;
> +
> +free_tables:
> +	kfree(freq_table);
> +free_power_table:
> +	kfree(power_table);
> +
> +	return ret;
> +}
> +
> +/**
> + * of_devfreq_cooling_register_power() - Register devfreq cooling device,
> + *                                      with OF and power information.
> + * @np: Pointer to OF device_node.
> + * @df: Pointer to devfreq device.
> + * @ops: Pointer to power ops.
> + *
> + * Register a devfreq cooling device.  The available OPPs must be
> + * registered on the device.
> + *
> + * If @ops is provided, the cooling device is registered with the
> + * power extensions.  For the power extensions to work correctly,
> + * devfreq should use the simple_ondemand governor, other governors
> + * are not currently supported.

Fine, but this should not be cooling device concern.

> + */
> +struct devfreq_cooling_device *
> +of_devfreq_cooling_register_power(struct device_node *np, struct devfreq=
 *df,
> +				  struct devfreq_cooling_ops *ops)
> +{
> +	struct thermal_cooling_device *cdev;
> +	struct devfreq_cooling_device *dfc;
> +	char dev_name[THERMAL_NAME_LENGTH];
> +	int err;
> +
> +	dfc =3D kzalloc(sizeof(*dfc), GFP_KERNEL);
> +	if (!dfc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dfc->devfreq =3D df;
> +
> +	if (ops) {
> +		if (strncmp(df->governor_name, "simple_ondemand",
> +			    sizeof("simple_ondemand")))
> +			dev_warn(df->dev.parent,
> +				 "Warning: Registering devfreq cooling device with power extensions =
but devfreq governor is not simple_ondemand\n");

I don't think this check should actually be in the devfreq cooling
device. I would prefer cooling devices still just provide the
functionality for the governor do what they need to. This is a policy
check, which I don't think should be done here. What if we add another
governor with 'power' extensions? should we come back here and remove
the warn? or add the governor to the check list?

> +
> +		if (!ops->get_static_power || !ops->get_dynamic_power) {

What is the reason we cannot use P=3Dalpha \times f \times V^2 as a
default?

> +			err =3D -EINVAL;
> +			goto free_dfc;
> +		}
> +		dfc->power_ops =3D ops;
> +
> +		devfreq_cooling_ops.get_requested_power =3D
> +			devfreq_cooling_get_requested_power;
> +		devfreq_cooling_ops.state2power =3D devfreq_cooling_state2power;
> +		devfreq_cooling_ops.power2state =3D devfreq_cooling_power2state;
> +	}
> +
> +	err =3D devfreq_cooling_gen_tables(dfc);
> +	if (err)
> +		goto free_dfc;
> +
> +	err =3D get_idr(&devfreq_idr, &dfc->id);
> +	if (err)
> +		goto free_tables;
> +
> +	snprintf(dev_name, sizeof(dev_name), "devfreq-%d", dfc->id);

the name does not seam to mention anything about thermal or cooling, any
particular reason?

> +
> +	cdev =3D thermal_of_cooling_device_register(np, dev_name, dfc,
> +						  &devfreq_cooling_ops);
> +	if (IS_ERR(cdev)) {
> +		err =3D PTR_ERR(cdev);
> +		dev_err(df->dev.parent,
> +			"Failed to register devfreq cooling device (%d)\n",
> +			err);
> +		goto release_idr;
> +	}
> +
> +	dfc->cdev =3D cdev;
> +
> +	return dfc;
> +
> +release_idr:
> +	release_idr(&devfreq_idr, dfc->id);
> +free_tables:
> +	kfree(dfc->power_table);
> +	kfree(dfc->freq_table);
> +free_dfc:
> +	kfree(dfc);
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL(of_devfreq_cooling_register_power);
> +
> +/**
> + * of_devfreq_cooling_register() - Register devfreq cooling device,
> + *                                with OF information.
> + * @np: Pointer to OF device_node.
> + * @df: Pointer to devfreq device.
> + */
> +struct devfreq_cooling_device *
> +of_devfreq_cooling_register(struct device_node *np, struct devfreq *df)
> +{
> +	return of_devfreq_cooling_register_power(np, df, NULL);
> +}
> +EXPORT_SYMBOL(of_devfreq_cooling_register);
> +
> +/**
> + * devfreq_cooling_register() - Register devfreq cooling device.
> + * @df: Pointer to devfreq device.
> + */
> +struct devfreq_cooling_device *devfreq_cooling_register(struct devfreq *=
df)
> +{
> +	return of_devfreq_cooling_register(NULL, df);
> +}
> +EXPORT_SYMBOL(devfreq_cooling_register);
> +
> +/**
> + * devfreq_cooling_unregister() - Unregister devfreq cooling device.
> + * @dfc: Pointer to devfreq cooling device to unregister.
> + */
> +void devfreq_cooling_unregister(struct devfreq_cooling_device *dfc)
> +{
> +	if (!dfc)
> +		return;
> +
> +	thermal_cooling_device_unregister(dfc->cdev);
> +	release_idr(&devfreq_idr, dfc->id);
> +	kfree(dfc->power_table);
> +	kfree(dfc->freq_table);
> +
> +	kfree(dfc);
> +}
> +EXPORT_SYMBOL(devfreq_cooling_unregister);

Any particular reason why this cannot be EXPORT_SYMBOL_GPL (same for all
exports above)?

> diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cool=
ing.h
> new file mode 100644
> index 000000000000..de866200efe0
> --- /dev/null
> +++ b/include/linux/devfreq_cooling.h
> @@ -0,0 +1,72 @@
> +/*
> + * devfreq_cooling: Thermal cooling device implementation for devices us=
ing
> + *                  devfreq
> + *
> + * Copyright (C) 2014-2015 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DEVFREQ_COOLING_H__
> +#define __DEVFREQ_COOLING_H__
> +
> +#include <linux/devfreq.h>
> +#include <linux/thermal.h>
> +
> +#ifdef CONFIG_DEVFREQ_THERMAL
> +
> +/**
> + * struct devfreq_cooling_ops - Devfreq cooling power ops
> + * @get_static_power: Take voltage, in mV, and return the static power i=
n mW.
> + * @get_dynamic_power: Take voltage, in mV, and frequency, in HZ, and re=
turn
> + * the dynamic power draw in mW.

If you are not providing a default, you must mention that all fields are
required.

> + */
> +struct devfreq_cooling_ops {
> +	unsigned long (*get_static_power)(unsigned long voltage);
> +	unsigned long (*get_dynamic_power)(unsigned long freq,
> +					   unsigned long voltage);
> +};
> +
> +struct devfreq_cooling_device *
> +of_devfreq_cooling_register_power(struct device_node *np, struct devfreq=
 *df,
> +				  struct devfreq_cooling_ops *ops);
> +struct devfreq_cooling_device *
> +of_devfreq_cooling_register(struct device_node *np, struct devfreq *df);
> +struct devfreq_cooling_device *devfreq_cooling_register(struct devfreq *=
df);
> +void devfreq_cooling_unregister(struct devfreq_cooling_device *dfc);
> +
> +#else /* !CONFIG_DEVFREQ_THERMAL */
> +
> +struct devfreq_cooling_device *
> +of_devfreq_cooling_register_power(struct device_node *np, struct devfreq=
 *df,
> +				  struct devfreq_cooling_ops *ops)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline struct devfreq_cooling_device *
> +of_devfreq_cooling_register(struct device_node *np, struct devfreq *df)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline struct devfreq_cooling_device *
> +devfreq_cooling_register(struct devfreq *df)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline void
> +devfreq_cooling_unregister(struct devfreq_cooling_device *dfc)
> +{
> +}
> +
> +#endif /* CONFIG_DEVFREQ_THERMAL */
> +#endif /* __DEVFREQ_COOLING_H__ */
> --=20
> 1.9.1
>=20

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV7783AAoJEMLUO4d9pOJWi8gIAJSKOPLRDMMnSqDK8jREZF5F
mx9DjoKZU8gErUGUi+uqs9pygjDgHpshOnNyRRX4QlvPpkO4IJPadJfm7d3cLb06
BRmI0m1lIeyxrb2+mYCy9Du2zg/zYmpTaVfxCn/tcjQbo2H43aBM6pBJx+Ee7P7p
KWa79a7g4LGYudor/FM5FSXKkcmB0C5vAtx3UEE8fo0IDXZGjYxf18c+190l9Vqd
9EOEgChSggJFAVSpC51LdxgTnuqGNZKz6ngP69GI+LRUTvvyFQY47qmrJAaBsrHA
LA0fP16qAIA5GSdIxNOdn8o6UhZODoIOPxd7C9pdpFmqeURD+60RFS8mUt0QTdk=
=DDTh
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
