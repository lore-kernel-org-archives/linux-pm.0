From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH v2 2/4] thermal: iio device for thermal sensor
Date: Sun, 20 Sep 2015 11:31:55 +0100
Message-ID: <55FE8B1B.8040109@kernel.org>
References: <1442529054-25803-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1442529054-25803-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49877 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbbITKcB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Sep 2015 06:32:01 -0400
In-Reply-To: <1442529054-25803-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org

On 17/09/15 23:30, Srinivas Pandruvada wrote:
> This change registers temperature sensor in a thermal zone as an IIO
> temperature device. This allows user space thermal application to ful=
ly
> utilize IIO capability to read temperature events and samples.
> The primary motivation for this change to improve performance for use=
r
> space thermal controllers like Linux thermal daemon or Intel=C2=AE Dy=
namic
> Platform and Thermal Framework (DPTF) for Chromium OS.
> The current sysfs has several limitations, which forces the current
> user space to use polling as the safe way. This polling causes perfor=
mance
> bottlenecks as some devices requires extremely aggressive response to
> changing temperature conditions.
> These are some limitations, which this change tries to address:
> - Temperature reading via sysfs attribute, which needs conversion fro=
m
> string to int
> - No way to set threshold settings to avoid polling for temperature c=
hange
> without using a RW passive trip point.
> - Event notifications via slow kobject uevents, which needs parsing t=
o id
> the zone and read temperature
> - Only pull interface from user space, kernel drivers can't send samp=
les
> - One sample at a time read from user space
> These limitations can be addressed by registering temperature sensor
> as an IIO device. IIO provides
> - buffered access via /dev/iio:deviceX node with select/poll capabili=
ty
> - temperature thresholds setting via iio event thresholds
> - Wait and receive events
> - Able to use different external trigger (data ready indications) and=
 push
> samples to buffers
>=20
> Next set of patches uses the IIO binding introduced in this patchset.
> The iio device created during call to thermal_zone_device_register. S=
amples
> are pushed to iio buffers when thermal_zone_device_update is called f=
rom
> client drivers.
>=20
> New thermal zone device callbacks:
> It introduces three new callbacks for thermal client drivers:
> get_threshold_temp: Get the current threshold temperature
> set_threshold_temp: Set the current threshold temperature
> check_notification_support: Inform that the client driver has asynchr=
onous
> notification mechanism. If it is then polling can be avoided for the
> temperature sensor.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
> ---
>  drivers/thermal/Kconfig       |  12 ++
>  drivers/thermal/Makefile      |   1 +
>  drivers/thermal/thermal_iio.c | 375 ++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/thermal/thermal_iio.h |  45 +++++
>  include/linux/thermal.h       |  13 ++
>  5 files changed, 446 insertions(+)
>  create mode 100644 drivers/thermal/thermal_iio.c
>  create mode 100644 drivers/thermal/thermal_iio.h
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0390044..bc7836e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -29,6 +29,18 @@ config THERMAL_HWMON
>  	  Say 'Y' here if you want all thermal sensors to
>  	  have hwmon sysfs interface too.
> =20
> +config THERMAL_IIO
> +	bool
> +	prompt "Thermal sensor from a zone as IIO sensor device"
> +	select IIO
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  This will register thermal sensor in a zone as an IIO temperature
> +	  sensor device.
> +	  This will help user space thermal controllers to use IIO ABI to
> +	  get events and buffered acces to temperature samples.
> +
>  config THERMAL_OF
>  	bool
>  	prompt "APIs to parse thermal data out of device tree"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 26f1608..b72a28d 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -7,6 +7,7 @@ thermal_sys-y			+=3D thermal_core.o
> =20
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)		+=3D thermal_hwmon.o
> +thermal_sys-$(CONFIG_THERMAL_IIO)		+=3D thermal_iio.o
>  thermal_sys-$(CONFIG_THERMAL_OF)		+=3D of-thermal.o
> =20
>  # governors
> diff --git a/drivers/thermal/thermal_iio.c b/drivers/thermal/thermal_=
iio.c
> new file mode 100644
> index 0000000..9c351e8
> --- /dev/null
> +++ b/drivers/thermal/thermal_iio.c
> @@ -0,0 +1,375 @@
> +/*
> + * thermal iio interface driver
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + */
> +
> +#include <linux/thermal.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +struct thermal_iio_data {
> +	struct thermal_zone_device *tz;
> +	struct iio_trigger *interrupt_trig;
> +	struct iio_chan_spec *channels;
> +	bool enable_trigger;
> +	int temp_thres;
> +	bool ev_enable_state;
> +	struct mutex mutex;
> +};
> +
> +static const struct iio_event_spec thermal_event =3D {
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE)
> +};
> +
> +#define THERMAL_TEMP_CHANNELS(event_cnt) {				\
> +	{								\
> +		.type =3D IIO_TEMP,					\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +		.scan_index =3D 0,					\
> +		.scan_type =3D {						\
> +			.sign =3D 'u',					\
> +			.realbits =3D 32,					\
> +			.storagebits =3D 32,				\
> +			.endianness =3D IIO_CPU,				\
> +		},							\
> +		.event_spec =3D &thermal_event,				\
> +		.num_event_specs =3D event_cnt,				\
> +	},								\
> +	IIO_CHAN_SOFT_TIMESTAMP(1),					\
> +}
> +
> +static const struct iio_chan_spec thermal_iio_channels[] =3D
> +						THERMAL_TEMP_CHANNELS(0);
> +static const struct iio_chan_spec thermal_iio_channels_with_events[]=
 =3D
