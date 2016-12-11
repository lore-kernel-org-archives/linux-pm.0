From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] iio: GPIO power switch support
Date: Sun, 11 Dec 2016 23:21:43 +0100
Message-ID: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series is aimed at improving the support for baylibre-acme[1]
power measurement capes. 

We would like to add support for power-cycling of devices measured
using TI INA226 ADCs. An example use case would be measuring the power
consumption of a development board during boot and power-cycling it
remotely using a GPIO power switch.

The first patch proposes to add a new DT binding for describing simple
power switches.

The second adds a simple IIO driver exposing a single attribute.

The motivation for using the IIO framework is the fact that we already
use it for reading the data from the ADC and that power-cycling the
measured devices is an integral part of our use case. Users would find
it convenient to be able to use libiio as the single interface.

[1] http://baylibre.com/acme/

Bartosz Golaszewski (2):
  devicetree: power: add bindings for GPIO-driven power switches
  iio: misc: add support for GPIO power switches

 .../bindings/power/gpio-power-switch.txt           |  25 ++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/misc/Kconfig                           |  17 +++
 drivers/iio/misc/Makefile                          |   6 +
 drivers/iio/misc/gpio-power-switch.c               | 127 +++++++++++++++++++++
 6 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/gpio-power-switch.txt
 create mode 100644 drivers/iio/misc/Kconfig
 create mode 100644 drivers/iio/misc/Makefile
 create mode 100644 drivers/iio/misc/gpio-power-switch.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
