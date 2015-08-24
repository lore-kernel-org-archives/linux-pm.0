From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 1/2] thermal: iio device for thermal sensor
Date: Mon, 24 Aug 2015 07:27:46 +0100
Message-ID: <8ED21323-2E7D-404D-A421-5901D2E16871@kernel.org>
References: <1439855577-17114-1-git-send-email-srinivas.pandruvada@linux.intel.com> <55DA28B7.3070007@kernel.org> <1440368741.3576.38.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47549 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbHXGaI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 02:30:08 -0400
In-Reply-To: <1440368741.3576.38.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org



On 23 August 2015 23:25:41 BST, Srinivas Pandruvada <srinivas.pandruvad=
a@linux.intel.com> wrote:
>On Sun, 2015-08-23 at 21:10 +0100, Jonathan Cameron wrote:
>> On 18/08/15 00:52, Srinivas Pandruvada wrote:
>> Hi Srinivas,
>Hi Jonathan,
>>=20
>> I'm not familiar enough with thermal to know how much sense the=20
>> support
>> makes, so mostly my review will concern itself with just the IIO sid=
e
>
>> of
>> things.
>>=20
>> > The only method to read temperature of a thermal zone is by readin=
g
>
>> > sysfs
>> > entry "temp". This works well when kernel is primarily doing=20
>> > thermal
>> > control and user mode tools/applications are reading temperature=20
>> > for
>> > display or debug purposes. But when user mode is doing primary=20
>> > thermal
>> > control using a "user space" governor, this model causes=20
>> > performance
>> > issues and have limitations. For example Linux thermal daemon or=20
>> > Intel=C2=AE
>> > Dynamic Platform and Thermal Framework (DPTF) for Chromium/Chrome=20
>> > OS are
>> > currently used as user space thermal controllers in several=20
>> > products.
>> > We have platforms with 10+ thermal sensors and thermal conditions=20
>> > are not
>> > an isolated cases, so it is important to manage thermal conditions=
=20
>> > without
>> > significantly degrading user experience. So we need an efficient=20
>> > way to
>> > read temperature and events, by
>> > - Not using polling from user space
>> > - Avoid sysfs string read for temperature and convert to decimal
>> > - Push model, so that driver can push changes when some temperatur=
e
>> > change event occurs, which needs attention
>> > - Let user space registers for some thresholds without using some
>> > passive trips
>> > - Avoid string based kobject uevent notifications
>> > - Able to use different external trigger (data ready indications)=20
>> > and push
>> > temperature samples
>>=20
>> The way you have done this is a little unusual...
>> Whilst you register a trigger, it never fires.  You drive
>> the buffer directly.
>>=20
>> To do a true trigger (as an interrupt) from a functional call like=20
>> that seen
>> here is a bit of a dance, but can be done if necessary.
>> I'm not sure I'm keen on the trick pulled here to avoid it.
>>=20
>I have these use cases. Not sure how best to handle
>- Some thermal drivers have its own interrupts like a real trigger.
>Those interrupts are registered in the drivers itself. For example:
>http://lxr.free-electrons.com/source/drivers/thermal/intel_soc_dts_the=
r
>mal.c line 446.
>In such case data will be directly pushed to buffer from drivers via
>thermal core interface.
>
>- Some drivers data ready is from some external events for example a
>indication from PMIC (Power management ICs). Becuase they are wired in
>so many different ways and provide interrupts, this will pollute
>drivers if each driver handles all cases. I rather use interrupt-
>trigger to sample temperature.
>
>- In some case drivers we need to sample on some external conditions
>identified from user space and use sysfs trigger to push sample.
>=20
>- If drivers don't have capability to interrupt, we still use push
>interface to send temperature samples uses something like RTC trigger.
>
Other than the rtc trigger is going away in favour of a high resolution=
 timer one that's all fine. =20

