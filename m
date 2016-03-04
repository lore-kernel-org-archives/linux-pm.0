From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/3] thermal: Add devm_thermal_zone_of_sensor_register() in managed devices list
Date: Fri, 4 Mar 2016 19:10:09 +0530
Message-ID: <1457098810-11964-3-git-send-email-ldewangan@nvidia.com>
References: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, corbet@lwn.net
Cc: rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

thermal_zone_of_sensor_register() and thermal_zone_of_sensor_unregister()
gained their devm_ wrappers. Add these APIs in the list of managed devices.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
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
