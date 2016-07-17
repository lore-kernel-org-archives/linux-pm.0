From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH v2 0/9] hwmon: New hwmon registration API
Date: Sat, 16 Jul 2016 22:30:23 -0700
Message-ID: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
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

The secind patch of the series introduces the API as well as support
for temperature sensor attributes. Subsequent patches introduce support
for voltage, current, power, energy, humidity, fan speed, and basic pwm
attributes.

The series was tested by converting several drivers (lm75, lm90, tmp102,
tmp421, ltc4245, nct7904, max31790) to the new API. Testing was done with
real chips as well as with the hwmon driver module test code available
at https://github.com/groeck/module-tests.

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
