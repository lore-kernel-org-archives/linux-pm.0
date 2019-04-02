From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 7/7] hwmon/drivers/core: Simplify complex dependency
Date: Tue,  2 Apr 2019 18:12:50 +0200
Message-ID: <20190402161256.11044-7-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

As the thermal framework does not longer compile as a module, we can
simplify this condition below:

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || \
        !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || \
        !(defined(MODULE) && 0))

=> (whatever && 0) = 0

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || !(0))

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || 1)

=> (whatever || 1) = 1

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (1)

=> (whatever && 1) = whatever

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)

CONFIG_THERMAL can not be a module anymore, then:

 if defined(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)

And CONFIG_THERMAL_OF already depends on CONFIG_THERMAL, so:

 if defined(CONFIG_THERMAL_OF)

Thus,

 ifdef CONFIG_THERMAL_OF

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/hwmon/hwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c22dc1e07911..6f76f2484db0 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -118,9 +118,7 @@ static DEFINE_IDA(hwmon_ida);
  * The complex conditional is necessary to avoid a cyclic dependency
  * between hwmon and thermal_sys modules.
  */
-#if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
-	(!defined(CONFIG_THERMAL_HWMON) || \
-	 !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))
+#ifdef CONFIG_THERMAL_OF
 static int hwmon_thermal_get_temp(void *data, int *temp)
 {
 	struct hwmon_thermal_data *tdata = data;
-- 
2.17.1
