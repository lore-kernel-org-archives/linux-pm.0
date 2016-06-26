From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/5] hwmon: New hwmon registration API
Date: Sat, 25 Jun 2016 20:26:23 -0700
Message-ID: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Up to now, each hwmon driver has to implement its own sysfs attributes.
This requires a lot of template code, and distracts from the driver's
core function to read and write chip registers.

To be able to reduce driver complexity, move sensor attribute handling
and thermal zone registration into the hwmon core. By using the new API,
driver size is typically reduced by 20-50% depending on driver complexity
and the number of sysfs attributes supported.

The first patch of the series introduces the API as well as support
for temperature sensors. Subsequent patches introduce support for
voltage, current, power, energy, humidity, and fan speed sensors.

The series was tested by converting several drivers (lm75, lm90, tmp102,
tmp421, ltc4245) to the new API. Testing was done with with real chips
as well as with the hwmon driver module test code available at
https://github.com/groeck/module-tests.
