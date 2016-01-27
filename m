From: =?iso-8859-1?Q?St=E9phan?= Kochen <stephan-j6uo2F6POYhmR6Xm/wNWPw@public.gmane.org>
Subject: Interrupt driven thermal OF sensors (was: [PATCH 2/3] lm90:
 initialize parameters from devicetree)
Date: Wed, 27 Jan 2016 22:18:53 +0100
Message-ID: <20160127211853.GA28555@Stephans-iMac.lan>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-3-git-send-email-stephan@kochen.nl>
 <56A24278.8050909@roeck-us.net>
 <20160122223238.GB21534@Stephans-iMac.lan>
 <56A2EB3E.4080002@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56A2EB3E.4080002-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 22, 2016 at 06:53:50PM -0800, Guenter Roeck wrote:
> The thermal subsystem supports setting trip points, which I would thi=
nk
> is what you are looking for here. Question is if an how you can use t=
he
> information from the thermal subsystem (and thus the thermal zone con=
figuration)
> to set the various limits in the lm90 driver. This should hopefully b=
e sufficient
> to fix your immediate problem. For handling alerts, I guess we'll hav=
e to wait for
> thermal subsystem improvements (unless of course you volunteer to do =
that work.

I may take a shot at this. So in short, the goal is to have a device
tree thermal zone communicate trip points to the sensor driver, and use
interrupts to act on trips.

(This indirectly solves my problem of my sensor having weird initial
values. Perhaps we also want a solution for this case if the thermal
subsystem is disabled, but for me there'd be no need.)

Here's what I see:

 - The thermal core layer already supports interrupt driven systems.
   Support is missing from thermal OF, the layer between thermal core
   and the sensor driver implementing device tree support.

 - Thermal OF registers a device in thermal core for each zone defined
   in the device tree.

 - In theory, a thermal zone in the device tree can have multiple
   sensors, and multiple zones can refer to the same sensor, but the
   current implementation only supports 1-on-1 relations.

 - There are already exports thermal_zone_device_update and
   thermal_notify_framework in thermal core, which allow external code
   to trigger an update.

 - Updates happen by explicit calls to such exports, or by an optional
   and configurable interval in thermal core.

What I think we want:

 - Any additions should be optional extensions implemented by sensor
   drivers. Polling should keep on working for all sensor drivers
   already supporting thermal OF, with no interface changes.

 - For interrupt-capable sensor drivers, the thermal OF device should
   keep the sensor driver updated with the current nearest trip
   temperature and hysteresis. (Don't burden drivers with a full list o=
f
   trip points.)

 - In the case of LM90, this would set the low and high alert
   temperatures. LM90 can have additional alerts (critical, emergency),
   but a sensor driver registered with thermal OF should disable any
   additional alerts.

 - Similarly, a sensor driver should disable alerts when there is no
   current trip temperature or hysteresis. (E.g., we're below the lowes=
t
   trip point.)

Implementation-wise:

 - The struct thermal_zone_of_device_ops needs an additional function t=
o
   set the current sensor trip temperature and hysteresis. Presence of
   this function indicates the sensor driver has interrupt support.

 - The thermal OF device will call this function every time the
   temperature slides across trip points. (Or when trip points are
   altered.)

 - The thermal OF device should ignore the polling delay (set it to 0)
   if its sensor has interrupt support. (In this case, we can also make
   polling-delay optional. It's currently required in the device tree.)

 - On interrupt, the sensor driver should call
   thermal_zone_device_update with its thermal_zone_device, as returned
   by thermal_zone_of_sensor_register.

My only concern is that I don't understand kernel contexts and interrup=
t
handling well enough. It looks like at least its up to the sensor drive=
r
to ensure calls into the thermal subsystem have long left the hardware
interrupt context, which I think should be sufficient.

Hoping all of this sounds about right!

--=20
St=E9phan Kochen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
