From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] thermal management fixes for v3.12-rc7
Date: Wed, 23 Oct 2013 09:30:28 +0800
Message-ID: <1382491828.2186.6.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52270 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab3JWBac (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Oct 2013 21:30:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, eduardo <eduardo.valentin@ti.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lukasz Majewski <l.majewski@samsung.com>

Hi, Linus,

please pull from git repository at

git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive Thermal management fixes for v3.12-rc7 with
top-most commit 167c3ad268c2643b926d693f402e893ce64857a8:

  Merge branch 'x86_pkg_temp' of .git into for-rc (2013-10-21 11:26:45
+0800)

on top of commit 22356f447ceb8d97a4885792e7d9e4607f712e1b:

  mm: Place preemption point in do_mlockall() loop (2013-09-24 19:44:40
-0700)

These includes several commits that are necessary to properly fix
regression for TMU test MUX address setting after reset, for exynos
thermal driver.

Specifics:

- fix a regression that the removal of setting a certain field at TMU
configuration setting results in immediately shutdown after reset
on Exynos4412 SoC.

- revert a patch which tries to link the thermal_zone device
and its hwmon node but breaks libsensors.

- fix a deadlock/lockdep warning issue in x86_pkg_temp thermal driver,
which can be reproduced on a buggy platform only.

- fix ti-soc-thermal driver to fall back on bandgap reading when reading
from PCB temperature sensor fails.

thanks,
rui

----------------------------------------------------------------

Eduardo Valentin (1):
      drivers: thermal: allow ti-soc-thermal run without pcb zone

Lukasz Majewski (3):
      thermal: exynos: Remove check for thermal device pointer at
exynos_report_trigger()
      thermal: exynos: Provide separate TMU data for Exynos4412
      thermal: exynos: Provide initial setting for TMU's test MUX
address at Exynos4412

Srinivas Pandruvada (1):
      Thermal: x86_pkg_temp: change spin lock

Zhang Rui (2):
      Revert "drivers: thermal: parent virtual hwmon with thermal zone"
      Merge branch 'x86_pkg_temp' of .git into for-rc

 drivers/thermal/samsung/exynos_thermal_common.c    |    2 --
 drivers/thermal/samsung/exynos_tmu.c               |   12 +++++---
 drivers/thermal/samsung/exynos_tmu.h               |    7 ++++-
 drivers/thermal/samsung/exynos_tmu_data.c          |   30
++++++++++++++++----
 drivers/thermal/samsung/exynos_tmu_data.h          |   13 ++++++++-
 drivers/thermal/thermal_hwmon.c                    |    2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |    1 +
 drivers/thermal/x86_pkg_temp_thermal.c             |   14 +++++----
 8 files changed, 60 insertions(+), 21 deletions(-)



