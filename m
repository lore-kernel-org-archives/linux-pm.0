From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 3/6] thermal: Add devm_thermal_zone_of_sensor_register() in managed devices list
Date: Wed, 9 Mar 2016 18:40:07 +0530
Message-ID: <1457529010-6538-4-git-send-email-ldewangan@nvidia.com>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19231 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbcCINXc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 08:23:32 -0500
In-Reply-To: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com, Laxman Dewangan <ldewangan@nvidia.com>

The interface thermal_zone_of_sensor_register() and
thermal_zone_of_sensor_unregister() gained their devm_
wrappers. Add these APIs in the list of managed devices.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- No change.

 Documentation/driver-model/devres.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 5930d9a..dd7ce58 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -342,6 +342,10 @@ SLAVE DMA ENGINE
 SPI
   devm_spi_register_master()
 
+THERMAL
+ devm_thermal_zone_of_sensor_register()
+ devm_thermal_zone_of_sensor_unregister()
+
 WATCHDOG
   devm_watchdog_register_device()
   devm_watchdog_unregister_device()
-- 
2.1.4

