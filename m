From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.10-rc1
Date: Tue, 13 Dec 2016 13:48:06 +0800
Message-ID: <1481608086.2083.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.10-rc1 with
top-most commit 0faf7dd5a947006978b549dfe29a01b710becf4a:

  MAINTAINERS: Samsung: Update maintainer for PWM FAN and SAMSUNG
THERMAL (2016-12-13 11:20:23 +0800)

on top of commit 23400ac997062647f2b63c82030d189671b1effe:

  Merge branch 'for-rc' of
git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux (2016-11-22
13:53:01 -0800)

Specifics:

- Thermal core code reorganization and cleanup. Two new files are
  created for thermal sysfs I/F code and thermal helper functions.
  From: Eduardo Valentin.

- Sanitize hotplug and locking for x86_pkg_temp driver.
  From: Thomas Gleixner.

- Update MAINTAINER file for pwm-fan driver and Samsung thermal driver.
  From: Lukasz Majewski.

- Fix module auto-load for max77620, tango and db8500 thermal driver.
  From: Javier Martinez Canillas.

- Fix a bug that thermal hwmon sysfs I/F returns wrong critical trip
  point temperature value. From: Krzysztof Kozlowski.

- Add Skylake PCH 100 series support for intel_pch_thermal driver.
  From: OGAWA Hirofumi.

- Small fixes and cleanups for platform thermal drivers.
  From Julia Lawall, Luis Henriques, Leo Yan, Stephen Boyd,
  Shawn Lin, Javi Merino and Lukasz Luba.

thanks,
rui

----------------------------------------------------------------
Eduardo Valentin (49):
      thermal: core: prevent zones with no types to be registered
      thermal: core: group thermal_zone DEVICE_ATTR's declarations
      thermal: core: group device_create_file() calls that are always
created
      thermal: core: use dev.groups to manage always present tz
attributes
      thermal: core: move emul_temp creation to tz->device.groups
      thermal: core: move mode attribute to tz->device.groups
      thermal: core: move passive attr to tz->device.groups
      thermal: core: improve power actor documentation
      thermal: core: move power actor code out of sysfs I/F section
      thermal: core: remove useless empty line
      thermal: core: fix style on remove_trip_attrs()
      thermal: core: move the trip attrs to the tz sysfs I/F section
      thermal: core: create tz->device.groups dynamically
      thermal: core: move trips attributes to tz->device.groups
      thermal: core: remove unnecessary device_remove() calls
      thermal: core: split passive_store
      thermal: core: split policy_store
      thermal: core: split available_policies_show()
      thermal: core: move to_thermal_zone() macro to header file
      thermal: core: treat correctly the return value of *scanf calls
      thermal: core: match parenthesis on code alignment
      thermal: core: move thermal_zone sysfs to thermal_sysfs.c
      thermal: core: move to_cooling_device macro to header file
      thermal: core: move cooling device sysfs to thermal_sysfs.c
      thermal: core: remove a couple of style issues on helpers
      thermal: core: introduce thermal_helpers.c
      thermal: core: group functions related to governor handling
      thermal: core: move idr handling to device management section
      thermal: core: small style fix on __unbind() helper
      thermal: core: move __unbind() helper to where it is used
      thermal: core: move bind_cdev() to where it is used
      thermal: core: move bind_tz() to where it is used
      thermal: core: fix couple of style issues on __bind() helper
      thermal: core: move __bind() to where it is used
      thermal: core: add inline to print_bind_err_msg()
      thermal: core: move notify to the zone update section
      thermal: core: add a comment describing the main update loop
      thermal: core: add a comment describing the power actor section
      thermal: core: add a comment describing the device management
section
      thermal: sysfs: remove symbols of emul_temp when config is
disabled
      thermal: core: remove FSF address in the GPL notice
      thermal: core: small style fix when checking for
__find_governor()
      thermal: core: standardize line breaking alignment
      thermal: core: remove void function return statements
      thermal: core: remove style warnings and checks
      thermal: core: improve kerneldoc entry of
