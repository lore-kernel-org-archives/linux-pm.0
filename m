From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 0/2] Intruduce thermal_zone_get_zone_by_node
Date: Thu, 9 Jan 2014 18:37:57 +0800
Message-ID: <1389263879-10483-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4813 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbaAIKhr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 05:37:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: eduardo.valentin@ti.com, rui.zhang@intel.com, mark.rutland@arm.com, durgadoss.r@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>

The thermal fw start to support device tree, so add a new funciton
thermal_zone_get_zone_by_node()

This series is v2.

Changes from v1:
1. not remove the thermal_zone_get_zone_by_name, and add the
new one, so it will not affect other driver.
2. split one patch into two patches.

Wei Ni (2):
  thermal: introduce thermal_zone_get_zone_by_node helper function
  thermal: use device node to get thermal zone

 drivers/thermal/of-thermal.c   |    6 ++++--
 drivers/thermal/thermal_core.c |   33 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |    3 +++
 3 files changed, 40 insertions(+), 2 deletions(-)

-- 
1.7.9.5

