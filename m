From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 1/5] thermal: Add support for hardware-tracked trip
 points
Date: Fri, 1 Jul 2016 18:39:21 -0700
Message-ID: <20160702013920.GA9796@localhost.localdomain>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
 <1465213489-14898-2-git-send-email-wxt@rock-chips.com>
 <1466565319.2379.0.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35350 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbcGBBj3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 21:39:29 -0400
Content-Disposition: inline
In-Reply-To: <1466565319.2379.0.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Andy Champ <andycham@amazon.com>, Laxman Dewangan <ldewangan@nvidia.com>, Durgadoss R <durgadoss.r@intel.com>, Ni Wade <wni@nvidia.com>, Leo Yan <leo.yan@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 22, 2016 at 11:15:19AM +0800, Zhang Rui wrote:
> On =E4=B8=80, 2016-06-06 at 19:44 +0800, Caesar Wang wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > This adds support for hardware-tracked trip points to the device tr=
ee
> > thermal sensor framework.
> >=20
> > The framework supports an arbitrary number of trip points. Whenever
> > the current temperature is updated, the trip points immediately
> > below and above the current temperature are found. A .set_trips
> > callback is then called with the temperatures. If there is no trip
> > point above or below the current temperature, the passed trip
> > temperature will be -INT_MAX or INT_MAX respectively. In this
> > callback,
> > the driver should program the hardware such that it is notified
> > when either of these trip points are triggered. When a trip point
> > is triggered, the driver should call `thermal_zone_device_update'
> > for the respective thermal zone. This will cause the trip points
> > to be updated again.
> >=20
> > If .set_trips is not implemented, the framework behaves as before.
> >=20
> > This patch is based on an earlier version from Mikko Perttunen
> > <mikko.perttunen@kapsi.fi>
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: linux-pm@vger.kernel.org
> >=20
> > ---
> >=20
> > Changes in v5:
> > - add the lock for thermal_zone_set_trips function.
> > - change based on next kernel.
> >=20
> > Changes in v4:
> > - Missing the lock added in v3.
> >=20
> > Changes in v3:
> > - as Javi comments on https://patchwork.kernel.org/patch/9001281/.
> > - add the lock for preventing the called from multi placce
> > - add the note for pre_low/high_trip.
> >=20
> > Changes in v2:
> > - update the sysfs-api.txt for set_trips.
> >=20
> > =C2=A0Documentation/thermal/sysfs-api.txt |=C2=A0=C2=A07 +++++
> > =C2=A0drivers/thermal/thermal_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 54
> > +++++++++++++++++++++++++++++++++++++
> > =C2=A0drivers/thermal/thermal_sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A03 +++
> > =C2=A0include/linux/thermal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 +++++++
> > =C2=A04 files changed, 74 insertions(+)
> >=20
> > diff --git a/Documentation/thermal/sysfs-api.txt
> > b/Documentation/thermal/sysfs-api.txt
> > index efc3f3d..75d8838 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -49,6 +49,9 @@ temperature) and throttle appropriate devices.
> > =C2=A0	.bind: bind the thermal zone device with a thermal cooling
> > device.
> > =C2=A0	.unbind: unbind the thermal zone device with a thermal
> > cooling device.
> > =C2=A0	.get_temp: get the current temperature of the thermal zone.
> > +	.set_trips: set the trip points window. Whenever the current
> > temperature
> > +		=C2=A0=C2=A0=C2=A0=C2=A0is updated, the trip points immediately =
below
> > and above the
> > +		=C2=A0=C2=A0=C2=A0=C2=A0current temperature are found.
> > =C2=A0	.get_mode: get the current mode (enabled/disabled) of the
> > thermal zone.
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0- "enabled" means the kernel thermal=
 management is
> > enabled.
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0- "disabled" will prevent kernel the=
rmal driver action
> > upon trip points
> > @@ -95,6 +98,10 @@ temperature) and throttle appropriate devices.
> > =C2=A0			get_temp:	a pointer to a function
> > that reads the
> > =C2=A0					sensor temperature. This is
> > mandatory
> > =C2=A0					callback provided by sensor
> > driver.
> > +			set_trips:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a pointer to a fu=
nction that
> > sets a
> > +					temperature window. When
> > this window is
> > +					left the driver must inform
> > the thermal
> > +					core via
> > thermal_zone_device_update.
> > =C2=A0			get_trend:=C2=A0	a pointer to a function
> > that reads the
> > =C2=A0					sensor temperature trend.
> > =C2=A0			set_emul_temp:	a pointer to a
> > function that sets
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 792aab7..e69aee2 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -368,6 +368,56 @@ static void handle_thermal_trip(struct
> > thermal_zone_device *tz, int trip)
> > =C2=A0	monitor_thermal_zone(tz);
> > =C2=A0}
> > =C2=A0
> > +void thermal_zone_set_trips(struct thermal_zone_device *tz)
> > +{
> > +	int low =3D -INT_MAX;
> > +	int high =3D INT_MAX;
> > +	int trip_temp, hysteresis;
> > +	int i, ret;
> > +
> > +	mutex_lock(&tz->lock);
> > +
> > +	if (!tz->ops->set_trips)
> > +		goto exit;
> > +
> 	if (!tz->ops->get_trip_hyst)
> 		goto exit;
>=20
> otherwise, the patch looks good to me.

Agreed here, you need to check if get_trip_hyst is present before
calling it. Not all drivers have it.

Besides, I would prefer you to lock after the checks:

	if (!tz->ops->set_trips)
		return;

	if (!tz->ops->get_trip_hyst)
		return;

	mutex_lock(&tz->lock);

>=20
> thanks,
> rui
> > +	for (i =3D 0; i < tz->trips; i++) {
> > +		int trip_low;
> > +
> > +		tz->ops->get_trip_temp(tz, i, &trip_temp);
> > +		tz->ops->get_trip_hyst(tz, i, &hysteresis);
> > +
> > +		trip_low =3D trip_temp - hysteresis;
> > +
> > +		if (trip_low < tz->temperature && trip_low > low)
> > +			low =3D trip_low;
> > +
> > +		if (trip_temp > tz->temperature && trip_temp < high)
> > +			high =3D trip_temp;
> > +	}
> > +
> > +	/* No need to change trip points */
> > +	if (tz->prev_low_trip =3D=3D low && tz->prev_high_trip =3D=3D hig=
h)
> > +		goto exit;
> > +
> > +	tz->prev_low_trip =3D low;
> > +	tz->prev_high_trip =3D high;
> > +
> > +	dev_dbg(&tz->device, "new temperature boundaries: %d < x <
> > %d\n",
> > +			low, high);
> > +
> > +	/*
> > +	=C2=A0* Set a temperature window. When this window is left the
> > driver
> > +	=C2=A0* must inform the thermal core via
> > thermal_zone_device_update.
> > +	=C2=A0*/
> > +	ret =3D tz->ops->set_trips(tz, low, high);
> > +	if (ret)
> > +		dev_err(&tz->device, "Failed to set trips: %d\n",
> > ret);
> > +
> > +exit:
> > +	mutex_unlock(&tz->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
> > +
> > =C2=A0static void update_temperature(struct thermal_zone_device *tz=
)
> > =C2=A0{
> > =C2=A0	int temp, ret;
> > @@ -417,6 +467,8 @@ void thermal_zone_device_update(struct
> > thermal_zone_device *tz)
> > =C2=A0
> > =C2=A0	update_temperature(tz);
> > =C2=A0
> > +	thermal_zone_set_trips(tz);
> > +
> > =C2=A0	for (count =3D 0; count < tz->trips; count++)
> > =C2=A0		handle_thermal_trip(tz, count);
> > =C2=A0}
> > @@ -1175,6 +1227,8 @@ thermal_zone_device_register(const char *type=
,
> > int trips, int mask,
> > =C2=A0	tz->trips =3D trips;
> > =C2=A0	tz->passive_delay =3D passive_delay;
> > =C2=A0	tz->polling_delay =3D polling_delay;
> > +	tz->prev_low_trip =3D INT_MAX;
> > +	tz->prev_high_trip =3D -INT_MAX;
> > =C2=A0
> > =C2=A0	/* sys I/F */
> > =C2=A0	/* Add nodes that are always present via .groups */
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index 743df50..33bbe30 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -219,6 +219,9 @@ trip_point_hyst_store(struct device *dev, struc=
t
> > device_attribute *attr,
> > =C2=A0	ret =3D tz->ops->set_trip_hyst(tz, trip, temperature);
> > =C2=A0	mutex_unlock(&tz->lock);
> > =C2=A0
> > +	if (!ret)
> > +		thermal_zone_set_trips(tz);
> > +
> > =C2=A0	return ret ? ret : count;
> > =C2=A0}
> > =C2=A0
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index ea667b6..780e69d 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -99,6 +99,7 @@ struct thermal_zone_device_ops {
> > =C2=A0	int (*unbind) (struct thermal_zone_device *,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct thermal_co=
oling_device *);
> > =C2=A0	int (*get_temp) (struct thermal_zone_device *, int *);
> > +	int (*set_trips) (struct thermal_zone_device *, int, int);
> > =C2=A0	int (*get_mode) (struct thermal_zone_device *,
> > =C2=A0			=C2=A0enum thermal_device_mode *);
> > =C2=A0	int (*set_mode) (struct thermal_zone_device *,
> > @@ -169,6 +170,10 @@ struct thermal_attr {
> > =C2=A0 * @last_temperature:	previous temperature read
> > =C2=A0 * @emul_temperature:	emulated temperature when using
> > CONFIG_THERMAL_EMULATION
> > =C2=A0 * @passive:		1 if you've crossed a passive trip
> > point, 0 otherwise.
> > + * @prev_low_trip:	the low current temperature if you've
> > crossed a passive
> > +			trip point.
> > + * @prev_high_trip:	the above current temperature if you've
> > crossed a
> > +			passive trip point.
> > =C2=A0 * @forced_passive:	If > 0, temperature at which to switch on
> > all ACPI
> > =C2=A0 *			processor cooling devices.=C2=A0=C2=A0Currently only
> > used by the
> > =C2=A0 *			step-wise governor.
> > @@ -201,6 +206,8 @@ struct thermal_zone_device {
> > =C2=A0	int last_temperature;
> > =C2=A0	int emul_temperature;
> > =C2=A0	int passive;
> > +	int prev_low_trip;
> > +	int prev_high_trip;
> > =C2=A0	unsigned int forced_passive;
> > =C2=A0	atomic_t need_update;
> > =C2=A0	struct thermal_zone_device_ops *ops;
> > @@ -428,6 +435,7 @@ int thermal_zone_bind_cooling_device(struct
> > thermal_zone_device *, int,
> > =C2=A0int thermal_zone_unbind_cooling_device(struct thermal_zone_de=
vice *,
> > int,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct thermal_=
cooling_device
> > *);
> > =C2=A0void thermal_zone_device_update(struct thermal_zone_device *)=
;
> > +void thermal_zone_set_trips(struct thermal_zone_device *);
> > =C2=A0
> > =C2=A0struct thermal_cooling_device *thermal_cooling_device_registe=
r(char
> > *, void *,
> > =C2=A0		const struct thermal_cooling_device_ops *);
> > @@ -477,6 +485,8 @@ static inline int
> > thermal_zone_unbind_cooling_device(
> > =C2=A0{ return -ENODEV; }
> > =C2=A0static inline void thermal_zone_device_update(struct
> > thermal_zone_device *tz)
> > =C2=A0{ }
> > +static inline void thermal_zone_set_trips(struct thermal_zone_devi=
ce
> > *tz)
> > +{ }
> > =C2=A0static inline struct thermal_cooling_device *
> > =C2=A0thermal_cooling_device_register(char *type, void *devdata,
> > =C2=A0	const struct thermal_cooling_device_ops *ops)
