From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6/7] thermal/drivers/core: Fix typo in the option name
Date: Tue,  2 Apr 2019 18:12:49 +0200
Message-ID: <20190402161256.11044-6-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Unlike the other options, the cpu cooling option is beginning
with a lowercase letter, changing to a uppercase.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d8aa7fac8c56..83e95a4fb61b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -148,7 +148,7 @@ config THERMAL_GOV_POWER_ALLOCATOR
 	  allocating and limiting power to devices.
 
 config CPU_THERMAL
-	bool "generic cpu cooling support"
+	bool "Generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
 	help
-- 
2.17.1
