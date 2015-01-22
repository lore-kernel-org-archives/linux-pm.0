From: Todd Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Thu, 22 Jan 2015 12:52:04 -0800
Message-ID: <cover.1421957474.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

New power_supply driver at driver/power which interfaces with the
axp20x mfd driver as a cell. Provides battery info, monitors for
changes, and generates alerts on temperature and capacity issues

Todd Brandt (3):
  mfd/axp20x: change battery cell name to fuel gauge
  mfd/axp20x: add support for fuel gauge cell
  X-Power AXP288 PMIC Fuel Gauge Driver

 drivers/mfd/axp20x.c              |    8 +-
 drivers/power/Kconfig             |    9 +
 drivers/power/Makefile            |    1 +
 drivers/power/axp288_fuel_gauge.c | 1148 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h        |   43 +-
 5 files changed, 1203 insertions(+), 6 deletions(-)
 create mode 100644 drivers/power/axp288_fuel_gauge.c

-- 
2.1.0
