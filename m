From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/9] cpuidle: rework device state count handling
Date: Fri, 20 Dec 2013 19:47:22 +0100
Message-ID: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37618 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab3LTSry (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 13:47:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

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

Reference to v1:
	http://comments.gmane.org/gmane.linux.power-management.general/37390

Changes since v1:
- synced patch series with next-20131220
- added ACKs from Daniel Lezcano

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