> +						THERMAL_TEMP_CHANNELS(1);
Hmm. I'd be tempted to put this out long hand to avoid that case of ass=
igning
num_event_specs to 0.  That's a little messy for the saving of a couple
of lines.

> +
> +static int thermal_iio_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	int temp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D thermal_zone_get_temp(iio_data->tz, &temp);
> +		if (!ret) {
> +			*val =3D temp;
> +			ret =3D IIO_VAL_INT;
> +		}
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t thermal_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	u32 buffer[4];
> +	int temp;
> +	int ret;
> +
> +	ret =3D thermal_zone_get_temp(iio_data->tz, &temp);
> +	if (ret)
> +		goto err_read;
> +
> +	*(u32 *)buffer =3D temp;
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   iio_get_time_ns());
> +err_read:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int thermal_data_rdy_trigger_set_state(struct iio_trigger *tr=
ig,
> +					      bool state)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	mutex_lock(&iio_data->mutex);
> +	if (iio_data->tz->ops->set_notification_status) {
> +		ret =3D iio_data->tz->ops->set_notification_status(iio_data->tz,
> +								 state);
> +		if (!ret)
> +			iio_data->enable_trigger =3D state;
> +	} else
> +		iio_data->enable_trigger =3D state;
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_validate_trigger(struct iio_dev *indio_dev,
> +					struct iio_trigger *trig)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +
> +	if (iio_data->interrupt_trig && iio_data->interrupt_trig !=3D trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops thermal_trigger_ops =3D {
> +	.set_trigger_state =3D thermal_data_rdy_trigger_set_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int thermal_iio_read_event(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  enum iio_event_type type,
> +				  enum iio_event_direction dir,
> +				  enum iio_event_info info,
> +				  int *val, int *val2)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&iio_data->mutex);
You shouldn't need to assign a value to val2 if you are returning IIO_V=
AL_INT.
> +	*val2 =3D 0;
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		*val =3D iio_data->temp_thres;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_write_event(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int val, int val2)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	mutex_lock(&iio_data->mutex);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		iio_data->temp_thres =3D val;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_read_event_config(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	bool state;
> +
> +	mutex_lock(&iio_data->mutex);
> +	state =3D iio_data->ev_enable_state;
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return state;
> +}
> +
> +static int thermal_iio_write_event_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  int state)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
> +	int temp_thres;
> +	int ret =3D 0;
> +
> +	mutex_lock(&iio_data->mutex);
> +	if ((state && iio_data->ev_enable_state) ||
> +	    (!state && !iio_data->ev_enable_state))
> +		goto done_write_event;
> +
> +	if (state && !iio_data->temp_thres) {
> +		ret =3D -EINVAL;
> +		goto done_write_event;
> +	}
> +
> +	if (state)
> +		temp_thres =3D iio_data->temp_thres;
> +	else
> +		temp_thres =3D 0;
That's fun.  Guess the freezing point is never of relevance here.
(in actively cooled systems it could be...)
> +
> +	ret =3D iio_data->tz->ops->set_threshold_temp(iio_data->tz, 0,
> +						    temp_thres);
> +	if (ret)
> +		goto done_write_event;
> +
> +	if (iio_data->tz->ops->set_notification_status) {
> +		ret =3D iio_data->tz->ops->set_notification_status(iio_data->tz,
> +								 state > 0);
> +		if (!ret)
> +			iio_data->ev_enable_state =3D state;
> +	} else
> +		iio_data->ev_enable_state =3D state;
> +
> +done_write_event:
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_setup_trig(struct iio_trigger **iio_trig,
> +				  struct thermal_zone_device *tz,
> +				  const char *format)
> +{
> +	struct iio_trigger *trig;
> +	int ret;
> +
> +	trig =3D devm_iio_trigger_alloc(&tz->device, format, tz->type,
> +				      tz->indio_dev->id);
> +	if (!trig) {
> +		dev_err(&tz->device, "Trigger Allocate Failed\n");
> +		return -ENOMEM;
> +	}
> +	trig->dev.parent =3D &tz->device;
> +	trig->ops =3D &thermal_trigger_ops;
> +	iio_trigger_set_drvdata(trig, tz->indio_dev);
> +	ret =3D iio_trigger_register(trig);
> +	if (ret) {
> +		dev_err(&tz->device, "Trigger Allocate Failed\n");
> +		return ret;
> +	}
> +	*iio_trig =3D trig;

I'm cynical.  Any failure in this function should result in the
*iio_trig not being used anyway so I'd be tempted to write
directly into it in the first place rathe rthan having the local
variable. Still their are obvious maintainability and semantic reasons
for not assigning it until success so feel free to keep it as it is!
You write nice consistent code (more so than me I suspect!)

> +
> +	return 0;
> +}
> +
> +static const struct iio_info thermal_iio_info =3D {
> +	.read_raw		=3D thermal_iio_read_raw,
> +	.read_event_value	=3D thermal_iio_read_event,
> +	.write_event_value	=3D thermal_iio_write_event,
> +	.write_event_config	=3D thermal_iio_write_event_config,
> +	.read_event_config	=3D thermal_iio_read_event_config,
> +	.validate_trigger	=3D thermal_iio_validate_trigger,
> +	.driver_module		=3D THIS_MODULE,
> +};
> +
> +int thermal_iio_sensor_register(struct thermal_zone_device *tz)
> +{
> +	struct thermal_iio_data *iio_data;
> +	int ret;
> +
> +	tz->indio_dev =3D devm_iio_device_alloc(&tz->device, sizeof(*iio_da=
ta));
> +	if (!tz->indio_dev)
> +		return -ENOMEM;
> +
> +	iio_data =3D iio_priv(tz->indio_dev);
> +	iio_data->tz =3D tz;
> +	mutex_init(&iio_data->mutex);
> +
> +	tz->indio_dev->dev.parent =3D &tz->device;
> +	if (tz->ops->set_threshold_temp)
> +		tz->indio_dev->channels =3D thermal_iio_channels_with_events;
> +	else
> +		tz->indio_dev->channels =3D thermal_iio_channels;
> +	tz->indio_dev->num_channels =3D ARRAY_SIZE(thermal_iio_channels);
> +	tz->indio_dev->name =3D tz->type;
> +	tz->indio_dev->info =3D &thermal_iio_info;
> +	tz->indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	if (tz->ops->check_notification_support &&
> +	    tz->ops->check_notification_support(tz)) {
> +		ret =3D thermal_iio_setup_trig(&iio_data->interrupt_trig, tz,
> +					     "%s-dev%d");
Just a thought, I wonder if we want the trigger naming to make it obvio=
us
that this is tripping on an event rather than simply being a new value
available?

As this whole driver is a little 'special' in terms of what it is for,
perhaps an explicit documentation file would be a useful addition?
Maybe even with a basic illustration of how this might be used with a
governer?
(maybe this is obvious to people from the thermal side of things ;)
Quite a bit of what we'd want is in your patch descriptions!
> +		if (ret)
> +			return ret;
> +
> +		tz->indio_dev->trig =3D iio_trigger_get(iio_data->interrupt_trig);
> +	}
> +	ret =3D iio_triggered_buffer_setup(tz->indio_dev,
> +					 &iio_pollfunc_store_time,
> +					 thermal_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&tz->device, "failed to init trigger buffer\n");
> +		goto err_unreg_int_trig;
> +	}
> +	ret =3D iio_device_register(tz->indio_dev);
> +	if (ret < 0) {
> +		dev_err(&tz->device, "unable to register iio device\n");
> +		goto err_cleanup_trig;
> +	}
> +
> +	return 0;
> +
> +err_cleanup_trig:
> +	iio_triggered_buffer_cleanup(tz->indio_dev);
> +err_unreg_int_trig:
> +	if (iio_data->interrupt_trig)
> +		iio_trigger_unregister(iio_data->interrupt_trig);
> +
> +	return ret;
> +}
> +
> +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(tz->indio_dev);
> +
> +	iio_device_unregister(tz->indio_dev);
> +	iio_triggered_buffer_cleanup(tz->indio_dev);
> +	if (iio_data->interrupt_trig)
> +		iio_trigger_unregister(iio_data->interrupt_trig);
> +
> +	return 0;
> +}
> +
> +#define IIO_EVENT_CODE_THERMAL_THRES IIO_UNMOD_EVENT_CODE(IIO_TEMP, =
0,\
> +							  IIO_EV_TYPE_THRESH,\
> +							  IIO_EV_DIR_EITHER)
> +
> +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> +			      enum thermal_device_event_type event)
> +{
> +	struct thermal_iio_data *iio_data =3D iio_priv(tz->indio_dev);
> +
> +	mutex_lock(&iio_data->mutex);
> +	if (iio_data->ev_enable_state &&
> +	    event =3D=3D THERMAL_DEVICE_EVENT_THRESHOLD)
> +		iio_push_event(tz->indio_dev,

As this macro is only used in one place, I would slightly prefer
that you just had it expanded here.  Not a major point though as I don'=
t
have to look far for the definition after all!

Is there really no way of knowing if it was a rising or a falling trip?
I would have thought that info was vital for a userspace governer!
I guess it just has to follow up with an explicit temperature read to f=
ind
out what happened.

> +			       IIO_EVENT_CODE_THERMAL_THRES,
> +			       iio_get_time_ns());
> +	if (iio_data->enable_trigger)
> +		iio_trigger_poll(tz->indio_dev->trig);
I wonder if you want to allow specification of which of your event type=
s
you want to trigger on.  Hmm. I'd suggest separate triggers but right n=
ow we
don't support multiple triggers of one buffer in IIO. Perhaps we need t=
o
consider if there is a major enough usecase to support that in future.

> +	mutex_unlock(&iio_data->mutex);
> +
> +	return 0;
> +}
> diff --git a/drivers/thermal/thermal_iio.h b/drivers/thermal/thermal_=
iio.h
> new file mode 100644
> index 0000000..c7d7168
> --- /dev/null
> +++ b/drivers/thermal/thermal_iio.h
> @@ -0,0 +1,45 @@
> +/*
> + * thermal iio interface driver interface file
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + */
> +
> +#ifndef __THERMAL_IIO_H__
> +#define __THERMAL_IIO_H__
> +
> +#if defined(CONFIG_THERMAL_IIO)
> +
> +int thermal_iio_sensor_register(struct thermal_zone_device *tz);
> +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz);
> +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> +			      enum thermal_device_event_type event);
> +
> +#else
> +
> +static int thermal_iio_sensor_register(struct thermal_zone_device *t=
z)
> +{
> +	return 0;
> +}
> +
> +static int thermal_iio_sensor_unregister(struct thermal_zone_device =
*tz)
> +{
> +	return 0;
> +}
> +
> +static int thermal_iio_sensor_threshold_notify(struct thermal_zone_d=
evice *tz,
> +					       enum thermal_device_event_type event);
> +
> +{
> +	return 0;
> +}
> +
> +#endif
> +#endif
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c074f6a..925d1e5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -114,6 +114,13 @@ struct thermal_zone_device_ops {
>  	int (*set_emul_temp) (struct thermal_zone_device *, int);
>  	int (*get_trend) (struct thermal_zone_device *, int,
>  			  enum thermal_trend *);
> +	int (*get_threshold_temp)(struct thermal_zone_device *, int,
> +				  int *);
> +	int (*set_threshold_temp)(struct thermal_zone_device *, int,
> +				  int);
> +	int (*set_notification_status)(struct thermal_zone_device *,
> +				       bool status);
> +	bool (*check_notification_support)(struct thermal_zone_device *);
>  	int (*notify) (struct thermal_zone_device *, int,
>  		       enum thermal_trip_type);
>  };
> @@ -148,6 +155,8 @@ struct thermal_attr {
>  	char name[THERMAL_NAME_LENGTH];
>  };
> =20
> +struct iio_dev;
> +
>  /**
>   * struct thermal_zone_device - structure for a thermal zone
>   * @id:		unique id number for each thermal zone
> @@ -182,6 +191,7 @@ struct thermal_attr {
>   * @lock:	lock to protect thermal_instances list
>   * @node:	node in thermal_tz_list (in thermal_core.c)
>   * @poll_queue:	delayed work for polling
> + * @indio_dev:	pointer to instance of an IIO dev for this zone
>   */
>  struct thermal_zone_device {
>  	int id;
> @@ -208,6 +218,9 @@ struct thermal_zone_device {
>  	struct mutex lock;
>  	struct list_head node;
>  	struct delayed_work poll_queue;
> +#if defined(CONFIG_THERMAL_IIO)
> +	struct iio_dev *indio_dev;
> +#endif
>  };
> =20
>  /**
>=20

