From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: add APDS9960 ALS + promixity driver
Date: Sun, 19 Jul 2015 18:56:52 -0700
Message-ID: <CAKzfze_2wchApiDHRaCWTgRWL_eep42hOdyXHnrE4Ox6UVxK5A@mail.gmail.com>
References: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
	<1436754043-6232-3-git-send-email-mranostay@gmail.com>
	<55AB7FBE.1060707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32795 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbbGTB4x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jul 2015 21:56:53 -0400
In-Reply-To: <55AB7FBE.1060707@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, linux-pm@vger.kernel.org

On Sun, Jul 19, 2015 at 3:45 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 13/07/15 03:20, Matt Ranostay wrote:
>> APDS9960 is a combination of ALS, proximity, and gesture sensors.
>>
>> This patch adds support for these functions along with gain control,
>> integration time, and event thresholds.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> Mostly looking good.  You don't need to repeat standard docs and there
> are a few bits and pieces inline.
>
> Jonathan
>> ---
>>  .../ABI/testing/sysfs-bus-iio-light-apds9960       |  128 +++
>>  drivers/iio/light/Kconfig                          |   12 +
>>  drivers/iio/light/Makefile                         |    1 +
>>  drivers/iio/light/apds9960.c                       | 1208 ++++++++++++++++++++
>>  4 files changed, 1349 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
>>  create mode 100644 drivers/iio/light/apds9960.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-apds9960 b/Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
>> new file mode 100644
>> index 0000000..010b8c8
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
>> @@ -0,0 +1,128 @@
> As a general rule, don't document any attributes covered by more generic
> docs.  Just leads to more ways to have out of date documentation!
>> +What:                /sys/bus/iio/devices/triggerX/name = "apds9960-gestureX"
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             The APDS9960 kernel module provides a trigger which enables
>> +             the gesture engine that pushes motion data to the buffer when
>> +             it becomes available.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_proximity0_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the non-gesture proximity sensor value.
> Looks like the generic docs need a wild card indexed version of these added
> (curriously the 0 index channel is there which makes no sense without allowing
> for higher indexes).
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_proximity1_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the UP gesture photodiode proximity value.
>> +             Access is disabled to prevent the side effect of
>> +             userspace clearing the hardware FIFO.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_proximity2_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the DOWN gesture photodiode proximity value.
>> +             Access is disabled to prevent the side effect of
>> +             userspace clearing the hardware FIFO.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_proximity3_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the LEFT gesture photodiode proximity value.
>> +             Access is disabled to prevent the side effect of
>> +             userspace clearing the hardware FIFO.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_proximity4_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the RIGHT gesture photodiode proximity value.
>> +             Access is disabled to prevent the side effect of
>> +             userspace clearing the hardware FIFO.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the current unprocessed illuminance for the clear/ALS
>> +             photodiode.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the current unprocessed illuminance value for the
>> +             red light wavelength photodiode.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the current unprocessed illuminance value for the
>> +             green light wavelength photodiode.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the current unprocessed illuminance value for the
>> +             blue light wavelength photodiode.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/integration_time_available
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Provide allowed integration time values in fractions of a second
>> +             for the ALS + RGB sensor engines.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_intensity_integration_time
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Set integration time in fractions of a second for the ALS + RGB
>> +             sensor engines.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/proximity_scale_available
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Provide the allowed gain values for the proximity + gesture
>> +             engines.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_proximity_scale
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Set the gain value for the proximity + gesture engines.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/intensity_scale_available
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Provide the allowed gain values for the ALS + RGB sensor
>> +             engines.
>> +
>> +What         /sys/bus/iio/devices/iio:deviceX/in_intensity_scale
>> +Date:                July 2015
>> +KernelVersion:       4.2
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Set the gain value for the ALS + RGB sensor engines.
> Nothing at all in here is non standard, so as things currently stand
> you don't need the additional ABI document.
>>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index e6198b7..6a4a47c7 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -50,6 +50,18 @@ config APDS9300
>>        To compile this driver as a module, choose M here: the
>>        module will be called apds9300.
>>
>> +config APDS9960
>> +     tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
>> +     select IIO_BUFFER
> missing regmap_i2c dependency.
>> +     select IIO_TRIGGERED_BUFFER
>> +     depends on I2C
>> +     help
>> +       Say Y here to build I2C interface support for the Avago
>> +       APDS9960 gesture/RGB/ALS/proximity sensor.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called apds9960
>> +
>>  config BH1750
>>       tristate "ROHM BH1750 ambient light sensor"
>>       depends on I2C
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index e2d50fd..0189ac7 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_ACPI_ALS)                += acpi-als.o
>>  obj-$(CONFIG_ADJD_S311)              += adjd_s311.o
>>  obj-$(CONFIG_AL3320A)                += al3320a.o
>>  obj-$(CONFIG_APDS9300)               += apds9300.o
>> +obj-$(CONFIG_APDS9960)               += apds9960.o
>>  obj-$(CONFIG_BH1750)         += bh1750.o
>>  obj-$(CONFIG_CM32181)                += cm32181.o
>>  obj-$(CONFIG_CM3232)         += cm3232.o
>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>> new file mode 100644
>> index 0000000..39de418
>> --- /dev/null
>> +++ b/drivers/iio/light/apds9960.c
>> @@ -0,0 +1,1208 @@
>> +/*
>> + * apds9960.c - Support for Avago APDS9960 gesture/RGB/ALS/proximity sensor
>> + *
>> + * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * TODO: gesture + proximity calib offsets
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/err.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/i2c.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/of_gpio.h>
>> +
>> +#define APDS9960_REGMAP_NAME "apds9960_regmap"
>> +#define APDS9960_DRV_NAME    "apds9960"
>> +
>> +#define APDS9960_REG_RAM_START       0x00
>> +#define APDS9960_REG_RAM_END 0x7f
>> +
>> +#define APDS9960_REG_ENABLE  0x80
>> +#define APDS9960_REG_ENABLE_PON              BIT(0)
>> +
>> +#define APDS9960_REG_ATIME   0x81
>> +#define APDS9960_REG_WTIME   0x83
>> +
>> +#define APDS9960_REG_AILTL   0x84
>> +#define APDS9960_REG_AILTH   0x85
>> +#define APDS9960_REG_AIHTL   0x86
>> +#define APDS9960_REG_AIHTH   0x87
>> +
>> +#define APDS9960_REG_PILT    0x89
>> +#define APDS9960_REG_PIHT    0x8b
>> +#define APDS9960_REG_PERS    0x8c
>> +
>> +#define APDS9960_REG_CONFIG_1        0x8d
>> +#define APDS9960_REG_PPULSE  0x8e
>> +
>> +#define APDS9960_REG_CONTROL 0x8f
>> +#define APDS9960_REG_CONTROL_AGAIN_MASK              0x03
>> +#define APDS9960_REG_CONTROL_PGAIN_MASK              0x0c
>> +#define APDS9960_REG_CONTROL_AGAIN_MASK_SHIFT        0
>> +#define APDS9960_REG_CONTROL_PGAIN_MASK_SHIFT        2
>> +
>> +#define APDS9960_REG_CONFIG_2        0x90
>> +#define APDS9960_REG_CONFIG_2_GGAIN_MASK     0x60
>> +#define APDS9960_REG_CONFIG_2_GGAIN_MASK_SHIFT       5
>> +
>> +#define APDS9960_REG_ID              0x92
>> +
>> +#define APDS9960_REG_STATUS  0x93
>> +#define APDS9960_REG_STATUS_PS_INT   BIT(5)
>> +#define APDS9960_REG_STATUS_ALS_INT  BIT(4)
>> +#define APDS9960_REG_STATUS_GINT     BIT(2)
>> +
>> +#define APDS9960_REG_PDATA   0x9c
>> +#define APDS9960_REG_POFFSET_UR      0x9d
>> +#define APDS9960_REG_POFFSET_DL 0x9e
>> +#define APDS9960_REG_CONFIG_3        0x9f
>> +
>> +#define APDS9960_REG_GPENTH  0xa0
>> +#define APDS9960_REG_GEXTH   0xa1
>> +
>> +#define APDS9960_REG_GCONF_1 0xa2
>> +#define APDS9960_REG_GCONF_1_GFIFO_THRES_MASK                0xc0
>> +#define APDS9960_REG_GCONF_1_GFIFO_THRES_MASK_SHIFT  6
>> +
>> +#define APDS9960_REG_GCONF_2 0xa3
>> +#define APDS9960_REG_GOFFSET_U       0xa4
>> +#define APDS9960_REG_GOFFSET_D       0xa5
>> +#define APDS9960_REG_GPULSE  0xa6
>> +#define APDS9960_REG_GOFFSET_L       0xa7
>> +#define APDS9960_REG_GOFFSET_R       0xa9
>> +#define APDS9960_REG_GCONF_3 0xaa
>> +
>> +#define APDS9960_REG_GCONF_4 0xab
>> +#define APDS9960_REG_GFLVL   0xae
>> +#define APDS9960_REG_GSTATUS 0xaf
>> +
>> +#define APDS9960_REG_IFORCE  0xe4
>> +#define APDS9960_REG_PICLEAR 0xe5
>> +#define APDS9960_REG_CICLEAR 0xe6
>> +#define APDS9960_REG_AICLEAR 0xe7
>> +
>> +#define APDS9960_DEFAULT_PERS        0x33
>> +#define APDS9960_DEFAULT_GPENTH      0x50
>> +#define APDS9960_DEFAULT_GEXTH       0x40
>> +
>> +#define APDS9960_MAX_INT_TIME_IN_US  1000000
>> +
>> +enum apds9960_als_channel_idx {
>> +     IDX_ALS_CLEAR, IDX_ALS_RED, IDX_ALS_GREEN, IDX_ALS_BLUE,
>> +};
>> +
>> +#define APDS9960_REG_ALS_BASE        0x94
>> +#define APDS9960_REG_ALS_CHANNEL(_colour) \
>> +     (APDS9960_REG_ALS_BASE + (IDX_ALS_##_colour * 2))
>> +
>> +enum apds9960_gesture_channel_idx {
>> +     IDX_DIR_UP, IDX_DIR_DOWN, IDX_DIR_LEFT, IDX_DIR_RIGHT,
>> +};
>> +
>> +#define APDS9960_REG_GFIFO_BASE      0xfc
>> +#define APDS9960_REG_GFIFO_DIR(_dir) \
>> +     (APDS9960_REG_GFIFO_BASE + IDX_DIR_##_dir)
>> +
>> +struct apds9960_data {
>> +     struct i2c_client *client;
>> +     struct iio_trigger *trig;
>> +     struct iio_dev *indio_dev;
>> +     struct mutex lock;
>> +
>> +     /* regmap fields */
>> +     struct regmap *regmap;
>> +     struct regmap_field *reg_int_als;
>> +     struct regmap_field *reg_int_ges;
>> +     struct regmap_field *reg_int_pxs;
>> +
>> +     struct regmap_field *reg_enable_als;
>> +     struct regmap_field *reg_enable_ges;
>> +     struct regmap_field *reg_enable_pxs;
>> +
>> +     /* state */
>> +     int als_int;
>> +     int pxs_int;
>> +     int gesture_mode_running;
>> +
>> +     /* gain values */
>> +     int als_gain;
>> +     int pxs_gain;
>> +
>> +     /* integration time value in us */
>> +     int als_adc_int_us;
>> +
>> +     /* gesture buffer */
>> +     u8 buffer[16]; /* 4 8-bit channels + 64-bit timestamp */
>> +};
>> +
>> +static const struct reg_default apds9960_reg_defaults[] = {
>> +     { APDS9960_REG_ATIME,           0xff },
> Could you add some explantion of these.
>> +     { APDS9960_REG_WTIME,           0xff },
>> +     { APDS9960_REG_CONFIG_1,        0x40 },
> Where it can be defined in terms of other various elements, please break
> them down.  Particuarly true, when as with the above, the bit being set
> looks to be marked reserved but so are other bits in that register...
>
>> +     { APDS9960_REG_CONFIG_2,        0x01 },
>> +     { APDS9960_REG_PPULSE,          0x40 },
>> +     { APDS9960_REG_GPULSE,          0x40 },
>> +};
>> +
>> +static const struct regmap_range apds9960_volatile_ranges[] = {
>> +     regmap_reg_range(APDS9960_REG_STATUS,
>> +                             APDS9960_REG_PDATA),
>> +     regmap_reg_range(APDS9960_REG_GFLVL,
>> +                             APDS9960_REG_GSTATUS),
>> +     regmap_reg_range(APDS9960_REG_GFIFO_DIR(UP),
>> +                             APDS9960_REG_GFIFO_DIR(RIGHT)),
>> +     regmap_reg_range(APDS9960_REG_IFORCE,
>> +                             APDS9960_REG_AICLEAR),
>> +};
>> +
>> +static const struct regmap_access_table apds9960_volatile_table = {
>> +     .yes_ranges     = apds9960_volatile_ranges,
>> +     .n_yes_ranges   = ARRAY_SIZE(apds9960_volatile_ranges),
>> +};
>> +
>> +static const struct regmap_range apds9960_precious_ranges[] = {
>> +     regmap_reg_range(APDS9960_REG_RAM_START, APDS9960_REG_RAM_END),
>> +};
>> +
>> +static const struct regmap_access_table apds9960_precious_table = {
>> +     .yes_ranges     = apds9960_precious_ranges,
>> +     .n_yes_ranges   = ARRAY_SIZE(apds9960_precious_ranges),
>> +};
>> +
>> +static const struct regmap_range apds9960_readable_ranges[] = {
>> +     regmap_reg_range(APDS9960_REG_ENABLE,
>> +                             APDS9960_REG_GSTATUS),
>> +     regmap_reg_range(APDS9960_REG_GFIFO_DIR(UP),
>> +                             APDS9960_REG_GFIFO_DIR(RIGHT)),
>> +};
>> +
>> +static const struct regmap_access_table apds9960_readable_table = {
>> +     .yes_ranges     = apds9960_readable_ranges,
>> +     .n_yes_ranges   = ARRAY_SIZE(apds9960_readable_ranges),
>> +};
>> +
>> +static const struct regmap_range apds9960_writeable_ranges[] = {
>> +     regmap_reg_range(APDS9960_REG_ENABLE, APDS9960_REG_CONFIG_2),
>> +     regmap_reg_range(APDS9960_REG_POFFSET_UR, APDS9960_REG_GCONF_4),
>> +     regmap_reg_range(APDS9960_REG_IFORCE, APDS9960_REG_AICLEAR),
>> +};
>> +
>> +static const struct regmap_access_table apds9960_writeable_table = {
>> +     .yes_ranges     = apds9960_writeable_ranges,
>> +     .n_yes_ranges   = ARRAY_SIZE(apds9960_writeable_ranges),
>> +};
>> +
>> +static const struct regmap_config apds9960_regmap_config = {
>> +     .name = APDS9960_REGMAP_NAME,
>> +     .reg_bits = 8,
>> +     .val_bits = 8,
>> +     .use_single_rw = 1,
>> +
>> +     .volatile_table = &apds9960_volatile_table,
>> +     .precious_table = &apds9960_precious_table,
>> +     .rd_table = &apds9960_readable_table,
>> +     .wr_table = &apds9960_writeable_table,
>> +
>> +     .reg_defaults = apds9960_reg_defaults,
>> +     .num_reg_defaults = ARRAY_SIZE(apds9960_reg_defaults),
>> +     .max_register = APDS9960_REG_GFIFO_DIR(RIGHT),
>> +     .cache_type = REGCACHE_RBTREE,
>> +};
>> +
>> +static const struct iio_event_spec apds9960_pxs_event_spec[] = {
>> +     {
>> +             .type = IIO_EV_TYPE_THRESH,
>> +             .dir = IIO_EV_DIR_RISING,
>> +             .mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +                     BIT(IIO_EV_INFO_ENABLE),
>> +     },
>> +     {
>> +             .type = IIO_EV_TYPE_THRESH,
>> +             .dir = IIO_EV_DIR_FALLING,
>> +             .mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +                     BIT(IIO_EV_INFO_ENABLE),
>> +     },
>> +};
>> +
>> +static const struct iio_event_spec apds9960_als_event_spec[] = {
>> +     {
>> +             .type = IIO_EV_TYPE_THRESH,
>> +             .dir = IIO_EV_DIR_RISING,
>> +             .mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +                     BIT(IIO_EV_INFO_ENABLE),
>> +     },
>> +     {
>> +             .type = IIO_EV_TYPE_THRESH,
>> +             .dir = IIO_EV_DIR_FALLING,
>> +             .mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +                     BIT(IIO_EV_INFO_ENABLE),
>> +     },
>> +};
>> +
>> +#define APDS9960_GESTURE_CHANNEL(_dir, _si) { \
>> +     .type = IIO_PROXIMITY, \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>> +     .address = APDS9960_REG_GFIFO_DIR(_dir), \
>> +     .channel = _si + 1, \
>> +     .scan_index = _si, \
>> +     .indexed = 1, \
>> +     .scan_type = { \
>> +             .sign = 'u', \
>> +             .realbits = 8, \
>> +             .storagebits = 8, \
>> +     }, \
>> +}
>> +
>> +#define APDS9960_INTENSITY_CHANNEL(_colour) { \
>> +     .type = IIO_INTENSITY, \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>> +                     BIT(IIO_CHAN_INFO_INT_TIME), \
>> +     .channel2 = IIO_MOD_LIGHT_##_colour, \
>> +     .address = APDS9960_REG_ALS_CHANNEL(_colour), \
>> +     .modified = 1, \
>> +     .scan_index = -1, \
>> +}
>> +
>> +static const struct iio_chan_spec apds9960_channels[] = {
> Interesting approach.  Guess it doesn't make sense to push the normal
> proximity / als through the buffer..
>> +     {
>> +             .type = IIO_PROXIMITY,
>> +             .address = APDS9960_REG_PDATA,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +             .channel = 0,
>> +             .indexed = 1,
>> +             .scan_index = -1,
>> +
>> +             .event_spec = apds9960_pxs_event_spec,
>> +             .num_event_specs = ARRAY_SIZE(apds9960_pxs_event_spec),
>> +     },
>> +     /* Gesture Sensor */
>> +     APDS9960_GESTURE_CHANNEL(UP, 0),
>> +     APDS9960_GESTURE_CHANNEL(DOWN, 1),
>> +     APDS9960_GESTURE_CHANNEL(LEFT, 2),
>> +     APDS9960_GESTURE_CHANNEL(RIGHT, 3),
>> +     IIO_CHAN_SOFT_TIMESTAMP(4),
>> +     /* ALS */
>> +     {
>> +             .type = IIO_INTENSITY,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>> +                     BIT(IIO_CHAN_INFO_INT_TIME),
>> +             .channel2 = IIO_MOD_LIGHT_CLEAR,
>> +             .address = APDS9960_REG_ALS_CHANNEL(CLEAR),
>> +             .modified = 1,
>> +             .scan_index = -1,
>> +
>> +             .event_spec = apds9960_als_event_spec,
>> +             .num_event_specs = ARRAY_SIZE(apds9960_als_event_spec),
>> +     },
>> +     /* RGB Sensor */
>> +     APDS9960_INTENSITY_CHANNEL(RED),
>> +     APDS9960_INTENSITY_CHANNEL(GREEN),
>> +     APDS9960_INTENSITY_CHANNEL(BLUE),
>> +};
>> +
>> +/* integration time in us */
>> +static const int apds9960_int_time[][2] =
>> +     { {28000, 246}, {100000, 219}, {200000, 182}, {700000, 0} };
>> +
>> +/* gain mapping */
>> +static const int apds9960_pxs_gain_map[] = {1, 2, 4, 8};
>> +static const int apds9960_als_gain_map[] = {1, 4, 16, 64};
>> +
>> +static IIO_CONST_ATTR(proximity_scale_available, "1 2 4 8");
>> +static IIO_CONST_ATTR(intensity_scale_available, "1 4 16 64");
>> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.028 0.1 0.2 0.7");
>> +
>> +static struct attribute *apds9960_attributes[] = {
>> +     &iio_const_attr_proximity_scale_available.dev_attr.attr,
>> +     &iio_const_attr_intensity_scale_available.dev_attr.attr,
>> +     &iio_const_attr_integration_time_available.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static struct attribute_group apds9960_attribute_group = {
>> +     .attrs = apds9960_attributes,
>> +};
>> +
>> +
>> +static const struct reg_field reg_field_int_als =
>> +                             REG_FIELD(APDS9960_REG_ENABLE, 4, 4);
>> +
>> +static const struct reg_field reg_field_int_ges =
>> +                             REG_FIELD(APDS9960_REG_GCONF_4, 1, 1);
>> +
>> +static const struct reg_field reg_field_int_pxs =
>> +                             REG_FIELD(APDS9960_REG_ENABLE, 5, 5);
>> +
>> +static const struct reg_field reg_field_enable_als =
>> +                             REG_FIELD(APDS9960_REG_ENABLE, 1, 1);
>> +
>> +static const struct reg_field reg_field_enable_ges =
>> +                             REG_FIELD(APDS9960_REG_ENABLE, 6, 6);
>> +
> Ideally all of these would have an apds9960 prefix.
>> +static const struct reg_field reg_field_enable_pxs =
>> +                             REG_FIELD(APDS9960_REG_ENABLE, 2, 2);
>> +
>> +static int apds9960_set_it_time(struct apds9960_data *data, int val2)
>> +{
>> +     int ret = -EINVAL;
>> +     int idx;
>> +
>> +     for (idx = 0; idx < ARRAY_SIZE(apds9960_int_time); idx++) {
>> +             if (apds9960_int_time[idx][0] == val2) {
>> +                     mutex_lock(&data->lock);
>> +                     ret = regmap_write(data->regmap, APDS9960_REG_ATIME,
>> +                                              apds9960_int_time[idx][1]);
>> +                     if (!ret)
>> +                             data->als_adc_int_us = val2;
>> +                     mutex_unlock(&data->lock);
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int apds9960_set_pxs_gain(struct apds9960_data *data, int val)
>> +{
>> +     int ret = -EINVAL;
>> +     int idx;
>> +
>> +     for (idx = 0; idx < ARRAY_SIZE(apds9960_pxs_gain_map); idx++) {
>> +             if (apds9960_pxs_gain_map[idx] == val) {
>> +                     /* pxs + gesture gains are mirrored */
>> +                     mutex_lock(&data->lock);
>> +                     ret = regmap_update_bits(data->regmap,
>> +                             APDS9960_REG_CONTROL,
>> +                             APDS9960_REG_CONTROL_PGAIN_MASK,
>> +                             idx << APDS9960_REG_CONTROL_PGAIN_MASK_SHIFT);
>> +                     if (ret) {
>> +                             mutex_unlock(&data->lock);
>> +                             break;
>> +                     }
>> +
>> +                     ret = regmap_update_bits(data->regmap,
>> +                             APDS9960_REG_CONFIG_2,
>> +                             APDS9960_REG_CONFIG_2_GGAIN_MASK,
>> +                             idx << APDS9960_REG_CONFIG_2_GGAIN_MASK_SHIFT);
>> +                     if (!ret)
>> +                             data->pxs_gain = idx;
>> +                     mutex_unlock(&data->lock);
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int apds9960_set_als_gain(struct apds9960_data *data, int val)
>> +{
>> +     int ret = -EINVAL;
>> +     int idx;
>> +
>> +     for (idx = 0; idx < ARRAY_SIZE(apds9960_als_gain_map); idx++) {
>> +             if (apds9960_als_gain_map[idx] == val) {
>> +                     mutex_lock(&data->lock);
>> +                     ret = regmap_update_bits(data->regmap,
>> +                                     APDS9960_REG_CONTROL,
>> +                                     APDS9960_REG_CONTROL_AGAIN_MASK, idx);
>> +                     if (!ret)
>> +                             data->als_gain = idx;
>> +                     mutex_unlock(&data->lock);
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>> +{
>> +     struct device *dev = &data->client->dev;
>> +     int ret = 0;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (on) {
>> +             int suspended;
>> +
>> +             suspended = pm_runtime_suspended(dev);
>> +             ret = pm_runtime_get_sync(dev);
>> +
>> +             /* Allow one integration cycle before allowing a reading */
>> +             if (suspended)
>> +                     usleep_range(data->als_adc_int_us,
>> +                                  APDS9960_MAX_INT_TIME_IN_US);
>> +     } else {
>> +             ret = pm_runtime_put_autosuspend(dev);
>> +     }
>> +
>> +     mutex_unlock(&data->lock);
>> +
>> +     return ret;
>> +}
>> +#else
>> +static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>> +{
>> +     return 0;
>> +}
>> +#endif
>> +
>> +static int apds9960_read_raw(struct iio_dev *indio_dev,
>> +                          struct iio_chan_spec const *chan,
>> +                          int *val, int *val2, long mask)
>> +{
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +     u16 buf;
>> +     int ret = -EINVAL;
>> +
>> +     if (data->gesture_mode_running)
>> +             return -EBUSY;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             apds9960_set_power_state(data, true);
>> +             switch (chan->type) {
>> +             case IIO_PROXIMITY:
>> +                     if (chan->scan_index == -1) {
>> +                             ret = regmap_read(data->regmap,
>> +                                               chan->address, val);
>> +                             if (!ret)
>> +                                     ret = IIO_VAL_INT;
>> +                     } else {
> If the channels don't have explicity channel mask entries for a polled
> read then there will be no way of reading them anyway except through the
> buffered interface.

What context do you mean by channel mask entries?

>> +                             /*
>> +                              * Cannot poll the GESTURE channels which are
>> +                              * just usable with triggered buffers.
>> +                              */
>> +                             ret = -EBUSY;
>> +                     }
>> +                     break;
>> +             case IIO_INTENSITY:
>> +                     ret = regmap_bulk_read(data->regmap, chan->address,
>> +                                            &buf, 2);
>> +                     if (!ret)
>> +                             ret = IIO_VAL_INT;
>> +                     *val = le16_to_cpu(buf);
>> +                     break;
>> +             default:
>> +                     ret = -EINVAL;
>> +             }
>> +             apds9960_set_power_state(data, false);
>> +             break;
>> +     case IIO_CHAN_INFO_INT_TIME:
>> +             /* RGB + ALS sensors only have int time */
>> +             mutex_lock(&data->lock);
>> +             switch (chan->type) {
>> +             case IIO_INTENSITY:
>> +                     *val = 0;
>> +                     *val2 = data->als_adc_int_us;
>> +                     ret = IIO_VAL_INT_PLUS_MICRO;
>> +                     break;
>> +             default:
>> +                     ret = -EINVAL;
>> +             }
>> +             mutex_unlock(&data->lock);
>> +             break;
>> +     case IIO_CHAN_INFO_SCALE:
>> +             mutex_lock(&data->lock);
>> +             switch (chan->type) {
>> +             case IIO_PROXIMITY:
>> +                     *val = apds9960_pxs_gain_map[data->pxs_gain];
>> +                     ret = IIO_VAL_INT;
>> +                     break;
>> +             case IIO_INTENSITY:
>> +                     *val = apds9960_als_gain_map[data->als_gain];
>> +                     ret = IIO_VAL_INT;
>> +                     break;
>> +             default:
>> +                     ret = -EINVAL;
>> +             }
>> +             mutex_unlock(&data->lock);
>> +             break;
>> +     }
>> +
>> +     return ret;
>> +};
>> +
>> +static int apds9960_write_raw(struct iio_dev *indio_dev,
>> +                          struct iio_chan_spec const *chan,
>> +                          int val, int val2, long mask)
>> +{
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_INT_TIME:
>> +             /* RGB + ALS sensors only have int time */
>> +             switch (chan->type) {
>> +             case IIO_INTENSITY:
>> +                     if (val != 0)
>> +                             return -EINVAL;
>> +                     return apds9960_set_it_time(data, val2);
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +     case IIO_CHAN_INFO_SCALE:
>> +             if (val2 != 0)
>> +                     return -EINVAL;
>> +             switch (chan->type) {
>> +             case IIO_PROXIMITY:
>> +                     return apds9960_set_pxs_gain(data, val);
>> +             case IIO_INTENSITY:
>> +                     return apds9960_set_als_gain(data, val);
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +     default:
>> +             return -EINVAL;
>> +     };
>> +
>> +     return 0;
>> +}
>> +
>> +static inline int apds9960_get_thres_reg(const struct iio_chan_spec *chan,
>> +                                      enum iio_event_direction dir,
>> +                                      u8 *reg)
>> +{
>> +     switch (dir) {
>> +     case IIO_EV_DIR_RISING:
>> +             switch (chan->type) {
>> +             case IIO_PROXIMITY:
>> +                     *reg = APDS9960_REG_PIHT;
>> +                     break;
>> +             case IIO_INTENSITY:
>> +                     *reg = APDS9960_REG_AIHTL;
>> +                     break;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +             break;
>> +     case IIO_EV_DIR_FALLING:
>> +             switch (chan->type) {
>> +             case IIO_PROXIMITY:
>> +                     *reg = APDS9960_REG_PILT;
>> +                     break;
>> +             case IIO_INTENSITY:
>> +                     *reg = APDS9960_REG_AILTL;
>> +                     break;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_read_event(struct iio_dev *indio_dev,
>> +                            const struct iio_chan_spec *chan,
>> +                            enum iio_event_type type,
>> +                            enum iio_event_direction dir,
>> +                            enum iio_event_info info,
>> +                            int *val, int *val2)
>> +{
>> +     u8 reg;
>> +     u16 buf;
>> +     int ret = 0;
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +
>> +     if (info != IIO_EV_INFO_VALUE)
>> +             return -EINVAL;
>> +
>> +     ret = apds9960_get_thres_reg(chan, dir, &reg);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     if (chan->type == IIO_PROXIMITY) {
>> +             ret = regmap_read(data->regmap, reg, val);
>> +             if (ret < 0)
>> +                     return ret;
>> +     } else if (chan->type == IIO_INTENSITY) {
>> +             ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
>> +             if (ret < 0)
>> +                     return ret;
>> +             *val = le16_to_cpu(buf);
>> +     } else
>> +             return -EINVAL;
>> +
>> +     *val2 = 0;
> blank line.
>> +     return IIO_VAL_INT;
>> +}
>> +
>> +static int apds9960_write_event(struct iio_dev *indio_dev,
>> +                             const struct iio_chan_spec *chan,
>> +                             enum iio_event_type type,
>> +                             enum iio_event_direction dir,
>> +                             enum iio_event_info info,
>> +                             int val, int val2)
>> +{
>> +     u8 reg;
>> +     u16 buf;
>> +     int ret = 0;
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +
>> +     if (info != IIO_EV_INFO_VALUE)
>> +             return -EINVAL;
>> +
>> +     ret = apds9960_get_thres_reg(chan, dir, &reg);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     if (chan->type == IIO_PROXIMITY) {
> Might be sensible to use #defines for the max limits in here.
>> +             if (val > 255)
>> +                     return -EINVAL;
>> +             ret = regmap_write(data->regmap, reg, val);
>> +             if (ret < 0)
>> +                     return ret;
>> +     } else if (chan->type == IIO_INTENSITY) {
>> +             if (val > 0xFFFF)
>> +                     return -EINVAL;
>> +             buf = cpu_to_le16(val);
>> +             ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
>> +             if (ret < 0)
>> +                     return ret;
>> +     } else
>> +             return -EINVAL;
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_read_event_config(struct iio_dev *indio_dev,
>> +                                   const struct iio_chan_spec *chan,
>> +                                   enum iio_event_type type,
>> +                                   enum iio_event_direction dir)
>> +{
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +
>> +     switch (chan->type) {
>> +     case IIO_PROXIMITY:
>> +             return data->pxs_int;
>> +     case IIO_INTENSITY:
>> +             return data->als_int;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_write_event_config(struct iio_dev *indio_dev,
>> +                                    const struct iio_chan_spec *chan,
>> +                                    enum iio_event_type type,
>> +                                    enum iio_event_direction dir,
>> +                                    int state)
>> +{
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +     int ret;
>> +
>> +     state = !!state;
>> +
>> +     switch (chan->type) {
>> +     case IIO_PROXIMITY:
>> +             if (data->pxs_int == state)
>> +                     return -EINVAL;
>> +
>> +             ret = regmap_field_write(data->reg_int_pxs, state);
>> +             if (ret)
>> +                     return ret;
>> +             data->pxs_int = state;
>> +             apds9960_set_power_state(data, state);
>> +             break;
>> +     case IIO_INTENSITY:
>> +             if (data->als_int == state)
>> +                     return -EINVAL;
>> +
>> +             ret = regmap_field_write(data->reg_int_als, state);
>> +             if (ret)
>> +                     return ret;
>> +             data->als_int = state;
>> +             apds9960_set_power_state(data, state);
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct iio_info apds9960_info = {
>> +     .driver_module = THIS_MODULE,
>> +     .attrs = &apds9960_attribute_group,
>> +     .read_raw = apds9960_read_raw,
>> +     .write_raw = apds9960_write_raw,
>> +     .read_event_value = apds9960_read_event,
>> +     .write_event_value = apds9960_write_event,
>> +     .read_event_config = apds9960_read_event_config,
>> +     .write_event_config = apds9960_write_event_config,
>> +
>> +};
>> +
>> +static irqreturn_t apds9960_interrupt_handler(int irq, void *private)
>> +{
>> +     struct iio_dev *indio_dev = private;
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +     int ret, status;
>> +
>> +     ret = regmap_read(data->regmap, APDS9960_REG_STATUS, &status);
>> +     if (ret < 0) {
>> +             dev_err(&data->client->dev, "irq status reg read failed\n");
>> +             return IRQ_HANDLED;
>> +     }
>> +
>> +     if ((status & APDS9960_REG_STATUS_ALS_INT) && data->als_int) {
>> +             iio_push_event(indio_dev,
>> +                            IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>> +                                                 IIO_EV_TYPE_THRESH,
>> +                                                 IIO_EV_DIR_EITHER),
>> +                            iio_get_time_ns());
>> +     }
>> +
>> +     if ((status & APDS9960_REG_STATUS_PS_INT) && data->pxs_int) {
>> +             iio_push_event(indio_dev,
>> +                            IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>> +                                                 IIO_EV_TYPE_THRESH,
>> +                                                 IIO_EV_DIR_EITHER),
>> +                            iio_get_time_ns());
>> +     }
>> +
>> +     if (status & APDS9960_REG_STATUS_GINT)
>> +             iio_trigger_poll_chained(data->trig);
>
> Using the chained form restricts (more or less) using this trigger to
> driver any other sensors.  Perhaps fine for now, but we may want to
> do the more complex approach to fire on a real interrupt later.
>
>> +
>> +     regmap_write(data->regmap, APDS9960_REG_AICLEAR, 1);
> Might be ideal to clear the als and prox interrupts separately as in theory
> you have a race condition here where you are clearing an interrupt you
> haven't necessarily seen (between the status read and the clear).
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static inline int apds9660_fifo_is_empty(struct apds9960_data *data)
>> +{
>> +     int cnt;
>> +     int ret;
>> +
>> +     ret = regmap_read(data->regmap, APDS9960_REG_GFLVL, &cnt);
>> +     if (ret)
>> +             return ret;
> blank line here.
>> +     return cnt;
>> +}
>> +
>> +static irqreturn_t apds9960_trigger_handler(int irq, void *private)
>> +{
>> +     struct iio_poll_func *pf = private;
>> +     struct iio_dev *indio_dev = pf->indio_dev;
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +     u8 buffer[4];
>> +     int ret;
>> +
>> +     mutex_lock(&data->lock);
>> +     data->gesture_mode_running = 1;
>> +
>> +     while (apds9660_fifo_is_empty(data) > 0) {
>> +             int i, j = 0;
>> +
>> +             memset(&data->buffer, 0, sizeof(data->buffer));
> Why bother zeroing out?  You are going to fill it anyway below. (or is there
> a risk of leaking info if the below fails?  Don't think so.
>> +
>> +             ret = regmap_bulk_read(data->regmap,
>> +                                    APDS9960_REG_GFIFO_BASE, &buffer, 4);
>> +             if (ret)
>> +                     goto err_read;
>> +
>> +             /*
>> +              * Even if we don't care about scan_index channels we need to
>> +              * read them to clear the FIFO.
>> +              */
>> +             for_each_set_bit(i, indio_dev->active_scan_mask,
>> +                                             indio_dev->masklength) {
>> +                     data->buffer[j++] = buffer[i];
>> +             }
>
> Don't need brackets around the above.  Also, why not read directly into the
> data->buffer and drop the copy?  If you have to read them anyway use
> the scan_masks_available to specify all channels are enabled together then
> let the in core demux logic handle dropping unwanted channels.
> Never any need to do this in driver any more.
>
> Or for that mater just use the lcoal buffer and don't bother with the one
> in data.
>
>> +             iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> +                                             iio_get_time_ns());
>> +     }
>> +
>> +err_read:
>> +     data->gesture_mode_running = 0;
>> +     mutex_unlock(&data->lock);
>> +     iio_trigger_notify_done(indio_dev->trig);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
>> +     .owner = THIS_MODULE,
>> +};
>> +
>> +static int apds9960_set_powermode(struct apds9960_data *data, bool state)
>> +{
>> +     int ret;
>> +
>> +     ret = regmap_update_bits(data->regmap, APDS9960_REG_ENABLE,
>> +                              APDS9960_REG_ENABLE_PON, state);
>> +     if (ret)
>> +             return ret;
> return directly.  Given only false value is 0 it'll be the same and 6 lines
> shorter.
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +     int ret;
>> +
>> +     ret = regmap_field_write(data->reg_int_ges, 1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_field_write(data->reg_enable_ges, 1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pm_runtime_get_sync(&data->client->dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_buffer_postdisable(struct iio_dev *indio_dev)
>> +{
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +     int ret;
>> +
>> +     ret = regmap_field_write(data->reg_enable_ges, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_field_write(data->reg_int_ges, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pm_runtime_put_autosuspend(&data->client->dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct iio_buffer_setup_ops apds9960_buffer_setup_ops = {
>> +     .preenable = apds9960_buffer_preenable,
>> +     .postenable = iio_triggered_buffer_postenable,
>> +     .predisable = iio_triggered_buffer_predisable,
>> +     .postdisable = apds9960_buffer_postdisable,
>> +};
>> +
>> +static int apds9960_regfield_init(struct apds9960_data *data)
>> +{
>> +     struct device *dev = &data->client->dev;
>> +     struct regmap *regmap = data->regmap;
>> +
> This feels like a rather long function for what it is doing.
> Worth trying to do these with an enum indexed array?  Might not
> be worthwhile.
>> +     data->reg_int_als =
>> +             devm_regmap_field_alloc(dev, regmap, reg_field_int_als);
>> +     if (IS_ERR(data->reg_int_als)) {
>> +             dev_err(dev, "INT ALS reg field init failed\n");
>> +             return PTR_ERR(data->reg_int_als);
>> +     }
>> +
>> +     data->reg_int_ges =
>> +             devm_regmap_field_alloc(dev, regmap, reg_field_int_ges);
>> +     if (IS_ERR(data->reg_int_ges)) {
>> +             dev_err(dev, "INT gesture reg field init failed\n");
>> +             return PTR_ERR(data->reg_int_ges);
>> +     }
>> +
>> +     data->reg_int_pxs =
>> +             devm_regmap_field_alloc(dev, regmap, reg_field_int_pxs);
>> +     if (IS_ERR(data->reg_int_pxs)) {
>> +             dev_err(dev, "INT pxs reg field init failed\n");
>> +             return PTR_ERR(data->reg_int_pxs);
>> +     }
>> +
>> +     data->reg_enable_als =
>> +             devm_regmap_field_alloc(dev, regmap, reg_field_enable_als);
>> +     if (IS_ERR(data->reg_enable_als)) {
>> +             dev_err(dev, "Enable ALS reg field init failed\n");
>> +             return PTR_ERR(data->reg_enable_als);
>> +     }
>> +
>> +     data->reg_enable_ges =
>> +             devm_regmap_field_alloc(dev, regmap, reg_field_enable_ges);
>> +     if (IS_ERR(data->reg_enable_ges)) {
>> +             dev_err(dev, "Enable gesture reg field init failed\n");
>> +             return PTR_ERR(data->reg_enable_ges);
>> +     }
>> +
>> +     data->reg_enable_pxs =
>> +             devm_regmap_field_alloc(dev, regmap, reg_field_enable_pxs);
>> +     if (IS_ERR(data->reg_enable_pxs)) {
>> +             dev_err(dev, "Enable PXS reg field init failed\n");
>> +             return PTR_ERR(data->reg_enable_pxs);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_chip_init(struct apds9960_data *data)
>> +{
>> +     int ret;
>> +
>> +     /* Default IT for ALS of 28 ms */
>> +     ret = apds9960_set_it_time(data, 28000);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Ensure gesture interrupt is OFF */
>> +     ret = regmap_field_write(data->reg_int_ges, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Disable gesture sensor, since polling is useless from user-space */
>> +     ret = regmap_field_write(data->reg_enable_ges, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Ensure proximity interrupt is OFF */
>> +     ret = regmap_field_write(data->reg_int_pxs, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Enable proximity sensor for polling */
>> +     ret = regmap_field_write(data->reg_enable_pxs, 1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Ensure ALS interrupt is OFF */
>> +     ret = regmap_field_write(data->reg_int_als, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Enable ALS sensor for polling */
>> +     ret = regmap_field_write(data->reg_enable_als, 1);
>> +     if (ret)
>> +             return ret;
>> +     /*
>> +      * When enabled trigger and interrupt after 3 readings
>> +      * outside threshold for ALS + PXS
>> +      */
>> +     ret = regmap_write(data->regmap, APDS9960_REG_PERS,
>> +                        APDS9960_DEFAULT_PERS);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * Wait for 4 event outside gesture threshold to prevent interrupt
>> +      * flooding.
> Strikes me that this will want  to be configurable in the long run.
>> +      */
>> +     ret = regmap_update_bits(data->regmap, APDS9960_REG_GCONF_1,
>> +                     APDS9960_REG_GCONF_1_GFIFO_THRES_MASK,
>> +                     BIT(0) << APDS9960_REG_GCONF_1_GFIFO_THRES_MASK_SHIFT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * Default ENTER and EXIT thresholds for the GESTURE engine.
>> +      */
>> +     ret = regmap_write(data->regmap, APDS9960_REG_GPENTH,
>> +                        APDS9960_DEFAULT_GPENTH);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_write(data->regmap, APDS9960_REG_GEXTH,
>> +                        APDS9960_DEFAULT_GEXTH);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = apds9960_set_powermode(data, 1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return 0;
>> +}
>> +
>> +static int apds9960_probe(struct i2c_client *client,
>> +                       const struct i2c_device_id *id)
>> +{
>> +     struct apds9960_data *data;
>> +     struct iio_dev *indio_dev;
>> +     struct iio_trigger *trig;
>> +     int ret;
>> +
>> +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     indio_dev->info = &apds9960_info;
>> +     indio_dev->name = APDS9960_DRV_NAME;
>> +     indio_dev->channels = apds9960_channels;
>> +     indio_dev->num_channels = ARRAY_SIZE(apds9960_channels);
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +     trig = devm_iio_trigger_alloc(&client->dev, "%s-gesture%d",
>> +                                   indio_dev->name, indio_dev->id);
>> +     if (!trig)
>> +             return -ENOMEM;
>> +
>> +     data = iio_priv(indio_dev);
>> +     i2c_set_clientdata(client, indio_dev);
>> +
>> +     data->regmap = devm_regmap_init_i2c(client, &apds9960_regmap_config);
>> +     if (IS_ERR(data->regmap)) {
>> +             dev_err(&client->dev, "regmap initialization failed.\n");
>> +             return PTR_ERR(data->regmap);
>> +     }
>> +
>> +     data->client = client;
>> +     data->trig = trig;
>> +     data->indio_dev = indio_dev;
>> +     trig->dev.parent = indio_dev->dev.parent;
>> +     trig->ops = &iio_interrupt_trigger_ops;
>> +
>> +     mutex_init(&data->lock);
>> +     iio_trigger_set_drvdata(trig, indio_dev);
>> +
>> +     ret = pm_runtime_set_active(&client->dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pm_runtime_enable(&client->dev);
>> +     pm_runtime_set_autosuspend_delay(&client->dev, 5000);
>> +     pm_runtime_use_autosuspend(&client->dev);
>> +
>> +     apds9960_set_power_state(data, true);
>> +
>> +     ret = iio_trigger_register(trig);
>> +     if (ret) {
>> +             dev_err(&client->dev, "failed to register trigger\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +                                      apds9960_trigger_handler,
>> +                                      &apds9960_buffer_setup_ops);
>> +     if (ret)
>> +             goto error_unreg_trigger;
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret)
>> +             goto error_unreg_buffer;
> Normally the iio_device_register is the last thing done.  This is
> because it is responsible for exposing userspace interfaces.  Is there
> any reason it is done so early in this driver?  Also you don't
> unwind it if you get errors on the next few functions.
>
>> +
>> +     ret = apds9960_regfield_init(data);
>> +     if (ret)
>> +             goto error_unreg_buffer;
>> +
>> +     ret = apds9960_chip_init(data);
>> +     if (ret)
>> +             goto error_unreg_buffer;
>> +
>> +     if (client->irq > 0) {
>> +             ret = devm_request_threaded_irq(&client->dev, client->irq,
>> +                                     NULL, apds9960_interrupt_handler,
>> +                                     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +                                     "apds9960_event",
>> +                                     indio_dev);
>> +             if (ret) {
>> +                     dev_err(&client->dev, "request irq (%d) failed\n",
>> +                             client->irq);
>> +                     goto error_unreg_buffer;
>> +             }
>> +     } else {
> I'd flip the logic here and handle the failure case first.  Kind of the
> conventional way of doing it and reduces indentation on the 'normal' path.
> (i.e. if (client->irq <= 0) { this bit }  then carry on with the knowledge
> that your irq number is good).
>
>> +             dev_err(&client->dev, "no valid irq defined\n");
>> +             ret = -EINVAL;
>> +             goto error_unreg_buffer;
>> +     }
>> +
>> +     apds9960_set_power_state(data, false);
> nit pick. Blank line here please.
>> +     return 0;
>> +
>> +error_unreg_buffer:
>> +     iio_triggered_buffer_cleanup(indio_dev);
>> +
>> +error_unreg_trigger:
>> +     iio_trigger_unregister(data->trig);
>> +     apds9960_set_power_state(data, false);
>> +
>> +     return ret;
>> +}
>> +
>> +static int apds9960_remove(struct i2c_client *client)
>> +{
>> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +     struct apds9960_data *data = iio_priv(indio_dev);
>> +
>> +     iio_device_unregister(indio_dev);
>> +     iio_triggered_buffer_cleanup(indio_dev);
>> +     iio_trigger_unregister(data->trig);
>> +
>> +     pm_runtime_disable(&client->dev);
>> +     pm_runtime_set_suspended(&client->dev);
>> +     apds9960_set_powermode(data, 0);
>> +
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int apds9960_runtime_suspend(struct device *dev)
>> +{
>> +     struct apds9960_data *data =
>> +                     iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +     return apds9960_set_powermode(data, 0);
>> +}
>> +
>> +static int apds9960_runtime_resume(struct device *dev)
>> +{
>> +     struct apds9960_data *data =
>> +                     iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +     return apds9960_set_powermode(data, 1);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops apds9960_pm_ops = {
>> +     SET_RUNTIME_PM_OPS(apds9960_runtime_suspend,
>> +                        apds9960_runtime_resume, NULL)
>> +};
>> +
>> +static const struct i2c_device_id apds9960_id[] = {
>> +     { "apds9960", 0 },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, apds9960_id);
>> +
>> +static struct i2c_driver apds9960_driver = {
>> +     .driver = {
>> +             .name   = APDS9960_DRV_NAME,
>> +             .pm     = &apds9960_pm_ops,
>> +             .owner = THIS_MODULE,
>> +     },
>> +     .probe          = apds9960_probe,
>> +     .remove         = apds9960_remove,
>> +     .id_table       = apds9960_id,
>> +};
>> +module_i2c_driver(apds9960_driver);
>> +
>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>> +MODULE_DESCRIPTION("ADPS9960 Gesture/RGB/ALS/Proximity sensor");
>> +MODULE_LICENSE("GPL");
>>
>
