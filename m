From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/6] thermal: iio bindings
Date: Sat, 26 Sep 2015 15:05:05 -0700
Message-ID: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23247 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258AbbIZWFk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Sep 2015 18:05:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v0
Since this was discussed during LPC in Seattle and three versions of RFC are
published and reviwed, this is posted as non RFC version. This has
changes in iio interface file as suggested by Jonathan. We may add threshold
event direction flag later if required, without much impact by adding new
event type.

RFC v2
- Rebase to 4.3.rc1
- Additional parameter to thermal_zone_device_update for event type
- Moved the dummy IIO callbacks to local include file, in this
way "not used" warnings can be avoided
- Remove changes from user space governor, rather notify from core
- Validate the trigger, so that when thermal device supports async
notifications, this will be exclusive trigger
- Use new thermal core event type to differentiate events for iio
threshold notification

RFC v1
- Change commit message to be more clear
- Split in three patches (First for thermal_iio.c, second to integrate
to thermal_core and third for user space governor).
- Removed IIO defines in thermal.h
- Removed direct push to buffers
- Other comments from Jonathan except introduce validate_trigger

RFC v0
Base version for first review

Srinivas Pandruvada (6):
  thermal: core: enhance thermal_zone_device_update
  thermal: documentation update
  thermal: iio device for thermal sensor
  thermal: use iio binding calls
  thermal: iio Documentation
  thermal: x86_pkg_temp: Register threshold callbacks

 Documentation/thermal/sysfs-api.txt                |  10 +
 Documentation/thermal/thermal_iio_binding          |  88 +++++
 drivers/acpi/thermal.c                             |   2 +-
 drivers/platform/x86/acerhdf.c                     |   2 +-
 drivers/thermal/Kconfig                            |  12 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/hisi_thermal.c                     |   3 +-
 drivers/thermal/imx_thermal.c                      |   4 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.h |   2 +-
 drivers/thermal/intel_soc_dts_iosf.c               |   3 +-
 drivers/thermal/of-thermal.c                       |   2 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |   2 +-
 drivers/thermal/rcar_thermal.c                     |   3 +-
 drivers/thermal/rockchip_thermal.c                 |   3 +-
 drivers/thermal/samsung/exynos_tmu.c               |   2 +-
 drivers/thermal/st/st_thermal_memmap.c             |   3 +-
 drivers/thermal/thermal_core.c                     |  21 +-
 drivers/thermal/thermal_iio.c                      | 383 +++++++++++++++++++++
 drivers/thermal/thermal_iio.h                      |  45 +++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   4 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |  11 +-
 include/linux/thermal.h                            |  26 +-
 23 files changed, 609 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/thermal/thermal_iio_binding
 create mode 100644 drivers/thermal/thermal_iio.c
 create mode 100644 drivers/thermal/thermal_iio.h

-- 
2.4.3

