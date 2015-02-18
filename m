From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 0/5] Various fixes to weights in the thermal framework
Date: Wed, 18 Feb 2015 16:04:20 +0000
Message-ID: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.arm.com ([217.140.108.86]:43996 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbBRQE7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 11:04:59 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>

Weights can be specified in the device tree, but the code currently
ignores the value.  Patch 1 fixes that by putting the weight in the
thermal_instance.  Patches 2-3 simplify the code in the fair share
governor by using the weight in the now populated thermal_instance.
Patch 4 exports the weight to sysfs.  Patch 5 drops the requirement of
all weights needing to add up to a hundred.

Existing thermal zones using this governor should still work, as these
series shouldn't make any functional change for them.  However,
thermal zones that previously weren't able to use the fair share
governor (because they were being register through device tree or
because they weren't populating thermal_bind_params) now populate the
weight properly and are able to use the governor.

Changes since v2[0]:
   - Change the default weight to 0.  For the fair share governor, if
     all weights are 0, cooling devices get the same percentage.

Changes since v1[1]:
   - Fix the call to thermal_zone_bind_cooling_device() in
     drivers/platform/x86/acerhdf.c and drivers/acpi/thermal.c

[0] http://thread.gmane.org/gmane.linux.power-management.general/56269
[1] http://thread.gmane.org/gmane.linux.power-management.general/55730

Javi Merino (4):
  thermal: fair_share: use the weight from the thermal instance
  thermal: fair_share: fix typo
  thermal: export weight to sysfs
  thermal: fair_share: generalize the weight concept

Kapileshwar Singh (1):
  thermal: of: fix cooling device weights in device tree

 Documentation/thermal/sysfs-api.txt                | 31 +++++++++--
 drivers/acpi/thermal.c                             |  9 ++--
 drivers/platform/x86/acerhdf.c                     |  3 +-
 drivers/thermal/db8500_thermal.c                   |  2 +-
 drivers/thermal/fair_share.c                       | 41 +++++++-------
 drivers/thermal/imx_thermal.c                      |  3 +-
 drivers/thermal/of-thermal.c                       |  5 +-
 drivers/thermal/samsung/exynos_thermal_common.c    |  3 +-
 drivers/thermal/thermal_core.c                     | 62 +++++++++++++++++++---
 drivers/thermal/thermal_core.h                     |  3 ++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 +-
 include/linux/thermal.h                            | 15 ++++--
 12 files changed, 137 insertions(+), 43 deletions(-)

-- 
1.9.1

