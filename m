From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.12-rc1
Date: Fri, 12 May 2017 15:06:27 +0800
Message-ID: <1494572787.3494.54.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61919 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756910AbdELHG1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 May 2017 03:06:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.12-rc1 with
top-most commit cb15c81a0c1c1f7829b9809a209ecacc77f5aa63:

  Merge branch 'thermal-soc' into next (2017-05-06 19:31:19 +0800)

on top of commit 39da7c509acff13fc8cb12ec1bb20337c988ed36:

  Linux 4.11-rc6 (2017-04-09 09:49:44 -0700)

Specifics:
- Fixed a problem that orderly_shutdown() is called for multiple times
  due to multiple critical overheating events raised in a short period
  by platform thermal driver. (Keerthy)
- Introduce a backup thermal shutdown mechanism, which invokes
  kernel_power_off()/emergency_restart() directly, after
  orderly_shutdown() being issued for certain amount of time(specified
  via Kconfig). This is useful in certain conditions that userspace
  may be unable to power off the system in a clean manner and leaves
  the system in a critical state, like in the middle of driver probing
  phase. (Keerthy)
- Introduces a new interface in thermal devfreq_cooling code so that
  the driver can provide more precise data regarding actual power to
  the thermal governor every time the power budget is calculated.
  (Lukasz Luba)
- Introduce BCM 2835 soc thermal driver and northstar thermal driver,
  within a new sub-folder. (Rafał Miłecki)
- Introduce DA9062/61 thermal driver. (Steve Twiss)
- Remove non-DT booting on TI-SoC driver. And also add support to
 
fetching coefficients from DT. (Keerthy)
- Refactoring of RCAR Gen3
thermal driver. (Niklas Söderlund)
- Small fix on MTK and intel-soc-dts thermal driver.
  (Dawei Chien, Brian Bian)

thanks,
rui


----------------------------------------------------------------
Brian Bian (1):
      Thermal: Intel SoC DTS: Change interrupt request behavior

Dawei Chien (1):
      thermal: mt8173: minor mtk_thermal.c cleanups

Keerthy (5):
      thermal: ti-soc-thermal: Fetch slope and offset from DT
      thermal: ti-soc-thermal: Remove redundant constants
      thermal: ti-soc-thermal: Remove redundant code
      thermal: core: Allow orderly_poweroff to be called only once
      thermal: core: Add a back up thermal shutdown mechanism

Lukasz Luba (3):
      thermal: devfreq_cooling: refactor code and add get_voltage
function
      thermal: devfreq_cooling: add new interface for direct power read
      trace: thermal: add another parameter 'power' to the tracing
function

Niklas Söderlund (7):
      thermal: rcar_gen3_thermal: add delay in .thermal_init on r8a7796
      thermal: rcar_gen3_thermal: remove unneeded mutex
      thermal: rcar_gen3_thermal: check that TSC exists before memory
allocation
      thermal: rcar_gen3_thermal: record and check number of TSCs found
      thermal: rcar_gen3_thermal: enable hardware interrupts for trip
points
      thermal: rcar_gen3_thermal: store device match data in private
structure
      thermal: rcar_gen3_thermal: add suspend and resume support

Rafał Miłecki (4):
      dt-bindings: thermal: add support for Broadcom's Northstar
thermal
      thermal: broadcom: add Northstar thermal driver
      thermal: broadcom: ns: specify myself as MODULE_AUTHOR
      thermal: bcm2835: move to the broadcom subdirectory

Stefan Wahren (2):
      dt-bindings: Add thermal zone to bcm2835-thermal example
      thermal: bcm2835: add thermal driver for bcm2835 SoC

Steve Twiss (2):
      Documentation: devicetree: thermal: da9062/61 TJUNC temperature
binding
      thermal: da9062/61: Thermal junction temperature monitoring
driver

Zhang Rui (4):
      Merge branches 'thermal-core' and 'thermal-intel' into next
      Merge branch 'backup-thermal-shutdown' into next
      Merge branch 'linus' of git://git.kernel.org/.../evalenti/linux-
soc-thermal into thermal-soc
      Merge branch 'thermal-soc' into next

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  32 ++-
 .../devicetree/bindings/thermal/brcm,ns-thermal    |  37 +++
 .../devicetree/bindings/thermal/da9062-thermal.txt |  36 +++
 Documentation/thermal/sysfs-api.txt                |  21 ++
 drivers/thermal/Kconfig                            |  32 +++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/broadcom/Kconfig                   |  16 ++
 drivers/thermal/broadcom/Makefile                  |   2 +
 drivers/thermal/broadcom/bcm2835_thermal.c         | 314
++++++++++++++++++++
 drivers/thermal/broadcom/ns-thermal.c              | 106 +++++++
 drivers/thermal/da9062-thermal.c                   | 315
+++++++++++++++++++++
 drivers/thermal/devfreq_cooling.c                  | 152 +++++++---
 drivers/thermal/intel_soc_dts_thermal.c            |   9 +-
 drivers/thermal/mtk_thermal.c                      |   2 +-
 drivers/thermal/rcar_gen3_thermal.c                | 199 ++++++++++++-
 drivers/thermal/thermal_core.c                     |  64 ++++-
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  10 -
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    |   4 -
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   6 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   4 -
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   4 -
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 158 +----------
 drivers/thermal/ti-soc-thermal/ti-thermal.h        |  16 --
 include/linux/devfreq_cooling.h                    |  19 ++
 include/trace/events/thermal.h                     |  11 +-
 25 files changed, 1305 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-
thermal
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-
thermal.txt
 create mode 100644 drivers/thermal/broadcom/Kconfig
 create mode 100644 drivers/thermal/broadcom/Makefile
 create mode 100644 drivers/thermal/broadcom/bcm2835_thermal.c
 create mode 100644 drivers/thermal/broadcom/ns-thermal.c
 create mode 100644 drivers/thermal/da9062-thermal.c
