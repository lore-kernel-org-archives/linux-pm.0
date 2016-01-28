From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Interrupt driven thermal OF sensors
Date: Wed, 27 Jan 2016 21:05:08 -0800
Message-ID: <56A9A184.90001@roeck-us.net>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-3-git-send-email-stephan@kochen.nl>
 <56A24278.8050909@roeck-us.net> <20160122223238.GB21534@Stephans-iMac.lan>
 <56A2EB3E.4080002@roeck-us.net> <20160127211853.GA28555@Stephans-iMac.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44378 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbcA1FFR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 00:05:17 -0500
In-Reply-To: <20160127211853.GA28555@Stephans-iMac.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?St=c3=a9phan_Kochen?= <stephan@kochen.nl>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, lm-sensors@lm-sensors.org, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On 01/27/2016 01:18 PM, St=E9phan Kochen wrote:
> On Fri, Jan 22, 2016 at 06:53:50PM -0800, Guenter Roeck wrote:
>> The thermal subsystem supports setting trip points, which I would th=
ink
>> is what you are looking for here. Question is if an how you can use =
the
>> information from the thermal subsystem (and thus the thermal zone co=
nfiguration)
>> to set the various limits in the lm90 driver. This should hopefully =
be sufficient
>> to fix your immediate problem. For handling alerts, I guess we'll ha=
ve to wait for
>> thermal subsystem improvements (unless of course you volunteer to do=
 that work.
>
> I may take a shot at this. So in short, the goal is to have a device
> tree thermal zone communicate trip points to the sensor driver, and u=
se
> interrupts to act on trips.
>
> (This indirectly solves my problem of my sensor having weird initial
> values. Perhaps we also want a solution for this case if the thermal
> subsystem is disabled, but for me there'd be no need.)
>
> Here's what I see:
>
>   - The thermal core layer already supports interrupt driven systems.
>     Support is missing from thermal OF, the layer between thermal cor=
e
>     and the sensor driver implementing device tree support.
>
>   - Thermal OF registers a device in thermal core for each zone defin=
ed
>     in the device tree.
>
>   - In theory, a thermal zone in the device tree can have multiple
>     sensors, and multiple zones can refer to the same sensor, but the
>     current implementation only supports 1-on-1 relations.
>
>   - There are already exports thermal_zone_device_update and
>     thermal_notify_framework in thermal core, which allow external co=
de
>     to trigger an update.
>
>   - Updates happen by explicit calls to such exports, or by an option=
al
>     and configurable interval in thermal core.
>
> What I think we want:
>
>   - Any additions should be optional extensions implemented by sensor
>     drivers. Polling should keep on working for all sensor drivers
>     already supporting thermal OF, with no interface changes.
>
>   - For interrupt-capable sensor drivers, the thermal OF device shoul=
d
>     keep the sensor driver updated with the current nearest trip
>     temperature and hysteresis. (Don't burden drivers with a full lis=
t of
>     trip points.)
>
>   - In the case of LM90, this would set the low and high alert
>     temperatures. LM90 can have additional alerts (critical, emergenc=
y),
>     but a sensor driver registered with thermal OF should disable any
>     additional alerts.
>
=2E.. and thus disable any external chip signals associated with those =
limits.

>   - Similarly, a sensor driver should disable alerts when there is no
>     current trip temperature or hysteresis. (E.g., we're below the lo=
west
>     trip point.)
>

The idea with most if not all temperature sensors is that multiple trip=
 points
would be configured as multiple limits in the chip. Often those limits,
when reached, are tied to pins to cause a specific action (eg to cause
an interrupt, turn on a fan, or shut down the hardware). In effect, you
suggest to re-define this mechanism and, for all practical purposes,
use just one of the limits provided by the chip(s).

Personally I don't think that would be a good idea, because it would ha=
ve
impact on hardware design. It would effectively limit the use of the th=
ermal
subsystem with temperature sensor chips to hardware designs which take
the thermal subsystem's expectations and assumptions into account.
At the same time, it would for all practical purposes mandate the use
of the thermal subsystem on such systems, because the hardware would de=
pend
on the thermal subsystem's implementation to control the temperature
in the system.

While it may be feasible in some situations to have the thermal subsyst=
em
dynamically set free-moving limits, there are many other situations whe=
re
those limits are tied to hardware responses, and the limits need to be =
static.

Maybe this is just a different world view. The thermal subsystem may se=
e the
world assuming that it always has an unlimited number of trip points av=
ailable,
and the chip it supports only support lower and upper boundaries (or tr=
ip points),
which can be set and changed as needed. This is somewhat different to t=
he
traditional world view, implemented not only in many temperature sensor=
s,
but also in fan controller or Super-IO chips, where a set of temperatur=
es
is programmed into the chip only once. I hope that it is possible to su=
pport
both mechanisms.

Thanks,
Guenter

> Implementation-wise:
>
>   - The struct thermal_zone_of_device_ops needs an additional functio=
n to
>     set the current sensor trip temperature and hysteresis. Presence =
of
>     this function indicates the sensor driver has interrupt support.
>
>   - The thermal OF device will call this function every time the
>     temperature slides across trip points. (Or when trip points are
>     altered.)
>
>   - The thermal OF device should ignore the polling delay (set it to =
0)
>     if its sensor has interrupt support. (In this case, we can also m=
ake
>     polling-delay optional. It's currently required in the device tre=
e.)
>
>   - On interrupt, the sensor driver should call
>     thermal_zone_device_update with its thermal_zone_device, as retur=
ned
>     by thermal_zone_of_sensor_register.
>
> My only concern is that I don't understand kernel contexts and interr=
upt
> handling well enough. It looks like at least its up to the sensor dri=
ver
> to ensure calls into the thermal subsystem have long left the hardwar=
e
> interrupt context, which I think should be sufficient.
>
> Hoping all of this sounds about right!
>

