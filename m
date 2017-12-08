From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: no hwmon entries in sysfs for thermal on raspberry pi 1b
Date: Fri, 8 Dec 2017 13:01:19 -0800
Message-ID: <20171208210119.GA3875@roeck-us.net>
References: <20171208195308.b7mq43ejegmzjlbi@falbala.home.lespocky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171208195308.b7mq43ejegmzjlbi@falbala.home.lespocky.de>
Sender: linux-hwmon-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 08, 2017 at 08:53:10PM +0100, Alexander Dahl wrote:
> Hei hei,
> 
> I have v4.15-rc2 vanilla running on the original Raspberry Pi 1B aka
> bcm2835 (not rev2, not the 1B+ or plus), compiled with ptxdist /
> DistroKit, using bcm2835-rpi-b.dts from arch/arm/boot/dts as device
> tree file. I try to get temperature values from the SoC with
> lm-sensors (for using it in some other project). After reading an
> issue report on the lm-sensors github project [1] I checked my kernel
> config. The following is set:
> 
>     CONFIG_HWMON=y
>     CONFIG_THERMAL_HWMON=y
>     CONFIG_THERMAL=y
>     CONFIG_THERMAL_OF=y
>     CONFIG_BCM2835_THERMAL=y
> 
> There's one thermal zone in sysfs and I get some temperature which I
> suppose is the temp of the SoC in m°C:
> 
>     root@DistroKit:~ cat /sys/class/thermal/thermal_zone0/temp 
>     42236
> 
> However, there's nothing below /sys/class/hwmon and I'm wondering why.
> There's a thermal zone named 'cpu-thermal' defined and active in DT.
> 
> I tried to read some driver code and as far as I understood
> thermal_add_hwmon_sysfs() must be called somewhere to get entries for
> hwmon in sysfs, and this is done in thermal_zone_device_register(), so
> probably a thermal zone must be present somehow, but it seems to be,
> at least I can read temp values from it.
> 
> What piece am I missing? Is it some kind of configuration I did wrong?
> 
On devicetree systems, the thermal subsystem initializes thermal zones with
of_parse_thermal_zones(). This function explicitly disables registration of
thermal zone sensors as hwmon devices because it _could_ be that the
thermal zone sensor is registered through hwmon.

of_parse_thermal_zones() runs independently of the actual thermal sensor
registration at boot time, so thermal drivers registering their sensors
using thermal_zone_of_sensor_register() don't really have a choice or
means to tell the thermal subsystem otherwise. This affects all drivers
which register a thermal zone with thermal_zone_of_sensor_register();
they simply won't register as hwmon devices.

I don't know a feasible solution at this time. There was a proposal to
introduce a new devicetree property, but that would be Linux specific and
also risky (it could be wrongly selected for a sensor which _does_ register
through hwmon).

Guenter
