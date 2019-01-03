From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.21-rc1
Date: Fri, 04 Jan 2019 02:43:14 +0800
Message-ID: <1546540994.2072.26.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal management updates for v4.21-rc1 with
top-most commit 24ef9ec891c761483c5270528781b8637b908eef:

  thermal/intel: fixup for Kconfig string parsing tightening up (2019-
01-03 23:52:28 +0800)

on top of commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

Note that commit 8636a1f9677d ("treewide: surround Kconfig file paths
with double quotes") makes some change to drivers/thermal/Kconfig, and
introduces a merge conflict. A manual merge is needed and commit
24ef9ec891c7 ("thermal/intel: fixup for Kconfig string parsing
tightening up") is applied in my tree in the last minute (it was kept
by Stephen Rothwell in linux-next previously).

Specifics:

- Add locking for cooling device sysfs attribute in case the cooling
device state is changed by userspace and thermal framework
simultaneously. (Thara Gopinath)

- Fix a problem that passive cooling is reset improperly after system
suspend/resume. (Wei Wang)

- Cleanup the driver/thermal/ directory by moving intel and qcom
platform specific drivers to platform specific sub-directories. (Amit
Kucheria)

- Some trivial cleanups. (Lukasz Luba, Wolfram Sang)

thanks,
rui



----------------------------------------------------------------
Amit Kucheria (2):
      drivers: thermal: Move various drivers for intel platforms into a
subdir
      drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir

Lukasz Luba (1):
      thermal: remove unused function parameter

Stephen Rothwell (1):
      thermal/intel: fixup for Kconfig string parsing tightening up

Thara Gopinath (1):
      thermal: Fix locking in cooling device sysfs update cur_state

Wei Wang (1):
      Thermal: do not clear passive state during system sleep

Wolfram Sang (5):
      thermal: int340x_thermal: int3400_thermal: simplify getting
.driver_data
      thermal: rockchip_thermal: simplify getting .driver_data
      thermal: spear_thermal: simplify getting .driver_data
      thermal: st: st_thermal: simplify getting .driver_data
      thermal: zx2967_thermal: simplify getting .driver_data

Zhang Rui (1):
      Merge branches 'for-rc' and 'thermal-core' into next

 drivers/thermal/Kconfig                            | 94 ++----------
----------
 drivers/thermal/Makefile                           | 10 +--
 drivers/thermal/intel/Kconfig                      | 77
++++++++++++++++++
 drivers/thermal/intel/Makefile                     | 12 +++
 .../thermal/{ => intel}/int340x_thermal/Kconfig    |  0
 .../thermal/{ => intel}/int340x_thermal/Makefile   |  0
 .../{ => intel}/int340x_thermal/acpi_thermal_rel.c |  0
 .../{ => intel}/int340x_thermal/acpi_thermal_rel.h |  0
 .../{ => intel}/int340x_thermal/int3400_thermal.c  |  9 +--
 .../{ => intel}/int340x_thermal/int3402_thermal.c  |  0
 .../{ => intel}/int340x_thermal/int3403_thermal.c  |  0
 .../{ => intel}/int340x_thermal/int3406_thermal.c  |  0
 .../int340x_thermal/int340x_thermal_zone.c         |  0
 .../int340x_thermal/int340x_thermal_zone.h         |  0
 .../int340x_thermal/processor_thermal_device.c     |  0
 .../thermal/{ => intel}/intel_bxt_pmic_thermal.c   |  0
 drivers/thermal/{ => intel}/intel_pch_thermal.c    |  0
 drivers/thermal/{ => intel}/intel_powerclamp.c     |  0
 .../thermal/{ => intel}/intel_quark_dts_thermal.c  |  0
 drivers/thermal/{ => intel}/intel_soc_dts_iosf.c   |  0
 drivers/thermal/{ => intel}/intel_soc_dts_iosf.h   |  0
 .../thermal/{ => intel}/intel_soc_dts_thermal.c    |  0
 drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c |  0
 drivers/thermal/qcom/Kconfig                       | 11 +++
 drivers/thermal/qcom/Makefile                      |  1 +
 drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c  |  2 +-
 drivers/thermal/rockchip_thermal.c                 |  8 +-
 drivers/thermal/spear_thermal.c                    |  8 +-
 drivers/thermal/st/st_thermal.c                    |  6 +-
 drivers/thermal/thermal_core.c                     | 18 +++--
 drivers/thermal/thermal_sysfs.c                    | 11 ++-
 drivers/thermal/zx2967_thermal.c                   |  6 +-
 32 files changed, 138 insertions(+), 135 deletions(-)
 create mode 100644 drivers/thermal/intel/Kconfig
 create mode 100644 drivers/thermal/intel/Makefile
 rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c
(100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h
(100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c
(96%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c
(100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c
(100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c
(100%)
 rename drivers/thermal/{ =>
intel}/int340x_thermal/int340x_thermal_zone.c (100%)
 rename drivers/thermal/{ =>
intel}/int340x_thermal/int340x_thermal_zone.h (100%)
 rename drivers/thermal/{ =>
intel}/int340x_thermal/processor_thermal_device.c (100%)
 rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
 rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
 rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (99%)
