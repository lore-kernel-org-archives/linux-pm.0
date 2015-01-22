From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 0/5] Various fixes to weights in the thermal framework
Date: Thu, 22 Jan 2015 17:27:00 +0000
Message-ID: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41127 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbAVR1n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jan 2015 12:27:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Kapileshwar.Singh@arm.com, Javi Merino <javi.merino@arm.com>

Weights can be specified in the device tree, but the code currently
ignores the value.  Patch 1 fixes that by putting the weight in the
thermal_instance.  Patches 2-3 simplifies the code in the fair share
governor by using the weight in the now populated thermal_instance.
Patch 4 exports the weight to sysfs.  Patch 5 drops the requirement of
all weights needing to add up to a hundred.

Existing thermal zones using this governor should still work, as these
series shouldn't make any functional change for them.  However,
thermal zones that previously weren't able to use the fair share
governor (because they were being register through device tree or
because they weren't populating thermal_bind_params) now populate the
weight properly and are able to use the governor.

Javi Merino (4):
  thermal: fair_share: use the weight from the thermal instance
  thermal: fair_share: fix typo
  thermal: export weight to sysfs
  thermal: fair_share: generalize the weight concept

Kapileshwar Singh (1):
  thermal: of: fix cooling device weights in device tree

 Documentation/thermal/sysfs-api.txt                | 27 ++++++++--
 drivers/thermal/db8500_thermal.c                   |  2 +-
 drivers/thermal/fair_share.c                       | 38 ++++++-------
 drivers/thermal/imx_thermal.c                      |  3 +-
 drivers/thermal/of-thermal.c                       |  5 +-
 drivers/thermal/samsung/exynos_thermal_common.c    |  3 +-
 drivers/thermal/thermal_core.c                     | 62 +++++++++++++++++++---
 drivers/thermal/thermal_core.h                     |  3 ++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 +-
 include/linux/thermal.h                            | 19 +++++--
 10 files changed, 126 insertions(+), 39 deletions(-)

-- 
1.9.1

