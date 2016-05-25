From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 1/5] thermal: Add support for hardware-tracked trip
 points
Date: Wed, 25 May 2016 17:44:21 +0100
Message-ID: <20160525164420.GB11807@e104805>
References: <1462268013-14992-1-git-send-email-wxt@rock-chips.com>
 <1462268013-14992-2-git-send-email-wxt@rock-chips.com>
 <20160524125741.GA8979@e104805>
 <57451B9C.7070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36162 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbcEYQo1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 May 2016 12:44:27 -0400
Content-Disposition: inline
In-Reply-To: <57451B9C.7070705@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Jonathan Corbet <corbet@lwn.net>, Ni Wade <wni@nvidia.com>, Durgadoss R <durgadoss.r@intel.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, dmitry.torokhov@gmail.com, linux-doc@vger.kernel.org, dianders@chromium.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, Laxman Dewangan <ldewangan@nvidia.com>, smbarber@google.com, Leo Yan <leo.yan@linaro.org>, cf@rock-chips.com, briannorris@google.com, Zhang Rui <rui.zhang@intel.com>, Andy Champ <andycham@amazon.com>

Hi Caesar,

On Wed, May 25, 2016 at 11:27:24AM +0800, Caesar Wang wrote:
> On 2016=E5=B9=B405=E6=9C=8824=E6=97=A5 20:57, Javi Merino wrote:
> >On Tue, May 03, 2016 at 05:33:29PM +0800, Caesar Wang wrote:
> >>From: Sascha Hauer <s.hauer@pengutronix.de>
> >>
> >>This adds support for hardware-tracked trip points to the device tr=
ee
> >>thermal sensor framework.
> >>
> >>The framework supports an arbitrary number of trip points. Whenever
> >>the current temperature is updated, the trip points immediately
> >>below and above the current temperature are found. A .set_trips
> >>callback is then called with the temperatures. If there is no trip
> >>point above or below the current temperature, the passed trip
> >>temperature will be -INT_MAX or INT_MAX respectively. In this callb=
ack,
> >>the driver should program the hardware such that it is notified
> >>when either of these trip points are triggered. When a trip point
> >>is triggered, the driver should call `thermal_zone_device_update'
> >>for the respective thermal zone. This will cause the trip points
> >>to be updated again.
> >>
> >>If .set_trips is not implemented, the framework behaves as before.
> >>
> >>This patch is based on an earlier version from Mikko Perttunen
> >><mikko.perttunen@kapsi.fi>
> >>
> >>Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >>Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> >>Cc: Zhang Rui <rui.zhang@intel.com>
> >>Cc: Eduardo Valentin <edubezval@gmail.com>
> >>Cc: linux-pm@vger.kernel.org
> >>
> >>---
> >>
> >>Changes in v2:
> >>- update the sysfs-api.txt for set_trips
> >>
> >>  Documentation/thermal/sysfs-api.txt |  7 +++++
> >>  drivers/thermal/thermal_core.c      | 52 ++++++++++++++++++++++++=
+++++++++++++
> >>  include/linux/thermal.h             |  3 +++
> >>  3 files changed, 62 insertions(+)
> <cut..>
> >>+	/*
> >>+	 * Set a temperature window. When this window is left the driver
> >>+	 * must inform the thermal core via thermal_zone_device_update.
> >>+	 */
> >>+	ret =3D tz->ops->set_trips(tz, low, high);
> >>+	if (ret)
> >>+		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
> >This function can be called at the same time from multiple places so
> >it should be reentrant.  I think you should call mutex_lock(tz->lock=
)
> >before "if (tz->prev_low_trip =3D=3D low && ..." and unlock it here.
>=20
> Sound reasonable, fixes it in next version.
>=20
> >>+}
> >>+
> >>  static void update_temperature(struct thermal_zone_device *tz)
> >>  {
> >>  	int temp, ret;
> >>@@ -569,6 +614,8 @@ void thermal_zone_device_update(struct thermal_=
zone_device *tz)
> >>  	update_temperature(tz);
> >>+	thermal_zone_set_trips(tz);
> >>+
> >>  	for (count =3D 0; count < tz->trips; count++)
> >>  		handle_thermal_trip(tz, count);
> >>  }
> >>@@ -754,6 +801,9 @@ trip_point_hyst_store(struct device *dev, struc=
t device_attribute *attr,
> >>  	 */
> >>  	ret =3D tz->ops->set_trip_hyst(tz, trip, temperature);
> >>+	if (!ret)
> >>+		thermal_zone_set_trips(tz);
> >>+
> >You should add a similar call to thermal_zone_set_trips() in trip_po=
int_temp_store()
>=20
> No, this patch has been done.
>=20
> if you see the linux next kernel.
> 72f3ada UPSTREAM: thermal: trip_point_temp_store() calls
> thermal_zone_device_update()
>=20
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -733,8 +733,12 @@ trip_point_temp_store(struct device *dev,
> struct device_attribute *attr,
> return -EINVAL;
>=20
> ret =3D tz->ops->set_trip_temp(tz, trip, temperature);
> + if (ret)
> + return ret;
>=20
> - return ret ? ret : count;
> + thermal_zone_device_update(tz);
> +
> + return count;
> }
>=20
> So the "thermal_zone_set_trips(tz)" have been set in
> thermal_zone_device_update.

Ah, right, I missed that.  Thanks!
Javi
