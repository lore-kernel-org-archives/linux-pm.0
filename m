From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] thermal: Fix build for !CONFIG_THERMAL
Date: Wed,  4 Mar 2015 12:05:39 +0000
Message-ID: <1425470739-16651-1-git-send-email-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Commit ddd4dd8ddf784 (thermal: extend the cooling device API to include
power information) added stubs for newly introduced functions when
!CONFIG_THERMAL but did not provide names for the parameters which is
a syntax error causing build errors in such configurations. Add names to
fix the issue.

Also remove an extra semicolon from power_actor_set_power() which also
breaks the build and declare the functions as static inline to avoid
both multiple definitions and sparse warnings.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/thermal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4fb31db70b6f..48131730187b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -405,11 +405,11 @@ void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 { return false; }
-int power_actor_get_max_power(struct thermal_cooling_device *,
+static inline int power_actor_get_max_power(struct thermal_cooling_device *cdev,
 			      struct thermal_zone_device *tz, u32 *max_power)
 { return 0; }
-int power_actor_set_power(struct thermal_cooling_device *,
-			  struct thermal_instance *, u32);
+static inline int power_actor_set_power(struct thermal_cooling_device *cdev,
+			  struct thermal_instance *instance, u32 power)
 { return 0; }
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
-- 
2.1.4
