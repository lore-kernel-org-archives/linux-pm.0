From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management fixes for v3.14-rc6
Date: Mon, 10 Mar 2014 00:25:21 +0800
Message-ID: <1394382321.9269.54.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from the git repository at

git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc6

to receive thermal management fixes for v3.14-rc6
with top-most commit f2234bcd03ad031225d7dc37dd18852a2f2ff2bf:

  Thermal: thermal zone governor fix (2014-03-03 23:15:57 +0800)

on top of commit d2a0476307e67a6e6a293563a4f4ad4ec79ac0e5:

  Merge branch 'akpm' (patches from Andrew Morton) (2014-02-25 15:38:13
-0800)


Specifics:

 - Update the help text of INT3403 Thermal driver, which was not
friendly to users. From Zhang Rui.

 - The "type" sysfs attribute of x86_pkg_temp_thermal registered thermal
zones includes an instance number, which makes the thermal-to-hwmon
bridge fails to group them all in a single hwmon device. Fixed by Jean
Delvare.

 - The hwmon device registered by x86_pkg_temp_thermal driver is
redundant because the temperature value reported by x86_pkg_temp_thermal
is already reported by the coretemp driver. Fixed by Jean Delvare.

 - Fix a problem that the cooling device can not be updated properly if
it is initialized at max cooling state. From Ni Wade.

 - Fix a problem that OF registered thermal zones are running without
thermal governors. From Zhang Rui.

 - Commit beeb5a1e (thermal: rcar-thermal: Enable driver compilation
with COMPILE_TEST) broke build on archs wihout io memory. Thus make it
depend on HAS_IOMEM to bypass build failures. Fixed by Richard
Weinberger.

thanks,
rui

----------------------------------------------------------------
Jean Delvare (2):
      x86_pkg_temp_thermal: Do not expose as a hwmon device
      x86_pkg_temp_thermal: Fix the thermal zone type

Ni Wade (1):
      Thermal: Allow first update of cooling device state

Richard Weinberger (1):
      thermal,rcar_thermal: Add dependency on HAS_IOMEM

Zhang Rui (2):
      Thermal: update INT3404 thermal driver help text
      Thermal: thermal zone governor fix

 drivers/thermal/Kconfig                |   13 +++++++++++--
 drivers/thermal/thermal_core.c         |   27
+++++++++++++++++++--------
 drivers/thermal/x86_pkg_temp_thermal.c |   11 ++++++-----
 3 files changed, 36 insertions(+), 15 deletions(-)
