From: Mason <slash.tmp@free.fr>
Subject: Re: Using a temperature sensor with 1-bit output for CPU throttling
Date: Tue, 21 Jul 2015 11:10:23 +0200
Message-ID: <55AE0C7F.40506@free.fr>
References: <553F6E85.5090402@free.fr> <5540E0E1.6080504@free.fr> <20150429163605.GM3054@e104805>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040903000300040203090205"
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20150429163605.GM3054@e104805>
Sender: cpufreq-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel <amit.daniel@samsung.com>, Andrew Lunn <andrew@lunn.ch>, Radhesh Fadnis <radhesh.fadnis@ti.com>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------040903000300040203090205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

I've made some progress (in that the system at least prints *something*)

On 29/04/2015 18:36, Javi Merino wrote:

> Your temperature sensor would be the input to the thermal zone
> device.  You register it with thermal_zone_device_register().  See
> Documentation/thermal/sysfs-api.txt .

My .bind() callback is:

static int tango_bind(struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
{
  return thermal_zone_bind_cooling_device(tz, 0, cdev, 4, 1);
}

I'm not sure I completely understand the last two parameters
(upper and lower).

    upper:the Maximum cooling state for this trip point.
          THERMAL_NO_LIMIT means no upper limit,
	  and the cooling device can be in max_state.

    lower:the Minimum cooling state can be used for this trip point.
          THERMAL_NO_LIMIT means no lower limit,
	  and the cooling device can be in cooling state 0.


My cpufreq driver exposes 5 frequencies, in this order:
F, F/2, F/3, F/5, F/9

So cooling state = 1 means 'F' is forbidden, right?
Thus the on-demand cpufreq governor is free to pick among
{F/2, F/3, F/5, F/9} ?

And cooling state = 4 means only F/9 is allowed?

> Your thermal sensor
> doesn't actually report temperature but the thermal framework expects
> a temperature, so your thermal zone's get_temp() function should
> report a fake temperature.  For example, if you've configure your
> sensor for 50C, then you could report 45C if the sensor reads as 0 and
> 50C if the sensor reads as 1.  It's a hack, but it should work.  Bear
> in mind that get_temp() should report in millicelsius.

Actually, I can get a rough estimate of the current temperature
by querying the sensor multiple times.

> Because you want on/off behavior, the bangbang governor is the
> simplest to use and should do the work.  You can choose as the default
> in your kernel configuration or you can choose it by passing it as
> part of the tzp that you pass to thermal_zone_device_register()
> 
> Put a trip point at the temperature you've set up your sensor to and
> bind the cpu cooling device to it.

I don't think I want on/off behavior. I want CPU throttling when the
temperature rises above a user-defined value.

I'm stuck with kernel 3.14, so I don't have all the governors to
choose from. I picked "step-wise".

I don't understand this behavior from the governor:

[   27.557494] thermal thermal_zone0: last_temperature=0, current_temperature=51000
[   27.583626] thermal thermal_zone0: Trip0[type=1,temp=70000]:trend=1,throttle=0
[   27.590961] thermal cooling_device0: cur_state=0
[   27.595672] thermal cooling_device0: old_target=-1, target=-1
[   27.601473] thermal cooling_device0: zone0->target=4294967295
[   27.607263] thermal cooling_device0: set to state 0

[   40.643340] thermal thermal_zone0: last_temperature=51000, current_temperature=46000
[   40.669930] thermal thermal_zone0: Trip0[type=1,temp=70000]:trend=2,throttle=0
[   40.677217] thermal cooling_device0: cur_state=0
[   40.681873] thermal cooling_device0: old_target=-1, target=4
[   40.687579] thermal cooling_device0: zone0->target=4
[   40.692669] thermal cooling_device0: set to state 4

The first temperature read = 51°C (below the 70°C trip point).
Next read = 46°C (still below the trip point) and even though
the governor claims throttle=0, it sets the cooling state to 4
(so minimal frequency if I understand correctly).

What am I missing?

I've attached my work-in-progress driver for reference.

Regards.


--------------040903000300040203090205
Content-Type: text/x-csrc;
 name="temperature.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="temperature.c"

#include <linux/module.h>
#include <linux/io.h>		// readl_relaxed, writel_relaxed
#include <linux/cpu_cooling.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Tango CPU throttling");

/*** CPU TEMPERATURE SENSOR ***/
#define SENSOR_ADDR 0x920100
static void __iomem *sensor_base;

#define TEMPSI_CMD	sensor_base + 0
#define TEMPSI_RES	sensor_base + 4
#define TEMPSI_CFG	sensor_base + 8

static const u8 temperature[] = {
	46, 51, 55, 60, 64, 69, 74, 79, 83, 88, 93, 97, 101, 106, 110, 115, 120, 124, 129, 133, 137,
};

static int tango_get_temp(struct thermal_zone_device *tz, unsigned long *res)
{
	int i;

	for (i = 20; i < 40; ++i)
	{
		writel_relaxed(i << 8 | 2, TEMPSI_CMD);
		while ((readl_relaxed(TEMPSI_CMD) & 0x80) == 0);
		if (readl_relaxed(TEMPSI_RES) == 0) break;
	}

	*res = temperature[i-20] * 1000;
	return 0;
}

static int tango_bind(struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
{
	return thermal_zone_bind_cooling_device(tz, 0, cdev, 4, 1);
}

static int tango_get_trip_type(struct thermal_zone_device *tz, int idx, enum thermal_trip_type *res)
{
	if (idx != 0) return -EINVAL;
	*res = THERMAL_TRIP_PASSIVE;
	return 0;
}

static int tango_get_trip_temp(struct thermal_zone_device *tz, int idx, unsigned long *res)
{
	if (idx != 0) return -EINVAL;
	*res = 70000;
	return 0;
}

static struct thermal_zone_device_ops ops = {
	.bind		= tango_bind,
	.get_temp	= tango_get_temp,
	.get_mode = 0,
	.get_trip_type	= tango_get_trip_type,
	.get_trip_temp	= tango_get_trip_temp,
};

static struct thermal_cooling_device *cdev;
static struct thermal_zone_device *tzdev;

static int ts_init(void)
{
	sensor_base = ioremap(SENSOR_ADDR, 16);
	writel_relaxed( 1, TEMPSI_CMD);
	writel_relaxed(50, TEMPSI_CFG);
	cdev = cpufreq_cooling_register(cpu_present_mask);
	tzdev = thermal_zone_device_register("tango_tz", 1, 0, NULL, &ops, NULL, 5000, 13000);
	return 0;
}

static void __exit ts_cleanup(void) { return; }

module_init(ts_init);
module_exit(ts_cleanup);

--------------040903000300040203090205--
