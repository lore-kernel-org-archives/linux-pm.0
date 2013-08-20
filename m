From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/9] cpuidle: rework device state count handling
Date: Tue, 20 Aug 2013 16:23:38 +0200
Message-ID: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58982 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3HTOYc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:24:32 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU005Y72OUJFE0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:24:31 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

Hi,

Some cpuidle drivers assume that cpuidle core will handle cases where
device->state_count is smaller than driver->state_count, unfortunately
currently this is untrue (device->state_count is used only for handling
cpuidle state sysfs entries and driver->state_count is used for all
other cases) and will not be fixed in the future as device->state_count
is planned to be removed [1].

This patchset fixes such drivers (ARM EXYNOS cpuidle driver and ACPI
cpuidle driver), removes superflous device->state_count initialization
from drivers for which device->state_count equals driver->state_count
(POWERPC pseries cpuidle driver and intel_idle driver) and finally
removes state_count field from struct cpuidle_device.

Additionaly (while at it) this patchset fixes C1E promotion disable
quirk handling (in intel_idle driver) and converts cpuidle drivers code
to use the common cpuidle_[un]register() routines (in POWERPC pseries
cpuidle driver and intel_idle driver).

[1] http://permalink.gmane.org/gmane.linux.power-management.general/36908

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (9):
  ARM: EXYNOS: cpuidle: fix AFTR mode check
  POWERPC: pseries: cpuidle: remove superfluous dev->state_count
    initialization
  POWERPC: pseries: cpuidle: use the common cpuidle_[un]register()
    routines
  ACPI / cpuidle: fix max idle state handling with hotplug CPU support
  ACPI / cpuidle: remove dev->state_count setting
  intel_idle: do C1E promotion disable quirk for hotplugged CPUs
  intel_idle: remove superfluous dev->state_count initialization
  intel_idle: use the common cpuidle_[un]register() routines
  cpuidle: remove state_count field from struct cpuidle_device

 arch/arm/mach-exynos/cpuidle.c                  |   8 +-
 arch/powerpc/platforms/pseries/processor_idle.c |  59 +---------
 drivers/acpi/processor_idle.c                   |  29 +++--
 drivers/cpuidle/cpuidle.c                       |   3 -
 drivers/cpuidle/sysfs.c                         |   5 +-
 drivers/idle/intel_idle.c                       | 140 +++++-------------------
 include/linux/cpuidle.h                         |   1 -
 7 files changed, 51 insertions(+), 194 deletions(-)

-- 
1.8.2.3

