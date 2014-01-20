From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v4 0/2] Support to tune governor in run time
Date: Mon, 20 Jan 2014 17:55:30 +0800
Message-ID: <1390211732-5853-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1720 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbaATJzs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2014 04:55:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: durgadoss.r@intel.com, MLongnecker@nvidia.com, linux-pm@vger.kernel.org, Wei Ni <wni@nvidia.com>

This serie can support to turn governor for thermal zone in
run time.
Adds avaiable_policies attribute, so the user can get available
governor policies and change te governor to a new one.
Adds thermal_update_governor() function, so the thermal platform
driver can use it to update governor.

Changes from v1:
1. split avaiable_policies part to the "patch 1/2", and add document
for it.
2. add document for the thermal_update_governor.
Changes from v2:
1. fix the overflow issue in the avaiable_policies_show
Changes from v3:
1. remove the .start/.stop callback, because we doesn't have the real
case to support it now.

Wei Ni (2):
  thermal: add available policies attribute
  thermal: add interface to support tune governor in run-time

 Documentation/thermal/sysfs-api.txt |   10 ++++++
 drivers/thermal/thermal_core.c      |   66 +++++++++++++++++++++++++++++++----
 include/linux/thermal.h             |    1 +
 3 files changed, 70 insertions(+), 7 deletions(-)

-- 
1.7.9.5