The approach described in the next paragraph should work fine with all =
of these cases.
>
>> What you can do is use the validate callback to restrict the trigger=
=20
>> you have
>> here to driving only the buffer in this same driver.
>> Then you can be sure that useing iio_trigger_poll_chained is fine.
>> That can be done without the irq_work dance.  Other triggers (don't
>> provide a validate callback in the other direction) should
>> then also work fine and you won't need to replicate the read
>> and push to buffers as currently.  The other triggers will just
>> see a threaded irq with no 'top half' and work normally.
>>=20
>> >=20
>> > There are some ways to achieve this using thermal sysfs 2.0, but=20
>> > still
>> > doesn't meet all requirements and will introduce backward=20
>> > compatibility
>> > issues. Other option is to enhance thermal sysfs by adding a senso=
r
>> > abstractions and providing a dev interface for poll/select. But=20
>> > since
>> > since Linux IIO already provides above capabilities, it is better=20
>> > we
>> > reuse IIO temperature sensor device. This change proposes use of=20
>> > IIO
>> > temperature sensor device for a thermal zone. Here IIO capabilitie=
s
>> > of triggered buffer and events are utilized.
>> >=20
>> > The iio device created during call to thermal_zone_device_register=
=2E
>> > Samples are pushed to iio buffers when thermal_zone_device_update=20
>> > is
>> > called from client drivers and user space governor is selected for=
=20
>> > the
>> > thermal zone. Only two additional callbacks for client driver to=20
>> > get/set
>> > thermal temperature thresholds.
>> >=20
>> > Signed-off-by: Srinivas Pandruvada <
>> > srinivas.pandruvada@linux.intel.com>
>>=20
>> > ---
>> >  drivers/thermal/Kconfig        |  11 ++
>> >  drivers/thermal/Makefile       |   1 +
>> >  drivers/thermal/thermal_core.c |   9 +-
>> >  drivers/thermal/thermal_iio.c  | 333=20
>> > +++++++++++++++++++++++++++++++++++++++++
>> >  drivers/thermal/user_space.c   |   1 +
>> >  include/linux/thermal.h        |  46 ++++++
>> >  6 files changed, 399 insertions(+), 2 deletions(-)
>> >  create mode 100644 drivers/thermal/thermal_iio.c
>> >=20
>> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> > index 118938e..0ea9d8b 100644
>> > --- a/drivers/thermal/Kconfig
>> > +++ b/drivers/thermal/Kconfig
>> > @@ -29,6 +29,17 @@ config THERMAL_HWMON
>> >  	  Say 'Y' here if you want all thermal sensors to
>> >  	  have hwmon sysfs interface too.
>> > =20
>> > +config THERMAL_IIO
>> > +	tristate "Thermal sensor from a zone as IIO device"
>> > +	select IIO
>> > +	select IIO_BUFFER
>> > +	select IIO_TRIGGERED_BUFFER
>> > +	help
>> > +	  This will register thermal sensor in a zone as an IIO=20
>> > temperature
>> > +	  sensor device.
>> > +	  This will help user space thermal controllers to use IIO=20
>> > ABI to
>> > +	  get events and buffered acces to temperature samples.
>> > +
>> >  config THERMAL_OF
>> >  	bool
>> >  	prompt "APIs to parse thermal data out of device tree"
>> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> > index 535dfee..4b42734 100644
>> > --- a/drivers/thermal/Makefile
>> > +++ b/drivers/thermal/Makefile
>> > @@ -7,6 +7,7 @@ thermal_sys-y			+=3D=20
>> > thermal_core.o
>> > =20
>> >  # interface to/from other layers providing sensors
>> >  thermal_sys-$(CONFIG_THERMAL_HWMON)		+=3D=20
>> > thermal_hwmon.o
>> > +thermal_sys-$(CONFIG_THERMAL_IIO)		+=3D thermal_iio.o
>> >  thermal_sys-$(CONFIG_THERMAL_OF)		+=3D of-thermal.o
>> > =20
>> >  # governors
>> > diff --git a/drivers/thermal/thermal_core.c=20
>> > b/drivers/thermal/thermal_core.c
>> > index 04659bf..483a4a1 100644
>> > --- a/drivers/thermal/thermal_core.c
>> > +++ b/drivers/thermal/thermal_core.c
>> > @@ -1833,10 +1833,15 @@ struct thermal_zone_device=20
>> > *thermal_zone_device_register(const char *type,
>> > =20
>> >  	mutex_unlock(&thermal_governor_lock);
>> > =20
>> > +	if (thermal_iio_sensor_register(tz))
>> > +		goto unregister;
>> > +
>> >  	if (!tz->tzp || !tz->tzp->no_hwmon) {
>> >  		result =3D thermal_add_hwmon_sysfs(tz);
>> > -		if (result)
>> > +		if (result) {
>> > +			thermal_iio_sensor_unregister(tz);
>> >  			goto unregister;
>> > +		}
>> >  	}
>> > =20
>> >  	mutex_lock(&thermal_list_lock);
>> > @@ -1919,7 +1924,7 @@ void thermal_zone_device_unregister(struct=20
>> > thermal_zone_device *tz)
>> >  	device_remove_file(&tz->device, &dev_attr_policy);
>> >  	remove_trip_attrs(tz);
>> >  	thermal_set_governor(tz, NULL);
>> > -
>> > +	thermal_iio_sensor_unregister(tz);
>> >  	thermal_remove_hwmon_sysfs(tz);
>> >  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>> >  	idr_destroy(&tz->idr);
>> > diff --git a/drivers/thermal/thermal_iio.c=20
>> > b/drivers/thermal/thermal_iio.c
>> > new file mode 100644
>> > index 0000000..e36ad90
>> > --- /dev/null
>> > +++ b/drivers/thermal/thermal_iio.c
>> > @@ -0,0 +1,333 @@
>> > +/*
>> > + * thermal iio interface driver
>> > + * Copyright (c) 2015, Intel Corporation.
>> > + *
>> > + * This program is free software; you can redistribute it and/or=20
>> > modify it
>> > + * under the terms and conditions of the GNU General Public=20
>> > License,
>> > + * version 2, as published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope it will be useful, but=
=20
>> > WITHOUT
>> > + * ANY WARRANTY; without even the implied warranty of=20
>> > MERCHANTABILITY or
>> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=20
>> > License for
>> > + * more details.
>> > + */
>> > +
>> > +#include <linux/thermal.h>
>> > +
>> > +struct thermal_iio_data {
>> > +	struct thermal_zone_device *tz;
>> > +	struct iio_trigger *dready_trig;
>> > +	s16 buffer[8];
>> Why so big?  Far as I can tell you read one 32 bit number into it at=
=20
>> most?
>> Also should also be a u32.  Actually I can't see why you need it
>> in this structure at all. =20
>>=20
>I will fix this in RFC v2.
>
>> > +	bool enable;
>> > +	long temp_thres;
>> > +	bool ev_enable_state;
>> > +	struct mutex mutex;
>> > +
>> > +};
>> > +
>> > +static const struct iio_event_spec thermal_event =3D {
>> > +		.type =3D IIO_EV_TYPE_THRESH,
>> > +		.dir =3D IIO_EV_DIR_EITHER,
>> > +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>> > +				 BIT(IIO_EV_INFO_ENABLE)
>> > +};
>> > +
>> > +#define THERMAL_TEMP_CHANNELS {				=09
>> > \
>> > +	{							=09
>> > \
>> > +		.type =3D IIO_TEMP,				=09
>> > \
>> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=09
>> > 	\
>> > +		.scan_index =3D 0,				=09
>> > \
>> > +		.scan_type =3D {				=09
>> > 	\
>> > +			.sign =3D 'u',			=09
>> > 	\
>> > +			.realbits =3D 32,			=09
>> > \
>> > +			.storagebits =3D 32,			=09
>> > \
>> > +			.shift =3D 0,			=09
>> > 	\
>> Don't bother specifying shift as that's the default (and intuitive=20
>> unlike
>> scan_index above which should be specified for ease of reading).
>> > +			.endianness =3D IIO_CPU,		=09
>> > 	\
>> > +		},
>OK
>> > 							\
>> > +		.event_spec =3D &thermal_event,		=09
>> > 	\
>> > +		.num_event_specs =3D 1			=09
>> > 	\
>> > +	},							=09
>> > \
>> > +}
>> > +
>> > +static const struct iio_chan_spec thermal_iio_channels[] =3D
>> > +							THERMAL_TE
>> > MP_CHANNELS;
>> > +
>> > +static int thermal_iio_read_raw(struct iio_dev *indio_dev,
>> > +				struct iio_chan_spec const *chan,
>> > +				int *val, int *val2, long mask)
>> > +{
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +	long temp;
>> > +	int ret;
>> > +
>> > +	switch (mask) {
>> > +	case IIO_CHAN_INFO_RAW:
>> Any interactions between this read and a buffered one if that is=20
>> enabled?
>> (don't know the limitations of the thermal stuff as to whether this
>> is a direct read to hardware or not..)
>This will provide on demand sample. The bufferred one will be pushed
>when something like a threshold is reached.
>Temperarture read can be as simple as reading a register. But sometime=
s
>we need to do a combination of operation and then use interpolation.
>> > +		ret =3D thermal_zone_get_temp(iio_data->tz, &temp);
>> > +		if (ret)
>> > +			return ret;
>> > +		*val =3D (int) temp;
>> > +		return IIO_VAL_INT;
>> > +	default:
>> > +		return -EINVAL;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> So this one is for when you are using other triggers...
>>=20
>> Really don't like the two different paths depending on who is=20
>> triggering
>> the read.
>>=20
>> > +static irqreturn_t thermal_trigger_handler(int irq, void *p)
>> > +{
>> > +	struct iio_poll_func *pf =3D p;
>> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +	long temp;
>> > +	int ret;
>> > +
>> > +	ret =3D thermal_zone_get_temp(iio_data->tz, &temp);
>> > +	if (ret)
>> > +		goto err_read;
>> > +
>> You have a channel spec saying it is unsigned...
>Will fix this.
>> > +	*(s32 *)iio_data->buffer =3D (s32)temp;
>> > +	iio_push_to_buffers(indio_dev, iio_data->buffer);
>> > +err_read:
>> > +	iio_trigger_notify_done(indio_dev->trig);
>> Blank line here.
>OK
>> > +	return IRQ_HANDLED;
>> > +}
>> > +
>> > +static int thermal_data_rdy_trigger_set_state(struct iio_trigger=20
>> > *trig,
>> > +					      bool state)
>> > +{
>> > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +
>> > +	mutex_lock(&iio_data->mutex);
>> > +	iio_data->enable =3D state;
>> > +	mutex_unlock(&iio_data->mutex);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static const struct iio_trigger_ops thermal_trigger_ops =3D {
>> > +	.set_trigger_state =3D thermal_data_rdy_trigger_set_state,
>> > +	.owner =3D THIS_MODULE,
>> > +};
>> > +
>> > +static int thermal_iio_read_event(struct iio_dev *indio_dev,
>> > +				  const struct iio_chan_spec=20
>> > *chan,
>> > +				  enum iio_event_type type,
>> > +				  enum iio_event_direction dir,
>> > +				  enum iio_event_info info,
>> > +				  int *val, int *val2)
>> > +{
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +	int ret;
>> > +
>> > +	mutex_lock(&iio_data->mutex);
>> > +	*val2 =3D 0;
>> > +	switch (info) {
>> > +	case IIO_EV_INFO_VALUE:
>> > +		*val =3D iio_data->temp_thres;
>> > +		ret =3D IIO_VAL_INT;
>> > +		break;
>> > +	default:
>> > +		ret =3D -EINVAL;
>> > +		break;
>> > +	}
>> > +	mutex_unlock(&iio_data->mutex);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +static int thermal_iio_write_event(struct iio_dev *indio_dev,
>> > +				   const struct iio_chan_spec=20
>> > *chan,
>> > +				   enum iio_event_type type,
>> > +				   enum iio_event_direction dir,
>> > +				   enum iio_event_info info,
>> > +				   int val, int val2)
>> > +{
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +	int ret =3D 0;
>> > +
>> > +	mutex_lock(&iio_data->mutex);
>> > +	if (iio_data->ev_enable_state) {
>> Would it be risky to update the threshold live if the event is=20
>> enabled?
>> Normally we try to do this if possible.
>This will depend on the thermal client drivers on variety of platforms=
=2E
>So just playing safe.
=46air enough if thermal also protects against this sort of change thou=
gh I=20
would expect this to be in the drivers. I.e drivers can temporarily dis=
able the threshold whilst changing it and reenable when done.
>>=20
>> > +		ret =3D -EBUSY;
>> > +		goto done_write_event;
>> > +	}
>> I'd insert a blank line here for readability.
>OK
>> > +	switch (info) {
>> > +	case IIO_EV_INFO_VALUE:
>> > +		iio_data->temp_thres =3D val;
>> > +		break;
>> > +	default:
>> > +		ret =3D -EINVAL;
>> > +		break;
>> > +	}
>> > +done_write_event:
>> > +	mutex_unlock(&iio_data->mutex);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +static int thermal_iio_read_event_config(struct iio_dev=20
>> > *indio_dev,
>> > +					 const struct=20
>> > iio_chan_spec *chan,
>> > +					 enum iio_event_type type,
>> > +					 enum iio_event_direction=20
>> > dir)
>> > +{
>> > +
>> Random blank line here.
>OK
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +	bool state;
>> > +
>> > +	mutex_lock(&iio_data->mutex);
>> > +	state =3D iio_data->ev_enable_state;
>> > +	mutex_unlock(&iio_data->mutex);
>> > +
>> > +	return state;
>> > +}
>> > +
>> > +static int thermal_iio_write_event_config(struct iio_dev=20
>> > *indio_dev,
>> > +					  const struct=20
>> > iio_chan_spec *chan,
>> > +					  enum iio_event_type=20
>> > type,
>> > +					  enum iio_event_direction=20
>> > dir,
>> > +					  int state)
>> > +{
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(indio_dev);
>> > +	int ret =3D 0;
>> > +
>> > +	mutex_lock(&iio_data->mutex);
>> What about both state and ev_enable_state being off?
>>=20
>OK
>> > +	if (state && iio_data->ev_enable_state)
>> > +		goto done_write_event;
>> > +
>> > +	if (iio_data->tz->ops->set_threshold_temp)
>> > +		ret =3D iio_data->tz->ops
>> > ->set_threshold_temp(iio_data->tz, 0,
>> > +							iio_data
>> > ->temp_thres);
>> > +	iio_data->ev_enable_state =3D state;
>> > +
>> > +done_write_event:
>> > +	mutex_unlock(&iio_data->mutex);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +static const struct iio_info thermal_iio_info =3D {
>> > +	.read_raw		=3D thermal_iio_read_raw,
>> > +	.read_event_value	=3D thermal_iio_read_event,
>> > +	.write_event_value	=3D thermal_iio_write_event,
>> > +	.write_event_config	=3D=20
>> > thermal_iio_write_event_config,
>> > +	.read_event_config	=3D thermal_iio_read_event_config,
>> > +	.driver_module		=3D THIS_MODULE,
>> > +};
>> > +
>> > +int thermal_iio_sensor_register(struct thermal_zone_device *tz)
>> > +{
>> > +	struct thermal_iio_data *iio_data;
>> > +	int ret;
>> > +
>> Hmm.  We should probably provide support for embedding iio directly=20
>> in another
>> structure at some point... Though handling the private data=20
>> allocation then
>> gets complex.
>>=20
>> Anyhow, this is fine for now.
>> > +	tz->indio_dev =3D devm_iio_device_alloc(&tz->device,=20
>> > sizeof(*iio_data));
>> > +	if (!tz->indio_dev)
>> > +		return -ENOMEM;
>> > +
>> > +	iio_data =3D iio_priv(tz->indio_dev);
>> > +	iio_data->tz =3D tz;
>> > +	mutex_init(&iio_data->mutex);
>> > +
>> > +	tz->indio_dev->dev.parent =3D &tz->device;
>> > +	tz->indio_dev->channels =3D thermal_iio_channels;
>> > +	tz->indio_dev->num_channels =3D=20
>> > ARRAY_SIZE(thermal_iio_channels);
>> > +	tz->indio_dev->name =3D tz->type;
>> > +	tz->indio_dev->info =3D &thermal_iio_info;
>> > +	tz->indio_dev->modes =3D INDIO_DIRECT_MODE;
>> > +
>> > +	iio_data->dready_trig =3D devm_iio_trigger_alloc(&tz
>> > ->device, "%s-dev%d",
>> > +						       tz->type,
>> > +						       tz
>> > ->indio_dev->id);
>> > +	if (iio_data->dready_trig =3D=3D NULL) {
>> > +		dev_err(&tz->device, "Trigger Allocate Failed\n");
>> > +		return -ENOMEM;
>> > +	}
>> > +
>> > +	iio_data->dready_trig->dev.parent =3D &tz->device;
>> > +	iio_data->dready_trig->ops =3D &thermal_trigger_ops;
>> > +	iio_trigger_set_drvdata(iio_data->dready_trig, tz
>> > ->indio_dev);
>> > +	tz->indio_dev->trig =3D iio_data->dready_trig;
>> > +	iio_trigger_get(tz->indio_dev->trig);
>> > +	ret =3D iio_trigger_register(iio_data->dready_trig);
>> > +	if (ret) {
>> > +		dev_err(&tz->device, "Trigger Allocate Failed\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret =3D iio_triggered_buffer_setup(tz->indio_dev,
>> Why store the time?  It's never used as the timestamp channel isn't=20
>> registered.
>It was suggested to add time during LPC talk. So will need to add
>timestamp channel.
Ah well :)
>> > +					 &iio_pollfunc_store_time,
>> > +					 thermal_trigger_handler,=20
>> > NULL);
>> > +	if (ret) {
>> > +		dev_err(&tz->device, "failed to initialize trigger=20
>> > buffer\n");
>> > +		goto err_unreg_trig;
>> > +	}
>> > +
>> > +	ret =3D iio_device_register(tz->indio_dev);
>> > +	if (ret < 0) {
>> > +		dev_err(&tz->device, "unable to register iio=20
>> > device\n");
>> > +		goto err_cleanup_trig;
>> > +	}
>> > +
>> > +	return 0;
>> > +
>> > +err_cleanup_trig:
>> > +	iio_triggered_buffer_cleanup(tz->indio_dev);
>> > +err_unreg_trig:
>> > +	iio_device_unregister(tz->indio_dev);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
>> > +{
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(tz
>> > ->indio_dev);
>> > +
>> > +	iio_device_unregister(tz->indio_dev);
>> > +	iio_triggered_buffer_cleanup(tz->indio_dev);
>> > +	iio_trigger_unregister(iio_data->dready_trig);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +#define IIO_EVENT_CODE_THERMAL_THRES=20
>> > IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,\
>> > +							=20
>> >  IIO_EV_TYPE_THRESH,\
>> > +							=20
>> >  IIO_EV_DIR_EITHER)
>> > +
>> > +#define IIO_EVENT_CODE_TRIP_UPDATE IIO_UNMOD_EVENT_CODE(IIO_TEMP,=
=20
>> > 0,\
>> > +							IIO_EV_TYP
>> > E_CHANGE,\
>> > +							IIO_EV_DIR
>> > _NONE)
>>=20
>> I'd like a justification of this particular one.  Normal use of
>> the change type doesn't really apply here (counting steps etc)...
>> (given one of the reviewers of this driver knows nothing about
>> thermal (yet :)
>>=20
>This is some case when driver wants to send event other than simple
>threshold change. We have some other temperature change event not
>because of threshold, for example error in temperature reporting
>circuit. I want user space to wake up and read temperature and find ou=
t
>the issue by error code returned and take action before.
That is rather ugly. We really should have another means of signalling =
that.

Oh for that general hardware error framework that always gets suggested
but never implemented!
>> > +
>> > +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
>> > +			      enum thermal_zone_event_type event)
>> > +{
>> > +	struct thermal_iio_data *iio_data =3D iio_priv(tz
>> > ->indio_dev);
>> > +	long temp =3D 0;
>> > +	int ret;
>> > +
>> > +	mutex_lock(&iio_data->mutex);
>> > +	if (iio_data->ev_enable_state) {
>> > +		if (event =3D=3D THERMAL_TEMP_THRESHOLD)
>> > +			iio_push_event(tz->indio_dev,
>> > +				     =20
>> >  IIO_EVENT_CODE_THERMAL_THRES,
>> > +				       iio_get_time_ns());
>> > +		else if (event =3D=3D THERMAL_TRIP_UPDATE)
>> > +			iio_push_event(tz->indio_dev,
>> > +				       IIO_EVENT_CODE_TRIP_UPDATE,
>> > +				       iio_get_time_ns());
>> > +		else
>> > +			dev_err(&tz->device, "invalid event\n");
>> > +	}
>> This enable needs a clearer name.
>> > +	if (iio_data->enable) {
>> > +		ret =3D thermal_zone_get_temp(iio_data->tz, &temp);
>> > +		if (ret)
>> > +			goto err_read;
>> Why not read directly into the buffer?  Ah, the parameter is an=20
>> unsigned
>> long so no guarantee it will be 32 bits (even if it currently will=20
>> be).
>> That's tedious. Ah well!  Speaking of which, temp is signed. Doubt=20
>> you meant
>> that.
>> > +		*(u32 *)iio_data->buffer =3D (u32)temp;
>>=20
>> So is there a real trigger here?  Doesn't look like to to me.
>> Not sure what the reason for faking one is.  They aren't necessary
>> where they don't make sense...
>>=20
>> > +		iio_push_to_buffers(tz->indio_dev, iio_data
>> > ->buffer);
>> > +	}
>> > +	mutex_unlock(&iio_data->mutex);
>> > +
>> > +	return 0;
>> Drop through here and have only one exit point and unlock?  Obviousl=
y
>
>> set
>> ret =3D 0 to ensure it's assigned.
>ok
>> > +err_read:
>> > +	mutex_unlock(&iio_data->mutex);
>> > +	return ret;
>> > +}
>> > diff --git a/drivers/thermal/user_space.c=20
>> > b/drivers/thermal/user_space.c
>> > index 10adcdd..742adec 100644
>> > --- a/drivers/thermal/user_space.c
>> > +++ b/drivers/thermal/user_space.c
>> > @@ -34,6 +34,7 @@
>> >   */
>> >  static int notify_user_space(struct thermal_zone_device *tz, int=20
>> > trip)
>> >  {
>> > +	thermal_iio_sensor_notify(tz, THERMAL_TEMP_THRESHOLD);
>> >  	mutex_lock(&tz->lock);
>> >  	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
>> >  	mutex_unlock(&tz->lock);
>> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> > index 037e9df..4c4c487 100644
>> > --- a/include/linux/thermal.h
>> > +++ b/include/linux/thermal.h
>> > @@ -31,6 +31,16 @@
>> >  #include <linux/workqueue.h>
>> >  #include <uapi/linux/thermal.h>
>> > =20
>> > +#if IS_ENABLED(CONFIG_THERMAL_IIO)
>> > +#include <linux/iio/iio.h>
>> > +#include <linux/iio/sysfs.h>
>> > +#include <linux/iio/buffer.h>
>> > +#include <linux/iio/trigger.h>
>> > +#include <linux/iio/events.h>
>> > +#include <linux/iio/trigger_consumer.h>
>> > +#include <linux/iio/triggered_buffer.h>
>> > +#endif
>> > +
>> >  #define THERMAL_TRIPS_NONE	-1
>> >  #define THERMAL_MAX_TRIPS	12
>> > =20
>> > @@ -111,6 +121,10 @@ struct thermal_zone_device_ops {
>> >  	int (*set_emul_temp) (struct thermal_zone_device *,=20
>> > unsigned long);
>> >  	int (*get_trend) (struct thermal_zone_device *, int,
>> >  			  enum thermal_trend *);
>> > +	int (*get_threshold_temp)(struct thermal_zone_device *,=20
>> > int,
>> > +				  unsigned long *);
>> > +	int (*set_threshold_temp)(struct thermal_zone_device *,=20
>> > int,
>> > +				  unsigned long);
>> >  	int (*notify) (struct thermal_zone_device *, int,
>> >  		       enum thermal_trip_type);
>> >  };
>> > @@ -205,6 +219,9 @@ struct thermal_zone_device {
>> >  	struct mutex lock;
>> >  	struct list_head node;
>> >  	struct delayed_work poll_queue;
>> > +#ifdef CONFIG_THERMAL_IIO
>> > +	struct iio_dev *indio_dev;
>> > +#endif
>> >  };
>> > =20
>> >  /**
>> > @@ -483,4 +500,33 @@ static inline int=20
>> > thermal_generate_netlink_event(struct thermal_zone_device *tz,
>> >  }
>> >  #endif
>> > =20
>> > +enum thermal_zone_event_type {
>> > +	THERMAL_TEMP_THRESHOLD,
>> > +	THERMAL_TRIP_UPDATE,
>> > +	THERMAL_EVENT_TYPE_MAX,
>> > +};
>> > +
>> > +#if IS_ENABLED(CONFIG_THERMAL) && IS_ENABLED(CONFIG_THERMAL_IIO)
>> > +int thermal_iio_sensor_register(struct thermal_zone_device *tz);
>> > +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)=
;
>> > +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
>> > +			      enum thermal_zone_event_type event);
>> > +#else
>> > +static int thermal_iio_sensor_register(struct thermal_zone_device=
=20
>> > *tz)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static int thermal_iio_sensor_unregister(struct=20
>> > thermal_zone_device *tz)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static int thermal_iio_sensor_notify(struct thermal_zone_device=20
>> > *tz
>> > +				     enum thermal_zone_event_type=20
>> > event)
>> > +{
>> > +	return 0;
>> > +}
>> > +#endif
>> > +
>> >  #endif /* __THERMAL_H__ */
>> >=20
>>=20
>Thanks,
>Srinivas
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm"=20
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Sent from my Android device with K-9 Mail. Please excuse my brevity.
