From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] User space governor enhancements
Date: Fri, 26 Aug 2016 16:21:15 -0700
Message-ID: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbcHZXVa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 19:21:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Currently user space governor doesn't send any information to user space
thermal controllers other than just some thermal event happened.
This change is addiing some additional properties to user space governor
events so that some meaningful action can take place.
For example if a thermal trip value is changed, then user space needs to
be informed to reload trip value. Also when trip is violated then send
temperature information to avoid another sysfs call.

To enhance user space governor, we also need some mechanism so that
thermal core can be notified from client drivers. This change adds
additional parameter to thermal_zone_device_update() to inform reason/event
code. It is still upto client driver to send any specific event code or not,
in that case they can send an unspecified event.

This series adds first user (int340x driversi) for this new I/F.

Srinivas Pandruvada (4):
  thermal: Enhance thermal_zone_device_update for events
  thermal: user_space gov: Add additional information in uevent
  thermal: int340x: New Interface to read trip and notify
  thermal: int3403: Process trip change notification

 drivers/acpi/thermal.c                             |  3 +-
 drivers/platform/x86/acerhdf.c                     |  2 +-
 drivers/regulator/max8973-regulator.c              |  3 +-
 drivers/thermal/db8500_thermal.c                   |  2 +-
 drivers/thermal/hisi_thermal.c                     |  3 +-
 drivers/thermal/imx_thermal.c                      |  4 +-
 drivers/thermal/int340x_thermal/int3402_thermal.c  |  3 +-
 drivers/thermal/int340x_thermal/int3403_thermal.c  |  9 +++-
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 60 ++++++++++++++--------
 .../thermal/int340x_thermal/int340x_thermal_zone.h |  6 ++-
 .../int340x_thermal/processor_thermal_device.c     |  3 +-
 drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
 drivers/thermal/of-thermal.c                       |  2 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |  2 +-
 drivers/thermal/rcar_thermal.c                     |  3 +-
 drivers/thermal/rockchip_thermal.c                 |  3 +-
 drivers/thermal/samsung/exynos_tmu.c               |  2 +-
 drivers/thermal/st/st_thermal_memmap.c             |  3 +-
 drivers/thermal/thermal_core.c                     | 21 +++++---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  4 +-
 drivers/thermal/user_space.c                       | 15 +++++-
 drivers/thermal/x86_pkg_temp_thermal.c             |  3 +-
 include/linux/thermal.h                            | 19 ++++++-
 23 files changed, 122 insertions(+), 56 deletions(-)

-- 
2.7.4

