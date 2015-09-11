From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.3-rc1
Date: Fri, 11 Sep 2015 10:55:14 +0800
Message-ID: <1441940114.22114.14.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4220 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbbIKCzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 22:55:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.3-rc1 with
top-most commit 5a924a07f882e866f2337bf65048be357956691a:

  Merge branches 'thermal-core' and 'thermal-intel' of .git into next
(2015-09-02 10:08:02 +0800)

on top of commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:

  Linux 4.2 (2015-08-30 11:34:09 -0700)


Specifics:

- use int instead of unsigned long to represent temperature to avoid
bogus overheat detection when negative temperature reported. From:
Sascha Hauer.

- export available thermal governors information to user space via
sysfs. From: Wei Ni.

- introduce new thermal driver for Wildcat Point platform controller
hub, which uses PCH thermal sensor and associated critical and hot trip
points. From: Tushar Dave.

- add suuport for Intel Skylake and Denlow platforms in powerclamp
driver.

- some small cleanups in thermal core.

thanks,
rui
----------------------------------------------------------------

Jacob Pan (1):
      thermal/powerclamp: add cpu id for denlow platform

Ni Wade (1):
      thermal: add available policies sysfs attribute

Radivoje Jovanovic (2):
      thermal/powerclamp: add cpu id for skylake h/s
      thermal/powerclamp: add cpu id for Skylake u/y

Sascha Hauer (5):
      thermal: consistently use int for temperatures
      thermal: trivial: fix typo in comment
      thermal: remove unnecessary call to
thermal_zone_device_set_polling
      thermal: Use IS_ENABLED instead of #ifdef
      thermal: Add comment explaining test for critical temperature

Tushar Dave (1):
      thermal: Add Intel PCH thermal driver

Zhang Rui (1):
      Merge branches 'thermal-core' and 'thermal-intel' of .git into
next

 Documentation/thermal/sysfs-api.txt                |   6 +
 drivers/acpi/thermal.c                             |  12 +-
 drivers/hwmon/lm75.c                               |   2 +-
 drivers/hwmon/ntc_thermistor.c                     |   2 +-
 drivers/hwmon/tmp102.c                             |   2 +-
 drivers/input/touchscreen/sun4i-ts.c               |   8 +-
 drivers/platform/x86/acerhdf.c                     |   9 +-
 drivers/platform/x86/intel_mid_thermal.c           |   9 +-
 drivers/power/charger-manager.c                    |   2 +-
 drivers/power/power_supply_core.c                  |   2 +-
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/armada_thermal.c                   |   2 +-
 drivers/thermal/db8500_thermal.c                   |   7 +-
 drivers/thermal/dove_thermal.c                     |   2 +-
 drivers/thermal/fair_share.c                       |   2 +-
 drivers/thermal/gov_bang_bang.c                    |   5 +-
 drivers/thermal/hisi_thermal.c                     |   4 +-
 drivers/thermal/imx_thermal.c                      |  27 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   2 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.c |  10 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.h |   8 +-
 .../int340x_thermal/processor_thermal_device.c     |   4 +-
 drivers/thermal/intel_pch_thermal.c                | 286
+++++++++++++++++++++
 drivers/thermal/intel_powerclamp.c                 |   3 +
 drivers/thermal/intel_quark_dts_thermal.c          |  13 +-
 drivers/thermal/intel_soc_dts_iosf.c               |   8 +-
 drivers/thermal/kirkwood_thermal.c                 |   2 +-
 drivers/thermal/of-thermal.c                       |  14 +-
 drivers/thermal/power_allocator.c                  |  16 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |   2 +-
 drivers/thermal/rcar_thermal.c                     |   7 +-
 drivers/thermal/rockchip_thermal.c                 |  10 +-
 drivers/thermal/samsung/exynos_tmu.c               |  23 +-
 drivers/thermal/spear_thermal.c                    |   2 +-
 drivers/thermal/st/st_thermal.c                    |   5 +-
 drivers/thermal/step_wise.c                        |   4 +-
 drivers/thermal/tegra_soctherm.c                   |   4 +-
 drivers/thermal/thermal_core.c                     | 109 ++++----
 drivers/thermal/thermal_hwmon.c                    |  10 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  10 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |  10 +-
 include/linux/thermal.h                            |  26 +-
 include/trace/events/thermal_power_allocator.h     |   6 +-
 44 files changed, 509 insertions(+), 197 deletions(-)
 create mode 100644 drivers/thermal/intel_pch_thermal.c


