From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/4] Add support for DA9150 Fuel-Gauge
Date: Fri, 26 Jun 2015 09:47:38 +0100
Message-ID: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch set adds support for the Dialog DA9150 Fuel-Gauge.

In this patch set the following is provided:
 - MFD Core and DT bindings updates.
 - Power Supply Fuel-Gauge support and DT bindings documentation.

This patch set is baselined against the v4.1 kernel version.

Changes in v2:
 - Moved temp callback function prototype to be part of power fuel-gauge patch,
   as requested by Lee Jones.

Adam Thomson (4):
  mfd: da9150: Add support for Fuel-Gauge
  mfd: da9150: Update DT bindings for Fuel-Gauge support
  power: Add support for DA9150 Fuel-Gauge
  power: da9150: Add DT bindings documentation for Fuel-Gauge

 Documentation/devicetree/bindings/mfd/da9150.txt   |   6 +
 .../devicetree/bindings/power/da9150-fg.txt        |  23 +
 drivers/mfd/da9150-core.c                          | 162 +++++-
 drivers/power/Kconfig                              |  10 +
 drivers/power/Makefile                             |   1 +
 drivers/power/da9150-fg.c                          | 589 +++++++++++++++++++++
 include/linux/mfd/da9150/core.h                    |  19 +
 include/linux/mfd/da9150/fg.h                      |  39 ++
 8 files changed, 841 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt
 create mode 100644 drivers/power/da9150-fg.c
 create mode 100644 include/linux/mfd/da9150/fg.h

--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
