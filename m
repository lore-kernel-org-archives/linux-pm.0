From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/7] mfd/iio: move the AB8500 GPADC driver to IIO
Date: Wed, 11 Jan 2017 00:47:38 +0100
Message-ID: <20170110234745.29691-1-linus.walleij@linaro.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Mboumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The AB8500 GPADC driver in MFD was created and merged before IIO
existed, but it was what I was basing my review comments on when
reviewing the IIO subsystem inclusion into the main kernel tree
from staging. I asked for the in-kernel ADC channel mechanism
and I guess I promised to make use of it.

As usual that is the kind of empty promise that you never come
around to actually fixing up. But eventually I did.

This patch set augments all consumers of the AB8500 GPADC to use
IIO channels, moves the driver to iio/adc, augments the driver to
register proper IIO ADC channels. Finally we add the required nodes
to the Ux500 DTS and connect it all up.

We delete the custom AB8500 GPADC header with its cross-call
functions and replace this mechanism with IIO's consumer API.

The biggest win, as it turns out, is being able to delete a whole
slew of debugfs files as these are fulfilled with standard
IIO ADC sysfs files.

I don't know the best merge path for this but suspect that as
usual Lee can merge them all and provide an immutable branch to
the other subsystems, which he has lots of routine in handling.
The final DTS patch can probably be merged separately through
ARM SoC.

Linus Walleij (7):
  power: supply: ab8500_btemp: convert to IIO ADC
  power: supply: ab8500_charger: convert to IIO ADC
  power: supply: ab8500_fg: convert to IIO ADC
  hwmon: ab8500: convert to IIO ADC
  mfd: ab8500: augment DT bindings
  mfd/iio: move the AB8500 GPADC to IIO
  ARM: dts: ux500: declare GPADC IIO ADC channels

 Documentation/devicetree/bindings/mfd/ab8500.txt |  119 ++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                |  102 +-
 drivers/hwmon/ab8500.c                           |   65 +-
 drivers/iio/adc/Kconfig                          |    7 +
 drivers/iio/adc/Makefile                         |    1 +
 drivers/{mfd => iio/adc}/ab8500-gpadc.c          |  469 ++++---
 drivers/mfd/Kconfig                              |    7 -
 drivers/mfd/Makefile                             |    1 -
 drivers/mfd/ab8500-debugfs.c                     | 1448 +++-------------------
 drivers/power/supply/ab8500_btemp.c              |   41 +-
 drivers/power/supply/ab8500_charger.c            |   78 +-
 drivers/power/supply/ab8500_fg.c                 |   23 +-
 include/linux/mfd/abx500/ab8500-gpadc.h          |   75 --
 13 files changed, 874 insertions(+), 1562 deletions(-)
 rename drivers/{mfd => iio/adc}/ab8500-gpadc.c (76%)
 delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h

-- 
2.9.3
