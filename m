From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.8-rc1
Date: Wed,  3 Aug 2016 15:58:47 -0700
Message-ID: <1470265127-22631-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal SoC Management updates for v4.8-rc1 with top-most

95170abf9a3320a2e4215ce9106569e5344b87f0:

  thermal: trivial: fix the typo (2016-07-01 20:05:59 -0700)

on top of commit b02b1fbdd338f70e49efa9ca9899214134526701:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2016-05-29 13:28:39 -0700)

----------------------------------------------------------------
Caesar Wang (4):
      thermal: rockchip: add the set_trips function
      thermal: rockchip: fixes the period time for tsadc
      thermal: rockchip: fixes the exception interrupts
      thermal: trivial: fix the typo

Eduardo Valentin (65):
      thermal: core: prevent zones with no types to be registered
      thermal: core: group thermal_zone DEVICE_ATTR's declarations
      thermal: core: group device_create_file() calls that are always created
      thermal: core: use dev.groups to manage always present tz attributes
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
      thermal: core: add a comment describing the device management section
      thermal: sysfs: remove symbols of emul_temp when config is disabled
      thermal: core: remove FSF address in the GPL notice
      thermal: core: small style fix when checking for __find_governor()
      thermal: core: standardize line breaking alignment
      thermal: core: remove void function return statements
      thermal: core: remove style warnings and checks
      thermal: core: improve kerneldoc entry of thermal_cooling_device_unregister
      thermal: core: use kzalloc(sizeof(*ptr),...)
      thermal: sysfs: use kcalloc() instead of kzalloc()
      thermal: sysfs: lock tz in type_show
      thermal: sysfs: lock tz while on access to mode properties
      thermal: sysfs: lock tz while on trip_point_type properties
      thermal: sysfs: lock tz while on trip_point_temp properties
      thermal: sysfs: lock tz while on trip_point_hyst properties
      thermal: sysfs: lock tz while on passive properties
      thermal: sysfs: lock tz while on policy properties
      thermal: sysfs: improve locking of emul_temp_store()
      thermal: sysfs: lock tz when access sustainable power properties
      thermal: sysfs: lock tz when access tzp properties
      thermal: sysfs: lock cdev while accessing type
      thermal: sysfs: lock cdev while accessing max_state
      thermal: sysfs: lock cdev while accessing cur_state
      thermal: sysfs: serialize access to instances
      thermal: sysfs: add comments describing locking strategy
      thermal: qcom: remove declare local symbols as static
      thermal: core: move slop and offset helpers to thermal_helpers.c

Keerthy (1):
      thermal: of-thermal: Fix setting of set_emul_temp hook

Rajendra Nayak (6):
      thermal: qcom: tsens: Add a skeletal TSENS drivers
      thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
      thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
      thermal: core: export apis to get slope and offset
      thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
      thermal: qcom: tsens-8996: Add support for 8996 family of SoCs

Sascha Hauer (4):
      thermal: Add support for hardware-tracked trip points
      thermal: of: implement .set_trips for device tree thermal zones
      thermal: streamline get_trend callbacks
      thermal: bang-bang governor: act on lower trip boundary

 .../devicetree/bindings/thermal/qcom-tsens.txt     |   21 +
 .../devicetree/bindings/thermal/thermal.txt        |   10 +-
 Documentation/thermal/sysfs-api.txt                |   19 +
 drivers/acpi/thermal.c                             |    1 -
 drivers/platform/x86/acerhdf.c                     |    1 -
 drivers/thermal/Kconfig                            |    5 +
 drivers/thermal/Makefile                           |    4 +-
 drivers/thermal/gov_bang_bang.c                    |    2 +-
 drivers/thermal/imx_thermal.c                      |    1 -
 drivers/thermal/of-thermal.c                       |   47 +-
 drivers/thermal/qcom/Kconfig                       |   11 +
 drivers/thermal/qcom/Makefile                      |    2 +
 drivers/thermal/qcom/tsens-8916.c                  |  113 ++
 drivers/thermal/qcom/tsens-8960.c                  |  292 ++++
 drivers/thermal/qcom/tsens-8974.c                  |  244 ++++
 drivers/thermal/qcom/tsens-8996.c                  |   84 ++
 drivers/thermal/qcom/tsens-common.c                |  141 ++
 drivers/thermal/qcom/tsens.c                       |  200 +++
 drivers/thermal/qcom/tsens.h                       |   94 ++
 drivers/thermal/rockchip_thermal.c                 |   93 +-
 drivers/thermal/thermal_core.c                     | 1395 +++++---------------
 drivers/thermal/thermal_core.h                     |   26 +
 drivers/thermal/thermal_helpers.c                  |  174 +++
 drivers/thermal/thermal_sysfs.c                    |  855 ++++++++++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   30 +-
 include/linux/thermal.h                            |   28 +-
 26 files changed, 2778 insertions(+), 1115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 drivers/thermal/qcom/Kconfig
 create mode 100644 drivers/thermal/qcom/Makefile
 create mode 100644 drivers/thermal/qcom/tsens-8916.c
 create mode 100644 drivers/thermal/qcom/tsens-8960.c
 create mode 100644 drivers/thermal/qcom/tsens-8974.c
 create mode 100644 drivers/thermal/qcom/tsens-8996.c
 create mode 100644 drivers/thermal/qcom/tsens-common.c
 create mode 100644 drivers/thermal/qcom/tsens.c
 create mode 100644 drivers/thermal/qcom/tsens.h
 create mode 100644 drivers/thermal/thermal_helpers.c
 create mode 100644 drivers/thermal/thermal_sysfs.c
