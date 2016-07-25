From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 0/9] hwmon: New hwmon registration API
Date: Sun, 24 Jul 2016 20:32:23 -0700
Message-ID: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Up to now, each hwmon driver has to implement its own sysfs attributes.
This requires a lot of template code, and distracts from the driver's
core function to read and write chip registers.

To be able to reduce driver complexity, move sensor attribute handling
and thermal zone registration into the hwmon core. By using the new API,
driver size is typically reduced by 20-50% depending on driver complexity
and the number of sysfs attributes supported.

The first patch of the series is preparatory; it reorders include files
in the hwmon core to make it easier to add or remove individual include
files.

The second patch of the series introduces the API as well as support
for temperature sensor attributes. Subsequent patches introduce support
for voltage, current, power, energy, humidity, fan speed, and basic pwm
attributes.

The series was tested by converting several drivers (lm75, lm90, tmp102,
tmp421, ltc4245, nct7904, max31790) to the new API. Testing was done with
real chips as well as with the hwmon driver module test code available
at https://github.com/groeck/module-tests.

v3:
- Thermal registration depends on IS_REACHABLE(CONFIG_THERMAL) and
  CONFIG_THERMAL_OF.
v2:
- Add patch 1/9 (order include files alphabetically).
- Add patch 9/9 (pwm support).
- Document callback function parameters of struct hwmon_ops in
  include/linux/hwmon.h.
- Clarify that the is_visible() callback is mandatory.
- If an attribute has no template string, treat it as invisible, not as
  error. Affected are virtual attributes such as HWMON_C_REGISTER_TZ.
- Initialize device attribute read/write callback functions unconditionally.
- Cosmetic changes, including typo fixes and added newlines for readability.
