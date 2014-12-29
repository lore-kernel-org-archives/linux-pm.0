From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.19-rc3
Date: Mon, 29 Dec 2014 11:20:02 +0800
Message-ID: <1419823202.26749.27.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33276 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbaL2DUN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 28 Dec 2014 22:20:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to get the latest Thermal Management changes for 3.19-rc3 with top-most
commit 7429b1e0d00e62426c74a45195ba72149cb9ad64:

  Merge branches 'thermal-core', 'thermal-soc' and 'thermal-int340x'
of .git into next (2014-12-24 10:38:30 +0800)

on top of commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

These things were supposed to be sent for 3.19-rc2, but I just noticed
that 3.19-rc2 was released today.

First of all, the most important change is the thermal cpu cooling
fixes. The major fix here is to have proper sequencing between cpufreq
layer and thermal cpu cooling registration. A take away of this fix is
an improvement in the thermal drivers code. Thermal drivers that require
cpu cooling do not need to check for cpufreq layer. The requirement now
is to propagate the error code, if any, while registering cpu cooling
device. Thanks to Viresh for implementing the required CPUfreq changes.

Second, a new driver is introduced for int340x processor thermal device.
Given that int340x thermal is disabled by default, and this processor
thermal device is only available on limited platforms, plus the driver
does nothing but exposes some thermal limitation information for user
space to use, thus I think it is safe to include it in this pull request
after missing 3.19-rc2.

Specifics:

- Thermal cpu cooling fixes and cleanups.

- introduce INT340X processor thermal reporting device driver. 

- several small fixes and cleanups for int340x thermal drivers.

thanks,
rui

----------------------------------------------------------------

Abhilash Kesavan (1):
      drivers: thermal: Remove ARCH_HAS_BANDGAP dependency for samsung

Dan Carpenter (1):
      thermal: cpu_cooling: small memory leak on error

Eduardo Valentin (3):
      thermal: cpu_cooling: check for the readiness of cpufreq layer
      thermal: db8500: Do not print error message in the EPROBE_DEFER
case
      thermal: ti-soc-thermal: Do not print error message in the
EPROBE_DEFER case

Fabio Estevam (1):
      thermal: imx: Do not print error message in the EPROBE_DEFER case

Ilkka Koskinen (1):
      Thermal/int340x: Handle properly the case when _trt or _art acpi
entry is missing

Jacob Pan (1):
      thermal/powerclamp: add ids for future xeon cpus

Javi Merino (2):
      thermal: cpu_cooling: return ERR_PTR() for !CPU_THERMAL or !
THERMAL_OF
      thermal: cpu_cooling: document node in struct
cpufreq_cooling_device

Lukasz Majewski (1):
      thermal:core:fix: Check return code of the ->get_max_state()
callback

Punit Agrawal (1):
      thermal: Fix cdev registration with THERMAL_NO_LIMIT on 64bit

Srinivas Pandruvada (4):
      thermal: int340x: Introduce processor reporting device
      Thermal/int340x/int3403: Fix memory leak
      Thermal/int340x/processor_thermal: Fix memory leak
      Thermal/int340x/int3403: Free acpi notification handler

Viresh Kumar (25):
      thermal: db8500: pass cpu_present_mask to
cpufreq_cooling_register()
      thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
      thermal: exynos: pass cpu_present_mask to
cpufreq_cooling_register()
      thermal: cpu_cooling: random comment fixups
      thermal: cpu_cooling: fix doc comment over struct
cpufreq_cooling_device
      thermal: cpu_cooling: Add comment to clarify relation between
cooling state and frequency
      thermal: cpu_cooling: Pass variable instead of its type to
sizeof()
      thermal: cpu_cooling: no need to set cpufreq_state to zero
      thermal: cpu_cooling: no need to set cpufreq_dev to NULL
      thermal: cpu_cooling: no need to initialze 'ret'
      thermal: cpu_cooling: propagate error returned by idr_alloc()
      thermal: cpu_cooling: Don't match min/max frequencies for all CPUs
on cooling register
      thermal: cpu_cooling: don't iterate over all allowed_cpus to
update cpufreq policy
      thermal: cpu_cooling: Don't check is_cpufreq_valid()
      thermal: cpu_cooling: do error handling at the bottom in
__cpufreq_cooling_register()
      thermal: cpu_cooling: initialize 'cpufreq_val' on registration
      thermal: cpu_cooling: Merge cpufreq_apply_cooling() into
cpufreq_set_cur_state()
      thermal: cpu_cooling: remove unnecessary wrapper
get_cpu_frequency()
      thermal: cpu_cooling: find max level during device registration
      thermal: cpu_cooling: get_property() doesn't need to support
GET_MAXL anymore
      thermal: cpu_cooling: use cpufreq_dev_list instead of
cpufreq_dev_count
      thermal: cpu_cooling: Pass 'cpufreq_dev' to get_property()
      thermal: cpu_cooling: Store frequencies in descending order
      thermal: cpu_cooling: Use cpufreq_dev->freq_table for finding
level/freq
      thermal: cpu_cooling: update copyright tags

Wolfram Sang (2):
      thermal: drop owner assignment from platform_drivers
      thermal: int340x_thermal: drop owner assignment from
platform_drivers

Zhang Rui (2):
      Merge branch 'fixes' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into thermal-soc
      Merge branches 'thermal-core', 'thermal-soc' and 'thermal-int340x'
of .git into next

 drivers/thermal/cpu_cooling.c                      | 360
++++++++-------------
 drivers/thermal/db8500_cpufreq_cooling.c           |  20 +-
 drivers/thermal/imx_thermal.c                      |  15 +-
 drivers/thermal/int340x_thermal/Makefile           |   1 +
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c |   8 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   1 -
 drivers/thermal/int340x_thermal/int3402_thermal.c  |   1 -
 drivers/thermal/int340x_thermal/int3403_thermal.c  |   4 +
 .../int340x_thermal/processor_thermal_device.c     | 309
++++++++++++++++++
 drivers/thermal/intel_powerclamp.c                 |   1 +
 drivers/thermal/rockchip_thermal.c                 |   1 -
 drivers/thermal/samsung/Kconfig                    |   2 +-
 drivers/thermal/samsung/exynos_thermal_common.c    |  12 +-
 drivers/thermal/samsung/exynos_tmu.c               |   5 +-
 drivers/thermal/thermal_core.c                     |   6 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  17 +-
 include/dt-bindings/thermal/thermal.h              |   2 +-
 include/linux/cpu_cooling.h                        |   6 +-
 include/linux/thermal.h                            |   2 +-
 19 files changed, 497 insertions(+), 276 deletions(-)
 create mode 100644
drivers/thermal/int340x_thermal/processor_thermal_device.c


