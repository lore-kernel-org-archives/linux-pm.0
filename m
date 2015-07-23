From: Mason <slash.tmp@free.fr>
Subject: Re: Using a temperature sensor with 1-bit output for CPU throttling
Date: Thu, 23 Jul 2015 11:19:33 +0200
Message-ID: <55B0B1A5.9000909@free.fr>
References: <553F6E85.5090402@free.fr> <5540E0E1.6080504@free.fr> <20150429163605.GM3054@e104805> <55AE0C7F.40506@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090900010600000702030502"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:18463 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbbGWJTo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jul 2015 05:19:44 -0400
In-Reply-To: <55AE0C7F.40506@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel <amit.daniel@samsung.com>, Andrew Lunn <andrew@lunn.ch>, Lukasz Majewski <l.majewski@samsung.com>

This is a multi-part message in MIME format.
--------------090900010600000702030502
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/07/2015 11:10, Mason wrote:

> I don't think I want on/off behavior. I want CPU throttling when
> the temperature rises above a user-defined value.
> 
> I'm stuck with kernel 3.14, so I don't have all the governors to
> choose from. I picked "step-wise".

I think the attached driver does what I want. (If anyone wants to
comment on the code, I'd be delighted to hear their suggestions!
Especially if there's a better way to do something.)

When the CPU temperature exceeds a user-defined threshold (default
120 °C) the maximum frequency is disabled for all cores (they are
in the same clock domain), and the system will only run at F/2
(at most) until the temperature dips below the threshold.

Does the cpu_cooling driver written by Amit Daniel also support
disabling/off-lining entire cores in multi-core systems, not just
throttling the frequency of the cores?

Regards.


--------------090900010600000702030502
Content-Type: text/x-csrc;
 name="tango_thermal.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tango_thermal.c"

#include <linux/module.h>
#include <linux/io.h>		// readl_relaxed, writel_relaxed
#include <linux/cpu_cooling.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Sigma Designs");
MODULE_DESCRIPTION("Tango CPU throttling");

/*** CPU TEMPERATURE SENSOR ***/
#define SENSOR_ADDR 0x920100
static struct thermal_cooling_device *tcdev;
static struct thermal_zone_device *tzdev;
static void __iomem *sensor_base;
static unsigned int threshold;

#define TEMPSI_CMD	sensor_base + 0
#define TEMPSI_RES	sensor_base + 4
#define TEMPSI_CFG	sensor_base + 8
#define SENSOR_IDLE	(readl_relaxed(TEMPSI_CMD) & 0x80)
#define IDX_OFFSET	18

static const u8 temperature[] = {
	 37,  41,  46,  51,  55,  60,  64,  69,
	 74,  79,  83,  88,  93,  97, 101, 106,
	110, 115, 120, 124, 129, 133, 137, 142,
};

typedef struct thermal_zone_device TZD;

static int tango_get_temp(TZD *tz, unsigned long *res)
{
	int i;

	for (i = IDX_OFFSET; i < 40; ++i)
	{
		writel_relaxed(i << 8 | 2, TEMPSI_CMD);
		while (!SENSOR_IDLE);
		if (readl_relaxed(TEMPSI_RES) == 0) break;
	}

	*res = temperature[i - IDX_OFFSET] * 1000;
	return 0;
}

static int tango_bind(TZD *tz, struct thermal_cooling_device *cdev)
{
	/*
	 * Disable max frequency when CPU temperature exceeds trip point
	 * by setting upper and lower cooling states to 1
	 */
	return thermal_zone_bind_cooling_device(tz, 0, cdev, 1, 1);
}

static int tango_unbind(TZD *tz, struct thermal_cooling_device *cdev)
{
	return thermal_zone_unbind_cooling_device(tz, 0, cdev);
}

static int tango_get_trip_type(TZD *tz, int idx, enum thermal_trip_type *res)
{
	*res = THERMAL_TRIP_PASSIVE;
	return 0;
}

static int tango_get_trip_temp(TZD *tz, int idx, unsigned long *res)
{
	*res = threshold;
	return 0;
}

static int tango_set_trip_temp(TZD *tz, int idx, unsigned long res)
{
	threshold = res;
	return 0;
}

static struct thermal_zone_device_ops ops = {
	.bind		= tango_bind,
	.unbind		= tango_unbind,
	.get_temp	= tango_get_temp,
	.get_trip_type	= tango_get_trip_type,
	.get_trip_temp	= tango_get_trip_temp,
	.set_trip_temp	= tango_set_trip_temp,
};

static int ts_init(void)
{
	threshold = 120000; // millidegrees Celsius
	sensor_base = ioremap(SENSOR_ADDR, 16);
	writel_relaxed( 1, TEMPSI_CMD);
	writel_relaxed(50, TEMPSI_CFG);
	tcdev = cpufreq_cooling_register(cpu_present_mask);
	tzdev = thermal_zone_device_register("tango_thermal", 1, 1, NULL, &ops, NULL, 1000, 2000);
	return 0;
}

static void __exit ts_cleanup(void)
{
	thermal_zone_device_unregister(tzdev);
	cpufreq_cooling_unregister(tcdev);
	writel_relaxed(0, TEMPSI_CFG);
	writel_relaxed(0, TEMPSI_CMD);
}

module_init(ts_init);
module_exit(ts_cleanup);

--------------090900010600000702030502--