thermal_cooling_device_unregister
      thermal: core: use kzalloc(sizeof(*ptr),...)
      thermal: sysfs: use kcalloc() instead of kzalloc()
      thermal: core: move slop and offset helpers to thermal_helpers.c

Javi Merino (1):
      devfreq_cooling: pass a pointer to devfreq in the power model
callbacks

Javier Martinez Canillas (3):
      thermal: max77620: Fix module autoload
      thermal: tango: Fix module autoload
      thermal: db8500: Fix module autoload

Julia Lawall (2):
      thermal: hwmon: use permission-specific DEVICE_ATTR variants
      thermal: int340x_thermal: use permission-specific DEVICE_ATTR
variants

Krzysztof Kozlowski (1):
      thermal: hwmon: Properly report critical temperature in sysfs

Leo Yan (1):
      thermal: hisilicon: fix for dependency

Luis Henriques (1):
      thermal: ti-soc-thermal: add missing clk_put()

Lukasz Luba (1):
      devfreq_cooling: make the structs devfreq_cooling_xxx visible for
all

Lukasz Majewski (1):
      MAINTAINERS: Samsung: Update maintainer for PWM FAN and SAMSUNG
THERMAL

OGAWA Hirofumi (1):
      thermal: intel_pch_thermal: Support skylake PCH 100 series
thermal

Sebastian Andrzej Siewior (1):
      thermal/x86 pkg temp: Convert to hotplug state machine

Shawn Lin (2):
      thermal: rockchip: improve the warning log
      dt-bindings: rockchip-thermal: fix the misleading description

Stephen Boyd (1):
      thermal: qcom-spmi: Treat reg property as a single cell

Thomas Gleixner (11):
      thermal/x86_pkg_temp: Cleanup thermal interrupt handling
      thermal/x86_pkg_temp: Remove redundant package search
      thermal/x86_pkg_temp: Replace open coded cpu search
      thermal/x86_pkg_temp: Sanitize callback (de)initialization
      thermal/x86_pkg_temp: Get rid of ref counting
      thermal/x86_pkg_temp: Cleanup namespace
      thermal/x86_pkg_temp: Cleanup code some more
      thermal/x86_pkg_temp: Sanitize locking
      thermal/x86_pkg_temp: Move work scheduled flag into package
struct
      thermal/x86_pkg_temp: Move work into package struct
      thermal/x86_pkg_temp: Sanitize package management

Zhang Rui (1):
      Merge branches 'thermal-core', 'thermal-intel', 'thermal-soc-
fixes' and 'thermal-reorg' into next

 .../bindings/thermal/rockchip-thermal.txt          |    3 +
 MAINTAINERS                                        |    4 +-
 drivers/thermal/Kconfig                            |    4 +-
 drivers/thermal/Makefile                           |    3 +-
 drivers/thermal/db8500_thermal.c                   |    1 +
 drivers/thermal/devfreq_cooling.c                  |    5 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |    2 +-
 drivers/thermal/intel_pch_thermal.c                |   64 +-
 drivers/thermal/max77620_thermal.c                 |    1 +
 drivers/thermal/qcom-spmi-temp-alarm.c             |    6 +-
 drivers/thermal/rockchip_thermal.c                 |    7 +-
 drivers/thermal/tango_thermal.c                    |    1 +
 drivers/thermal/thermal_core.c                     | 1446 +++++-------
--------
 drivers/thermal/thermal_core.h                     |   26 +
 drivers/thermal/thermal_helpers.c                  |  226 +++
 drivers/thermal/thermal_hwmon.c                    |    4 +-
 drivers/thermal/thermal_sysfs.c                    |  771 +++++++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |    5 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |  587 ++++----
 include/linux/devfreq_cooling.h                    |    9 +-
 include/linux/thermal.h                            |    2 +
 21 files changed, 1650 insertions(+), 1527 deletions(-)
 create mode 100644 drivers/thermal/thermal_helpers.c
 create mode 100644 drivers/thermal/thermal_sysfs.c
